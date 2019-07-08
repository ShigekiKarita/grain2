module grain.cuda.dpp.nvrtc;


        import core.stdc.config;
        import core.stdc.stdarg: va_list;
        static import core.simd;
        static import std.conv;

        struct Int128 { long lower; long upper; }
        struct UInt128 { ulong lower; ulong upper; }

        struct __locale_data { int dummy; }



alias _Bool = bool;
struct dpp {
    static struct Opaque(int N) {
        void[N] bytes;
    }

    static bool isEmpty(T)() {
        return T.tupleof.length == 0;
    }
    static struct Move(T) {
        T* ptr;
    }


    static auto move(T)(ref T value) {
        return Move!T(&value);
    }
    mixin template EnumD(string name, T, string prefix) if(is(T == enum)) {
        private static string _memberMixinStr(string member) {
            import std.conv: text;
            import std.array: replace;
            return text(` `, member.replace(prefix, ""), ` = `, T.stringof, `.`, member, `,`);
        }
        private static string _enumMixinStr() {
            import std.array: join;
            string[] ret;
            ret ~= "enum " ~ name ~ "{";
            static foreach(member; __traits(allMembers, T)) {
                ret ~= _memberMixinStr(member);
            }
            ret ~= "}";
            return ret.join("\n");
        }
        mixin(_enumMixinStr());
    }
}

extern(C)
{
    nvrtcResult nvrtcGetLoweredName(_nvrtcProgram*, const(const(char)*), const(char)**) @nogc nothrow;
    nvrtcResult nvrtcAddNameExpression(_nvrtcProgram*, const(const(char)*)) @nogc nothrow;
    nvrtcResult nvrtcGetProgramLog(_nvrtcProgram*, char*) @nogc nothrow;
    nvrtcResult nvrtcGetProgramLogSize(_nvrtcProgram*, c_ulong*) @nogc nothrow;
    nvrtcResult nvrtcGetPTX(_nvrtcProgram*, char*) @nogc nothrow;
    nvrtcResult nvrtcGetPTXSize(_nvrtcProgram*, c_ulong*) @nogc nothrow;
    nvrtcResult nvrtcCompileProgram(_nvrtcProgram*, int, const(const(char)*)*) @nogc nothrow;
    nvrtcResult nvrtcDestroyProgram(_nvrtcProgram**) @nogc nothrow;
    nvrtcResult nvrtcCreateProgram(_nvrtcProgram**, const(char)*, const(char)*, int, const(const(char)*)*, const(const(char)*)*) @nogc nothrow;
    struct _nvrtcProgram;
    alias nvrtcProgram = _nvrtcProgram*;
    nvrtcResult nvrtcVersion(int*, int*) @nogc nothrow;
    const(char)* nvrtcGetErrorString(nvrtcResult) @nogc nothrow;
    enum _Anonymous_0
    {
        NVRTC_SUCCESS = 0,
        NVRTC_ERROR_OUT_OF_MEMORY = 1,
        NVRTC_ERROR_PROGRAM_CREATION_FAILURE = 2,
        NVRTC_ERROR_INVALID_INPUT = 3,
        NVRTC_ERROR_INVALID_PROGRAM = 4,
        NVRTC_ERROR_INVALID_OPTION = 5,
        NVRTC_ERROR_COMPILATION = 6,
        NVRTC_ERROR_BUILTIN_OPERATION_FAILURE = 7,
        NVRTC_ERROR_NO_NAME_EXPRESSIONS_AFTER_COMPILATION = 8,
        NVRTC_ERROR_NO_LOWERED_NAMES_BEFORE_COMPILATION = 9,
        NVRTC_ERROR_NAME_EXPRESSION_NOT_VALID = 10,
        NVRTC_ERROR_INTERNAL_ERROR = 11,
    }
    enum NVRTC_SUCCESS = _Anonymous_0.NVRTC_SUCCESS;
    enum NVRTC_ERROR_OUT_OF_MEMORY = _Anonymous_0.NVRTC_ERROR_OUT_OF_MEMORY;
    enum NVRTC_ERROR_PROGRAM_CREATION_FAILURE = _Anonymous_0.NVRTC_ERROR_PROGRAM_CREATION_FAILURE;
    enum NVRTC_ERROR_INVALID_INPUT = _Anonymous_0.NVRTC_ERROR_INVALID_INPUT;
    enum NVRTC_ERROR_INVALID_PROGRAM = _Anonymous_0.NVRTC_ERROR_INVALID_PROGRAM;
    enum NVRTC_ERROR_INVALID_OPTION = _Anonymous_0.NVRTC_ERROR_INVALID_OPTION;
    enum NVRTC_ERROR_COMPILATION = _Anonymous_0.NVRTC_ERROR_COMPILATION;
    enum NVRTC_ERROR_BUILTIN_OPERATION_FAILURE = _Anonymous_0.NVRTC_ERROR_BUILTIN_OPERATION_FAILURE;
    enum NVRTC_ERROR_NO_NAME_EXPRESSIONS_AFTER_COMPILATION = _Anonymous_0.NVRTC_ERROR_NO_NAME_EXPRESSIONS_AFTER_COMPILATION;
    enum NVRTC_ERROR_NO_LOWERED_NAMES_BEFORE_COMPILATION = _Anonymous_0.NVRTC_ERROR_NO_LOWERED_NAMES_BEFORE_COMPILATION;
    enum NVRTC_ERROR_NAME_EXPRESSION_NOT_VALID = _Anonymous_0.NVRTC_ERROR_NAME_EXPRESSION_NOT_VALID;
    enum NVRTC_ERROR_INTERNAL_ERROR = _Anonymous_0.NVRTC_ERROR_INTERNAL_ERROR;
    alias nvrtcResult = _Anonymous_0;
    alias fsfilcnt_t = c_ulong;
    alias fsblkcnt_t = c_ulong;
    alias blkcnt_t = c_long;
    alias blksize_t = c_long;
    alias register_t = c_long;
    alias u_int64_t = c_ulong;
    alias u_int32_t = uint;
    alias u_int16_t = ushort;
    alias u_int8_t = ubyte;
    alias int64_t = c_long;
    alias int32_t = int;
    alias int16_t = short;
    alias int8_t = byte;
    alias key_t = int;
    alias caddr_t = char*;
    alias daddr_t = int;
    alias ssize_t = c_long;
    alias id_t = uint;
    alias pid_t = int;
    alias off_t = c_long;
    alias uid_t = uint;
    alias nlink_t = c_ulong;
    alias mode_t = uint;
    alias gid_t = uint;
    alias dev_t = c_ulong;
    alias ino_t = c_ulong;
    alias loff_t = c_long;
    alias fsid_t = __fsid_t;
    alias u_quad_t = c_ulong;
    alias quad_t = c_long;
    alias u_long = c_ulong;
    alias u_int = uint;
    alias u_short = ushort;
    alias u_char = ubyte;
    ulong gnu_dev_makedev(uint, uint) @nogc nothrow;
    uint gnu_dev_minor(ulong) @nogc nothrow;
    uint gnu_dev_major(ulong) @nogc nothrow;
    int pselect(int, fd_set*, fd_set*, fd_set*, const(timespec)*, const(__sigset_t)*) @nogc nothrow;
    int select(int, fd_set*, fd_set*, fd_set*, timeval*) @nogc nothrow;
    alias fd_mask = c_long;
    struct fd_set
    {
        c_long[16] __fds_bits;
    }
    alias __fd_mask = c_long;
    alias suseconds_t = c_long;
    alias sigset_t = __sigset_t;
    union wait
    {
        int w_status;
        static struct _Anonymous_1
        {
            import std.bitmanip: bitfields;

            align(4):
            mixin(bitfields!(
                uint, "__w_termsig", 7,
                uint, "__w_coredump", 1,
                uint, "__w_retcode", 8,
                uint, "_anonymous_2", 16,
            ));
        }
        _Anonymous_1 __wait_terminated;
        static struct _Anonymous_3
        {
            import std.bitmanip: bitfields;

            align(4):
            mixin(bitfields!(
                uint, "__w_stopval", 8,
                uint, "__w_stopsig", 8,
                uint, "_anonymous_4", 16,
            ));
        }
        _Anonymous_3 __wait_stopped;
    }
    enum _Anonymous_5
    {
        P_ALL = 0,
        P_PID = 1,
        P_PGID = 2,
    }
    enum P_ALL = _Anonymous_5.P_ALL;
    enum P_PID = _Anonymous_5.P_PID;
    enum P_PGID = _Anonymous_5.P_PGID;
    alias idtype_t = _Anonymous_5;
    alias __socklen_t = uint;
    alias __intptr_t = c_long;
    alias __caddr_t = char*;
    alias __qaddr_t = c_long*;
    alias __loff_t = c_long;
    alias __syscall_ulong_t = c_ulong;
    alias __syscall_slong_t = c_long;
    alias __ssize_t = c_long;
    alias __fsword_t = c_long;
    alias __fsfilcnt64_t = c_ulong;
    alias __fsfilcnt_t = c_ulong;
    alias __fsblkcnt64_t = c_ulong;
    alias __fsblkcnt_t = c_ulong;
    alias __blkcnt64_t = c_long;
    alias __blkcnt_t = c_long;
    alias __blksize_t = c_long;
    alias __timer_t = void*;
    alias __clockid_t = int;
    alias __key_t = int;
    alias __daddr_t = int;
    alias __suseconds_t = c_long;
    alias __useconds_t = uint;
    alias __time_t = c_long;
    alias __id_t = uint;
    alias __rlim64_t = c_ulong;
    alias __rlim_t = c_ulong;
    alias __clock_t = c_long;
    struct __fsid_t
    {
        int[2] __val;
    }
    alias __pid_t = int;
    alias __off64_t = c_long;
    alias __off_t = c_long;
    alias __nlink_t = c_ulong;
    alias __mode_t = uint;
    alias __ino64_t = c_ulong;
    alias __ino_t = c_ulong;
    alias __gid_t = uint;
    alias __uid_t = uint;
    alias __dev_t = c_ulong;
    alias __u_quad_t = c_ulong;
    alias __quad_t = c_long;
    alias __uint64_t = c_ulong;
    alias __int64_t = c_long;
    alias __uint32_t = uint;
    alias __int32_t = int;
    alias __uint16_t = ushort;
    alias __int16_t = short;
    alias __uint8_t = ubyte;
    alias __int8_t = byte;
    alias __u_long = c_ulong;
    alias __u_int = uint;
    alias __u_short = ushort;
    alias __u_char = ubyte;
    struct timeval
    {
        c_long tv_sec;
        c_long tv_usec;
    }
    struct __sigset_t
    {
        c_ulong[16] __val;
    }
    alias __sig_atomic_t = int;
    union pthread_barrierattr_t
    {
        char[4] __size;
        int __align;
    }
    union pthread_barrier_t
    {
        char[32] __size;
        c_long __align;
    }
    alias pthread_spinlock_t = int;
    pragma(mangle, "alloca") void* alloca_(c_ulong) @nogc nothrow;
    union pthread_rwlockattr_t
    {
        char[8] __size;
        c_long __align;
    }
    alias size_t = c_ulong;
    alias wchar_t = int;
    union pthread_rwlock_t
    {
        static struct _Anonymous_6
        {
            int __lock;
            uint __nr_readers;
            uint __readers_wakeup;
            uint __writer_wakeup;
            uint __nr_readers_queued;
            uint __nr_writers_queued;
            int __writer;
            int __shared;
            byte __rwelision;
            ubyte[7] __pad1;
            c_ulong __pad2;
            uint __flags;
        }
        _Anonymous_6 __data;
        char[56] __size;
        c_long __align;
    }
    alias pthread_once_t = int;
    alias pthread_key_t = uint;
    union pthread_condattr_t
    {
        char[4] __size;
        int __align;
    }
    union pthread_cond_t
    {
        static struct _Anonymous_7
        {
            int __lock;
            uint __futex;
            ulong __total_seq;
            ulong __wakeup_seq;
            ulong __woken_seq;
            void* __mutex;
            uint __nwaiters;
            uint __broadcast_seq;
        }
        _Anonymous_7 __data;
        char[48] __size;
        long __align;
    }
    union pthread_mutexattr_t
    {
        char[4] __size;
        int __align;
    }
    union pthread_mutex_t
    {
        struct __pthread_mutex_s
        {
            int __lock;
            uint __count;
            int __owner;
            uint __nusers;
            int __kind;
            short __spins;
            short __elision;
            __pthread_internal_list __list;
        }
        __pthread_mutex_s __data;
        char[40] __size;
        c_long __align;
    }
    struct __pthread_internal_list
    {
        __pthread_internal_list* __prev;
        __pthread_internal_list* __next;
    }
    alias __pthread_list_t = __pthread_internal_list;
    union pthread_attr_t
    {
        char[56] __size;
        c_long __align;
    }
    alias pthread_t = c_ulong;
    struct timespec
    {
        c_long tv_sec;
        c_long tv_nsec;
    }
    alias timer_t = void*;
    union __WAIT_STATUS
    {
        wait* __uptr;
        int* __iptr;
    }
    alias clockid_t = int;
    struct div_t
    {
        int quot;
        int rem;
    }
    struct ldiv_t
    {
        c_long quot;
        c_long rem;
    }
    struct lldiv_t
    {
        long quot;
        long rem;
    }
    alias time_t = c_long;
    c_ulong __ctype_get_mb_cur_max() @nogc nothrow;
    double atof(const(char)*) @nogc nothrow;
    int atoi(const(char)*) @nogc nothrow;
    c_long atol(const(char)*) @nogc nothrow;
    long atoll(const(char)*) @nogc nothrow;
    double strtod(const(char)*, char**) @nogc nothrow;
    float strtof(const(char)*, char**) @nogc nothrow;
    real strtold(const(char)*, char**) @nogc nothrow;
    c_long strtol(const(char)*, char**, int) @nogc nothrow;
    c_ulong strtoul(const(char)*, char**, int) @nogc nothrow;
    long strtoq(const(char)*, char**, int) @nogc nothrow;
    ulong strtouq(const(char)*, char**, int) @nogc nothrow;
    long strtoll(const(char)*, char**, int) @nogc nothrow;
    ulong strtoull(const(char)*, char**, int) @nogc nothrow;
    char* l64a(c_long) @nogc nothrow;
    c_long a64l(const(char)*) @nogc nothrow;
    c_long random() @nogc nothrow;
    void srandom(uint) @nogc nothrow;
    char* initstate(uint, char*, c_ulong) @nogc nothrow;
    char* setstate(char*) @nogc nothrow;
    struct random_data
    {
        int* fptr;
        int* rptr;
        int* state;
        int rand_type;
        int rand_deg;
        int rand_sep;
        int* end_ptr;
    }
    int random_r(random_data*, int*) @nogc nothrow;
    int srandom_r(uint, random_data*) @nogc nothrow;
    int initstate_r(uint, char*, c_ulong, random_data*) @nogc nothrow;
    int setstate_r(char*, random_data*) @nogc nothrow;
    int rand() @nogc nothrow;
    void srand(uint) @nogc nothrow;
    int rand_r(uint*) @nogc nothrow;
    double drand48() @nogc nothrow;
    double erand48(ushort*) @nogc nothrow;
    c_long lrand48() @nogc nothrow;
    c_long nrand48(ushort*) @nogc nothrow;
    c_long mrand48() @nogc nothrow;
    c_long jrand48(ushort*) @nogc nothrow;
    void srand48(c_long) @nogc nothrow;
    ushort* seed48(ushort*) @nogc nothrow;
    void lcong48(ushort*) @nogc nothrow;
    struct drand48_data
    {
        ushort[3] __x;
        ushort[3] __old_x;
        ushort __c;
        ushort __init;
        ulong __a;
    }
    int drand48_r(drand48_data*, double*) @nogc nothrow;
    int erand48_r(ushort*, drand48_data*, double*) @nogc nothrow;
    int lrand48_r(drand48_data*, c_long*) @nogc nothrow;
    int nrand48_r(ushort*, drand48_data*, c_long*) @nogc nothrow;
    int mrand48_r(drand48_data*, c_long*) @nogc nothrow;
    int jrand48_r(ushort*, drand48_data*, c_long*) @nogc nothrow;
    int srand48_r(c_long, drand48_data*) @nogc nothrow;
    int seed48_r(ushort*, drand48_data*) @nogc nothrow;
    int lcong48_r(ushort*, drand48_data*) @nogc nothrow;
    void* malloc(c_ulong) @nogc nothrow;
    void* calloc(c_ulong, c_ulong) @nogc nothrow;
    void* realloc(void*, c_ulong) @nogc nothrow;
    void free(void*) @nogc nothrow;
    void cfree(void*) @nogc nothrow;
    void* valloc(c_ulong) @nogc nothrow;
    int posix_memalign(void**, c_ulong, c_ulong) @nogc nothrow;
    void* aligned_alloc(c_ulong, c_ulong) @nogc nothrow;
    void abort() @nogc nothrow;
    int atexit(void function()) @nogc nothrow;
    int at_quick_exit(void function()) @nogc nothrow;
    int on_exit(void function(int, void*), void*) @nogc nothrow;
    void exit(int) @nogc nothrow;
    void quick_exit(int) @nogc nothrow;
    void _Exit(int) @nogc nothrow;
    char* getenv(const(char)*) @nogc nothrow;
    int putenv(char*) @nogc nothrow;
    int setenv(const(char)*, const(char)*, int) @nogc nothrow;
    int unsetenv(const(char)*) @nogc nothrow;
    int clearenv() @nogc nothrow;
    char* mktemp(char*) @nogc nothrow;
    int mkstemp(char*) @nogc nothrow;
    int mkstemps(char*, int) @nogc nothrow;
    char* mkdtemp(char*) @nogc nothrow;
    int system(const(char)*) @nogc nothrow;
    char* realpath(const(char)*, char*) @nogc nothrow;
    alias __compar_fn_t = int function(const(void)*, const(void)*);
    void* bsearch(const(void)*, const(void)*, c_ulong, c_ulong, int function(const(void)*, const(void)*)) @nogc nothrow;
    void qsort(void*, c_ulong, c_ulong, int function(const(void)*, const(void)*)) @nogc nothrow;
    int abs(int) @nogc nothrow;
    c_long labs(c_long) @nogc nothrow;
    long llabs(long) @nogc nothrow;
    div_t div(int, int) @nogc nothrow;
    ldiv_t ldiv(c_long, c_long) @nogc nothrow;
    lldiv_t lldiv(long, long) @nogc nothrow;
    char* ecvt(double, int, int*, int*) @nogc nothrow;
    char* fcvt(double, int, int*, int*) @nogc nothrow;
    char* gcvt(double, int, char*) @nogc nothrow;
    char* qecvt(real, int, int*, int*) @nogc nothrow;
    char* qfcvt(real, int, int*, int*) @nogc nothrow;
    char* qgcvt(real, int, char*) @nogc nothrow;
    int ecvt_r(double, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int fcvt_r(double, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int qecvt_r(real, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int qfcvt_r(real, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int mblen(const(char)*, c_ulong) @nogc nothrow;
    int mbtowc(int*, const(char)*, c_ulong) @nogc nothrow;
    int wctomb(char*, int) @nogc nothrow;
    c_ulong mbstowcs(int*, const(char)*, c_ulong) @nogc nothrow;
    c_ulong wcstombs(char*, const(int)*, c_ulong) @nogc nothrow;
    int rpmatch(const(char)*) @nogc nothrow;
    int getsubopt(char**, char**, char**) @nogc nothrow;
    int getloadavg(double*, int) @nogc nothrow;
    alias clock_t = c_long;




    static if(!is(typeof(__clock_t_defined))) {
        enum __clock_t_defined = 1;
    }
    static if(!is(typeof(__time_t_defined))) {
        enum __time_t_defined = 1;
    }




    static if(!is(typeof(EXIT_SUCCESS))) {
        enum EXIT_SUCCESS = 0;
    }




    static if(!is(typeof(EXIT_FAILURE))) {
        enum EXIT_FAILURE = 1;
    }




    static if(!is(typeof(RAND_MAX))) {
        enum RAND_MAX = 2147483647;
    }




    static if(!is(typeof(__lldiv_t_defined))) {
        enum __lldiv_t_defined = 1;
    }




    static if(!is(typeof(__ldiv_t_defined))) {
        enum __ldiv_t_defined = 1;
    }
    static if(!is(typeof(__clockid_t_defined))) {
        enum __clockid_t_defined = 1;
    }
    static if(!is(typeof(_STDLIB_H))) {
        enum _STDLIB_H = 1;
    }
    static if(!is(typeof(__timer_t_defined))) {
        enum __timer_t_defined = 1;
    }






    static if(!is(typeof(_STDC_PREDEF_H))) {
        enum _STDC_PREDEF_H = 1;
    }






    static if(!is(typeof(__timespec_defined))) {
        enum __timespec_defined = 1;
    }




    static if(!is(typeof(__GLIBC_MINOR__))) {
        enum __GLIBC_MINOR__ = 23;
    }




    static if(!is(typeof(__GLIBC__))) {
        enum __GLIBC__ = 2;
    }




    static if(!is(typeof(__GNU_LIBRARY__))) {
        enum __GNU_LIBRARY__ = 6;
    }




    static if(!is(typeof(__USE_FORTIFY_LEVEL))) {
        enum __USE_FORTIFY_LEVEL = 0;
    }




    static if(!is(typeof(__USE_ATFILE))) {
        enum __USE_ATFILE = 1;
    }






    static if(!is(typeof(__USE_MISC))) {
        enum __USE_MISC = 1;
    }




    static if(!is(typeof(_BITS_BYTESWAP_H))) {
        enum _BITS_BYTESWAP_H = 1;
    }




    static if(!is(typeof(_ATFILE_SOURCE))) {
        enum _ATFILE_SOURCE = 1;
    }




    static if(!is(typeof(__USE_XOPEN2K8))) {
        enum __USE_XOPEN2K8 = 1;
    }




    static if(!is(typeof(__USE_ISOC99))) {
        enum __USE_ISOC99 = 1;
    }






    static if(!is(typeof(__USE_ISOC95))) {
        enum __USE_ISOC95 = 1;
    }






    static if(!is(typeof(__USE_XOPEN2K))) {
        enum __USE_XOPEN2K = 1;
    }




    static if(!is(typeof(__USE_POSIX199506))) {
        enum __USE_POSIX199506 = 1;
    }




    static if(!is(typeof(__USE_POSIX199309))) {
        enum __USE_POSIX199309 = 1;
    }




    static if(!is(typeof(__USE_POSIX2))) {
        enum __USE_POSIX2 = 1;
    }




    static if(!is(typeof(__USE_POSIX))) {
        enum __USE_POSIX = 1;
    }






    static if(!is(typeof(_POSIX_C_SOURCE))) {
        enum _POSIX_C_SOURCE = 200809L;
    }






    static if(!is(typeof(_POSIX_SOURCE))) {
        enum _POSIX_SOURCE = 1;
    }




    static if(!is(typeof(__USE_POSIX_IMPLICITLY))) {
        enum __USE_POSIX_IMPLICITLY = 1;
    }
    static if(!is(typeof(_BITS_PTHREADTYPES_H))) {
        enum _BITS_PTHREADTYPES_H = 1;
    }




    static if(!is(typeof(__USE_ISOC11))) {
        enum __USE_ISOC11 = 1;
    }




    static if(!is(typeof(_DEFAULT_SOURCE))) {
        enum _DEFAULT_SOURCE = 1;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_ATTR_T))) {
        enum __SIZEOF_PTHREAD_ATTR_T = 56;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEX_T))) {
        enum __SIZEOF_PTHREAD_MUTEX_T = 40;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEXATTR_T))) {
        enum __SIZEOF_PTHREAD_MUTEXATTR_T = 4;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_COND_T))) {
        enum __SIZEOF_PTHREAD_COND_T = 48;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_CONDATTR_T))) {
        enum __SIZEOF_PTHREAD_CONDATTR_T = 4;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCK_T))) {
        enum __SIZEOF_PTHREAD_RWLOCK_T = 56;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCKATTR_T))) {
        enum __SIZEOF_PTHREAD_RWLOCKATTR_T = 8;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIER_T))) {
        enum __SIZEOF_PTHREAD_BARRIER_T = 32;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIERATTR_T))) {
        enum __SIZEOF_PTHREAD_BARRIERATTR_T = 4;
    }
    static if(!is(typeof(_FEATURES_H))) {
        enum _FEATURES_H = 1;
    }






    static if(!is(typeof(__have_pthread_attr_t))) {
        enum __have_pthread_attr_t = 1;
    }
    static if(!is(typeof(__PTHREAD_MUTEX_HAVE_PREV))) {
        enum __PTHREAD_MUTEX_HAVE_PREV = 1;
    }
    static if(!is(typeof(__PDP_ENDIAN))) {
        enum __PDP_ENDIAN = 3412;
    }




    static if(!is(typeof(__BIG_ENDIAN))) {
        enum __BIG_ENDIAN = 4321;
    }




    static if(!is(typeof(__LITTLE_ENDIAN))) {
        enum __LITTLE_ENDIAN = 1234;
    }




    static if(!is(typeof(_ENDIAN_H))) {
        enum _ENDIAN_H = 1;
    }
    static if(!is(typeof(__PTHREAD_RWLOCK_INT_FLAGS_SHARED))) {
        enum __PTHREAD_RWLOCK_INT_FLAGS_SHARED = 1;
    }
    static if(!is(typeof(_ALLOCA_H))) {
        enum _ALLOCA_H = 1;
    }




    static if(!is(typeof(__FD_ZERO_STOS))) {
        enum __FD_ZERO_STOS = "stosq";
    }
    static if(!is(typeof(_SIGSET_H_types))) {
        enum _SIGSET_H_types = 1;
    }






    static if(!is(typeof(_STRUCT_TIMEVAL))) {
        enum _STRUCT_TIMEVAL = 1;
    }




    static if(!is(typeof(_BITS_TYPES_H))) {
        enum _BITS_TYPES_H = 1;
    }
    static if(!is(typeof(_BITS_TYPESIZES_H))) {
        enum _BITS_TYPESIZES_H = 1;
    }
    static if(!is(typeof(__OFF_T_MATCHES_OFF64_T))) {
        enum __OFF_T_MATCHES_OFF64_T = 1;
    }




    static if(!is(typeof(__INO_T_MATCHES_INO64_T))) {
        enum __INO_T_MATCHES_INO64_T = 1;
    }




    static if(!is(typeof(__FD_SETSIZE))) {
        enum __FD_SETSIZE = 1024;
    }




    static if(!is(typeof(WNOHANG))) {
        enum WNOHANG = 1;
    }




    static if(!is(typeof(WUNTRACED))) {
        enum WUNTRACED = 2;
    }




    static if(!is(typeof(WSTOPPED))) {
        enum WSTOPPED = 2;
    }




    static if(!is(typeof(WEXITED))) {
        enum WEXITED = 4;
    }




    static if(!is(typeof(WCONTINUED))) {
        enum WCONTINUED = 8;
    }




    static if(!is(typeof(WNOWAIT))) {
        enum WNOWAIT = 0x01000000;
    }




    static if(!is(typeof(__WNOTHREAD))) {
        enum __WNOTHREAD = 0x20000000;
    }




    static if(!is(typeof(__WALL))) {
        enum __WALL = 0x40000000;
    }




    static if(!is(typeof(__WCLONE))) {
        enum __WCLONE = 0x80000000;
    }




    static if(!is(typeof(__ENUM_IDTYPE_T))) {
        enum __ENUM_IDTYPE_T = 1;
    }
    static if(!is(typeof(__W_CONTINUED))) {
        enum __W_CONTINUED = 0xffff;
    }




    static if(!is(typeof(__WCOREFLAG))) {
        enum __WCOREFLAG = 0x80;
    }
    static if(!is(typeof(__WORDSIZE))) {
        enum __WORDSIZE = 64;
    }




    static if(!is(typeof(__WORDSIZE_TIME64_COMPAT32))) {
        enum __WORDSIZE_TIME64_COMPAT32 = 1;
    }




    static if(!is(typeof(__SYSCALL_WORDSIZE))) {
        enum __SYSCALL_WORDSIZE = 64;
    }
    static if(!is(typeof(_SYS_CDEFS_H))) {
        enum _SYS_CDEFS_H = 1;
    }
    static if(!is(typeof(_SYS_SELECT_H))) {
        enum _SYS_SELECT_H = 1;
    }
    static if(!is(typeof(_SYS_SYSMACROS_H))) {
        enum _SYS_SYSMACROS_H = 1;
    }
    static if(!is(typeof(_SYS_TYPES_H))) {
        enum _SYS_TYPES_H = 1;
    }
    static if(!is(typeof(__BIT_TYPES_DEFINED__))) {
        enum __BIT_TYPES_DEFINED__ = 1;
    }
}
