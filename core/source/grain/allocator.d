module grain.allocator;

import grain.tensor : Opt;

struct CPUMallocator
{
    Opt opt;
    alias opt this;
    
    enum deviceof = "cpu";

    /**
    Standard allocator methods per the semantics defined above. The
    $(D deallocate) method is $(D @system) because it
    may move memory around, leaving dangling pointers in user code. Somewhat
    paradoxically, $(D malloc) is $(D @safe) but that's only useful to safe
    programs that can afford to leak memory allocated.
    */
    @trusted @nogc nothrow
    void[] allocate()(size_t bytes)
    {
        if (!bytes) return null;

        void* p;
        if (this.pinMemory)
        {
            assert(false, "cannot allocate PIN memory without cuda support. add \"grain2:cuda\" to dependencies");
        }
        else
        {
            import core.memory : pureMalloc;
            p = pureMalloc(bytes);
        }
        return p ? p[0 .. bytes] : null;
    }

    /// Ditto
    @system @nogc nothrow
    bool deallocate()(void[] b)
    {
        if (this.pinMemory)
        {
            assert(false, "cannot allocate PIN memory without cuda support. add \"grain2:cuda\" to dependencies");
        }
        else
        {
            import core.memory : pureFree;
            pureFree(b.ptr);
        }
        return true;
    }

    enum instance =  typeof(this)();
}
