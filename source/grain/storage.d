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
