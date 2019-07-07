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
    
    void[] data;
    Allocator allocator;
    alias data this;

    @disable this(this);
    @disable new(size_t);
    
    this(size_t bytes, Allocator a = Allocator.instance)
    {
        this.allocator = a;
        this.data = a.allocate(bytes);
    }

    ~this()
    {
        this.allocator.deallocate(this.data);
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
        return typeof(return)(this);
    }
}

/// Iterator for RCStorage that shares ownership by itself
struct RCIter(It, Rc)
{
    It ptr;
    Rc rc;  // hold ownership here
    alias ptr this;

    this(Rc rc)
    {
        this.rc = rc;
        this.ptr = cast(It) rc.data.ptr;
    }
}
