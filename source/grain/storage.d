/// Storage
module grain.storage;


/// Basic storage
struct Storage(Allocator)
{
    static if(is(typeof(Allocator.deviceof))) {
        enum deviceof = Allocator.deviceof;
    } else {
        enum deviceof = "cpu";
    }
    
    void[] payload;
    Allocator allocator;
    alias payload this;

    @disable this(this);
    @disable new(size_t);
    
    this(size_t bytes, Allocator a = Allocator.instance)
    {
        this.allocator = a;
        this.payload = a.allocate(bytes);
    }

    ~this()
    {
        this.allocator.deallocate(this.payload);
    }
}

/// Reference count storage
struct RCStorage(Allocator)
{
    import mir.rc.ptr : RCPtr, createRC;

    alias Base = Storage!Allocator;

    RCPtr!Base base;
    alias base this;
    
    this(size_t bytes, Allocator a = Allocator.instance)
    {
        this.base = createRC!Base(bytes, a);
    }

    RCIter!(It, typeof(this)) iterator(It)()
    {
        return typeof(return)(cast(It) this.base.ptr, this);
    }
}

/// Iterator for RCStorage that shares ownership by itself
struct RCIter(It, Rc)
{
    import mir.ndslice.traits : isIterator;
    static assert(isIterator!It);
    
    It _iterator;
    Rc _rc;  // hold ownership here

    alias T = typeof(*It.init);

    private inout payload()
    {
        return cast(It) _rc.payload;
    }

    ///
    inout(T)* lightScope()() scope return inout @property @trusted
    {
        debug
        {
            assert(payload <= _iterator);
            assert(_iterator is null || _iterator <= payload + _rc.length / T.sizeof);
        }
        return _iterator;
    }
    
    ///   
    ref inout(T) opUnary(string op : "*")() inout scope return
    {
        debug
        {
            assert(_iterator);
            assert(payload);
            assert(payload <= _iterator);
            assert(_iterator <= payload + _rc.length / T.sizeof);
        }
        return *_iterator;
    }

    ///   
    ref inout(T) opIndex(ptrdiff_t index) inout scope return @trusted
    {
        debug
        {
            assert(_iterator);
            assert(payload);
            assert(payload <= _iterator + index);
            assert(_iterator + index <= payload + _rc.length / T.sizeof);
        }
        return _iterator[index];
    }

    ///   
    void opUnary(string op)() scope
        if (op == "--" || op == "++")
    { mixin(op ~ "_iterator;"); }

    ///   
    void opOpAssign(string op)(ptrdiff_t index) scope
        if (op == "-" || op == "+")
    { mixin("_iterator " ~ op ~ "= index;"); }

    ///
    RCIter!(It, Rc) opBinary(string op)(ptrdiff_t index)
        if (op == "+" || op == "-")
    { return typeof(return)(_iterator + index, _rc); }

    ///   
    RCIter!(const It, RC) opBinary(string op)(ptrdiff_t index) const
        if (op == "+" || op == "-")
    { return typeof(return)(_iterator + index, _rc); }

    ///   
    RCIter!(immutable It, RC) opBinary(string op)(ptrdiff_t index) immutable
        if (op == "+" || op == "-")
    { return typeof(return)(_iterator + index, _rc); }

    ///   
    ptrdiff_t opBinary(string op : "-")(scope ref const typeof(this) right) scope const
    { return this._iterator - right._iterator; }

    ///   
    bool opEquals()(scope ref const typeof(this) right) scope const
    { return this._iterator == right._iterator; }

    ///   
    ptrdiff_t opCmp()(scope ref const typeof(this) right) scope const
    { return this._iterator - right._iterator; }
}


import stdx.allocator.mallocator : Mallocator;

alias DefaultCPUStorage = RCStorage!Mallocator;

/// Refrence counting string
struct RCString
{
    import mir.rc.array : RCArray, rcarray;
    RCArray!(immutable char) payload;
    alias toString this;
    
    this(scope const(char)[] s) @nogc @safe pure nothrow
    {
        this = s;
    }

    void opAssign(scope const(char)[] rhs) @nogc @safe pure nothrow
    {
        this.payload = rcarray!(immutable char)(rhs);
    }
    
    string toString() return scope @nogc @safe pure nothrow const
    {
        return this.payload[];
    }

}

///
@safe @nogc pure nothrow
unittest
{
    void f(string) {}
    RCString r;
    {
        auto s1 = "hello, world";

        // assign (copy)
        r = s1;
        assert(&r[0] != &s1[0]);

        // able to copy mutable string
        char[100] s;
        s[0 .. s1.length] = s1;
        r = s;
        r = RCString(s[0 .. s1.length]);
    }
    assert(r == "hello, world");
}
