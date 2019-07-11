module grain.allocator;

import grain.tensor : Opt;

struct CPUMallocator
{
    Opt opt;
    alias opt this;
    
    enum deviceof = "cpu";
    enum pinned = false;

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
        import core.memory : pureMalloc;
        p = pureMalloc(bytes);
        return p ? p[0 .. bytes] : null;
    }

    /// Ditto
    @system @nogc nothrow
    bool deallocate()(void[] b)
    {
        import core.memory : pureFree;
        pureFree(b.ptr);
        return true;
    }

    enum instance =  typeof(this)();
}

import grain.storage;
alias cpu = RCStorage!CPUMallocator;
