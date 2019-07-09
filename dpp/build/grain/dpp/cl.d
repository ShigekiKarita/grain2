module grain.dpp.cl;


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
    union cl_double16
    {
        double[16] s;
        static struct _Anonymous_0
        {
            double x;
            double y;
            double z;
            double w;
            double __spacer4;
            double __spacer5;
            double __spacer6;
            double __spacer7;
            double __spacer8;
            double __spacer9;
            double sa;
            double sb;
            double sc;
            double sd;
            double se;
            double sf;
        }
        _Anonymous_0 _anonymous_1;
        auto x() @property @nogc pure nothrow { return _anonymous_1.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_1.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_1.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_1.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.w = val; }
        auto __spacer4() @property @nogc pure nothrow { return _anonymous_1.__spacer4; }
        void __spacer4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.__spacer4 = val; }
        auto __spacer5() @property @nogc pure nothrow { return _anonymous_1.__spacer5; }
        void __spacer5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.__spacer5 = val; }
        auto __spacer6() @property @nogc pure nothrow { return _anonymous_1.__spacer6; }
        void __spacer6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.__spacer6 = val; }
        auto __spacer7() @property @nogc pure nothrow { return _anonymous_1.__spacer7; }
        void __spacer7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.__spacer7 = val; }
        auto __spacer8() @property @nogc pure nothrow { return _anonymous_1.__spacer8; }
        void __spacer8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.__spacer8 = val; }
        auto __spacer9() @property @nogc pure nothrow { return _anonymous_1.__spacer9; }
        void __spacer9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.__spacer9 = val; }
        auto sa() @property @nogc pure nothrow { return _anonymous_1.sa; }
        void sa(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.sa = val; }
        auto sb() @property @nogc pure nothrow { return _anonymous_1.sb; }
        void sb(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.sb = val; }
        auto sc() @property @nogc pure nothrow { return _anonymous_1.sc; }
        void sc(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.sc = val; }
        auto sd() @property @nogc pure nothrow { return _anonymous_1.sd; }
        void sd(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.sd = val; }
        auto se() @property @nogc pure nothrow { return _anonymous_1.se; }
        void se(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.se = val; }
        auto sf() @property @nogc pure nothrow { return _anonymous_1.sf; }
        void sf(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_1.sf = val; }
        static struct _Anonymous_2
        {
            double s0;
            double s1;
            double s2;
            double s3;
            double s4;
            double s5;
            double s6;
            double s7;
            double s8;
            double s9;
            double sA;
            double sB;
            double sC;
            double sD;
            double sE;
            double sF;
        }
        _Anonymous_2 _anonymous_3;
        auto s0() @property @nogc pure nothrow { return _anonymous_3.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_3.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_3.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_3.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_3.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_3.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_3.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_3.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.s7 = val; }
        auto s8() @property @nogc pure nothrow { return _anonymous_3.s8; }
        void s8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.s8 = val; }
        auto s9() @property @nogc pure nothrow { return _anonymous_3.s9; }
        void s9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.s9 = val; }
        auto sA() @property @nogc pure nothrow { return _anonymous_3.sA; }
        void sA(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.sA = val; }
        auto sB() @property @nogc pure nothrow { return _anonymous_3.sB; }
        void sB(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.sB = val; }
        auto sC() @property @nogc pure nothrow { return _anonymous_3.sC; }
        void sC(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.sC = val; }
        auto sD() @property @nogc pure nothrow { return _anonymous_3.sD; }
        void sD(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.sD = val; }
        auto sE() @property @nogc pure nothrow { return _anonymous_3.sE; }
        void sE(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.sE = val; }
        auto sF() @property @nogc pure nothrow { return _anonymous_3.sF; }
        void sF(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_3.sF = val; }
        static struct _Anonymous_4
        {
            cl_double8 lo;
            cl_double8 hi;
        }
        _Anonymous_4 _anonymous_5;
        auto lo() @property @nogc pure nothrow { return _anonymous_5.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_5.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_5.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_5.hi = val; }
        int [8] v2;
    }
    union cl_double8
    {
        double[8] s;
        static struct _Anonymous_6
        {
            double x;
            double y;
            double z;
            double w;
        }
        _Anonymous_6 _anonymous_7;
        auto x() @property @nogc pure nothrow { return _anonymous_7.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_7.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_7.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_7.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_7.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_7.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_7.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_7.w = val; }
        static struct _Anonymous_8
        {
            double s0;
            double s1;
            double s2;
            double s3;
            double s4;
            double s5;
            double s6;
            double s7;
        }
        _Anonymous_8 _anonymous_9;
        auto s0() @property @nogc pure nothrow { return _anonymous_9.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_9.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_9.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_9.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_9.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_9.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_9.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_9.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_9.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_9.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_9.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_9.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_9.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_9.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_9.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_9.s7 = val; }
        static struct _Anonymous_10
        {
            cl_double4 lo;
            cl_double4 hi;
        }
        _Anonymous_10 _anonymous_11;
        auto lo() @property @nogc pure nothrow { return _anonymous_11.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_11.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_11.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_11.hi = val; }
        int [4] v2;
    }
    alias cl_double3 = cl_double4;
    union cl_double4
    {
        double[4] s;
        static struct _Anonymous_12
        {
            double x;
            double y;
            double z;
            double w;
        }
        _Anonymous_12 _anonymous_13;
        auto x() @property @nogc pure nothrow { return _anonymous_13.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_13.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_13.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_13.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_13.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_13.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_13.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_13.w = val; }
        static struct _Anonymous_14
        {
            double s0;
            double s1;
            double s2;
            double s3;
        }
        _Anonymous_14 _anonymous_15;
        auto s0() @property @nogc pure nothrow { return _anonymous_15.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_15.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_15.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_15.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_15.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_15.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_15.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_15.s3 = val; }
        static struct _Anonymous_16
        {
            cl_double2 lo;
            cl_double2 hi;
        }
        _Anonymous_16 _anonymous_17;
        auto lo() @property @nogc pure nothrow { return _anonymous_17.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_17.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_17.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_17.hi = val; }
        int [2] v2;
    }
    union cl_double2
    {
        double[2] s;
        static struct _Anonymous_18
        {
            double x;
            double y;
        }
        _Anonymous_18 _anonymous_19;
        auto x() @property @nogc pure nothrow { return _anonymous_19.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_19.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_19.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_19.y = val; }
        static struct _Anonymous_20
        {
            double s0;
            double s1;
        }
        _Anonymous_20 _anonymous_21;
        auto s0() @property @nogc pure nothrow { return _anonymous_21.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_21.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_21.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_21.s1 = val; }
        static struct _Anonymous_22
        {
            double lo;
            double hi;
        }
        _Anonymous_22 _anonymous_23;
        auto lo() @property @nogc pure nothrow { return _anonymous_23.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_23.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_23.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_23.hi = val; }
        int v2;
    }
    union cl_float16
    {
        float[16] s;
        static struct _Anonymous_24
        {
            float x;
            float y;
            float z;
            float w;
            float __spacer4;
            float __spacer5;
            float __spacer6;
            float __spacer7;
            float __spacer8;
            float __spacer9;
            float sa;
            float sb;
            float sc;
            float sd;
            float se;
            float sf;
        }
        _Anonymous_24 _anonymous_25;
        auto x() @property @nogc pure nothrow { return _anonymous_25.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_25.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_25.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_25.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.w = val; }
        auto __spacer4() @property @nogc pure nothrow { return _anonymous_25.__spacer4; }
        void __spacer4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.__spacer4 = val; }
        auto __spacer5() @property @nogc pure nothrow { return _anonymous_25.__spacer5; }
        void __spacer5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.__spacer5 = val; }
        auto __spacer6() @property @nogc pure nothrow { return _anonymous_25.__spacer6; }
        void __spacer6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.__spacer6 = val; }
        auto __spacer7() @property @nogc pure nothrow { return _anonymous_25.__spacer7; }
        void __spacer7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.__spacer7 = val; }
        auto __spacer8() @property @nogc pure nothrow { return _anonymous_25.__spacer8; }
        void __spacer8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.__spacer8 = val; }
        auto __spacer9() @property @nogc pure nothrow { return _anonymous_25.__spacer9; }
        void __spacer9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.__spacer9 = val; }
        auto sa() @property @nogc pure nothrow { return _anonymous_25.sa; }
        void sa(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.sa = val; }
        auto sb() @property @nogc pure nothrow { return _anonymous_25.sb; }
        void sb(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.sb = val; }
        auto sc() @property @nogc pure nothrow { return _anonymous_25.sc; }
        void sc(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.sc = val; }
        auto sd() @property @nogc pure nothrow { return _anonymous_25.sd; }
        void sd(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.sd = val; }
        auto se() @property @nogc pure nothrow { return _anonymous_25.se; }
        void se(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.se = val; }
        auto sf() @property @nogc pure nothrow { return _anonymous_25.sf; }
        void sf(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_25.sf = val; }
        static struct _Anonymous_26
        {
            float s0;
            float s1;
            float s2;
            float s3;
            float s4;
            float s5;
            float s6;
            float s7;
            float s8;
            float s9;
            float sA;
            float sB;
            float sC;
            float sD;
            float sE;
            float sF;
        }
        _Anonymous_26 _anonymous_27;
        auto s0() @property @nogc pure nothrow { return _anonymous_27.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_27.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_27.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_27.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_27.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_27.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_27.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_27.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.s7 = val; }
        auto s8() @property @nogc pure nothrow { return _anonymous_27.s8; }
        void s8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.s8 = val; }
        auto s9() @property @nogc pure nothrow { return _anonymous_27.s9; }
        void s9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.s9 = val; }
        auto sA() @property @nogc pure nothrow { return _anonymous_27.sA; }
        void sA(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.sA = val; }
        auto sB() @property @nogc pure nothrow { return _anonymous_27.sB; }
        void sB(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.sB = val; }
        auto sC() @property @nogc pure nothrow { return _anonymous_27.sC; }
        void sC(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.sC = val; }
        auto sD() @property @nogc pure nothrow { return _anonymous_27.sD; }
        void sD(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.sD = val; }
        auto sE() @property @nogc pure nothrow { return _anonymous_27.sE; }
        void sE(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.sE = val; }
        auto sF() @property @nogc pure nothrow { return _anonymous_27.sF; }
        void sF(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_27.sF = val; }
        static struct _Anonymous_28
        {
            cl_float8 lo;
            cl_float8 hi;
        }
        _Anonymous_28 _anonymous_29;
        auto lo() @property @nogc pure nothrow { return _anonymous_29.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_29.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_29.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_29.hi = val; }
        core.simd.float4[8] v2;
        core.simd.float4[4] v4;
    }
    union cl_float8
    {
        float[8] s;
        static struct _Anonymous_30
        {
            float x;
            float y;
            float z;
            float w;
        }
        _Anonymous_30 _anonymous_31;
        auto x() @property @nogc pure nothrow { return _anonymous_31.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_31.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_31.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_31.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_31.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_31.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_31.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_31.w = val; }
        static struct _Anonymous_32
        {
            float s0;
            float s1;
            float s2;
            float s3;
            float s4;
            float s5;
            float s6;
            float s7;
        }
        _Anonymous_32 _anonymous_33;
        auto s0() @property @nogc pure nothrow { return _anonymous_33.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_33.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_33.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_33.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_33.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_33.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_33.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_33.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_33.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_33.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_33.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_33.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_33.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_33.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_33.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_33.s7 = val; }
        static struct _Anonymous_34
        {
            cl_float4 lo;
            cl_float4 hi;
        }
        _Anonymous_34 _anonymous_35;
        auto lo() @property @nogc pure nothrow { return _anonymous_35.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_35.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_35.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_35.hi = val; }
        core.simd.float4[4] v2;
        core.simd.float4[2] v4;
    }
    alias cl_float3 = cl_float4;
    union cl_float4
    {
        float[4] s;
        static struct _Anonymous_36
        {
            float x;
            float y;
            float z;
            float w;
        }
        _Anonymous_36 _anonymous_37;
        auto x() @property @nogc pure nothrow { return _anonymous_37.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_37.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_37.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_37.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_37.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_37.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_37.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_37.w = val; }
        static struct _Anonymous_38
        {
            float s0;
            float s1;
            float s2;
            float s3;
        }
        _Anonymous_38 _anonymous_39;
        auto s0() @property @nogc pure nothrow { return _anonymous_39.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_39.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_39.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_39.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_39.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_39.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_39.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_39.s3 = val; }
        static struct _Anonymous_40
        {
            cl_float2 lo;
            cl_float2 hi;
        }
        _Anonymous_40 _anonymous_41;
        auto lo() @property @nogc pure nothrow { return _anonymous_41.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_41.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_41.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_41.hi = val; }
        core.simd.float4[2] v2;
        core.simd.float4 v4;
    }
    union cl_float2
    {
        float[2] s;
        static struct _Anonymous_42
        {
            float x;
            float y;
        }
        _Anonymous_42 _anonymous_43;
        auto x() @property @nogc pure nothrow { return _anonymous_43.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_43.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_43.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_43.y = val; }
        static struct _Anonymous_44
        {
            float s0;
            float s1;
        }
        _Anonymous_44 _anonymous_45;
        auto s0() @property @nogc pure nothrow { return _anonymous_45.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_45.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_45.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_45.s1 = val; }
        static struct _Anonymous_46
        {
            float lo;
            float hi;
        }
        _Anonymous_46 _anonymous_47;
        auto lo() @property @nogc pure nothrow { return _anonymous_47.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_47.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_47.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_47.hi = val; }
        core.simd.float4 v2;
    }
    union cl_ulong16
    {
        c_ulong[16] s;
        static struct _Anonymous_48
        {
            c_ulong x;
            c_ulong y;
            c_ulong z;
            c_ulong w;
            c_ulong __spacer4;
            c_ulong __spacer5;
            c_ulong __spacer6;
            c_ulong __spacer7;
            c_ulong __spacer8;
            c_ulong __spacer9;
            c_ulong sa;
            c_ulong sb;
            c_ulong sc;
            c_ulong sd;
            c_ulong se;
            c_ulong sf;
        }
        _Anonymous_48 _anonymous_49;
        auto x() @property @nogc pure nothrow { return _anonymous_49.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_49.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_49.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_49.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.w = val; }
        auto __spacer4() @property @nogc pure nothrow { return _anonymous_49.__spacer4; }
        void __spacer4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.__spacer4 = val; }
        auto __spacer5() @property @nogc pure nothrow { return _anonymous_49.__spacer5; }
        void __spacer5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.__spacer5 = val; }
        auto __spacer6() @property @nogc pure nothrow { return _anonymous_49.__spacer6; }
        void __spacer6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.__spacer6 = val; }
        auto __spacer7() @property @nogc pure nothrow { return _anonymous_49.__spacer7; }
        void __spacer7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.__spacer7 = val; }
        auto __spacer8() @property @nogc pure nothrow { return _anonymous_49.__spacer8; }
        void __spacer8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.__spacer8 = val; }
        auto __spacer9() @property @nogc pure nothrow { return _anonymous_49.__spacer9; }
        void __spacer9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.__spacer9 = val; }
        auto sa() @property @nogc pure nothrow { return _anonymous_49.sa; }
        void sa(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.sa = val; }
        auto sb() @property @nogc pure nothrow { return _anonymous_49.sb; }
        void sb(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.sb = val; }
        auto sc() @property @nogc pure nothrow { return _anonymous_49.sc; }
        void sc(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.sc = val; }
        auto sd() @property @nogc pure nothrow { return _anonymous_49.sd; }
        void sd(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.sd = val; }
        auto se() @property @nogc pure nothrow { return _anonymous_49.se; }
        void se(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.se = val; }
        auto sf() @property @nogc pure nothrow { return _anonymous_49.sf; }
        void sf(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_49.sf = val; }
        static struct _Anonymous_50
        {
            c_ulong s0;
            c_ulong s1;
            c_ulong s2;
            c_ulong s3;
            c_ulong s4;
            c_ulong s5;
            c_ulong s6;
            c_ulong s7;
            c_ulong s8;
            c_ulong s9;
            c_ulong sA;
            c_ulong sB;
            c_ulong sC;
            c_ulong sD;
            c_ulong sE;
            c_ulong sF;
        }
        _Anonymous_50 _anonymous_51;
        auto s0() @property @nogc pure nothrow { return _anonymous_51.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_51.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_51.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_51.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_51.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_51.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_51.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_51.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.s7 = val; }
        auto s8() @property @nogc pure nothrow { return _anonymous_51.s8; }
        void s8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.s8 = val; }
        auto s9() @property @nogc pure nothrow { return _anonymous_51.s9; }
        void s9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.s9 = val; }
        auto sA() @property @nogc pure nothrow { return _anonymous_51.sA; }
        void sA(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.sA = val; }
        auto sB() @property @nogc pure nothrow { return _anonymous_51.sB; }
        void sB(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.sB = val; }
        auto sC() @property @nogc pure nothrow { return _anonymous_51.sC; }
        void sC(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.sC = val; }
        auto sD() @property @nogc pure nothrow { return _anonymous_51.sD; }
        void sD(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.sD = val; }
        auto sE() @property @nogc pure nothrow { return _anonymous_51.sE; }
        void sE(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.sE = val; }
        auto sF() @property @nogc pure nothrow { return _anonymous_51.sF; }
        void sF(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_51.sF = val; }
        static struct _Anonymous_52
        {
            cl_ulong8 lo;
            cl_ulong8 hi;
        }
        _Anonymous_52 _anonymous_53;
        auto lo() @property @nogc pure nothrow { return _anonymous_53.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_53.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_53.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_53.hi = val; }
        core.simd.c_ulong8[8] v2;
    }
    union cl_ulong8
    {
        c_ulong[8] s;
        static struct _Anonymous_54
        {
            c_ulong x;
            c_ulong y;
            c_ulong z;
            c_ulong w;
        }
        _Anonymous_54 _anonymous_55;
        auto x() @property @nogc pure nothrow { return _anonymous_55.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_55.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_55.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_55.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_55.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_55.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_55.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_55.w = val; }
        static struct _Anonymous_56
        {
            c_ulong s0;
            c_ulong s1;
            c_ulong s2;
            c_ulong s3;
            c_ulong s4;
            c_ulong s5;
            c_ulong s6;
            c_ulong s7;
        }
        _Anonymous_56 _anonymous_57;
        auto s0() @property @nogc pure nothrow { return _anonymous_57.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_57.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_57.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_57.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_57.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_57.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_57.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_57.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_57.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_57.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_57.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_57.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_57.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_57.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_57.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_57.s7 = val; }
        static struct _Anonymous_58
        {
            cl_ulong4 lo;
            cl_ulong4 hi;
        }
        _Anonymous_58 _anonymous_59;
        auto lo() @property @nogc pure nothrow { return _anonymous_59.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_59.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_59.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_59.hi = val; }
        core.simd.c_ulong8[4] v2;
    }
    alias cl_ulong3 = cl_ulong4;
    union cl_ulong4
    {
        c_ulong[4] s;
        static struct _Anonymous_60
        {
            c_ulong x;
            c_ulong y;
            c_ulong z;
            c_ulong w;
        }
        _Anonymous_60 _anonymous_61;
        auto x() @property @nogc pure nothrow { return _anonymous_61.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_61.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_61.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_61.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_61.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_61.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_61.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_61.w = val; }
        static struct _Anonymous_62
        {
            c_ulong s0;
            c_ulong s1;
            c_ulong s2;
            c_ulong s3;
        }
        _Anonymous_62 _anonymous_63;
        auto s0() @property @nogc pure nothrow { return _anonymous_63.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_63.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_63.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_63.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_63.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_63.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_63.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_63.s3 = val; }
        static struct _Anonymous_64
        {
            cl_ulong2 lo;
            cl_ulong2 hi;
        }
        _Anonymous_64 _anonymous_65;
        auto lo() @property @nogc pure nothrow { return _anonymous_65.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_65.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_65.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_65.hi = val; }
        core.simd.c_ulong8[2] v2;
    }
    union cl_ulong2
    {
        c_ulong[2] s;
        static struct _Anonymous_66
        {
            c_ulong x;
            c_ulong y;
        }
        _Anonymous_66 _anonymous_67;
        auto x() @property @nogc pure nothrow { return _anonymous_67.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_67.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_67.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_67.y = val; }
        static struct _Anonymous_68
        {
            c_ulong s0;
            c_ulong s1;
        }
        _Anonymous_68 _anonymous_69;
        auto s0() @property @nogc pure nothrow { return _anonymous_69.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_69.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_69.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_69.s1 = val; }
        static struct _Anonymous_70
        {
            c_ulong lo;
            c_ulong hi;
        }
        _Anonymous_70 _anonymous_71;
        auto lo() @property @nogc pure nothrow { return _anonymous_71.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_71.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_71.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_71.hi = val; }
        core.simd.c_ulong8 v2;
    }
    union cl_long16
    {
        c_long[16] s;
        static struct _Anonymous_72
        {
            c_long x;
            c_long y;
            c_long z;
            c_long w;
            c_long __spacer4;
            c_long __spacer5;
            c_long __spacer6;
            c_long __spacer7;
            c_long __spacer8;
            c_long __spacer9;
            c_long sa;
            c_long sb;
            c_long sc;
            c_long sd;
            c_long se;
            c_long sf;
        }
        _Anonymous_72 _anonymous_73;
        auto x() @property @nogc pure nothrow { return _anonymous_73.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_73.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_73.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_73.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.w = val; }
        auto __spacer4() @property @nogc pure nothrow { return _anonymous_73.__spacer4; }
        void __spacer4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.__spacer4 = val; }
        auto __spacer5() @property @nogc pure nothrow { return _anonymous_73.__spacer5; }
        void __spacer5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.__spacer5 = val; }
        auto __spacer6() @property @nogc pure nothrow { return _anonymous_73.__spacer6; }
        void __spacer6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.__spacer6 = val; }
        auto __spacer7() @property @nogc pure nothrow { return _anonymous_73.__spacer7; }
        void __spacer7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.__spacer7 = val; }
        auto __spacer8() @property @nogc pure nothrow { return _anonymous_73.__spacer8; }
        void __spacer8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.__spacer8 = val; }
        auto __spacer9() @property @nogc pure nothrow { return _anonymous_73.__spacer9; }
        void __spacer9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.__spacer9 = val; }
        auto sa() @property @nogc pure nothrow { return _anonymous_73.sa; }
        void sa(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.sa = val; }
        auto sb() @property @nogc pure nothrow { return _anonymous_73.sb; }
        void sb(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.sb = val; }
        auto sc() @property @nogc pure nothrow { return _anonymous_73.sc; }
        void sc(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.sc = val; }
        auto sd() @property @nogc pure nothrow { return _anonymous_73.sd; }
        void sd(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.sd = val; }
        auto se() @property @nogc pure nothrow { return _anonymous_73.se; }
        void se(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.se = val; }
        auto sf() @property @nogc pure nothrow { return _anonymous_73.sf; }
        void sf(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_73.sf = val; }
        static struct _Anonymous_74
        {
            c_long s0;
            c_long s1;
            c_long s2;
            c_long s3;
            c_long s4;
            c_long s5;
            c_long s6;
            c_long s7;
            c_long s8;
            c_long s9;
            c_long sA;
            c_long sB;
            c_long sC;
            c_long sD;
            c_long sE;
            c_long sF;
        }
        _Anonymous_74 _anonymous_75;
        auto s0() @property @nogc pure nothrow { return _anonymous_75.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_75.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_75.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_75.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_75.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_75.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_75.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_75.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.s7 = val; }
        auto s8() @property @nogc pure nothrow { return _anonymous_75.s8; }
        void s8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.s8 = val; }
        auto s9() @property @nogc pure nothrow { return _anonymous_75.s9; }
        void s9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.s9 = val; }
        auto sA() @property @nogc pure nothrow { return _anonymous_75.sA; }
        void sA(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.sA = val; }
        auto sB() @property @nogc pure nothrow { return _anonymous_75.sB; }
        void sB(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.sB = val; }
        auto sC() @property @nogc pure nothrow { return _anonymous_75.sC; }
        void sC(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.sC = val; }
        auto sD() @property @nogc pure nothrow { return _anonymous_75.sD; }
        void sD(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.sD = val; }
        auto sE() @property @nogc pure nothrow { return _anonymous_75.sE; }
        void sE(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.sE = val; }
        auto sF() @property @nogc pure nothrow { return _anonymous_75.sF; }
        void sF(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_75.sF = val; }
        static struct _Anonymous_76
        {
            cl_long8 lo;
            cl_long8 hi;
        }
        _Anonymous_76 _anonymous_77;
        auto lo() @property @nogc pure nothrow { return _anonymous_77.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_77.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_77.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_77.hi = val; }
        core.simd.c_long8[8] v2;
    }
    union cl_long8
    {
        c_long[8] s;
        static struct _Anonymous_78
        {
            c_long x;
            c_long y;
            c_long z;
            c_long w;
        }
        _Anonymous_78 _anonymous_79;
        auto x() @property @nogc pure nothrow { return _anonymous_79.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_79.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_79.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_79.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_79.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_79.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_79.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_79.w = val; }
        static struct _Anonymous_80
        {
            c_long s0;
            c_long s1;
            c_long s2;
            c_long s3;
            c_long s4;
            c_long s5;
            c_long s6;
            c_long s7;
        }
        _Anonymous_80 _anonymous_81;
        auto s0() @property @nogc pure nothrow { return _anonymous_81.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_81.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_81.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_81.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_81.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_81.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_81.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_81.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_81.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_81.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_81.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_81.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_81.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_81.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_81.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_81.s7 = val; }
        static struct _Anonymous_82
        {
            cl_long4 lo;
            cl_long4 hi;
        }
        _Anonymous_82 _anonymous_83;
        auto lo() @property @nogc pure nothrow { return _anonymous_83.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_83.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_83.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_83.hi = val; }
        core.simd.c_long8[4] v2;
    }
    alias cl_long3 = cl_long4;
    union cl_long4
    {
        c_long[4] s;
        static struct _Anonymous_84
        {
            c_long x;
            c_long y;
            c_long z;
            c_long w;
        }
        _Anonymous_84 _anonymous_85;
        auto x() @property @nogc pure nothrow { return _anonymous_85.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_85.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_85.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_85.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_85.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_85.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_85.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_85.w = val; }
        static struct _Anonymous_86
        {
            c_long s0;
            c_long s1;
            c_long s2;
            c_long s3;
        }
        _Anonymous_86 _anonymous_87;
        auto s0() @property @nogc pure nothrow { return _anonymous_87.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_87.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_87.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_87.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_87.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_87.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_87.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_87.s3 = val; }
        static struct _Anonymous_88
        {
            cl_long2 lo;
            cl_long2 hi;
        }
        _Anonymous_88 _anonymous_89;
        auto lo() @property @nogc pure nothrow { return _anonymous_89.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_89.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_89.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_89.hi = val; }
        core.simd.c_long8[2] v2;
    }
    union cl_long2
    {
        c_long[2] s;
        static struct _Anonymous_90
        {
            c_long x;
            c_long y;
        }
        _Anonymous_90 _anonymous_91;
        auto x() @property @nogc pure nothrow { return _anonymous_91.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_91.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_91.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_91.y = val; }
        static struct _Anonymous_92
        {
            c_long s0;
            c_long s1;
        }
        _Anonymous_92 _anonymous_93;
        auto s0() @property @nogc pure nothrow { return _anonymous_93.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_93.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_93.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_93.s1 = val; }
        static struct _Anonymous_94
        {
            c_long lo;
            c_long hi;
        }
        _Anonymous_94 _anonymous_95;
        auto lo() @property @nogc pure nothrow { return _anonymous_95.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_95.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_95.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_95.hi = val; }
        core.simd.c_long8 v2;
    }
    union cl_uint16
    {
        uint[16] s;
        static struct _Anonymous_96
        {
            uint x;
            uint y;
            uint z;
            uint w;
            uint __spacer4;
            uint __spacer5;
            uint __spacer6;
            uint __spacer7;
            uint __spacer8;
            uint __spacer9;
            uint sa;
            uint sb;
            uint sc;
            uint sd;
            uint se;
            uint sf;
        }
        _Anonymous_96 _anonymous_97;
        auto x() @property @nogc pure nothrow { return _anonymous_97.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_97.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_97.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_97.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.w = val; }
        auto __spacer4() @property @nogc pure nothrow { return _anonymous_97.__spacer4; }
        void __spacer4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.__spacer4 = val; }
        auto __spacer5() @property @nogc pure nothrow { return _anonymous_97.__spacer5; }
        void __spacer5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.__spacer5 = val; }
        auto __spacer6() @property @nogc pure nothrow { return _anonymous_97.__spacer6; }
        void __spacer6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.__spacer6 = val; }
        auto __spacer7() @property @nogc pure nothrow { return _anonymous_97.__spacer7; }
        void __spacer7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.__spacer7 = val; }
        auto __spacer8() @property @nogc pure nothrow { return _anonymous_97.__spacer8; }
        void __spacer8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.__spacer8 = val; }
        auto __spacer9() @property @nogc pure nothrow { return _anonymous_97.__spacer9; }
        void __spacer9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.__spacer9 = val; }
        auto sa() @property @nogc pure nothrow { return _anonymous_97.sa; }
        void sa(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.sa = val; }
        auto sb() @property @nogc pure nothrow { return _anonymous_97.sb; }
        void sb(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.sb = val; }
        auto sc() @property @nogc pure nothrow { return _anonymous_97.sc; }
        void sc(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.sc = val; }
        auto sd() @property @nogc pure nothrow { return _anonymous_97.sd; }
        void sd(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.sd = val; }
        auto se() @property @nogc pure nothrow { return _anonymous_97.se; }
        void se(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.se = val; }
        auto sf() @property @nogc pure nothrow { return _anonymous_97.sf; }
        void sf(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_97.sf = val; }
        static struct _Anonymous_98
        {
            uint s0;
            uint s1;
            uint s2;
            uint s3;
            uint s4;
            uint s5;
            uint s6;
            uint s7;
            uint s8;
            uint s9;
            uint sA;
            uint sB;
            uint sC;
            uint sD;
            uint sE;
            uint sF;
        }
        _Anonymous_98 _anonymous_99;
        auto s0() @property @nogc pure nothrow { return _anonymous_99.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_99.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_99.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_99.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_99.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_99.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_99.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_99.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.s7 = val; }
        auto s8() @property @nogc pure nothrow { return _anonymous_99.s8; }
        void s8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.s8 = val; }
        auto s9() @property @nogc pure nothrow { return _anonymous_99.s9; }
        void s9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.s9 = val; }
        auto sA() @property @nogc pure nothrow { return _anonymous_99.sA; }
        void sA(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.sA = val; }
        auto sB() @property @nogc pure nothrow { return _anonymous_99.sB; }
        void sB(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.sB = val; }
        auto sC() @property @nogc pure nothrow { return _anonymous_99.sC; }
        void sC(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.sC = val; }
        auto sD() @property @nogc pure nothrow { return _anonymous_99.sD; }
        void sD(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.sD = val; }
        auto sE() @property @nogc pure nothrow { return _anonymous_99.sE; }
        void sE(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.sE = val; }
        auto sF() @property @nogc pure nothrow { return _anonymous_99.sF; }
        void sF(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_99.sF = val; }
        static struct _Anonymous_100
        {
            cl_uint8 lo;
            cl_uint8 hi;
        }
        _Anonymous_100 _anonymous_101;
        auto lo() @property @nogc pure nothrow { return _anonymous_101.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_101.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_101.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_101.hi = val; }
        core.simd.uint4[8] v2;
        core.simd.uint4[4] v4;
    }
    union cl_uint8
    {
        uint[8] s;
        static struct _Anonymous_102
        {
            uint x;
            uint y;
            uint z;
            uint w;
        }
        _Anonymous_102 _anonymous_103;
        auto x() @property @nogc pure nothrow { return _anonymous_103.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_103.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_103.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_103.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_103.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_103.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_103.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_103.w = val; }
        static struct _Anonymous_104
        {
            uint s0;
            uint s1;
            uint s2;
            uint s3;
            uint s4;
            uint s5;
            uint s6;
            uint s7;
        }
        _Anonymous_104 _anonymous_105;
        auto s0() @property @nogc pure nothrow { return _anonymous_105.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_105.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_105.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_105.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_105.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_105.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_105.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_105.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_105.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_105.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_105.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_105.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_105.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_105.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_105.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_105.s7 = val; }
        static struct _Anonymous_106
        {
            cl_uint4 lo;
            cl_uint4 hi;
        }
        _Anonymous_106 _anonymous_107;
        auto lo() @property @nogc pure nothrow { return _anonymous_107.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_107.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_107.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_107.hi = val; }
        core.simd.uint4[4] v2;
        core.simd.uint4[2] v4;
    }
    alias cl_uint3 = cl_uint4;
    union cl_uint4
    {
        uint[4] s;
        static struct _Anonymous_108
        {
            uint x;
            uint y;
            uint z;
            uint w;
        }
        _Anonymous_108 _anonymous_109;
        auto x() @property @nogc pure nothrow { return _anonymous_109.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_109.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_109.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_109.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_109.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_109.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_109.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_109.w = val; }
        static struct _Anonymous_110
        {
            uint s0;
            uint s1;
            uint s2;
            uint s3;
        }
        _Anonymous_110 _anonymous_111;
        auto s0() @property @nogc pure nothrow { return _anonymous_111.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_111.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_111.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_111.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_111.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_111.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_111.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_111.s3 = val; }
        static struct _Anonymous_112
        {
            cl_uint2 lo;
            cl_uint2 hi;
        }
        _Anonymous_112 _anonymous_113;
        auto lo() @property @nogc pure nothrow { return _anonymous_113.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_113.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_113.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_113.hi = val; }
        core.simd.uint4[2] v2;
        core.simd.uint4 v4;
    }
    union cl_uint2
    {
        uint[2] s;
        static struct _Anonymous_114
        {
            uint x;
            uint y;
        }
        _Anonymous_114 _anonymous_115;
        auto x() @property @nogc pure nothrow { return _anonymous_115.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_115.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_115.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_115.y = val; }
        static struct _Anonymous_116
        {
            uint s0;
            uint s1;
        }
        _Anonymous_116 _anonymous_117;
        auto s0() @property @nogc pure nothrow { return _anonymous_117.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_117.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_117.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_117.s1 = val; }
        static struct _Anonymous_118
        {
            uint lo;
            uint hi;
        }
        _Anonymous_118 _anonymous_119;
        auto lo() @property @nogc pure nothrow { return _anonymous_119.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_119.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_119.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_119.hi = val; }
        core.simd.uint4 v2;
    }
    union cl_int16
    {
        int[16] s;
        static struct _Anonymous_120
        {
            int x;
            int y;
            int z;
            int w;
            int __spacer4;
            int __spacer5;
            int __spacer6;
            int __spacer7;
            int __spacer8;
            int __spacer9;
            int sa;
            int sb;
            int sc;
            int sd;
            int se;
            int sf;
        }
        _Anonymous_120 _anonymous_121;
        auto x() @property @nogc pure nothrow { return _anonymous_121.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_121.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_121.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_121.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.w = val; }
        auto __spacer4() @property @nogc pure nothrow { return _anonymous_121.__spacer4; }
        void __spacer4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.__spacer4 = val; }
        auto __spacer5() @property @nogc pure nothrow { return _anonymous_121.__spacer5; }
        void __spacer5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.__spacer5 = val; }
        auto __spacer6() @property @nogc pure nothrow { return _anonymous_121.__spacer6; }
        void __spacer6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.__spacer6 = val; }
        auto __spacer7() @property @nogc pure nothrow { return _anonymous_121.__spacer7; }
        void __spacer7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.__spacer7 = val; }
        auto __spacer8() @property @nogc pure nothrow { return _anonymous_121.__spacer8; }
        void __spacer8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.__spacer8 = val; }
        auto __spacer9() @property @nogc pure nothrow { return _anonymous_121.__spacer9; }
        void __spacer9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.__spacer9 = val; }
        auto sa() @property @nogc pure nothrow { return _anonymous_121.sa; }
        void sa(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.sa = val; }
        auto sb() @property @nogc pure nothrow { return _anonymous_121.sb; }
        void sb(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.sb = val; }
        auto sc() @property @nogc pure nothrow { return _anonymous_121.sc; }
        void sc(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.sc = val; }
        auto sd() @property @nogc pure nothrow { return _anonymous_121.sd; }
        void sd(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.sd = val; }
        auto se() @property @nogc pure nothrow { return _anonymous_121.se; }
        void se(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.se = val; }
        auto sf() @property @nogc pure nothrow { return _anonymous_121.sf; }
        void sf(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_121.sf = val; }
        static struct _Anonymous_122
        {
            int s0;
            int s1;
            int s2;
            int s3;
            int s4;
            int s5;
            int s6;
            int s7;
            int s8;
            int s9;
            int sA;
            int sB;
            int sC;
            int sD;
            int sE;
            int sF;
        }
        _Anonymous_122 _anonymous_123;
        auto s0() @property @nogc pure nothrow { return _anonymous_123.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_123.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_123.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_123.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_123.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_123.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_123.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_123.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.s7 = val; }
        auto s8() @property @nogc pure nothrow { return _anonymous_123.s8; }
        void s8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.s8 = val; }
        auto s9() @property @nogc pure nothrow { return _anonymous_123.s9; }
        void s9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.s9 = val; }
        auto sA() @property @nogc pure nothrow { return _anonymous_123.sA; }
        void sA(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.sA = val; }
        auto sB() @property @nogc pure nothrow { return _anonymous_123.sB; }
        void sB(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.sB = val; }
        auto sC() @property @nogc pure nothrow { return _anonymous_123.sC; }
        void sC(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.sC = val; }
        auto sD() @property @nogc pure nothrow { return _anonymous_123.sD; }
        void sD(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.sD = val; }
        auto sE() @property @nogc pure nothrow { return _anonymous_123.sE; }
        void sE(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.sE = val; }
        auto sF() @property @nogc pure nothrow { return _anonymous_123.sF; }
        void sF(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_123.sF = val; }
        static struct _Anonymous_124
        {
            cl_int8 lo;
            cl_int8 hi;
        }
        _Anonymous_124 _anonymous_125;
        auto lo() @property @nogc pure nothrow { return _anonymous_125.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_125.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_125.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_125.hi = val; }
        core.simd.int4[8] v2;
        core.simd.int4[4] v4;
    }
    union cl_int8
    {
        int[8] s;
        static struct _Anonymous_126
        {
            int x;
            int y;
            int z;
            int w;
        }
        _Anonymous_126 _anonymous_127;
        auto x() @property @nogc pure nothrow { return _anonymous_127.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_127.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_127.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_127.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_127.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_127.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_127.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_127.w = val; }
        static struct _Anonymous_128
        {
            int s0;
            int s1;
            int s2;
            int s3;
            int s4;
            int s5;
            int s6;
            int s7;
        }
        _Anonymous_128 _anonymous_129;
        auto s0() @property @nogc pure nothrow { return _anonymous_129.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_129.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_129.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_129.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_129.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_129.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_129.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_129.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_129.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_129.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_129.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_129.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_129.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_129.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_129.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_129.s7 = val; }
        static struct _Anonymous_130
        {
            cl_int4 lo;
            cl_int4 hi;
        }
        _Anonymous_130 _anonymous_131;
        auto lo() @property @nogc pure nothrow { return _anonymous_131.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_131.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_131.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_131.hi = val; }
        core.simd.int4[4] v2;
        core.simd.int4[2] v4;
    }
    alias cl_int3 = cl_int4;
    union cl_int4
    {
        int[4] s;
        static struct _Anonymous_132
        {
            int x;
            int y;
            int z;
            int w;
        }
        _Anonymous_132 _anonymous_133;
        auto x() @property @nogc pure nothrow { return _anonymous_133.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_133.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_133.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_133.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_133.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_133.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_133.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_133.w = val; }
        static struct _Anonymous_134
        {
            int s0;
            int s1;
            int s2;
            int s3;
        }
        _Anonymous_134 _anonymous_135;
        auto s0() @property @nogc pure nothrow { return _anonymous_135.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_135.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_135.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_135.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_135.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_135.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_135.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_135.s3 = val; }
        static struct _Anonymous_136
        {
            cl_int2 lo;
            cl_int2 hi;
        }
        _Anonymous_136 _anonymous_137;
        auto lo() @property @nogc pure nothrow { return _anonymous_137.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_137.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_137.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_137.hi = val; }
        core.simd.int4[2] v2;
        core.simd.int4 v4;
    }
    union cl_int2
    {
        int[2] s;
        static struct _Anonymous_138
        {
            int x;
            int y;
        }
        _Anonymous_138 _anonymous_139;
        auto x() @property @nogc pure nothrow { return _anonymous_139.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_139.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_139.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_139.y = val; }
        static struct _Anonymous_140
        {
            int s0;
            int s1;
        }
        _Anonymous_140 _anonymous_141;
        auto s0() @property @nogc pure nothrow { return _anonymous_141.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_141.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_141.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_141.s1 = val; }
        static struct _Anonymous_142
        {
            int lo;
            int hi;
        }
        _Anonymous_142 _anonymous_143;
        auto lo() @property @nogc pure nothrow { return _anonymous_143.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_143.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_143.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_143.hi = val; }
        core.simd.int4 v2;
    }
    union cl_ushort16
    {
        ushort[16] s;
        static struct _Anonymous_144
        {
            ushort x;
            ushort y;
            ushort z;
            ushort w;
            ushort __spacer4;
            ushort __spacer5;
            ushort __spacer6;
            ushort __spacer7;
            ushort __spacer8;
            ushort __spacer9;
            ushort sa;
            ushort sb;
            ushort sc;
            ushort sd;
            ushort se;
            ushort sf;
        }
        _Anonymous_144 _anonymous_145;
        auto x() @property @nogc pure nothrow { return _anonymous_145.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_145.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_145.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_145.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.w = val; }
        auto __spacer4() @property @nogc pure nothrow { return _anonymous_145.__spacer4; }
        void __spacer4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.__spacer4 = val; }
        auto __spacer5() @property @nogc pure nothrow { return _anonymous_145.__spacer5; }
        void __spacer5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.__spacer5 = val; }
        auto __spacer6() @property @nogc pure nothrow { return _anonymous_145.__spacer6; }
        void __spacer6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.__spacer6 = val; }
        auto __spacer7() @property @nogc pure nothrow { return _anonymous_145.__spacer7; }
        void __spacer7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.__spacer7 = val; }
        auto __spacer8() @property @nogc pure nothrow { return _anonymous_145.__spacer8; }
        void __spacer8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.__spacer8 = val; }
        auto __spacer9() @property @nogc pure nothrow { return _anonymous_145.__spacer9; }
        void __spacer9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.__spacer9 = val; }
        auto sa() @property @nogc pure nothrow { return _anonymous_145.sa; }
        void sa(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.sa = val; }
        auto sb() @property @nogc pure nothrow { return _anonymous_145.sb; }
        void sb(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.sb = val; }
        auto sc() @property @nogc pure nothrow { return _anonymous_145.sc; }
        void sc(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.sc = val; }
        auto sd() @property @nogc pure nothrow { return _anonymous_145.sd; }
        void sd(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.sd = val; }
        auto se() @property @nogc pure nothrow { return _anonymous_145.se; }
        void se(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.se = val; }
        auto sf() @property @nogc pure nothrow { return _anonymous_145.sf; }
        void sf(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_145.sf = val; }
        static struct _Anonymous_146
        {
            ushort s0;
            ushort s1;
            ushort s2;
            ushort s3;
            ushort s4;
            ushort s5;
            ushort s6;
            ushort s7;
            ushort s8;
            ushort s9;
            ushort sA;
            ushort sB;
            ushort sC;
            ushort sD;
            ushort sE;
            ushort sF;
        }
        _Anonymous_146 _anonymous_147;
        auto s0() @property @nogc pure nothrow { return _anonymous_147.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_147.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_147.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_147.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_147.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_147.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_147.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_147.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.s7 = val; }
        auto s8() @property @nogc pure nothrow { return _anonymous_147.s8; }
        void s8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.s8 = val; }
        auto s9() @property @nogc pure nothrow { return _anonymous_147.s9; }
        void s9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.s9 = val; }
        auto sA() @property @nogc pure nothrow { return _anonymous_147.sA; }
        void sA(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.sA = val; }
        auto sB() @property @nogc pure nothrow { return _anonymous_147.sB; }
        void sB(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.sB = val; }
        auto sC() @property @nogc pure nothrow { return _anonymous_147.sC; }
        void sC(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.sC = val; }
        auto sD() @property @nogc pure nothrow { return _anonymous_147.sD; }
        void sD(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.sD = val; }
        auto sE() @property @nogc pure nothrow { return _anonymous_147.sE; }
        void sE(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.sE = val; }
        auto sF() @property @nogc pure nothrow { return _anonymous_147.sF; }
        void sF(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_147.sF = val; }
        static struct _Anonymous_148
        {
            cl_ushort8 lo;
            cl_ushort8 hi;
        }
        _Anonymous_148 _anonymous_149;
        auto lo() @property @nogc pure nothrow { return _anonymous_149.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_149.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_149.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_149.hi = val; }
        int [4] v4;
        int [2] v8;
    }
    union cl_ushort8
    {
        ushort[8] s;
        static struct _Anonymous_150
        {
            ushort x;
            ushort y;
            ushort z;
            ushort w;
        }
        _Anonymous_150 _anonymous_151;
        auto x() @property @nogc pure nothrow { return _anonymous_151.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_151.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_151.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_151.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_151.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_151.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_151.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_151.w = val; }
        static struct _Anonymous_152
        {
            ushort s0;
            ushort s1;
            ushort s2;
            ushort s3;
            ushort s4;
            ushort s5;
            ushort s6;
            ushort s7;
        }
        _Anonymous_152 _anonymous_153;
        auto s0() @property @nogc pure nothrow { return _anonymous_153.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_153.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_153.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_153.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_153.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_153.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_153.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_153.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_153.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_153.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_153.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_153.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_153.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_153.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_153.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_153.s7 = val; }
        static struct _Anonymous_154
        {
            cl_ushort4 lo;
            cl_ushort4 hi;
        }
        _Anonymous_154 _anonymous_155;
        auto lo() @property @nogc pure nothrow { return _anonymous_155.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_155.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_155.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_155.hi = val; }
        int [2] v4;
        int v8;
    }
    alias cl_ushort3 = cl_ushort4;
    union cl_ushort4
    {
        ushort[4] s;
        static struct _Anonymous_156
        {
            ushort x;
            ushort y;
            ushort z;
            ushort w;
        }
        _Anonymous_156 _anonymous_157;
        auto x() @property @nogc pure nothrow { return _anonymous_157.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_157.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_157.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_157.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_157.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_157.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_157.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_157.w = val; }
        static struct _Anonymous_158
        {
            ushort s0;
            ushort s1;
            ushort s2;
            ushort s3;
        }
        _Anonymous_158 _anonymous_159;
        auto s0() @property @nogc pure nothrow { return _anonymous_159.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_159.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_159.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_159.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_159.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_159.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_159.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_159.s3 = val; }
        static struct _Anonymous_160
        {
            cl_ushort2 lo;
            cl_ushort2 hi;
        }
        _Anonymous_160 _anonymous_161;
        auto lo() @property @nogc pure nothrow { return _anonymous_161.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_161.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_161.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_161.hi = val; }
        int v4;
    }
    union cl_ushort2
    {
        ushort[2] s;
        static struct _Anonymous_162
        {
            ushort x;
            ushort y;
        }
        _Anonymous_162 _anonymous_163;
        auto x() @property @nogc pure nothrow { return _anonymous_163.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_163.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_163.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_163.y = val; }
        static struct _Anonymous_164
        {
            ushort s0;
            ushort s1;
        }
        _Anonymous_164 _anonymous_165;
        auto s0() @property @nogc pure nothrow { return _anonymous_165.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_165.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_165.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_165.s1 = val; }
        static struct _Anonymous_166
        {
            ushort lo;
            ushort hi;
        }
        _Anonymous_166 _anonymous_167;
        auto lo() @property @nogc pure nothrow { return _anonymous_167.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_167.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_167.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_167.hi = val; }
    }
    union cl_short16
    {
        short[16] s;
        static struct _Anonymous_168
        {
            short x;
            short y;
            short z;
            short w;
            short __spacer4;
            short __spacer5;
            short __spacer6;
            short __spacer7;
            short __spacer8;
            short __spacer9;
            short sa;
            short sb;
            short sc;
            short sd;
            short se;
            short sf;
        }
        _Anonymous_168 _anonymous_169;
        auto x() @property @nogc pure nothrow { return _anonymous_169.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_169.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_169.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_169.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.w = val; }
        auto __spacer4() @property @nogc pure nothrow { return _anonymous_169.__spacer4; }
        void __spacer4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.__spacer4 = val; }
        auto __spacer5() @property @nogc pure nothrow { return _anonymous_169.__spacer5; }
        void __spacer5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.__spacer5 = val; }
        auto __spacer6() @property @nogc pure nothrow { return _anonymous_169.__spacer6; }
        void __spacer6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.__spacer6 = val; }
        auto __spacer7() @property @nogc pure nothrow { return _anonymous_169.__spacer7; }
        void __spacer7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.__spacer7 = val; }
        auto __spacer8() @property @nogc pure nothrow { return _anonymous_169.__spacer8; }
        void __spacer8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.__spacer8 = val; }
        auto __spacer9() @property @nogc pure nothrow { return _anonymous_169.__spacer9; }
        void __spacer9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.__spacer9 = val; }
        auto sa() @property @nogc pure nothrow { return _anonymous_169.sa; }
        void sa(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.sa = val; }
        auto sb() @property @nogc pure nothrow { return _anonymous_169.sb; }
        void sb(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.sb = val; }
        auto sc() @property @nogc pure nothrow { return _anonymous_169.sc; }
        void sc(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.sc = val; }
        auto sd() @property @nogc pure nothrow { return _anonymous_169.sd; }
        void sd(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.sd = val; }
        auto se() @property @nogc pure nothrow { return _anonymous_169.se; }
        void se(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.se = val; }
        auto sf() @property @nogc pure nothrow { return _anonymous_169.sf; }
        void sf(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_169.sf = val; }
        static struct _Anonymous_170
        {
            short s0;
            short s1;
            short s2;
            short s3;
            short s4;
            short s5;
            short s6;
            short s7;
            short s8;
            short s9;
            short sA;
            short sB;
            short sC;
            short sD;
            short sE;
            short sF;
        }
        _Anonymous_170 _anonymous_171;
        auto s0() @property @nogc pure nothrow { return _anonymous_171.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_171.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_171.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_171.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_171.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_171.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_171.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_171.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.s7 = val; }
        auto s8() @property @nogc pure nothrow { return _anonymous_171.s8; }
        void s8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.s8 = val; }
        auto s9() @property @nogc pure nothrow { return _anonymous_171.s9; }
        void s9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.s9 = val; }
        auto sA() @property @nogc pure nothrow { return _anonymous_171.sA; }
        void sA(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.sA = val; }
        auto sB() @property @nogc pure nothrow { return _anonymous_171.sB; }
        void sB(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.sB = val; }
        auto sC() @property @nogc pure nothrow { return _anonymous_171.sC; }
        void sC(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.sC = val; }
        auto sD() @property @nogc pure nothrow { return _anonymous_171.sD; }
        void sD(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.sD = val; }
        auto sE() @property @nogc pure nothrow { return _anonymous_171.sE; }
        void sE(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.sE = val; }
        auto sF() @property @nogc pure nothrow { return _anonymous_171.sF; }
        void sF(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_171.sF = val; }
        static struct _Anonymous_172
        {
            cl_short8 lo;
            cl_short8 hi;
        }
        _Anonymous_172 _anonymous_173;
        auto lo() @property @nogc pure nothrow { return _anonymous_173.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_173.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_173.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_173.hi = val; }
        int [4] v4;
        int [2] v8;
    }
    union cl_short8
    {
        short[8] s;
        static struct _Anonymous_174
        {
            short x;
            short y;
            short z;
            short w;
        }
        _Anonymous_174 _anonymous_175;
        auto x() @property @nogc pure nothrow { return _anonymous_175.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_175.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_175.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_175.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_175.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_175.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_175.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_175.w = val; }
        static struct _Anonymous_176
        {
            short s0;
            short s1;
            short s2;
            short s3;
            short s4;
            short s5;
            short s6;
            short s7;
        }
        _Anonymous_176 _anonymous_177;
        auto s0() @property @nogc pure nothrow { return _anonymous_177.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_177.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_177.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_177.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_177.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_177.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_177.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_177.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_177.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_177.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_177.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_177.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_177.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_177.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_177.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_177.s7 = val; }
        static struct _Anonymous_178
        {
            cl_short4 lo;
            cl_short4 hi;
        }
        _Anonymous_178 _anonymous_179;
        auto lo() @property @nogc pure nothrow { return _anonymous_179.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_179.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_179.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_179.hi = val; }
        int [2] v4;
        int v8;
    }
    alias cl_short3 = cl_short4;
    union cl_short4
    {
        short[4] s;
        static struct _Anonymous_180
        {
            short x;
            short y;
            short z;
            short w;
        }
        _Anonymous_180 _anonymous_181;
        auto x() @property @nogc pure nothrow { return _anonymous_181.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_181.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_181.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_181.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_181.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_181.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_181.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_181.w = val; }
        static struct _Anonymous_182
        {
            short s0;
            short s1;
            short s2;
            short s3;
        }
        _Anonymous_182 _anonymous_183;
        auto s0() @property @nogc pure nothrow { return _anonymous_183.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_183.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_183.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_183.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_183.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_183.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_183.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_183.s3 = val; }
        static struct _Anonymous_184
        {
            cl_short2 lo;
            cl_short2 hi;
        }
        _Anonymous_184 _anonymous_185;
        auto lo() @property @nogc pure nothrow { return _anonymous_185.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_185.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_185.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_185.hi = val; }
        int v4;
    }
    union cl_short2
    {
        short[2] s;
        static struct _Anonymous_186
        {
            short x;
            short y;
        }
        _Anonymous_186 _anonymous_187;
        auto x() @property @nogc pure nothrow { return _anonymous_187.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_187.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_187.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_187.y = val; }
        static struct _Anonymous_188
        {
            short s0;
            short s1;
        }
        _Anonymous_188 _anonymous_189;
        auto s0() @property @nogc pure nothrow { return _anonymous_189.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_189.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_189.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_189.s1 = val; }
        static struct _Anonymous_190
        {
            short lo;
            short hi;
        }
        _Anonymous_190 _anonymous_191;
        auto lo() @property @nogc pure nothrow { return _anonymous_191.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_191.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_191.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_191.hi = val; }
    }
    union cl_uchar16
    {
        ubyte[16] s;
        static struct _Anonymous_192
        {
            ubyte x;
            ubyte y;
            ubyte z;
            ubyte w;
            ubyte __spacer4;
            ubyte __spacer5;
            ubyte __spacer6;
            ubyte __spacer7;
            ubyte __spacer8;
            ubyte __spacer9;
            ubyte sa;
            ubyte sb;
            ubyte sc;
            ubyte sd;
            ubyte se;
            ubyte sf;
        }
        _Anonymous_192 _anonymous_193;
        auto x() @property @nogc pure nothrow { return _anonymous_193.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_193.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_193.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_193.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.w = val; }
        auto __spacer4() @property @nogc pure nothrow { return _anonymous_193.__spacer4; }
        void __spacer4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.__spacer4 = val; }
        auto __spacer5() @property @nogc pure nothrow { return _anonymous_193.__spacer5; }
        void __spacer5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.__spacer5 = val; }
        auto __spacer6() @property @nogc pure nothrow { return _anonymous_193.__spacer6; }
        void __spacer6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.__spacer6 = val; }
        auto __spacer7() @property @nogc pure nothrow { return _anonymous_193.__spacer7; }
        void __spacer7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.__spacer7 = val; }
        auto __spacer8() @property @nogc pure nothrow { return _anonymous_193.__spacer8; }
        void __spacer8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.__spacer8 = val; }
        auto __spacer9() @property @nogc pure nothrow { return _anonymous_193.__spacer9; }
        void __spacer9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.__spacer9 = val; }
        auto sa() @property @nogc pure nothrow { return _anonymous_193.sa; }
        void sa(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.sa = val; }
        auto sb() @property @nogc pure nothrow { return _anonymous_193.sb; }
        void sb(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.sb = val; }
        auto sc() @property @nogc pure nothrow { return _anonymous_193.sc; }
        void sc(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.sc = val; }
        auto sd() @property @nogc pure nothrow { return _anonymous_193.sd; }
        void sd(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.sd = val; }
        auto se() @property @nogc pure nothrow { return _anonymous_193.se; }
        void se(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.se = val; }
        auto sf() @property @nogc pure nothrow { return _anonymous_193.sf; }
        void sf(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_193.sf = val; }
        static struct _Anonymous_194
        {
            ubyte s0;
            ubyte s1;
            ubyte s2;
            ubyte s3;
            ubyte s4;
            ubyte s5;
            ubyte s6;
            ubyte s7;
            ubyte s8;
            ubyte s9;
            ubyte sA;
            ubyte sB;
            ubyte sC;
            ubyte sD;
            ubyte sE;
            ubyte sF;
        }
        _Anonymous_194 _anonymous_195;
        auto s0() @property @nogc pure nothrow { return _anonymous_195.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_195.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_195.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_195.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_195.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_195.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_195.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_195.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.s7 = val; }
        auto s8() @property @nogc pure nothrow { return _anonymous_195.s8; }
        void s8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.s8 = val; }
        auto s9() @property @nogc pure nothrow { return _anonymous_195.s9; }
        void s9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.s9 = val; }
        auto sA() @property @nogc pure nothrow { return _anonymous_195.sA; }
        void sA(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.sA = val; }
        auto sB() @property @nogc pure nothrow { return _anonymous_195.sB; }
        void sB(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.sB = val; }
        auto sC() @property @nogc pure nothrow { return _anonymous_195.sC; }
        void sC(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.sC = val; }
        auto sD() @property @nogc pure nothrow { return _anonymous_195.sD; }
        void sD(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.sD = val; }
        auto sE() @property @nogc pure nothrow { return _anonymous_195.sE; }
        void sE(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.sE = val; }
        auto sF() @property @nogc pure nothrow { return _anonymous_195.sF; }
        void sF(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_195.sF = val; }
        static struct _Anonymous_196
        {
            cl_uchar8 lo;
            cl_uchar8 hi;
        }
        _Anonymous_196 _anonymous_197;
        auto lo() @property @nogc pure nothrow { return _anonymous_197.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_197.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_197.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_197.hi = val; }
        int [2] v8;
        int v16;
    }
    union cl_uchar8
    {
        ubyte[8] s;
        static struct _Anonymous_198
        {
            ubyte x;
            ubyte y;
            ubyte z;
            ubyte w;
        }
        _Anonymous_198 _anonymous_199;
        auto x() @property @nogc pure nothrow { return _anonymous_199.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_199.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_199.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_199.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_199.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_199.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_199.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_199.w = val; }
        static struct _Anonymous_200
        {
            ubyte s0;
            ubyte s1;
            ubyte s2;
            ubyte s3;
            ubyte s4;
            ubyte s5;
            ubyte s6;
            ubyte s7;
        }
        _Anonymous_200 _anonymous_201;
        auto s0() @property @nogc pure nothrow { return _anonymous_201.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_201.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_201.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_201.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_201.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_201.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_201.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_201.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_201.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_201.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_201.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_201.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_201.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_201.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_201.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_201.s7 = val; }
        static struct _Anonymous_202
        {
            cl_uchar4 lo;
            cl_uchar4 hi;
        }
        _Anonymous_202 _anonymous_203;
        auto lo() @property @nogc pure nothrow { return _anonymous_203.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_203.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_203.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_203.hi = val; }
        int v8;
    }
    alias cl_uchar3 = cl_uchar4;
    union cl_uchar4
    {
        ubyte[4] s;
        static struct _Anonymous_204
        {
            ubyte x;
            ubyte y;
            ubyte z;
            ubyte w;
        }
        _Anonymous_204 _anonymous_205;
        auto x() @property @nogc pure nothrow { return _anonymous_205.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_205.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_205.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_205.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_205.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_205.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_205.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_205.w = val; }
        static struct _Anonymous_206
        {
            ubyte s0;
            ubyte s1;
            ubyte s2;
            ubyte s3;
        }
        _Anonymous_206 _anonymous_207;
        auto s0() @property @nogc pure nothrow { return _anonymous_207.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_207.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_207.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_207.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_207.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_207.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_207.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_207.s3 = val; }
        static struct _Anonymous_208
        {
            cl_uchar2 lo;
            cl_uchar2 hi;
        }
        _Anonymous_208 _anonymous_209;
        auto lo() @property @nogc pure nothrow { return _anonymous_209.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_209.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_209.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_209.hi = val; }
    }
    union cl_uchar2
    {
        ubyte[2] s;
        static struct _Anonymous_210
        {
            ubyte x;
            ubyte y;
        }
        _Anonymous_210 _anonymous_211;
        auto x() @property @nogc pure nothrow { return _anonymous_211.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_211.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_211.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_211.y = val; }
        static struct _Anonymous_212
        {
            ubyte s0;
            ubyte s1;
        }
        _Anonymous_212 _anonymous_213;
        auto s0() @property @nogc pure nothrow { return _anonymous_213.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_213.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_213.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_213.s1 = val; }
        static struct _Anonymous_214
        {
            ubyte lo;
            ubyte hi;
        }
        _Anonymous_214 _anonymous_215;
        auto lo() @property @nogc pure nothrow { return _anonymous_215.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_215.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_215.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_215.hi = val; }
    }
    union cl_char16
    {
        byte[16] s;
        static struct _Anonymous_216
        {
            byte x;
            byte y;
            byte z;
            byte w;
            byte __spacer4;
            byte __spacer5;
            byte __spacer6;
            byte __spacer7;
            byte __spacer8;
            byte __spacer9;
            byte sa;
            byte sb;
            byte sc;
            byte sd;
            byte se;
            byte sf;
        }
        _Anonymous_216 _anonymous_217;
        auto x() @property @nogc pure nothrow { return _anonymous_217.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_217.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_217.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_217.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.w = val; }
        auto __spacer4() @property @nogc pure nothrow { return _anonymous_217.__spacer4; }
        void __spacer4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.__spacer4 = val; }
        auto __spacer5() @property @nogc pure nothrow { return _anonymous_217.__spacer5; }
        void __spacer5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.__spacer5 = val; }
        auto __spacer6() @property @nogc pure nothrow { return _anonymous_217.__spacer6; }
        void __spacer6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.__spacer6 = val; }
        auto __spacer7() @property @nogc pure nothrow { return _anonymous_217.__spacer7; }
        void __spacer7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.__spacer7 = val; }
        auto __spacer8() @property @nogc pure nothrow { return _anonymous_217.__spacer8; }
        void __spacer8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.__spacer8 = val; }
        auto __spacer9() @property @nogc pure nothrow { return _anonymous_217.__spacer9; }
        void __spacer9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.__spacer9 = val; }
        auto sa() @property @nogc pure nothrow { return _anonymous_217.sa; }
        void sa(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.sa = val; }
        auto sb() @property @nogc pure nothrow { return _anonymous_217.sb; }
        void sb(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.sb = val; }
        auto sc() @property @nogc pure nothrow { return _anonymous_217.sc; }
        void sc(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.sc = val; }
        auto sd() @property @nogc pure nothrow { return _anonymous_217.sd; }
        void sd(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.sd = val; }
        auto se() @property @nogc pure nothrow { return _anonymous_217.se; }
        void se(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.se = val; }
        auto sf() @property @nogc pure nothrow { return _anonymous_217.sf; }
        void sf(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_217.sf = val; }
        static struct _Anonymous_218
        {
            byte s0;
            byte s1;
            byte s2;
            byte s3;
            byte s4;
            byte s5;
            byte s6;
            byte s7;
            byte s8;
            byte s9;
            byte sA;
            byte sB;
            byte sC;
            byte sD;
            byte sE;
            byte sF;
        }
        _Anonymous_218 _anonymous_219;
        auto s0() @property @nogc pure nothrow { return _anonymous_219.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_219.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_219.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_219.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_219.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_219.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_219.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_219.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.s7 = val; }
        auto s8() @property @nogc pure nothrow { return _anonymous_219.s8; }
        void s8(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.s8 = val; }
        auto s9() @property @nogc pure nothrow { return _anonymous_219.s9; }
        void s9(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.s9 = val; }
        auto sA() @property @nogc pure nothrow { return _anonymous_219.sA; }
        void sA(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.sA = val; }
        auto sB() @property @nogc pure nothrow { return _anonymous_219.sB; }
        void sB(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.sB = val; }
        auto sC() @property @nogc pure nothrow { return _anonymous_219.sC; }
        void sC(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.sC = val; }
        auto sD() @property @nogc pure nothrow { return _anonymous_219.sD; }
        void sD(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.sD = val; }
        auto sE() @property @nogc pure nothrow { return _anonymous_219.sE; }
        void sE(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.sE = val; }
        auto sF() @property @nogc pure nothrow { return _anonymous_219.sF; }
        void sF(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_219.sF = val; }
        static struct _Anonymous_220
        {
            cl_char8 lo;
            cl_char8 hi;
        }
        _Anonymous_220 _anonymous_221;
        auto lo() @property @nogc pure nothrow { return _anonymous_221.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_221.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_221.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_221.hi = val; }
        int [2] v8;
        int v16;
    }
    union cl_char8
    {
        byte[8] s;
        static struct _Anonymous_222
        {
            byte x;
            byte y;
            byte z;
            byte w;
        }
        _Anonymous_222 _anonymous_223;
        auto x() @property @nogc pure nothrow { return _anonymous_223.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_223.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_223.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_223.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_223.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_223.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_223.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_223.w = val; }
        static struct _Anonymous_224
        {
            byte s0;
            byte s1;
            byte s2;
            byte s3;
            byte s4;
            byte s5;
            byte s6;
            byte s7;
        }
        _Anonymous_224 _anonymous_225;
        auto s0() @property @nogc pure nothrow { return _anonymous_225.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_225.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_225.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_225.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_225.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_225.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_225.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_225.s3 = val; }
        auto s4() @property @nogc pure nothrow { return _anonymous_225.s4; }
        void s4(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_225.s4 = val; }
        auto s5() @property @nogc pure nothrow { return _anonymous_225.s5; }
        void s5(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_225.s5 = val; }
        auto s6() @property @nogc pure nothrow { return _anonymous_225.s6; }
        void s6(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_225.s6 = val; }
        auto s7() @property @nogc pure nothrow { return _anonymous_225.s7; }
        void s7(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_225.s7 = val; }
        static struct _Anonymous_226
        {
            cl_char4 lo;
            cl_char4 hi;
        }
        _Anonymous_226 _anonymous_227;
        auto lo() @property @nogc pure nothrow { return _anonymous_227.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_227.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_227.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_227.hi = val; }
        int v8;
    }
    alias cl_char3 = cl_char4;
    union cl_char4
    {
        byte[4] s;
        static struct _Anonymous_228
        {
            byte x;
            byte y;
            byte z;
            byte w;
        }
        _Anonymous_228 _anonymous_229;
        auto x() @property @nogc pure nothrow { return _anonymous_229.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_229.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_229.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_229.y = val; }
        auto z() @property @nogc pure nothrow { return _anonymous_229.z; }
        void z(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_229.z = val; }
        auto w() @property @nogc pure nothrow { return _anonymous_229.w; }
        void w(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_229.w = val; }
        static struct _Anonymous_230
        {
            byte s0;
            byte s1;
            byte s2;
            byte s3;
        }
        _Anonymous_230 _anonymous_231;
        auto s0() @property @nogc pure nothrow { return _anonymous_231.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_231.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_231.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_231.s1 = val; }
        auto s2() @property @nogc pure nothrow { return _anonymous_231.s2; }
        void s2(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_231.s2 = val; }
        auto s3() @property @nogc pure nothrow { return _anonymous_231.s3; }
        void s3(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_231.s3 = val; }
        static struct _Anonymous_232
        {
            cl_char2 lo;
            cl_char2 hi;
        }
        _Anonymous_232 _anonymous_233;
        auto lo() @property @nogc pure nothrow { return _anonymous_233.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_233.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_233.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_233.hi = val; }
    }
    union cl_char2
    {
        byte[2] s;
        static struct _Anonymous_234
        {
            byte x;
            byte y;
        }
        _Anonymous_234 _anonymous_235;
        auto x() @property @nogc pure nothrow { return _anonymous_235.x; }
        void x(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_235.x = val; }
        auto y() @property @nogc pure nothrow { return _anonymous_235.y; }
        void y(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_235.y = val; }
        static struct _Anonymous_236
        {
            byte s0;
            byte s1;
        }
        _Anonymous_236 _anonymous_237;
        auto s0() @property @nogc pure nothrow { return _anonymous_237.s0; }
        void s0(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_237.s0 = val; }
        auto s1() @property @nogc pure nothrow { return _anonymous_237.s1; }
        void s1(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_237.s1 = val; }
        static struct _Anonymous_238
        {
            byte lo;
            byte hi;
        }
        _Anonymous_238 _anonymous_239;
        auto lo() @property @nogc pure nothrow { return _anonymous_239.lo; }
        void lo(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_239.lo = val; }
        auto hi() @property @nogc pure nothrow { return _anonymous_239.hi; }
        void hi(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_239.hi = val; }
    }
    alias __cl_float2 = core.simd.float4;
    alias __cl_long1 = core.simd.c_long8;
    alias __cl_ulong1 = core.simd.c_ulong8;
    alias __cl_int2 = core.simd.int4;
    alias __cl_uint2 = core.simd.uint4;
    alias __cl_short4 = int ;
    alias __cl_ushort4 = int ;
    alias __cl_char8 = int ;
    pragma(mangle, "alloca") void* alloca_(c_ulong) @nogc nothrow;
    alias __cl_uchar8 = int ;
    struct max_align_t
    {
        long __clang_max_align_nonce1;
        real __clang_max_align_nonce2;
    }
    alias __m128d = int ;
    alias __m128i = int ;
    alias __v2df = int ;
    alias __v2di = int ;
    alias __v8hi = int ;
    alias __v16qi = int ;
    alias __v2du = int ;
    alias __v8hu = int ;
    alias __v16qu = int ;
    alias __v16qs = int ;
    static int _mm_add_sd(int , int ) @nogc nothrow;
    static int _mm_add_pd(int , int ) @nogc nothrow;
    static int _mm_sub_sd(int , int ) @nogc nothrow;
    static int _mm_sub_pd(int , int ) @nogc nothrow;
    static int _mm_mul_sd(int , int ) @nogc nothrow;
    static int _mm_mul_pd(int , int ) @nogc nothrow;
    static int _mm_div_sd(int , int ) @nogc nothrow;
    static int _mm_div_pd(int , int ) @nogc nothrow;
    static int _mm_sqrt_sd(int , int ) @nogc nothrow;
    static int _mm_sqrt_pd(int ) @nogc nothrow;
    static int _mm_min_sd(int , int ) @nogc nothrow;
    static int _mm_min_pd(int , int ) @nogc nothrow;
    static int _mm_max_sd(int , int ) @nogc nothrow;
    static int _mm_max_pd(int , int ) @nogc nothrow;
    static int _mm_and_pd(int , int ) @nogc nothrow;
    static int _mm_andnot_pd(int , int ) @nogc nothrow;
    static int _mm_or_pd(int , int ) @nogc nothrow;
    static int _mm_xor_pd(int , int ) @nogc nothrow;
    static int _mm_cmpeq_pd(int , int ) @nogc nothrow;
    static int _mm_cmplt_pd(int , int ) @nogc nothrow;
    static int _mm_cmple_pd(int , int ) @nogc nothrow;
    static int _mm_cmpgt_pd(int , int ) @nogc nothrow;
    static int _mm_cmpge_pd(int , int ) @nogc nothrow;
    static int _mm_cmpord_pd(int , int ) @nogc nothrow;
    static int _mm_cmpunord_pd(int , int ) @nogc nothrow;
    static int _mm_cmpneq_pd(int , int ) @nogc nothrow;
    static int _mm_cmpnlt_pd(int , int ) @nogc nothrow;
    static int _mm_cmpnle_pd(int , int ) @nogc nothrow;
    static int _mm_cmpngt_pd(int , int ) @nogc nothrow;
    static int _mm_cmpnge_pd(int , int ) @nogc nothrow;
    static int _mm_cmpeq_sd(int , int ) @nogc nothrow;
    static int _mm_cmplt_sd(int , int ) @nogc nothrow;
    static int _mm_cmple_sd(int , int ) @nogc nothrow;
    static int _mm_cmpgt_sd(int , int ) @nogc nothrow;
    static int _mm_cmpge_sd(int , int ) @nogc nothrow;
    static int _mm_cmpord_sd(int , int ) @nogc nothrow;
    static int _mm_cmpunord_sd(int , int ) @nogc nothrow;
    static int _mm_cmpneq_sd(int , int ) @nogc nothrow;
    static int _mm_cmpnlt_sd(int , int ) @nogc nothrow;
    static int _mm_cmpnle_sd(int , int ) @nogc nothrow;
    static int _mm_cmpngt_sd(int , int ) @nogc nothrow;
    static int _mm_cmpnge_sd(int , int ) @nogc nothrow;
    static int _mm_comieq_sd(int , int ) @nogc nothrow;
    static int _mm_comilt_sd(int , int ) @nogc nothrow;
    static int _mm_comile_sd(int , int ) @nogc nothrow;
    static int _mm_comigt_sd(int , int ) @nogc nothrow;
    static int _mm_comige_sd(int , int ) @nogc nothrow;
    static int _mm_comineq_sd(int , int ) @nogc nothrow;
    static int _mm_ucomieq_sd(int , int ) @nogc nothrow;
    static int _mm_ucomilt_sd(int , int ) @nogc nothrow;
    static int _mm_ucomile_sd(int , int ) @nogc nothrow;
    static int _mm_ucomigt_sd(int , int ) @nogc nothrow;
    static int _mm_ucomige_sd(int , int ) @nogc nothrow;
    static int _mm_ucomineq_sd(int , int ) @nogc nothrow;
    static core.simd.float4 _mm_cvtpd_ps(int ) @nogc nothrow;
    static int _mm_cvtps_pd(core.simd.float4) @nogc nothrow;
    static int _mm_cvtepi32_pd(int ) @nogc nothrow;
    static int _mm_cvtpd_epi32(int ) @nogc nothrow;
    static int _mm_cvtsd_si32(int ) @nogc nothrow;
    static core.simd.float4 _mm_cvtsd_ss(core.simd.float4, int ) @nogc nothrow;
    static int _mm_cvtsi32_sd(int , int) @nogc nothrow;
    static int _mm_cvtss_sd(int , core.simd.float4) @nogc nothrow;
    static int _mm_cvttpd_epi32(int ) @nogc nothrow;
    static int _mm_cvttsd_si32(int ) @nogc nothrow;
    static int _mm_cvtpd_pi32(int ) @nogc nothrow;
    static int _mm_cvttpd_pi32(int ) @nogc nothrow;
    static int _mm_cvtpi32_pd(int ) @nogc nothrow;
    static double _mm_cvtsd_f64(int ) @nogc nothrow;
    static int _mm_load_pd(const(double)*) @nogc nothrow;
    static int _mm_load1_pd(const(double)*) @nogc nothrow;
    alias __cl_double2 = int ;
    static int _mm_loadr_pd(const(double)*) @nogc nothrow;
    static int _mm_loadu_pd(const(double)*) @nogc nothrow;
    static int _mm_loadu_si64(const(void)*) @nogc nothrow;
    static int _mm_load_sd(const(double)*) @nogc nothrow;
    static int _mm_loadh_pd(int , const(double)*) @nogc nothrow;
    static int _mm_loadl_pd(int , const(double)*) @nogc nothrow;
    static int _mm_undefined_pd() @nogc nothrow;
    static int _mm_set_sd(double) @nogc nothrow;
    static int _mm_set1_pd(double) @nogc nothrow;
    static int _mm_set_pd1(double) @nogc nothrow;
    static int _mm_set_pd(double, double) @nogc nothrow;
    static int _mm_setr_pd(double, double) @nogc nothrow;
    static int _mm_setzero_pd() @nogc nothrow;
    static int _mm_move_sd(int , int ) @nogc nothrow;
    static void _mm_store_sd(double*, int ) @nogc nothrow;
    static void _mm_store_pd(double*, int ) @nogc nothrow;
    static void _mm_store1_pd(double*, int ) @nogc nothrow;
    static void _mm_store_pd1(double*, int ) @nogc nothrow;
    static void _mm_storeu_pd(double*, int ) @nogc nothrow;
    static void _mm_storer_pd(double*, int ) @nogc nothrow;
    static void _mm_storeh_pd(double*, int ) @nogc nothrow;
    static void _mm_storel_pd(double*, int ) @nogc nothrow;
    static int _mm_add_epi8(int , int ) @nogc nothrow;
    static int _mm_add_epi16(int , int ) @nogc nothrow;
    static int _mm_add_epi32(int , int ) @nogc nothrow;
    static int _mm_add_si64(int , int ) @nogc nothrow;
    static int _mm_add_epi64(int , int ) @nogc nothrow;
    static int _mm_adds_epi8(int , int ) @nogc nothrow;
    static int _mm_adds_epi16(int , int ) @nogc nothrow;
    static int _mm_adds_epu8(int , int ) @nogc nothrow;
    static int _mm_adds_epu16(int , int ) @nogc nothrow;
    static int _mm_avg_epu8(int , int ) @nogc nothrow;
    static int _mm_avg_epu16(int , int ) @nogc nothrow;
    static int _mm_madd_epi16(int , int ) @nogc nothrow;
    static int _mm_max_epi16(int , int ) @nogc nothrow;
    static int _mm_max_epu8(int , int ) @nogc nothrow;
    static int _mm_min_epi16(int , int ) @nogc nothrow;
    static int _mm_min_epu8(int , int ) @nogc nothrow;
    static int _mm_mulhi_epi16(int , int ) @nogc nothrow;
    static int _mm_mulhi_epu16(int , int ) @nogc nothrow;
    static int _mm_mullo_epi16(int , int ) @nogc nothrow;
    static int _mm_mul_su32(int , int ) @nogc nothrow;
    static int _mm_mul_epu32(int , int ) @nogc nothrow;
    static int _mm_sad_epu8(int , int ) @nogc nothrow;
    static int _mm_sub_epi8(int , int ) @nogc nothrow;
    static int _mm_sub_epi16(int , int ) @nogc nothrow;
    static int _mm_sub_epi32(int , int ) @nogc nothrow;
    static int _mm_sub_si64(int , int ) @nogc nothrow;
    static int _mm_sub_epi64(int , int ) @nogc nothrow;
    static int _mm_subs_epi8(int , int ) @nogc nothrow;
    static int _mm_subs_epi16(int , int ) @nogc nothrow;
    static int _mm_subs_epu8(int , int ) @nogc nothrow;
    static int _mm_subs_epu16(int , int ) @nogc nothrow;
    static int _mm_and_si128(int , int ) @nogc nothrow;
    static int _mm_andnot_si128(int , int ) @nogc nothrow;
    static int _mm_or_si128(int , int ) @nogc nothrow;
    static int _mm_xor_si128(int , int ) @nogc nothrow;
    alias __cl_long2 = core.simd.c_long8;
    alias __cl_ulong2 = core.simd.c_ulong8;
    static int _mm_slli_epi16(int , int) @nogc nothrow;
    static int _mm_sll_epi16(int , int ) @nogc nothrow;
    static int _mm_slli_epi32(int , int) @nogc nothrow;
    static int _mm_sll_epi32(int , int ) @nogc nothrow;
    static int _mm_slli_epi64(int , int) @nogc nothrow;
    static int _mm_sll_epi64(int , int ) @nogc nothrow;
    static int _mm_srai_epi16(int , int) @nogc nothrow;
    static int _mm_sra_epi16(int , int ) @nogc nothrow;
    static int _mm_srai_epi32(int , int) @nogc nothrow;
    static int _mm_sra_epi32(int , int ) @nogc nothrow;
    alias __cl_int4 = core.simd.int4;
    alias __cl_uint4 = core.simd.uint4;
    static int _mm_srli_epi16(int , int) @nogc nothrow;
    static int _mm_srl_epi16(int , int ) @nogc nothrow;
    static int _mm_srli_epi32(int , int) @nogc nothrow;
    static int _mm_srl_epi32(int , int ) @nogc nothrow;
    static int _mm_srli_epi64(int , int) @nogc nothrow;
    static int _mm_srl_epi64(int , int ) @nogc nothrow;
    static int _mm_cmpeq_epi8(int , int ) @nogc nothrow;
    static int _mm_cmpeq_epi16(int , int ) @nogc nothrow;
    static int _mm_cmpeq_epi32(int , int ) @nogc nothrow;
    static int _mm_cmpgt_epi8(int , int ) @nogc nothrow;
    static int _mm_cmpgt_epi16(int , int ) @nogc nothrow;
    static int _mm_cmpgt_epi32(int , int ) @nogc nothrow;
    static int _mm_cmplt_epi8(int , int ) @nogc nothrow;
    static int _mm_cmplt_epi16(int , int ) @nogc nothrow;
    static int _mm_cmplt_epi32(int , int ) @nogc nothrow;
    static int _mm_cvtsi64_sd(int , long) @nogc nothrow;
    static long _mm_cvtsd_si64(int ) @nogc nothrow;
    static long _mm_cvttsd_si64(int ) @nogc nothrow;
    static core.simd.float4 _mm_cvtepi32_ps(int ) @nogc nothrow;
    static int _mm_cvtps_epi32(core.simd.float4) @nogc nothrow;
    static int _mm_cvttps_epi32(core.simd.float4) @nogc nothrow;
    static int _mm_cvtsi32_si128(int) @nogc nothrow;
    static int _mm_cvtsi64_si128(long) @nogc nothrow;
    static int _mm_cvtsi128_si32(int ) @nogc nothrow;
    static long _mm_cvtsi128_si64(int ) @nogc nothrow;
    static int _mm_load_si128(const(int )*) @nogc nothrow;
    static int _mm_loadu_si128(const(int )*) @nogc nothrow;
    static int _mm_loadl_epi64(const(int )*) @nogc nothrow;
    static int _mm_undefined_si128() @nogc nothrow;
    static int _mm_set_epi64x(long, long) @nogc nothrow;
    static int _mm_set_epi64(int , int ) @nogc nothrow;
    static int _mm_set_epi32(int, int, int, int) @nogc nothrow;
    static int _mm_set_epi16(short, short, short, short, short, short, short, short) @nogc nothrow;
    static int _mm_set_epi8(char, char, char, char, char, char, char, char, char, char, char, char, char, char, char, char) @nogc nothrow;
    static int _mm_set1_epi64x(long) @nogc nothrow;
    static int _mm_set1_epi64(int ) @nogc nothrow;
    static int _mm_set1_epi32(int) @nogc nothrow;
    static int _mm_set1_epi16(short) @nogc nothrow;
    static int _mm_set1_epi8(char) @nogc nothrow;
    static int _mm_setr_epi64(int , int ) @nogc nothrow;
    static int _mm_setr_epi32(int, int, int, int) @nogc nothrow;
    static int _mm_setr_epi16(short, short, short, short, short, short, short, short) @nogc nothrow;
    static int _mm_setr_epi8(char, char, char, char, char, char, char, char, char, char, char, char, char, char, char, char) @nogc nothrow;
    static int _mm_setzero_si128() @nogc nothrow;
    static void _mm_store_si128(int *, int ) @nogc nothrow;
    static void _mm_storeu_si128(int *, int ) @nogc nothrow;
    static void _mm_maskmoveu_si128(int , int , char*) @nogc nothrow;
    static void _mm_storel_epi64(int *, int ) @nogc nothrow;
    static void _mm_stream_pd(double*, int ) @nogc nothrow;
    static void _mm_stream_si128(int *, int ) @nogc nothrow;
    static void _mm_stream_si32(int*, int) @nogc nothrow;
    static void _mm_stream_si64(long*, long) @nogc nothrow;
    void _mm_clflush(const(void)*) @nogc nothrow;
    void _mm_lfence() @nogc nothrow;
    void _mm_mfence() @nogc nothrow;
    static int _mm_packs_epi16(int , int ) @nogc nothrow;
    static int _mm_packs_epi32(int , int ) @nogc nothrow;
    static int _mm_packus_epi16(int , int ) @nogc nothrow;
    static int _mm_extract_epi16(int , int) @nogc nothrow;
    static int _mm_insert_epi16(int , int, int) @nogc nothrow;
    static int _mm_movemask_epi8(int ) @nogc nothrow;
    alias __cl_short8 = int ;
    alias __cl_ushort8 = int ;
    alias __cl_char16 = int ;
    static int _mm_unpackhi_epi8(int , int ) @nogc nothrow;
    static int _mm_unpackhi_epi16(int , int ) @nogc nothrow;
    static int _mm_unpackhi_epi32(int , int ) @nogc nothrow;
    static int _mm_unpackhi_epi64(int , int ) @nogc nothrow;
    static int _mm_unpacklo_epi8(int , int ) @nogc nothrow;
    static int _mm_unpacklo_epi16(int , int ) @nogc nothrow;
    static int _mm_unpacklo_epi32(int , int ) @nogc nothrow;
    static int _mm_unpacklo_epi64(int , int ) @nogc nothrow;
    static int _mm_movepi64_pi64(int ) @nogc nothrow;
    static int _mm_movpi64_epi64(int ) @nogc nothrow;
    static int _mm_move_epi64(int ) @nogc nothrow;
    static int _mm_unpackhi_pd(int , int ) @nogc nothrow;
    static int _mm_unpacklo_pd(int , int ) @nogc nothrow;
    static int _mm_movemask_pd(int ) @nogc nothrow;
    alias __cl_uchar16 = int ;
    static core.simd.float4 _mm_castpd_ps(int ) @nogc nothrow;
    static int _mm_castpd_si128(int ) @nogc nothrow;
    static int _mm_castps_pd(core.simd.float4) @nogc nothrow;
    static int _mm_castps_si128(core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_castsi128_ps(int ) @nogc nothrow;
    static int _mm_castsi128_pd(int ) @nogc nothrow;
    void _mm_pause() @nogc nothrow;
    alias __cl_float4 = core.simd.float4;
    alias cl_GLenum = uint;
    static float _cvtsh_ss(ushort) @nogc nothrow;
    alias cl_GLint = int;
    alias cl_GLuint = uint;
    static core.simd.float4 _mm_cvtph_ps(int ) @nogc nothrow;
    static void* _mm_malloc(c_ulong, c_ulong) @nogc nothrow;
    static void _mm_free(void*) @nogc nothrow;
    alias __m64 = int ;
    alias __v1di = int ;
    alias __v2si = core.simd.int4;
    alias __v4hi = int ;
    alias __v8qi = int ;
    alias cl_double = double;
    static void _mm_empty() @nogc nothrow;
    static int _mm_cvtsi32_si64(int) @nogc nothrow;
    static int _mm_cvtsi64_si32(int ) @nogc nothrow;
    static int _mm_cvtsi64_m64(long) @nogc nothrow;
    static long _mm_cvtm64_si64(int ) @nogc nothrow;
    static int _mm_packs_pi16(int , int ) @nogc nothrow;
    static int _mm_packs_pi32(int , int ) @nogc nothrow;
    static int _mm_packs_pu16(int , int ) @nogc nothrow;
    static int _mm_unpackhi_pi8(int , int ) @nogc nothrow;
    static int _mm_unpackhi_pi16(int , int ) @nogc nothrow;
    static int _mm_unpackhi_pi32(int , int ) @nogc nothrow;
    static int _mm_unpacklo_pi8(int , int ) @nogc nothrow;
    static int _mm_unpacklo_pi16(int , int ) @nogc nothrow;
    static int _mm_unpacklo_pi32(int , int ) @nogc nothrow;
    static int _mm_add_pi8(int , int ) @nogc nothrow;
    static int _mm_add_pi16(int , int ) @nogc nothrow;
    static int _mm_add_pi32(int , int ) @nogc nothrow;
    static int _mm_adds_pi8(int , int ) @nogc nothrow;
    static int _mm_adds_pi16(int , int ) @nogc nothrow;
    static int _mm_adds_pu8(int , int ) @nogc nothrow;
    static int _mm_adds_pu16(int , int ) @nogc nothrow;
    static int _mm_sub_pi8(int , int ) @nogc nothrow;
    static int _mm_sub_pi16(int , int ) @nogc nothrow;
    static int _mm_sub_pi32(int , int ) @nogc nothrow;
    static int _mm_subs_pi8(int , int ) @nogc nothrow;
    static int _mm_subs_pi16(int , int ) @nogc nothrow;
    static int _mm_subs_pu8(int , int ) @nogc nothrow;
    static int _mm_subs_pu16(int , int ) @nogc nothrow;
    static int _mm_madd_pi16(int , int ) @nogc nothrow;
    static int _mm_mulhi_pi16(int , int ) @nogc nothrow;
    static int _mm_mullo_pi16(int , int ) @nogc nothrow;
    static int _mm_sll_pi16(int , int ) @nogc nothrow;
    static int _mm_slli_pi16(int , int) @nogc nothrow;
    static int _mm_sll_pi32(int , int ) @nogc nothrow;
    static int _mm_slli_pi32(int , int) @nogc nothrow;
    static int _mm_sll_si64(int , int ) @nogc nothrow;
    static int _mm_slli_si64(int , int) @nogc nothrow;
    static int _mm_sra_pi16(int , int ) @nogc nothrow;
    static int _mm_srai_pi16(int , int) @nogc nothrow;
    static int _mm_sra_pi32(int , int ) @nogc nothrow;
    static int _mm_srai_pi32(int , int) @nogc nothrow;
    static int _mm_srl_pi16(int , int ) @nogc nothrow;
    static int _mm_srli_pi16(int , int) @nogc nothrow;
    static int _mm_srl_pi32(int , int ) @nogc nothrow;
    static int _mm_srli_pi32(int , int) @nogc nothrow;
    static int _mm_srl_si64(int , int ) @nogc nothrow;
    static int _mm_srli_si64(int , int) @nogc nothrow;
    static int _mm_and_si64(int , int ) @nogc nothrow;
    static int _mm_andnot_si64(int , int ) @nogc nothrow;
    static int _mm_or_si64(int , int ) @nogc nothrow;
    static int _mm_xor_si64(int , int ) @nogc nothrow;
    static int _mm_cmpeq_pi8(int , int ) @nogc nothrow;
    static int _mm_cmpeq_pi16(int , int ) @nogc nothrow;
    static int _mm_cmpeq_pi32(int , int ) @nogc nothrow;
    static int _mm_cmpgt_pi8(int , int ) @nogc nothrow;
    static int _mm_cmpgt_pi16(int , int ) @nogc nothrow;
    static int _mm_cmpgt_pi32(int , int ) @nogc nothrow;
    static int _mm_setzero_si64() @nogc nothrow;
    static int _mm_set_pi32(int, int) @nogc nothrow;
    static int _mm_set_pi16(short, short, short, short) @nogc nothrow;
    static int _mm_set_pi8(char, char, char, char, char, char, char, char) @nogc nothrow;
    static int _mm_set1_pi32(int) @nogc nothrow;
    static int _mm_set1_pi16(short) @nogc nothrow;
    static int _mm_set1_pi8(char) @nogc nothrow;
    static int _mm_setr_pi32(int, int) @nogc nothrow;
    static int _mm_setr_pi16(short, short, short, short) @nogc nothrow;
    static int _mm_setr_pi8(char, char, char, char, char, char, char, char) @nogc nothrow;
    alias cl_float = float;
    alias cl_half = ushort;
    alias cl_ulong = c_ulong;
    alias cl_long = c_long;
    alias cl_uint = uint;
    alias cl_int = int;
    alias cl_ushort = ushort;
    alias cl_short = short;
    alias cl_uchar = ubyte;
    alias cl_char = byte;
    void* clGetExtensionFunctionAddress(const(char)*) @nogc nothrow;
    int clUnloadCompiler() @nogc nothrow;
    int clEnqueueBarrier(_cl_command_queue*) @nogc nothrow;
    int clEnqueueWaitForEvents(_cl_command_queue*, uint, const(_cl_event*)*) @nogc nothrow;
    int clEnqueueMarker(_cl_command_queue*, _cl_event**) @nogc nothrow;
    _cl_mem* clCreateImage3D(_cl_context*, c_ulong, const(_cl_image_format)*, c_ulong, c_ulong, c_ulong, c_ulong, c_ulong, void*, int*) @nogc nothrow;
    _cl_mem* clCreateImage2D(_cl_context*, c_ulong, const(_cl_image_format)*, c_ulong, c_ulong, c_ulong, void*, int*) @nogc nothrow;
    void* clGetExtensionFunctionAddressForPlatform(_cl_platform_id*, const(char)*) @nogc nothrow;
    int clEnqueueBarrierWithWaitList(_cl_command_queue*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueMarkerWithWaitList(_cl_command_queue*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueNativeKernel(_cl_command_queue*, void function(void*), void*, c_ulong, uint, const(_cl_mem*)*, const(void)**, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    alias ptrdiff_t = c_long;
    alias size_t = c_ulong;
    alias wchar_t = int;
    int clEnqueueTask(_cl_command_queue*, _cl_kernel*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    alias __v4si = core.simd.int4;
    alias __v4sf = core.simd.float4;
    alias __m128 = core.simd.float4;
    alias __v4su = core.simd.uint4;
    static core.simd.float4 _mm_add_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_add_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_sub_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_sub_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_mul_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_mul_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_div_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_div_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_sqrt_ss(core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_sqrt_ps(core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_rcp_ss(core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_rcp_ps(core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_rsqrt_ss(core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_rsqrt_ps(core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_min_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_min_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_max_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_max_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_and_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_andnot_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_or_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_xor_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpeq_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpeq_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmplt_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmplt_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmple_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmple_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpgt_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpgt_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpge_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpge_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpneq_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpneq_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpnlt_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpnlt_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpnle_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpnle_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpngt_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpngt_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpnge_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpnge_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpord_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpord_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpunord_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cmpunord_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static int _mm_comieq_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static int _mm_comilt_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static int _mm_comile_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static int _mm_comigt_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static int _mm_comige_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static int _mm_comineq_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static int _mm_ucomieq_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static int _mm_ucomilt_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static int _mm_ucomile_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static int _mm_ucomigt_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static int _mm_ucomige_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static int _mm_ucomineq_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static int _mm_cvtss_si32(core.simd.float4) @nogc nothrow;
    static int _mm_cvt_ss2si(core.simd.float4) @nogc nothrow;
    static long _mm_cvtss_si64(core.simd.float4) @nogc nothrow;
    static int _mm_cvtps_pi32(core.simd.float4) @nogc nothrow;
    static int _mm_cvt_ps2pi(core.simd.float4) @nogc nothrow;
    static int _mm_cvttss_si32(core.simd.float4) @nogc nothrow;
    static int _mm_cvtt_ss2si(core.simd.float4) @nogc nothrow;
    static long _mm_cvttss_si64(core.simd.float4) @nogc nothrow;
    static int _mm_cvttps_pi32(core.simd.float4) @nogc nothrow;
    static int _mm_cvtt_ps2pi(core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cvtsi32_ss(core.simd.float4, int) @nogc nothrow;
    static core.simd.float4 _mm_cvt_si2ss(core.simd.float4, int) @nogc nothrow;
    static core.simd.float4 _mm_cvtsi64_ss(core.simd.float4, long) @nogc nothrow;
    static core.simd.float4 _mm_cvtpi32_ps(core.simd.float4, int ) @nogc nothrow;
    static core.simd.float4 _mm_cvt_pi2ps(core.simd.float4, int ) @nogc nothrow;
    static float _mm_cvtss_f32(core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_loadh_pi(core.simd.float4, const(int )*) @nogc nothrow;
    static core.simd.float4 _mm_loadl_pi(core.simd.float4, const(int )*) @nogc nothrow;
    static core.simd.float4 _mm_load_ss(const(float)*) @nogc nothrow;
    static core.simd.float4 _mm_load1_ps(const(float)*) @nogc nothrow;
    int clEnqueueNDRangeKernel(_cl_command_queue*, _cl_kernel*, uint, const(c_ulong)*, const(c_ulong)*, const(c_ulong)*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    static core.simd.float4 _mm_load_ps(const(float)*) @nogc nothrow;
    static core.simd.float4 _mm_loadu_ps(const(float)*) @nogc nothrow;
    static core.simd.float4 _mm_loadr_ps(const(float)*) @nogc nothrow;
    static core.simd.float4 _mm_undefined_ps() @nogc nothrow;
    static core.simd.float4 _mm_set_ss(float) @nogc nothrow;
    static core.simd.float4 _mm_set1_ps(float) @nogc nothrow;
    static core.simd.float4 _mm_set_ps1(float) @nogc nothrow;
    static core.simd.float4 _mm_set_ps(float, float, float, float) @nogc nothrow;
    static core.simd.float4 _mm_setr_ps(float, float, float, float) @nogc nothrow;
    static core.simd.float4 _mm_setzero_ps() @nogc nothrow;
    static void _mm_storeh_pi(int *, core.simd.float4) @nogc nothrow;
    static void _mm_storel_pi(int *, core.simd.float4) @nogc nothrow;
    static void _mm_store_ss(float*, core.simd.float4) @nogc nothrow;
    static void _mm_storeu_ps(float*, core.simd.float4) @nogc nothrow;
    static void _mm_store_ps(float*, core.simd.float4) @nogc nothrow;
    static void _mm_store1_ps(float*, core.simd.float4) @nogc nothrow;
    static void _mm_store_ps1(float*, core.simd.float4) @nogc nothrow;
    static void _mm_storer_ps(float*, core.simd.float4) @nogc nothrow;
    int clEnqueueMigrateMemObjects(_cl_command_queue*, uint, const(_cl_mem*)*, c_ulong, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    static void _mm_stream_pi(int *, int ) @nogc nothrow;
    static void _mm_stream_ps(float*, core.simd.float4) @nogc nothrow;
    void _mm_sfence() @nogc nothrow;
    int clEnqueueUnmapMemObject(_cl_command_queue*, _cl_mem*, void*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    static int _mm_max_pi16(int , int ) @nogc nothrow;
    static int _mm_max_pu8(int , int ) @nogc nothrow;
    static int _mm_min_pi16(int , int ) @nogc nothrow;
    static int _mm_min_pu8(int , int ) @nogc nothrow;
    static int _mm_movemask_pi8(int ) @nogc nothrow;
    static int _mm_mulhi_pu16(int , int ) @nogc nothrow;
    static void _mm_maskmove_si64(int , int , char*) @nogc nothrow;
    static int _mm_avg_pu8(int , int ) @nogc nothrow;
    static int _mm_avg_pu16(int , int ) @nogc nothrow;
    static int _mm_sad_pu8(int , int ) @nogc nothrow;
    uint _mm_getcsr() @nogc nothrow;
    void _mm_setcsr(uint) @nogc nothrow;
    static core.simd.float4 _mm_unpackhi_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_unpacklo_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_move_ss(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_movehl_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_movelh_ps(core.simd.float4, core.simd.float4) @nogc nothrow;
    static core.simd.float4 _mm_cvtpi16_ps(int ) @nogc nothrow;
    static core.simd.float4 _mm_cvtpu16_ps(int ) @nogc nothrow;
    static core.simd.float4 _mm_cvtpi8_ps(int ) @nogc nothrow;
    static core.simd.float4 _mm_cvtpu8_ps(int ) @nogc nothrow;
    static core.simd.float4 _mm_cvtpi32x2_ps(int , int ) @nogc nothrow;
    static int _mm_cvtps_pi16(core.simd.float4) @nogc nothrow;
    static int _mm_cvtps_pi8(core.simd.float4) @nogc nothrow;
    static int _mm_movemask_ps(core.simd.float4) @nogc nothrow;
    void* clEnqueueMapImage(_cl_command_queue*, _cl_mem*, uint, c_ulong, const(c_ulong)*, const(c_ulong)*, c_ulong*, c_ulong*, uint, const(_cl_event*)*, _cl_event**, int*) @nogc nothrow;
    void* clEnqueueMapBuffer(_cl_command_queue*, _cl_mem*, uint, c_ulong, c_ulong, c_ulong, uint, const(_cl_event*)*, _cl_event**, int*) @nogc nothrow;
    int clEnqueueCopyBufferToImage(_cl_command_queue*, _cl_mem*, _cl_mem*, c_ulong, const(c_ulong)*, const(c_ulong)*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueCopyImageToBuffer(_cl_command_queue*, _cl_mem*, _cl_mem*, const(c_ulong)*, const(c_ulong)*, c_ulong, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueCopyImage(_cl_command_queue*, _cl_mem*, _cl_mem*, const(c_ulong)*, const(c_ulong)*, const(c_ulong)*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueFillImage(_cl_command_queue*, _cl_mem*, const(void)*, const(c_ulong)*, const(c_ulong)*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueWriteImage(_cl_command_queue*, _cl_mem*, uint, const(c_ulong)*, const(c_ulong)*, c_ulong, c_ulong, const(void)*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueReadImage(_cl_command_queue*, _cl_mem*, uint, const(c_ulong)*, const(c_ulong)*, c_ulong, c_ulong, void*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueCopyBufferRect(_cl_command_queue*, _cl_mem*, _cl_mem*, const(c_ulong)*, const(c_ulong)*, const(c_ulong)*, c_ulong, c_ulong, c_ulong, c_ulong, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueCopyBuffer(_cl_command_queue*, _cl_mem*, _cl_mem*, c_ulong, c_ulong, c_ulong, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueFillBuffer(_cl_command_queue*, _cl_mem*, const(void)*, c_ulong, c_ulong, c_ulong, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueWriteBufferRect(_cl_command_queue*, _cl_mem*, uint, const(c_ulong)*, const(c_ulong)*, const(c_ulong)*, c_ulong, c_ulong, c_ulong, c_ulong, const(void)*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueWriteBuffer(_cl_command_queue*, _cl_mem*, uint, c_ulong, c_ulong, const(void)*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueReadBufferRect(_cl_command_queue*, _cl_mem*, uint, const(c_ulong)*, const(c_ulong)*, const(c_ulong)*, c_ulong, c_ulong, c_ulong, c_ulong, void*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clEnqueueReadBuffer(_cl_command_queue*, _cl_mem*, uint, c_ulong, c_ulong, void*, uint, const(_cl_event*)*, _cl_event**) @nogc nothrow;
    int clFinish(_cl_command_queue*) @nogc nothrow;
    int clFlush(_cl_command_queue*) @nogc nothrow;
    int clGetEventProfilingInfo(_cl_event*, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
    int clSetEventCallback(_cl_event*, int, void function(_cl_event*, int, void*), void*) @nogc nothrow;
    int clSetUserEventStatus(_cl_event*, int) @nogc nothrow;
    int clReleaseEvent(_cl_event*) @nogc nothrow;
    int clRetainEvent(_cl_event*) @nogc nothrow;
    _cl_event* clCreateUserEvent(_cl_context*, int*) @nogc nothrow;
    int clGetEventInfo(_cl_event*, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
    int clWaitForEvents(uint, const(_cl_event*)*) @nogc nothrow;
    int clGetKernelWorkGroupInfo(_cl_kernel*, _cl_device_id*, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
    alias int8_t = byte;
    alias int16_t = short;
    alias int32_t = int;
    alias int64_t = c_long;
    alias uint8_t = ubyte;
    alias uint16_t = ushort;
    alias uint32_t = uint;
    alias uint64_t = ulong;
    alias int_least8_t = byte;
    alias int_least16_t = short;
    alias int_least32_t = int;
    alias int_least64_t = c_long;
    alias uint_least8_t = ubyte;
    alias uint_least16_t = ushort;
    alias uint_least32_t = uint;
    alias uint_least64_t = c_ulong;
    alias int_fast8_t = byte;
    alias int_fast16_t = c_long;
    alias int_fast32_t = c_long;
    alias int_fast64_t = c_long;
    alias uint_fast8_t = ubyte;
    alias uint_fast16_t = c_ulong;
    alias uint_fast32_t = c_ulong;
    alias uint_fast64_t = c_ulong;
    alias intptr_t = c_long;
    alias uintptr_t = c_ulong;
    alias intmax_t = c_long;
    alias uintmax_t = c_ulong;
    int clGetKernelArgInfo(_cl_kernel*, uint, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
    int clGetKernelInfo(_cl_kernel*, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
    int clSetKernelArg(_cl_kernel*, uint, c_ulong, const(void)*) @nogc nothrow;
    int clReleaseKernel(_cl_kernel*) @nogc nothrow;
    int clRetainKernel(_cl_kernel*) @nogc nothrow;
    int clCreateKernelsInProgram(_cl_program*, uint, _cl_kernel**, uint*) @nogc nothrow;
    _cl_kernel* clCreateKernel(_cl_program*, const(char)*, int*) @nogc nothrow;
    int clGetProgramBuildInfo(_cl_program*, _cl_device_id*, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
    int clGetProgramInfo(_cl_program*, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
    int clUnloadPlatformCompiler(_cl_platform_id*) @nogc nothrow;
    _cl_program* clLinkProgram(_cl_context*, uint, const(_cl_device_id*)*, const(char)*, uint, const(_cl_program*)*, void function(_cl_program*, void*), void*, int*) @nogc nothrow;
    int clCompileProgram(_cl_program*, uint, const(_cl_device_id*)*, const(char)*, uint, const(_cl_program*)*, const(char)**, void function(_cl_program*, void*), void*) @nogc nothrow;
    int clBuildProgram(_cl_program*, uint, const(_cl_device_id*)*, const(char)*, void function(_cl_program*, void*), void*) @nogc nothrow;
    int clReleaseProgram(_cl_program*) @nogc nothrow;
    int clRetainProgram(_cl_program*) @nogc nothrow;
    _cl_program* clCreateProgramWithBuiltInKernels(_cl_context*, uint, const(_cl_device_id*)*, const(char)*, int*) @nogc nothrow;
    _cl_program* clCreateProgramWithBinary(_cl_context*, uint, const(_cl_device_id*)*, const(c_ulong)*, const(ubyte)**, int*, int*) @nogc nothrow;
    union __WAIT_STATUS
    {
        wait* __uptr;
        int* __iptr;
    }
    _cl_program* clCreateProgramWithSource(_cl_context*, uint, const(char)**, const(c_ulong)*, int*) @nogc nothrow;
    int clGetSamplerInfo(_cl_sampler*, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
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
    int clReleaseSampler(_cl_sampler*) @nogc nothrow;
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
    int clRetainSampler(_cl_sampler*) @nogc nothrow;
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
    alias time_t = c_long;
    alias clockid_t = int;
    _cl_sampler* clCreateSampler(_cl_context*, uint, uint, uint, int*) @nogc nothrow;
    alias timer_t = void*;
    struct timespec
    {
        c_long tv_sec;
        c_long tv_nsec;
    }
    int clSetMemObjectDestructorCallback(_cl_mem*, void function(_cl_mem*, void*), void*) @nogc nothrow;
    int clGetImageInfo(_cl_mem*, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
    int clGetMemObjectInfo(_cl_mem*, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
    int clGetSupportedImageFormats(_cl_context*, c_ulong, uint, uint, _cl_image_format*, uint*) @nogc nothrow;
    alias pthread_t = c_ulong;
    union pthread_attr_t
    {
        char[56] __size;
        c_long __align;
    }
    alias __pthread_list_t = __pthread_internal_list;
    struct __pthread_internal_list
    {
        __pthread_internal_list* __prev;
        __pthread_internal_list* __next;
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
    int clReleaseMemObject(_cl_mem*) @nogc nothrow;
    union pthread_mutexattr_t
    {
        char[4] __size;
        int __align;
    }
    union pthread_cond_t
    {
        static struct _Anonymous_240
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
        _Anonymous_240 __data;
        char[48] __size;
        long __align;
    }
    union pthread_condattr_t
    {
        char[4] __size;
        int __align;
    }
    alias pthread_key_t = uint;
    alias pthread_once_t = int;
    union pthread_rwlock_t
    {
        static struct _Anonymous_241
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
        _Anonymous_241 __data;
        char[56] __size;
        c_long __align;
    }
    union pthread_rwlockattr_t
    {
        char[8] __size;
        c_long __align;
    }
    alias pthread_spinlock_t = int;
    union pthread_barrier_t
    {
        char[32] __size;
        c_long __align;
    }
    union pthread_barrierattr_t
    {
        char[4] __size;
        int __align;
    }
    int clRetainMemObject(_cl_mem*) @nogc nothrow;
    _cl_mem* clCreateImage(_cl_context*, c_ulong, const(_cl_image_format)*, const(_cl_image_desc)*, void*, int*) @nogc nothrow;
    alias __sig_atomic_t = int;
    struct __sigset_t
    {
        c_ulong[16] __val;
    }
    struct timeval
    {
        c_long tv_sec;
        c_long tv_usec;
    }
    _cl_mem* clCreateSubBuffer(_cl_mem*, c_ulong, uint, const(void)*, int*) @nogc nothrow;
    alias __u_char = ubyte;
    alias __u_short = ushort;
    alias __u_int = uint;
    alias __u_long = c_ulong;
    alias __int8_t = byte;
    alias __uint8_t = ubyte;
    alias __int16_t = short;
    alias __uint16_t = ushort;
    alias __int32_t = int;
    alias __uint32_t = uint;
    alias __int64_t = c_long;
    alias __uint64_t = c_ulong;
    alias __quad_t = c_long;
    alias __u_quad_t = c_ulong;
    _cl_mem* clCreateBuffer(_cl_context*, c_ulong, c_ulong, void*, int*) @nogc nothrow;
    int clGetCommandQueueInfo(_cl_command_queue*, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
    int clReleaseCommandQueue(_cl_command_queue*) @nogc nothrow;
    alias __dev_t = c_ulong;
    alias __uid_t = uint;
    alias __gid_t = uint;
    alias __ino_t = c_ulong;
    alias __ino64_t = c_ulong;
    alias __mode_t = uint;
    alias __nlink_t = c_ulong;
    alias __off_t = c_long;
    alias __off64_t = c_long;
    alias __pid_t = int;
    struct __fsid_t
    {
        int[2] __val;
    }
    alias __clock_t = c_long;
    alias __rlim_t = c_ulong;
    alias __rlim64_t = c_ulong;
    alias __id_t = uint;
    alias __time_t = c_long;
    alias __useconds_t = uint;
    alias __suseconds_t = c_long;
    alias __daddr_t = int;
    alias __key_t = int;
    alias __clockid_t = int;
    alias __timer_t = void*;
    alias __blksize_t = c_long;
    alias __blkcnt_t = c_long;
    alias __blkcnt64_t = c_long;
    alias __fsblkcnt_t = c_ulong;
    alias __fsblkcnt64_t = c_ulong;
    alias __fsfilcnt_t = c_ulong;
    alias __fsfilcnt64_t = c_ulong;
    alias __fsword_t = c_long;
    alias __ssize_t = c_long;
    alias __syscall_slong_t = c_long;
    alias __syscall_ulong_t = c_ulong;
    alias __loff_t = c_long;
    alias __qaddr_t = c_long*;
    alias __caddr_t = char*;
    alias __intptr_t = c_long;
    alias __socklen_t = uint;
    int clRetainCommandQueue(_cl_command_queue*) @nogc nothrow;
    _cl_command_queue* clCreateCommandQueue(_cl_context*, _cl_device_id*, c_ulong, int*) @nogc nothrow;
    int clGetContextInfo(_cl_context*, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
    int clReleaseContext(_cl_context*) @nogc nothrow;
    int clRetainContext(_cl_context*) @nogc nothrow;
    _cl_context* clCreateContextFromType(const(c_long)*, c_ulong, void function(const(char)*, const(void)*, c_ulong, void*), void*, int*) @nogc nothrow;
    _cl_context* clCreateContext(const(c_long)*, uint, const(_cl_device_id*)*, void function(const(char)*, const(void)*, c_ulong, void*), void*, int*) @nogc nothrow;
    int clReleaseDevice(_cl_device_id*) @nogc nothrow;
    int clRetainDevice(_cl_device_id*) @nogc nothrow;
    int clCreateSubDevices(_cl_device_id*, const(c_long)*, uint, _cl_device_id**, uint*) @nogc nothrow;
    int clGetDeviceInfo(_cl_device_id*, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
    int clGetDeviceIDs(_cl_platform_id*, c_ulong, uint, _cl_device_id**, uint*) @nogc nothrow;
    alias idtype_t = _Anonymous_242;
    enum _Anonymous_242
    {
        P_ALL = 0,
        P_PID = 1,
        P_PGID = 2,
    }
    enum P_ALL = _Anonymous_242.P_ALL;
    enum P_PID = _Anonymous_242.P_PID;
    enum P_PGID = _Anonymous_242.P_PGID;
    int clGetPlatformInfo(_cl_platform_id*, uint, c_ulong, void*, c_ulong*) @nogc nothrow;
    int clGetPlatformIDs(uint, _cl_platform_id**, uint*) @nogc nothrow;
    struct _cl_buffer_region
    {
        c_ulong origin;
        c_ulong size;
    }
    alias cl_buffer_region = _cl_buffer_region;
    struct _cl_image_desc
    {
        uint image_type;
        c_ulong image_width;
        c_ulong image_height;
        c_ulong image_depth;
        c_ulong image_array_size;
        c_ulong image_row_pitch;
        c_ulong image_slice_pitch;
        uint num_mip_levels;
        uint num_samples;
        _cl_mem* buffer;
    }
    alias cl_image_desc = _cl_image_desc;
    struct _cl_image_format
    {
        uint image_channel_order;
        uint image_channel_data_type;
    }
    union wait
    {
        int w_status;
        static struct _Anonymous_243
        {
            import std.bitmanip: bitfields;

            align(4):
            mixin(bitfields!(
                uint, "__w_termsig", 7,
                uint, "__w_coredump", 1,
                uint, "__w_retcode", 8,
                uint, "_anonymous_244", 16,
            ));
        }
        _Anonymous_243 __wait_terminated;
        static struct _Anonymous_245
        {
            import std.bitmanip: bitfields;

            align(4):
            mixin(bitfields!(
                uint, "__w_stopval", 8,
                uint, "__w_stopsig", 8,
                uint, "_anonymous_246", 16,
            ));
        }
        _Anonymous_245 __wait_stopped;
    }
    alias cl_image_format = _cl_image_format;
    alias cl_profiling_info = uint;
    alias cl_command_type = uint;
    alias cl_event_info = uint;
    alias cl_kernel_work_group_info = uint;
    alias cl_kernel_arg_type_qualifier = c_ulong;
    alias cl_kernel_arg_access_qualifier = uint;
    alias cl_kernel_arg_address_qualifier = uint;
    alias cl_kernel_arg_info = uint;
    alias cl_kernel_info = uint;
    alias cl_build_status = int;
    alias cl_program_binary_type = uint;
    alias cl_program_build_info = uint;
    alias cl_program_info = uint;
    alias cl_map_flags = c_ulong;
    alias cl_sampler_info = uint;
    alias cl_filter_mode = uint;
    alias cl_addressing_mode = uint;
    alias cl_buffer_create_type = uint;
    alias cl_image_info = uint;
    alias cl_mem_migration_flags = c_ulong;
    alias cl_mem_info = uint;
    alias cl_mem_object_type = uint;
    alias cl_mem_flags = c_ulong;
    alias cl_channel_type = uint;
    alias cl_channel_order = uint;
    alias cl_command_queue_info = uint;
    alias cl_context_info = uint;
    alias cl_context_properties = c_long;
    alias cl_device_affinity_domain = c_ulong;
    alias cl_device_partition_property = c_long;
    alias cl_command_queue_properties = c_ulong;
    alias cl_device_exec_capabilities = c_ulong;
    alias cl_device_local_mem_type = uint;
    alias cl_device_mem_cache_type = uint;
    alias cl_device_fp_config = c_ulong;
    alias cl_device_info = uint;
    alias cl_platform_info = uint;
    alias cl_device_type = c_ulong;
    alias cl_bitfield = c_ulong;
    alias cl_bool = uint;
    struct _cl_sampler;
    alias cl_sampler = _cl_sampler*;
    struct _cl_event;
    alias cl_event = _cl_event*;
    struct _cl_kernel;
    alias cl_kernel = _cl_kernel*;
    struct _cl_program;
    alias cl_program = _cl_program*;
    struct _cl_mem;
    alias cl_mem = _cl_mem*;
    struct _cl_command_queue;
    alias cl_command_queue = _cl_command_queue*;
    struct _cl_context;
    alias cl_context = _cl_context*;
    struct _cl_device_id;
    alias cl_device_id = _cl_device_id*;
    struct _cl_platform_id;
    alias cl_platform_id = _cl_platform_id*;
    alias fsfilcnt_t = c_ulong;
    alias fsblkcnt_t = c_ulong;
    alias blkcnt_t = c_long;
    alias blksize_t = c_long;
    alias register_t = c_long;
    alias u_int64_t = c_ulong;
    alias u_int32_t = uint;
    alias u_int16_t = ushort;
    alias u_int8_t = ubyte;
    alias key_t = int;
    alias caddr_t = char*;
    alias daddr_t = int;
    alias ssize_t = c_long;
    alias id_t = uint;
    alias pid_t = int;
    alias off_t = c_long;
    alias sigset_t = __sigset_t;
    alias uid_t = uint;
    alias nlink_t = c_ulong;
    alias mode_t = uint;
    alias suseconds_t = c_long;
    alias gid_t = uint;
    alias __fd_mask = c_long;
    alias dev_t = c_ulong;
    alias ino_t = c_ulong;
    alias loff_t = c_long;
    struct fd_set
    {
        c_long[16] __fds_bits;
    }
    alias fsid_t = __fsid_t;
    alias u_quad_t = c_ulong;
    alias fd_mask = c_long;
    alias quad_t = c_long;
    alias u_long = c_ulong;
    alias u_int = uint;
    alias u_short = ushort;
    alias u_char = ubyte;
    int select(int, fd_set*, fd_set*, fd_set*, timeval*) @nogc nothrow;
    int pselect(int, fd_set*, fd_set*, fd_set*, const(timespec)*, const(__sigset_t)*) @nogc nothrow;
    uint gnu_dev_major(ulong) @nogc nothrow;
    uint gnu_dev_minor(ulong) @nogc nothrow;
    ulong gnu_dev_makedev(uint, uint) @nogc nothrow;




    static if(!is(typeof(_SYS_TYPES_H))) {
        enum _SYS_TYPES_H = 1;
    }
    static if(!is(typeof(_SYS_SYSMACROS_H))) {
        enum _SYS_SYSMACROS_H = 1;
    }
    static if(!is(typeof(_SYS_SELECT_H))) {
        enum _SYS_SELECT_H = 1;
    }
    static if(!is(typeof(__BIT_TYPES_DEFINED__))) {
        enum __BIT_TYPES_DEFINED__ = 1;
    }
    static if(!is(typeof(_SYS_CDEFS_H))) {
        enum _SYS_CDEFS_H = 1;
    }
    static if(!is(typeof(__SYSCALL_WORDSIZE))) {
        enum __SYSCALL_WORDSIZE = 64;
    }




    static if(!is(typeof(__WORDSIZE_TIME64_COMPAT32))) {
        enum __WORDSIZE_TIME64_COMPAT32 = 1;
    }




    static if(!is(typeof(__WORDSIZE))) {
        enum __WORDSIZE = 64;
    }
    static if(!is(typeof(_BITS_WCHAR_H))) {
        enum _BITS_WCHAR_H = 1;
    }
    static if(!is(typeof(__WCOREFLAG))) {
        enum __WCOREFLAG = 0x80;
    }




    static if(!is(typeof(__W_CONTINUED))) {
        enum __W_CONTINUED = 0xffff;
    }
    static if(!is(typeof(CL_SUCCESS))) {
        enum CL_SUCCESS = 0;
    }
    static if(!is(typeof(CL_VERSION_1_0))) {
        enum CL_VERSION_1_0 = 1;
    }




    static if(!is(typeof(CL_VERSION_1_1))) {
        enum CL_VERSION_1_1 = 1;
    }




    static if(!is(typeof(CL_VERSION_1_2))) {
        enum CL_VERSION_1_2 = 1;
    }




    static if(!is(typeof(CL_FALSE))) {
        enum CL_FALSE = 0;
    }




    static if(!is(typeof(CL_TRUE))) {
        enum CL_TRUE = 1;
    }
    static if(!is(typeof(CL_PLATFORM_PROFILE))) {
        enum CL_PLATFORM_PROFILE = 0x0900;
    }




    static if(!is(typeof(CL_PLATFORM_VERSION))) {
        enum CL_PLATFORM_VERSION = 0x0901;
    }




    static if(!is(typeof(CL_PLATFORM_NAME))) {
        enum CL_PLATFORM_NAME = 0x0902;
    }




    static if(!is(typeof(CL_PLATFORM_VENDOR))) {
        enum CL_PLATFORM_VENDOR = 0x0903;
    }




    static if(!is(typeof(CL_PLATFORM_EXTENSIONS))) {
        enum CL_PLATFORM_EXTENSIONS = 0x0904;
    }
    static if(!is(typeof(CL_DEVICE_TYPE_ALL))) {
        enum CL_DEVICE_TYPE_ALL = 0xFFFFFFFF;
    }




    static if(!is(typeof(CL_DEVICE_TYPE))) {
        enum CL_DEVICE_TYPE = 0x1000;
    }




    static if(!is(typeof(CL_DEVICE_VENDOR_ID))) {
        enum CL_DEVICE_VENDOR_ID = 0x1001;
    }




    static if(!is(typeof(CL_DEVICE_MAX_COMPUTE_UNITS))) {
        enum CL_DEVICE_MAX_COMPUTE_UNITS = 0x1002;
    }




    static if(!is(typeof(CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS))) {
        enum CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS = 0x1003;
    }




    static if(!is(typeof(CL_DEVICE_MAX_WORK_GROUP_SIZE))) {
        enum CL_DEVICE_MAX_WORK_GROUP_SIZE = 0x1004;
    }




    static if(!is(typeof(CL_DEVICE_MAX_WORK_ITEM_SIZES))) {
        enum CL_DEVICE_MAX_WORK_ITEM_SIZES = 0x1005;
    }




    static if(!is(typeof(CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR))) {
        enum CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR = 0x1006;
    }




    static if(!is(typeof(CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT))) {
        enum CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT = 0x1007;
    }




    static if(!is(typeof(CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT))) {
        enum CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT = 0x1008;
    }




    static if(!is(typeof(CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG))) {
        enum CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG = 0x1009;
    }




    static if(!is(typeof(CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT))) {
        enum CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT = 0x100A;
    }




    static if(!is(typeof(CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE))) {
        enum CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE = 0x100B;
    }




    static if(!is(typeof(CL_DEVICE_MAX_CLOCK_FREQUENCY))) {
        enum CL_DEVICE_MAX_CLOCK_FREQUENCY = 0x100C;
    }




    static if(!is(typeof(CL_DEVICE_ADDRESS_BITS))) {
        enum CL_DEVICE_ADDRESS_BITS = 0x100D;
    }




    static if(!is(typeof(CL_DEVICE_MAX_READ_IMAGE_ARGS))) {
        enum CL_DEVICE_MAX_READ_IMAGE_ARGS = 0x100E;
    }




    static if(!is(typeof(CL_DEVICE_MAX_WRITE_IMAGE_ARGS))) {
        enum CL_DEVICE_MAX_WRITE_IMAGE_ARGS = 0x100F;
    }




    static if(!is(typeof(CL_DEVICE_MAX_MEM_ALLOC_SIZE))) {
        enum CL_DEVICE_MAX_MEM_ALLOC_SIZE = 0x1010;
    }




    static if(!is(typeof(CL_DEVICE_IMAGE2D_MAX_WIDTH))) {
        enum CL_DEVICE_IMAGE2D_MAX_WIDTH = 0x1011;
    }




    static if(!is(typeof(CL_DEVICE_IMAGE2D_MAX_HEIGHT))) {
        enum CL_DEVICE_IMAGE2D_MAX_HEIGHT = 0x1012;
    }




    static if(!is(typeof(CL_DEVICE_IMAGE3D_MAX_WIDTH))) {
        enum CL_DEVICE_IMAGE3D_MAX_WIDTH = 0x1013;
    }




    static if(!is(typeof(CL_DEVICE_IMAGE3D_MAX_HEIGHT))) {
        enum CL_DEVICE_IMAGE3D_MAX_HEIGHT = 0x1014;
    }




    static if(!is(typeof(CL_DEVICE_IMAGE3D_MAX_DEPTH))) {
        enum CL_DEVICE_IMAGE3D_MAX_DEPTH = 0x1015;
    }




    static if(!is(typeof(CL_DEVICE_IMAGE_SUPPORT))) {
        enum CL_DEVICE_IMAGE_SUPPORT = 0x1016;
    }




    static if(!is(typeof(CL_DEVICE_MAX_PARAMETER_SIZE))) {
        enum CL_DEVICE_MAX_PARAMETER_SIZE = 0x1017;
    }




    static if(!is(typeof(CL_DEVICE_MAX_SAMPLERS))) {
        enum CL_DEVICE_MAX_SAMPLERS = 0x1018;
    }




    static if(!is(typeof(CL_DEVICE_MEM_BASE_ADDR_ALIGN))) {
        enum CL_DEVICE_MEM_BASE_ADDR_ALIGN = 0x1019;
    }




    static if(!is(typeof(CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE))) {
        enum CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE = 0x101A;
    }




    static if(!is(typeof(CL_DEVICE_SINGLE_FP_CONFIG))) {
        enum CL_DEVICE_SINGLE_FP_CONFIG = 0x101B;
    }




    static if(!is(typeof(CL_DEVICE_GLOBAL_MEM_CACHE_TYPE))) {
        enum CL_DEVICE_GLOBAL_MEM_CACHE_TYPE = 0x101C;
    }




    static if(!is(typeof(CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE))) {
        enum CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE = 0x101D;
    }




    static if(!is(typeof(CL_DEVICE_GLOBAL_MEM_CACHE_SIZE))) {
        enum CL_DEVICE_GLOBAL_MEM_CACHE_SIZE = 0x101E;
    }




    static if(!is(typeof(CL_DEVICE_GLOBAL_MEM_SIZE))) {
        enum CL_DEVICE_GLOBAL_MEM_SIZE = 0x101F;
    }




    static if(!is(typeof(CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE))) {
        enum CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE = 0x1020;
    }




    static if(!is(typeof(CL_DEVICE_MAX_CONSTANT_ARGS))) {
        enum CL_DEVICE_MAX_CONSTANT_ARGS = 0x1021;
    }




    static if(!is(typeof(CL_DEVICE_LOCAL_MEM_TYPE))) {
        enum CL_DEVICE_LOCAL_MEM_TYPE = 0x1022;
    }




    static if(!is(typeof(CL_DEVICE_LOCAL_MEM_SIZE))) {
        enum CL_DEVICE_LOCAL_MEM_SIZE = 0x1023;
    }




    static if(!is(typeof(CL_DEVICE_ERROR_CORRECTION_SUPPORT))) {
        enum CL_DEVICE_ERROR_CORRECTION_SUPPORT = 0x1024;
    }




    static if(!is(typeof(CL_DEVICE_PROFILING_TIMER_RESOLUTION))) {
        enum CL_DEVICE_PROFILING_TIMER_RESOLUTION = 0x1025;
    }




    static if(!is(typeof(CL_DEVICE_ENDIAN_LITTLE))) {
        enum CL_DEVICE_ENDIAN_LITTLE = 0x1026;
    }




    static if(!is(typeof(CL_DEVICE_AVAILABLE))) {
        enum CL_DEVICE_AVAILABLE = 0x1027;
    }




    static if(!is(typeof(CL_DEVICE_COMPILER_AVAILABLE))) {
        enum CL_DEVICE_COMPILER_AVAILABLE = 0x1028;
    }




    static if(!is(typeof(CL_DEVICE_EXECUTION_CAPABILITIES))) {
        enum CL_DEVICE_EXECUTION_CAPABILITIES = 0x1029;
    }




    static if(!is(typeof(CL_DEVICE_QUEUE_PROPERTIES))) {
        enum CL_DEVICE_QUEUE_PROPERTIES = 0x102A;
    }




    static if(!is(typeof(CL_DEVICE_NAME))) {
        enum CL_DEVICE_NAME = 0x102B;
    }




    static if(!is(typeof(CL_DEVICE_VENDOR))) {
        enum CL_DEVICE_VENDOR = 0x102C;
    }




    static if(!is(typeof(CL_DRIVER_VERSION))) {
        enum CL_DRIVER_VERSION = 0x102D;
    }




    static if(!is(typeof(CL_DEVICE_PROFILE))) {
        enum CL_DEVICE_PROFILE = 0x102E;
    }




    static if(!is(typeof(CL_DEVICE_VERSION))) {
        enum CL_DEVICE_VERSION = 0x102F;
    }




    static if(!is(typeof(CL_DEVICE_EXTENSIONS))) {
        enum CL_DEVICE_EXTENSIONS = 0x1030;
    }




    static if(!is(typeof(CL_DEVICE_PLATFORM))) {
        enum CL_DEVICE_PLATFORM = 0x1031;
    }




    static if(!is(typeof(CL_DEVICE_DOUBLE_FP_CONFIG))) {
        enum CL_DEVICE_DOUBLE_FP_CONFIG = 0x1032;
    }




    static if(!is(typeof(CL_DEVICE_PREFERRED_VECTOR_WIDTH_HALF))) {
        enum CL_DEVICE_PREFERRED_VECTOR_WIDTH_HALF = 0x1034;
    }




    static if(!is(typeof(CL_DEVICE_HOST_UNIFIED_MEMORY))) {
        enum CL_DEVICE_HOST_UNIFIED_MEMORY = 0x1035;
    }




    static if(!is(typeof(CL_DEVICE_NATIVE_VECTOR_WIDTH_CHAR))) {
        enum CL_DEVICE_NATIVE_VECTOR_WIDTH_CHAR = 0x1036;
    }




    static if(!is(typeof(CL_DEVICE_NATIVE_VECTOR_WIDTH_SHORT))) {
        enum CL_DEVICE_NATIVE_VECTOR_WIDTH_SHORT = 0x1037;
    }




    static if(!is(typeof(CL_DEVICE_NATIVE_VECTOR_WIDTH_INT))) {
        enum CL_DEVICE_NATIVE_VECTOR_WIDTH_INT = 0x1038;
    }




    static if(!is(typeof(CL_DEVICE_NATIVE_VECTOR_WIDTH_LONG))) {
        enum CL_DEVICE_NATIVE_VECTOR_WIDTH_LONG = 0x1039;
    }




    static if(!is(typeof(CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT))) {
        enum CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT = 0x103A;
    }




    static if(!is(typeof(CL_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE))) {
        enum CL_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE = 0x103B;
    }




    static if(!is(typeof(CL_DEVICE_NATIVE_VECTOR_WIDTH_HALF))) {
        enum CL_DEVICE_NATIVE_VECTOR_WIDTH_HALF = 0x103C;
    }




    static if(!is(typeof(CL_DEVICE_OPENCL_C_VERSION))) {
        enum CL_DEVICE_OPENCL_C_VERSION = 0x103D;
    }




    static if(!is(typeof(CL_DEVICE_LINKER_AVAILABLE))) {
        enum CL_DEVICE_LINKER_AVAILABLE = 0x103E;
    }




    static if(!is(typeof(CL_DEVICE_BUILT_IN_KERNELS))) {
        enum CL_DEVICE_BUILT_IN_KERNELS = 0x103F;
    }




    static if(!is(typeof(CL_DEVICE_IMAGE_MAX_BUFFER_SIZE))) {
        enum CL_DEVICE_IMAGE_MAX_BUFFER_SIZE = 0x1040;
    }




    static if(!is(typeof(CL_DEVICE_IMAGE_MAX_ARRAY_SIZE))) {
        enum CL_DEVICE_IMAGE_MAX_ARRAY_SIZE = 0x1041;
    }




    static if(!is(typeof(CL_DEVICE_PARENT_DEVICE))) {
        enum CL_DEVICE_PARENT_DEVICE = 0x1042;
    }




    static if(!is(typeof(CL_DEVICE_PARTITION_MAX_SUB_DEVICES))) {
        enum CL_DEVICE_PARTITION_MAX_SUB_DEVICES = 0x1043;
    }




    static if(!is(typeof(CL_DEVICE_PARTITION_PROPERTIES))) {
        enum CL_DEVICE_PARTITION_PROPERTIES = 0x1044;
    }




    static if(!is(typeof(CL_DEVICE_PARTITION_AFFINITY_DOMAIN))) {
        enum CL_DEVICE_PARTITION_AFFINITY_DOMAIN = 0x1045;
    }




    static if(!is(typeof(CL_DEVICE_PARTITION_TYPE))) {
        enum CL_DEVICE_PARTITION_TYPE = 0x1046;
    }




    static if(!is(typeof(CL_DEVICE_REFERENCE_COUNT))) {
        enum CL_DEVICE_REFERENCE_COUNT = 0x1047;
    }




    static if(!is(typeof(CL_DEVICE_PREFERRED_INTEROP_USER_SYNC))) {
        enum CL_DEVICE_PREFERRED_INTEROP_USER_SYNC = 0x1048;
    }




    static if(!is(typeof(CL_DEVICE_PRINTF_BUFFER_SIZE))) {
        enum CL_DEVICE_PRINTF_BUFFER_SIZE = 0x1049;
    }




    static if(!is(typeof(CL_DEVICE_IMAGE_PITCH_ALIGNMENT))) {
        enum CL_DEVICE_IMAGE_PITCH_ALIGNMENT = 0x104A;
    }




    static if(!is(typeof(CL_DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT))) {
        enum CL_DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT = 0x104B;
    }
    static if(!is(typeof(CL_NONE))) {
        enum CL_NONE = 0x0;
    }




    static if(!is(typeof(CL_READ_ONLY_CACHE))) {
        enum CL_READ_ONLY_CACHE = 0x1;
    }




    static if(!is(typeof(CL_READ_WRITE_CACHE))) {
        enum CL_READ_WRITE_CACHE = 0x2;
    }




    static if(!is(typeof(CL_LOCAL))) {
        enum CL_LOCAL = 0x1;
    }




    static if(!is(typeof(CL_GLOBAL))) {
        enum CL_GLOBAL = 0x2;
    }
    static if(!is(typeof(CL_CONTEXT_REFERENCE_COUNT))) {
        enum CL_CONTEXT_REFERENCE_COUNT = 0x1080;
    }




    static if(!is(typeof(CL_CONTEXT_DEVICES))) {
        enum CL_CONTEXT_DEVICES = 0x1081;
    }




    static if(!is(typeof(CL_CONTEXT_PROPERTIES))) {
        enum CL_CONTEXT_PROPERTIES = 0x1082;
    }




    static if(!is(typeof(CL_CONTEXT_NUM_DEVICES))) {
        enum CL_CONTEXT_NUM_DEVICES = 0x1083;
    }




    static if(!is(typeof(CL_CONTEXT_PLATFORM))) {
        enum CL_CONTEXT_PLATFORM = 0x1084;
    }




    static if(!is(typeof(CL_CONTEXT_INTEROP_USER_SYNC))) {
        enum CL_CONTEXT_INTEROP_USER_SYNC = 0x1085;
    }




    static if(!is(typeof(CL_DEVICE_PARTITION_EQUALLY))) {
        enum CL_DEVICE_PARTITION_EQUALLY = 0x1086;
    }




    static if(!is(typeof(CL_DEVICE_PARTITION_BY_COUNTS))) {
        enum CL_DEVICE_PARTITION_BY_COUNTS = 0x1087;
    }




    static if(!is(typeof(CL_DEVICE_PARTITION_BY_COUNTS_LIST_END))) {
        enum CL_DEVICE_PARTITION_BY_COUNTS_LIST_END = 0x0;
    }




    static if(!is(typeof(CL_DEVICE_PARTITION_BY_AFFINITY_DOMAIN))) {
        enum CL_DEVICE_PARTITION_BY_AFFINITY_DOMAIN = 0x1088;
    }
    static if(!is(typeof(CL_QUEUE_CONTEXT))) {
        enum CL_QUEUE_CONTEXT = 0x1090;
    }




    static if(!is(typeof(CL_QUEUE_DEVICE))) {
        enum CL_QUEUE_DEVICE = 0x1091;
    }




    static if(!is(typeof(CL_QUEUE_REFERENCE_COUNT))) {
        enum CL_QUEUE_REFERENCE_COUNT = 0x1092;
    }




    static if(!is(typeof(CL_QUEUE_PROPERTIES))) {
        enum CL_QUEUE_PROPERTIES = 0x1093;
    }
    static if(!is(typeof(CL_R))) {
        enum CL_R = 0x10B0;
    }




    static if(!is(typeof(CL_A))) {
        enum CL_A = 0x10B1;
    }




    static if(!is(typeof(CL_RG))) {
        enum CL_RG = 0x10B2;
    }




    static if(!is(typeof(CL_RA))) {
        enum CL_RA = 0x10B3;
    }




    static if(!is(typeof(CL_RGB))) {
        enum CL_RGB = 0x10B4;
    }




    static if(!is(typeof(CL_RGBA))) {
        enum CL_RGBA = 0x10B5;
    }




    static if(!is(typeof(CL_BGRA))) {
        enum CL_BGRA = 0x10B6;
    }




    static if(!is(typeof(CL_ARGB))) {
        enum CL_ARGB = 0x10B7;
    }




    static if(!is(typeof(CL_INTENSITY))) {
        enum CL_INTENSITY = 0x10B8;
    }




    static if(!is(typeof(CL_LUMINANCE))) {
        enum CL_LUMINANCE = 0x10B9;
    }




    static if(!is(typeof(CL_Rx))) {
        enum CL_Rx = 0x10BA;
    }




    static if(!is(typeof(CL_RGx))) {
        enum CL_RGx = 0x10BB;
    }




    static if(!is(typeof(CL_RGBx))) {
        enum CL_RGBx = 0x10BC;
    }




    static if(!is(typeof(CL_DEPTH))) {
        enum CL_DEPTH = 0x10BD;
    }




    static if(!is(typeof(CL_DEPTH_STENCIL))) {
        enum CL_DEPTH_STENCIL = 0x10BE;
    }




    static if(!is(typeof(CL_SNORM_INT8))) {
        enum CL_SNORM_INT8 = 0x10D0;
    }




    static if(!is(typeof(CL_SNORM_INT16))) {
        enum CL_SNORM_INT16 = 0x10D1;
    }




    static if(!is(typeof(CL_UNORM_INT8))) {
        enum CL_UNORM_INT8 = 0x10D2;
    }




    static if(!is(typeof(CL_UNORM_INT16))) {
        enum CL_UNORM_INT16 = 0x10D3;
    }




    static if(!is(typeof(CL_UNORM_SHORT_565))) {
        enum CL_UNORM_SHORT_565 = 0x10D4;
    }




    static if(!is(typeof(CL_UNORM_SHORT_555))) {
        enum CL_UNORM_SHORT_555 = 0x10D5;
    }




    static if(!is(typeof(CL_UNORM_INT_101010))) {
        enum CL_UNORM_INT_101010 = 0x10D6;
    }




    static if(!is(typeof(CL_SIGNED_INT8))) {
        enum CL_SIGNED_INT8 = 0x10D7;
    }




    static if(!is(typeof(CL_SIGNED_INT16))) {
        enum CL_SIGNED_INT16 = 0x10D8;
    }




    static if(!is(typeof(CL_SIGNED_INT32))) {
        enum CL_SIGNED_INT32 = 0x10D9;
    }




    static if(!is(typeof(CL_UNSIGNED_INT8))) {
        enum CL_UNSIGNED_INT8 = 0x10DA;
    }




    static if(!is(typeof(CL_UNSIGNED_INT16))) {
        enum CL_UNSIGNED_INT16 = 0x10DB;
    }




    static if(!is(typeof(CL_UNSIGNED_INT32))) {
        enum CL_UNSIGNED_INT32 = 0x10DC;
    }




    static if(!is(typeof(CL_HALF_FLOAT))) {
        enum CL_HALF_FLOAT = 0x10DD;
    }




    static if(!is(typeof(CL_FLOAT))) {
        enum CL_FLOAT = 0x10DE;
    }




    static if(!is(typeof(CL_UNORM_INT24))) {
        enum CL_UNORM_INT24 = 0x10DF;
    }




    static if(!is(typeof(CL_MEM_OBJECT_BUFFER))) {
        enum CL_MEM_OBJECT_BUFFER = 0x10F0;
    }




    static if(!is(typeof(CL_MEM_OBJECT_IMAGE2D))) {
        enum CL_MEM_OBJECT_IMAGE2D = 0x10F1;
    }




    static if(!is(typeof(CL_MEM_OBJECT_IMAGE3D))) {
        enum CL_MEM_OBJECT_IMAGE3D = 0x10F2;
    }




    static if(!is(typeof(CL_MEM_OBJECT_IMAGE2D_ARRAY))) {
        enum CL_MEM_OBJECT_IMAGE2D_ARRAY = 0x10F3;
    }




    static if(!is(typeof(CL_MEM_OBJECT_IMAGE1D))) {
        enum CL_MEM_OBJECT_IMAGE1D = 0x10F4;
    }




    static if(!is(typeof(CL_MEM_OBJECT_IMAGE1D_ARRAY))) {
        enum CL_MEM_OBJECT_IMAGE1D_ARRAY = 0x10F5;
    }




    static if(!is(typeof(CL_MEM_OBJECT_IMAGE1D_BUFFER))) {
        enum CL_MEM_OBJECT_IMAGE1D_BUFFER = 0x10F6;
    }




    static if(!is(typeof(CL_MEM_TYPE))) {
        enum CL_MEM_TYPE = 0x1100;
    }




    static if(!is(typeof(CL_MEM_FLAGS))) {
        enum CL_MEM_FLAGS = 0x1101;
    }




    static if(!is(typeof(CL_MEM_SIZE))) {
        enum CL_MEM_SIZE = 0x1102;
    }




    static if(!is(typeof(CL_MEM_HOST_PTR))) {
        enum CL_MEM_HOST_PTR = 0x1103;
    }




    static if(!is(typeof(CL_MEM_MAP_COUNT))) {
        enum CL_MEM_MAP_COUNT = 0x1104;
    }




    static if(!is(typeof(CL_MEM_REFERENCE_COUNT))) {
        enum CL_MEM_REFERENCE_COUNT = 0x1105;
    }




    static if(!is(typeof(CL_MEM_CONTEXT))) {
        enum CL_MEM_CONTEXT = 0x1106;
    }




    static if(!is(typeof(CL_MEM_ASSOCIATED_MEMOBJECT))) {
        enum CL_MEM_ASSOCIATED_MEMOBJECT = 0x1107;
    }




    static if(!is(typeof(CL_MEM_OFFSET))) {
        enum CL_MEM_OFFSET = 0x1108;
    }




    static if(!is(typeof(CL_IMAGE_FORMAT))) {
        enum CL_IMAGE_FORMAT = 0x1110;
    }




    static if(!is(typeof(CL_IMAGE_ELEMENT_SIZE))) {
        enum CL_IMAGE_ELEMENT_SIZE = 0x1111;
    }




    static if(!is(typeof(CL_IMAGE_ROW_PITCH))) {
        enum CL_IMAGE_ROW_PITCH = 0x1112;
    }




    static if(!is(typeof(CL_IMAGE_SLICE_PITCH))) {
        enum CL_IMAGE_SLICE_PITCH = 0x1113;
    }




    static if(!is(typeof(CL_IMAGE_WIDTH))) {
        enum CL_IMAGE_WIDTH = 0x1114;
    }




    static if(!is(typeof(CL_IMAGE_HEIGHT))) {
        enum CL_IMAGE_HEIGHT = 0x1115;
    }




    static if(!is(typeof(CL_IMAGE_DEPTH))) {
        enum CL_IMAGE_DEPTH = 0x1116;
    }




    static if(!is(typeof(CL_IMAGE_ARRAY_SIZE))) {
        enum CL_IMAGE_ARRAY_SIZE = 0x1117;
    }




    static if(!is(typeof(CL_IMAGE_BUFFER))) {
        enum CL_IMAGE_BUFFER = 0x1118;
    }




    static if(!is(typeof(CL_IMAGE_NUM_MIP_LEVELS))) {
        enum CL_IMAGE_NUM_MIP_LEVELS = 0x1119;
    }




    static if(!is(typeof(CL_IMAGE_NUM_SAMPLES))) {
        enum CL_IMAGE_NUM_SAMPLES = 0x111A;
    }




    static if(!is(typeof(CL_ADDRESS_NONE))) {
        enum CL_ADDRESS_NONE = 0x1130;
    }




    static if(!is(typeof(CL_ADDRESS_CLAMP_TO_EDGE))) {
        enum CL_ADDRESS_CLAMP_TO_EDGE = 0x1131;
    }




    static if(!is(typeof(CL_ADDRESS_CLAMP))) {
        enum CL_ADDRESS_CLAMP = 0x1132;
    }




    static if(!is(typeof(CL_ADDRESS_REPEAT))) {
        enum CL_ADDRESS_REPEAT = 0x1133;
    }




    static if(!is(typeof(CL_ADDRESS_MIRRORED_REPEAT))) {
        enum CL_ADDRESS_MIRRORED_REPEAT = 0x1134;
    }




    static if(!is(typeof(CL_FILTER_NEAREST))) {
        enum CL_FILTER_NEAREST = 0x1140;
    }




    static if(!is(typeof(CL_FILTER_LINEAR))) {
        enum CL_FILTER_LINEAR = 0x1141;
    }




    static if(!is(typeof(CL_SAMPLER_REFERENCE_COUNT))) {
        enum CL_SAMPLER_REFERENCE_COUNT = 0x1150;
    }




    static if(!is(typeof(CL_SAMPLER_CONTEXT))) {
        enum CL_SAMPLER_CONTEXT = 0x1151;
    }




    static if(!is(typeof(CL_SAMPLER_NORMALIZED_COORDS))) {
        enum CL_SAMPLER_NORMALIZED_COORDS = 0x1152;
    }




    static if(!is(typeof(CL_SAMPLER_ADDRESSING_MODE))) {
        enum CL_SAMPLER_ADDRESSING_MODE = 0x1153;
    }




    static if(!is(typeof(CL_SAMPLER_FILTER_MODE))) {
        enum CL_SAMPLER_FILTER_MODE = 0x1154;
    }
    static if(!is(typeof(CL_PROGRAM_REFERENCE_COUNT))) {
        enum CL_PROGRAM_REFERENCE_COUNT = 0x1160;
    }




    static if(!is(typeof(CL_PROGRAM_CONTEXT))) {
        enum CL_PROGRAM_CONTEXT = 0x1161;
    }




    static if(!is(typeof(CL_PROGRAM_NUM_DEVICES))) {
        enum CL_PROGRAM_NUM_DEVICES = 0x1162;
    }




    static if(!is(typeof(CL_PROGRAM_DEVICES))) {
        enum CL_PROGRAM_DEVICES = 0x1163;
    }




    static if(!is(typeof(CL_PROGRAM_SOURCE))) {
        enum CL_PROGRAM_SOURCE = 0x1164;
    }




    static if(!is(typeof(CL_PROGRAM_BINARY_SIZES))) {
        enum CL_PROGRAM_BINARY_SIZES = 0x1165;
    }




    static if(!is(typeof(CL_PROGRAM_BINARIES))) {
        enum CL_PROGRAM_BINARIES = 0x1166;
    }




    static if(!is(typeof(CL_PROGRAM_NUM_KERNELS))) {
        enum CL_PROGRAM_NUM_KERNELS = 0x1167;
    }




    static if(!is(typeof(CL_PROGRAM_KERNEL_NAMES))) {
        enum CL_PROGRAM_KERNEL_NAMES = 0x1168;
    }




    static if(!is(typeof(CL_PROGRAM_BUILD_STATUS))) {
        enum CL_PROGRAM_BUILD_STATUS = 0x1181;
    }




    static if(!is(typeof(CL_PROGRAM_BUILD_OPTIONS))) {
        enum CL_PROGRAM_BUILD_OPTIONS = 0x1182;
    }




    static if(!is(typeof(CL_PROGRAM_BUILD_LOG))) {
        enum CL_PROGRAM_BUILD_LOG = 0x1183;
    }




    static if(!is(typeof(CL_PROGRAM_BINARY_TYPE))) {
        enum CL_PROGRAM_BINARY_TYPE = 0x1184;
    }




    static if(!is(typeof(CL_PROGRAM_BINARY_TYPE_NONE))) {
        enum CL_PROGRAM_BINARY_TYPE_NONE = 0x0;
    }




    static if(!is(typeof(CL_PROGRAM_BINARY_TYPE_COMPILED_OBJECT))) {
        enum CL_PROGRAM_BINARY_TYPE_COMPILED_OBJECT = 0x1;
    }




    static if(!is(typeof(CL_PROGRAM_BINARY_TYPE_LIBRARY))) {
        enum CL_PROGRAM_BINARY_TYPE_LIBRARY = 0x2;
    }




    static if(!is(typeof(CL_PROGRAM_BINARY_TYPE_EXECUTABLE))) {
        enum CL_PROGRAM_BINARY_TYPE_EXECUTABLE = 0x4;
    }




    static if(!is(typeof(CL_BUILD_SUCCESS))) {
        enum CL_BUILD_SUCCESS = 0;
    }
    static if(!is(typeof(CL_KERNEL_FUNCTION_NAME))) {
        enum CL_KERNEL_FUNCTION_NAME = 0x1190;
    }




    static if(!is(typeof(CL_KERNEL_NUM_ARGS))) {
        enum CL_KERNEL_NUM_ARGS = 0x1191;
    }




    static if(!is(typeof(CL_KERNEL_REFERENCE_COUNT))) {
        enum CL_KERNEL_REFERENCE_COUNT = 0x1192;
    }




    static if(!is(typeof(CL_KERNEL_CONTEXT))) {
        enum CL_KERNEL_CONTEXT = 0x1193;
    }




    static if(!is(typeof(CL_KERNEL_PROGRAM))) {
        enum CL_KERNEL_PROGRAM = 0x1194;
    }




    static if(!is(typeof(CL_KERNEL_ATTRIBUTES))) {
        enum CL_KERNEL_ATTRIBUTES = 0x1195;
    }




    static if(!is(typeof(CL_KERNEL_ARG_ADDRESS_QUALIFIER))) {
        enum CL_KERNEL_ARG_ADDRESS_QUALIFIER = 0x1196;
    }




    static if(!is(typeof(CL_KERNEL_ARG_ACCESS_QUALIFIER))) {
        enum CL_KERNEL_ARG_ACCESS_QUALIFIER = 0x1197;
    }




    static if(!is(typeof(CL_KERNEL_ARG_TYPE_NAME))) {
        enum CL_KERNEL_ARG_TYPE_NAME = 0x1198;
    }




    static if(!is(typeof(CL_KERNEL_ARG_TYPE_QUALIFIER))) {
        enum CL_KERNEL_ARG_TYPE_QUALIFIER = 0x1199;
    }




    static if(!is(typeof(CL_KERNEL_ARG_NAME))) {
        enum CL_KERNEL_ARG_NAME = 0x119A;
    }




    static if(!is(typeof(CL_KERNEL_ARG_ADDRESS_GLOBAL))) {
        enum CL_KERNEL_ARG_ADDRESS_GLOBAL = 0x119B;
    }




    static if(!is(typeof(CL_KERNEL_ARG_ADDRESS_LOCAL))) {
        enum CL_KERNEL_ARG_ADDRESS_LOCAL = 0x119C;
    }




    static if(!is(typeof(CL_KERNEL_ARG_ADDRESS_CONSTANT))) {
        enum CL_KERNEL_ARG_ADDRESS_CONSTANT = 0x119D;
    }




    static if(!is(typeof(CL_KERNEL_ARG_ADDRESS_PRIVATE))) {
        enum CL_KERNEL_ARG_ADDRESS_PRIVATE = 0x119E;
    }




    static if(!is(typeof(CL_KERNEL_ARG_ACCESS_READ_ONLY))) {
        enum CL_KERNEL_ARG_ACCESS_READ_ONLY = 0x11A0;
    }




    static if(!is(typeof(CL_KERNEL_ARG_ACCESS_WRITE_ONLY))) {
        enum CL_KERNEL_ARG_ACCESS_WRITE_ONLY = 0x11A1;
    }




    static if(!is(typeof(CL_KERNEL_ARG_ACCESS_READ_WRITE))) {
        enum CL_KERNEL_ARG_ACCESS_READ_WRITE = 0x11A2;
    }




    static if(!is(typeof(CL_KERNEL_ARG_ACCESS_NONE))) {
        enum CL_KERNEL_ARG_ACCESS_NONE = 0x11A3;
    }




    static if(!is(typeof(CL_KERNEL_ARG_TYPE_NONE))) {
        enum CL_KERNEL_ARG_TYPE_NONE = 0;
    }
    static if(!is(typeof(CL_KERNEL_WORK_GROUP_SIZE))) {
        enum CL_KERNEL_WORK_GROUP_SIZE = 0x11B0;
    }




    static if(!is(typeof(CL_KERNEL_COMPILE_WORK_GROUP_SIZE))) {
        enum CL_KERNEL_COMPILE_WORK_GROUP_SIZE = 0x11B1;
    }




    static if(!is(typeof(CL_KERNEL_LOCAL_MEM_SIZE))) {
        enum CL_KERNEL_LOCAL_MEM_SIZE = 0x11B2;
    }




    static if(!is(typeof(CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE))) {
        enum CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE = 0x11B3;
    }




    static if(!is(typeof(CL_KERNEL_PRIVATE_MEM_SIZE))) {
        enum CL_KERNEL_PRIVATE_MEM_SIZE = 0x11B4;
    }




    static if(!is(typeof(CL_KERNEL_GLOBAL_WORK_SIZE))) {
        enum CL_KERNEL_GLOBAL_WORK_SIZE = 0x11B5;
    }




    static if(!is(typeof(CL_EVENT_COMMAND_QUEUE))) {
        enum CL_EVENT_COMMAND_QUEUE = 0x11D0;
    }




    static if(!is(typeof(CL_EVENT_COMMAND_TYPE))) {
        enum CL_EVENT_COMMAND_TYPE = 0x11D1;
    }




    static if(!is(typeof(CL_EVENT_REFERENCE_COUNT))) {
        enum CL_EVENT_REFERENCE_COUNT = 0x11D2;
    }




    static if(!is(typeof(CL_EVENT_COMMAND_EXECUTION_STATUS))) {
        enum CL_EVENT_COMMAND_EXECUTION_STATUS = 0x11D3;
    }




    static if(!is(typeof(CL_EVENT_CONTEXT))) {
        enum CL_EVENT_CONTEXT = 0x11D4;
    }




    static if(!is(typeof(CL_COMMAND_NDRANGE_KERNEL))) {
        enum CL_COMMAND_NDRANGE_KERNEL = 0x11F0;
    }




    static if(!is(typeof(CL_COMMAND_TASK))) {
        enum CL_COMMAND_TASK = 0x11F1;
    }




    static if(!is(typeof(CL_COMMAND_NATIVE_KERNEL))) {
        enum CL_COMMAND_NATIVE_KERNEL = 0x11F2;
    }




    static if(!is(typeof(CL_COMMAND_READ_BUFFER))) {
        enum CL_COMMAND_READ_BUFFER = 0x11F3;
    }




    static if(!is(typeof(CL_COMMAND_WRITE_BUFFER))) {
        enum CL_COMMAND_WRITE_BUFFER = 0x11F4;
    }




    static if(!is(typeof(CL_COMMAND_COPY_BUFFER))) {
        enum CL_COMMAND_COPY_BUFFER = 0x11F5;
    }




    static if(!is(typeof(CL_COMMAND_READ_IMAGE))) {
        enum CL_COMMAND_READ_IMAGE = 0x11F6;
    }




    static if(!is(typeof(CL_COMMAND_WRITE_IMAGE))) {
        enum CL_COMMAND_WRITE_IMAGE = 0x11F7;
    }




    static if(!is(typeof(CL_COMMAND_COPY_IMAGE))) {
        enum CL_COMMAND_COPY_IMAGE = 0x11F8;
    }




    static if(!is(typeof(CL_COMMAND_COPY_IMAGE_TO_BUFFER))) {
        enum CL_COMMAND_COPY_IMAGE_TO_BUFFER = 0x11F9;
    }




    static if(!is(typeof(CL_COMMAND_COPY_BUFFER_TO_IMAGE))) {
        enum CL_COMMAND_COPY_BUFFER_TO_IMAGE = 0x11FA;
    }




    static if(!is(typeof(CL_COMMAND_MAP_BUFFER))) {
        enum CL_COMMAND_MAP_BUFFER = 0x11FB;
    }




    static if(!is(typeof(CL_COMMAND_MAP_IMAGE))) {
        enum CL_COMMAND_MAP_IMAGE = 0x11FC;
    }




    static if(!is(typeof(CL_COMMAND_UNMAP_MEM_OBJECT))) {
        enum CL_COMMAND_UNMAP_MEM_OBJECT = 0x11FD;
    }




    static if(!is(typeof(CL_COMMAND_MARKER))) {
        enum CL_COMMAND_MARKER = 0x11FE;
    }




    static if(!is(typeof(CL_COMMAND_ACQUIRE_GL_OBJECTS))) {
        enum CL_COMMAND_ACQUIRE_GL_OBJECTS = 0x11FF;
    }




    static if(!is(typeof(CL_COMMAND_RELEASE_GL_OBJECTS))) {
        enum CL_COMMAND_RELEASE_GL_OBJECTS = 0x1200;
    }




    static if(!is(typeof(CL_COMMAND_READ_BUFFER_RECT))) {
        enum CL_COMMAND_READ_BUFFER_RECT = 0x1201;
    }




    static if(!is(typeof(CL_COMMAND_WRITE_BUFFER_RECT))) {
        enum CL_COMMAND_WRITE_BUFFER_RECT = 0x1202;
    }




    static if(!is(typeof(CL_COMMAND_COPY_BUFFER_RECT))) {
        enum CL_COMMAND_COPY_BUFFER_RECT = 0x1203;
    }




    static if(!is(typeof(CL_COMMAND_USER))) {
        enum CL_COMMAND_USER = 0x1204;
    }




    static if(!is(typeof(CL_COMMAND_BARRIER))) {
        enum CL_COMMAND_BARRIER = 0x1205;
    }




    static if(!is(typeof(CL_COMMAND_MIGRATE_MEM_OBJECTS))) {
        enum CL_COMMAND_MIGRATE_MEM_OBJECTS = 0x1206;
    }




    static if(!is(typeof(CL_COMMAND_FILL_BUFFER))) {
        enum CL_COMMAND_FILL_BUFFER = 0x1207;
    }




    static if(!is(typeof(CL_COMMAND_FILL_IMAGE))) {
        enum CL_COMMAND_FILL_IMAGE = 0x1208;
    }




    static if(!is(typeof(CL_COMPLETE))) {
        enum CL_COMPLETE = 0x0;
    }




    static if(!is(typeof(CL_RUNNING))) {
        enum CL_RUNNING = 0x1;
    }




    static if(!is(typeof(CL_SUBMITTED))) {
        enum CL_SUBMITTED = 0x2;
    }




    static if(!is(typeof(CL_QUEUED))) {
        enum CL_QUEUED = 0x3;
    }




    static if(!is(typeof(CL_BUFFER_CREATE_TYPE_REGION))) {
        enum CL_BUFFER_CREATE_TYPE_REGION = 0x1220;
    }




    static if(!is(typeof(CL_PROFILING_COMMAND_QUEUED))) {
        enum CL_PROFILING_COMMAND_QUEUED = 0x1280;
    }




    static if(!is(typeof(CL_PROFILING_COMMAND_SUBMIT))) {
        enum CL_PROFILING_COMMAND_SUBMIT = 0x1281;
    }




    static if(!is(typeof(CL_PROFILING_COMMAND_START))) {
        enum CL_PROFILING_COMMAND_START = 0x1282;
    }




    static if(!is(typeof(CL_PROFILING_COMMAND_END))) {
        enum CL_PROFILING_COMMAND_END = 0x1283;
    }
    static if(!is(typeof(__ENUM_IDTYPE_T))) {
        enum __ENUM_IDTYPE_T = 1;
    }




    static if(!is(typeof(__WCLONE))) {
        enum __WCLONE = 0x80000000;
    }




    static if(!is(typeof(__WALL))) {
        enum __WALL = 0x40000000;
    }




    static if(!is(typeof(__WNOTHREAD))) {
        enum __WNOTHREAD = 0x20000000;
    }




    static if(!is(typeof(WNOWAIT))) {
        enum WNOWAIT = 0x01000000;
    }




    static if(!is(typeof(WCONTINUED))) {
        enum WCONTINUED = 8;
    }




    static if(!is(typeof(WEXITED))) {
        enum WEXITED = 4;
    }




    static if(!is(typeof(WSTOPPED))) {
        enum WSTOPPED = 2;
    }




    static if(!is(typeof(WUNTRACED))) {
        enum WUNTRACED = 2;
    }




    static if(!is(typeof(WNOHANG))) {
        enum WNOHANG = 1;
    }




    static if(!is(typeof(__FD_SETSIZE))) {
        enum __FD_SETSIZE = 1024;
    }




    static if(!is(typeof(__INO_T_MATCHES_INO64_T))) {
        enum __INO_T_MATCHES_INO64_T = 1;
    }




    static if(!is(typeof(__OFF_T_MATCHES_OFF64_T))) {
        enum __OFF_T_MATCHES_OFF64_T = 1;
    }
    static if(!is(typeof(_BITS_TYPESIZES_H))) {
        enum _BITS_TYPESIZES_H = 1;
    }
    static if(!is(typeof(_BITS_TYPES_H))) {
        enum _BITS_TYPES_H = 1;
    }




    static if(!is(typeof(_STRUCT_TIMEVAL))) {
        enum _STRUCT_TIMEVAL = 1;
    }






    static if(!is(typeof(_SIGSET_H_types))) {
        enum _SIGSET_H_types = 1;
    }
    static if(!is(typeof(__FD_ZERO_STOS))) {
        enum __FD_ZERO_STOS = "stosq";
    }




    static if(!is(typeof(__PTHREAD_RWLOCK_INT_FLAGS_SHARED))) {
        enum __PTHREAD_RWLOCK_INT_FLAGS_SHARED = 1;
    }
    static if(!is(typeof(__PTHREAD_MUTEX_HAVE_PREV))) {
        enum __PTHREAD_MUTEX_HAVE_PREV = 1;
    }




    static if(!is(typeof(__have_pthread_attr_t))) {
        enum __have_pthread_attr_t = 1;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIERATTR_T))) {
        enum __SIZEOF_PTHREAD_BARRIERATTR_T = 4;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIER_T))) {
        enum __SIZEOF_PTHREAD_BARRIER_T = 32;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCKATTR_T))) {
        enum __SIZEOF_PTHREAD_RWLOCKATTR_T = 8;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCK_T))) {
        enum __SIZEOF_PTHREAD_RWLOCK_T = 56;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_CONDATTR_T))) {
        enum __SIZEOF_PTHREAD_CONDATTR_T = 4;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_COND_T))) {
        enum __SIZEOF_PTHREAD_COND_T = 48;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEXATTR_T))) {
        enum __SIZEOF_PTHREAD_MUTEXATTR_T = 4;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEX_T))) {
        enum __SIZEOF_PTHREAD_MUTEX_T = 40;
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_ATTR_T))) {
        enum __SIZEOF_PTHREAD_ATTR_T = 56;
    }




    static if(!is(typeof(_BITS_PTHREADTYPES_H))) {
        enum _BITS_PTHREADTYPES_H = 1;
    }
    static if(!is(typeof(_BITS_BYTESWAP_H))) {
        enum _BITS_BYTESWAP_H = 1;
    }






    static if(!is(typeof(__timespec_defined))) {
        enum __timespec_defined = 1;
    }




    static if(!is(typeof(__timer_t_defined))) {
        enum __timer_t_defined = 1;
    }




    static if(!is(typeof(__clockid_t_defined))) {
        enum __clockid_t_defined = 1;
    }




    static if(!is(typeof(__time_t_defined))) {
        enum __time_t_defined = 1;
    }




    static if(!is(typeof(__clock_t_defined))) {
        enum __clock_t_defined = 1;
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
    static if(!is(typeof(_STDLIB_H))) {
        enum _STDLIB_H = 1;
    }
    static if(!is(typeof(_STDINT_H))) {
        enum _STDINT_H = 1;
    }




    static if(!is(typeof(_STDC_PREDEF_H))) {
        enum _STDC_PREDEF_H = 1;
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




    static if(!is(typeof(__USE_ISOC11))) {
        enum __USE_ISOC11 = 1;
    }




    static if(!is(typeof(_DEFAULT_SOURCE))) {
        enum _DEFAULT_SOURCE = 1;
    }
    static if(!is(typeof(_FEATURES_H))) {
        enum _FEATURES_H = 1;
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
    static if(!is(typeof(_MM_HINT_NTA))) {
        enum _MM_HINT_NTA = 0;
    }




    static if(!is(typeof(_MM_HINT_T2))) {
        enum _MM_HINT_T2 = 1;
    }




    static if(!is(typeof(_MM_HINT_T1))) {
        enum _MM_HINT_T1 = 2;
    }




    static if(!is(typeof(_MM_HINT_T0))) {
        enum _MM_HINT_T0 = 3;
    }




    static if(!is(typeof(_MM_HINT_ET1))) {
        enum _MM_HINT_ET1 = 6;
    }




    static if(!is(typeof(_MM_HINT_ET0))) {
        enum _MM_HINT_ET0 = 7;
    }
    static if(!is(typeof(CL_CHAR_BIT))) {
        enum CL_CHAR_BIT = 8;
    }




    static if(!is(typeof(CL_SCHAR_MAX))) {
        enum CL_SCHAR_MAX = 127;
    }
    static if(!is(typeof(CL_UCHAR_MAX))) {
        enum CL_UCHAR_MAX = 255;
    }




    static if(!is(typeof(CL_SHRT_MAX))) {
        enum CL_SHRT_MAX = 32767;
    }






    static if(!is(typeof(CL_USHRT_MAX))) {
        enum CL_USHRT_MAX = 65535;
    }




    static if(!is(typeof(CL_INT_MAX))) {
        enum CL_INT_MAX = 2147483647;
    }






    static if(!is(typeof(CL_UINT_MAX))) {
        enum CL_UINT_MAX = 0xffffffffU;
    }
    static if(!is(typeof(CL_FLT_DIG))) {
        enum CL_FLT_DIG = 6;
    }




    static if(!is(typeof(CL_FLT_MANT_DIG))) {
        enum CL_FLT_MANT_DIG = 24;
    }
    static if(!is(typeof(CL_FLT_RADIX))) {
        enum CL_FLT_RADIX = 2;
    }




    static if(!is(typeof(CL_FLT_MAX))) {
        enum CL_FLT_MAX = 0x1.fffffep127f;
    }




    static if(!is(typeof(CL_FLT_MIN))) {
        enum CL_FLT_MIN = 0x1.0p-126f;
    }




    static if(!is(typeof(CL_FLT_EPSILON))) {
        enum CL_FLT_EPSILON = 0x1.0p-23f;
    }




    static if(!is(typeof(CL_DBL_DIG))) {
        enum CL_DBL_DIG = 15;
    }




    static if(!is(typeof(CL_DBL_MANT_DIG))) {
        enum CL_DBL_MANT_DIG = 53;
    }
    static if(!is(typeof(CL_DBL_RADIX))) {
        enum CL_DBL_RADIX = 2;
    }




    static if(!is(typeof(CL_DBL_MAX))) {
        enum CL_DBL_MAX = 0x1.fffffffffffffp1023;
    }




    static if(!is(typeof(CL_DBL_MIN))) {
        enum CL_DBL_MIN = 0x1.0p-1022;
    }




    static if(!is(typeof(CL_DBL_EPSILON))) {
        enum CL_DBL_EPSILON = 0x1.0p-52;
    }




    static if(!is(typeof(CL_M_E))) {
        enum CL_M_E = 2.718281828459045090796;
    }




    static if(!is(typeof(CL_M_LOG2E))) {
        enum CL_M_LOG2E = 1.442695040888963387005;
    }




    static if(!is(typeof(CL_M_LOG10E))) {
        enum CL_M_LOG10E = 0.434294481903251816668;
    }




    static if(!is(typeof(CL_M_LN2))) {
        enum CL_M_LN2 = 0.693147180559945286227;
    }




    static if(!is(typeof(CL_M_LN10))) {
        enum CL_M_LN10 = 2.302585092994045901094;
    }




    static if(!is(typeof(CL_M_PI))) {
        enum CL_M_PI = 3.141592653589793115998;
    }




    static if(!is(typeof(CL_M_PI_2))) {
        enum CL_M_PI_2 = 1.570796326794896557999;
    }




    static if(!is(typeof(CL_M_PI_4))) {
        enum CL_M_PI_4 = 0.785398163397448278999;
    }




    static if(!is(typeof(CL_M_1_PI))) {
        enum CL_M_1_PI = 0.318309886183790691216;
    }




    static if(!is(typeof(CL_M_2_PI))) {
        enum CL_M_2_PI = 0.636619772367581382433;
    }




    static if(!is(typeof(CL_M_2_SQRTPI))) {
        enum CL_M_2_SQRTPI = 1.128379167095512558561;
    }




    static if(!is(typeof(CL_M_SQRT2))) {
        enum CL_M_SQRT2 = 1.414213562373095145475;
    }




    static if(!is(typeof(CL_M_SQRT1_2))) {
        enum CL_M_SQRT1_2 = 0.707106781186547572737;
    }




    static if(!is(typeof(CL_M_E_F))) {
        enum CL_M_E_F = 2.71828174591064f;
    }




    static if(!is(typeof(CL_M_LOG2E_F))) {
        enum CL_M_LOG2E_F = 1.44269502162933f;
    }




    static if(!is(typeof(CL_M_LOG10E_F))) {
        enum CL_M_LOG10E_F = 0.43429449200630f;
    }




    static if(!is(typeof(CL_M_LN2_F))) {
        enum CL_M_LN2_F = 0.69314718246460f;
    }




    static if(!is(typeof(CL_M_LN10_F))) {
        enum CL_M_LN10_F = 2.30258512496948f;
    }




    static if(!is(typeof(CL_M_PI_F))) {
        enum CL_M_PI_F = 3.14159274101257f;
    }




    static if(!is(typeof(CL_M_PI_2_F))) {
        enum CL_M_PI_2_F = 1.57079637050629f;
    }




    static if(!is(typeof(CL_M_PI_4_F))) {
        enum CL_M_PI_4_F = 0.78539818525314f;
    }




    static if(!is(typeof(CL_M_1_PI_F))) {
        enum CL_M_1_PI_F = 0.31830987334251f;
    }




    static if(!is(typeof(CL_M_2_PI_F))) {
        enum CL_M_2_PI_F = 0.63661974668503f;
    }




    static if(!is(typeof(CL_M_2_SQRTPI_F))) {
        enum CL_M_2_SQRTPI_F = 1.12837922573090f;
    }




    static if(!is(typeof(CL_M_SQRT2_F))) {
        enum CL_M_SQRT2_F = 1.41421353816986f;
    }




    static if(!is(typeof(CL_M_SQRT1_2_F))) {
        enum CL_M_SQRT1_2_F = 0.70710676908493f;
    }
    static if(!is(typeof(__CL_FLOAT4__))) {
        enum __CL_FLOAT4__ = 1;
    }
    static if(!is(typeof(__CL_UCHAR16__))) {
        enum __CL_UCHAR16__ = 1;
    }




    static if(!is(typeof(__CL_CHAR16__))) {
        enum __CL_CHAR16__ = 1;
    }




    static if(!is(typeof(__CL_USHORT8__))) {
        enum __CL_USHORT8__ = 1;
    }




    static if(!is(typeof(__CL_SHORT8__))) {
        enum __CL_SHORT8__ = 1;
    }




    static if(!is(typeof(__CL_INT4__))) {
        enum __CL_INT4__ = 1;
    }




    static if(!is(typeof(__CL_UINT4__))) {
        enum __CL_UINT4__ = 1;
    }




    static if(!is(typeof(__CL_ULONG2__))) {
        enum __CL_ULONG2__ = 1;
    }




    static if(!is(typeof(__CL_LONG2__))) {
        enum __CL_LONG2__ = 1;
    }




    static if(!is(typeof(__CL_DOUBLE2__))) {
        enum __CL_DOUBLE2__ = 1;
    }
    static if(!is(typeof(_ALLOCA_H))) {
        enum _ALLOCA_H = 1;
    }




    static if(!is(typeof(__CL_UCHAR8__))) {
        enum __CL_UCHAR8__ = 1;
    }




    static if(!is(typeof(__CL_CHAR8__))) {
        enum __CL_CHAR8__ = 1;
    }




    static if(!is(typeof(__CL_USHORT4__))) {
        enum __CL_USHORT4__ = 1;
    }




    static if(!is(typeof(__CL_SHORT4__))) {
        enum __CL_SHORT4__ = 1;
    }




    static if(!is(typeof(__CL_INT2__))) {
        enum __CL_INT2__ = 1;
    }




    static if(!is(typeof(__CL_UINT2__))) {
        enum __CL_UINT2__ = 1;
    }




    static if(!is(typeof(__CL_ULONG1__))) {
        enum __CL_ULONG1__ = 1;
    }




    static if(!is(typeof(__CL_LONG1__))) {
        enum __CL_LONG1__ = 1;
    }




    static if(!is(typeof(__CL_FLOAT2__))) {
        enum __CL_FLOAT2__ = 1;
    }




    static if(!is(typeof(__CL_HAS_ANON_STRUCT__))) {
        enum __CL_HAS_ANON_STRUCT__ = 1;
    }
    static if(!is(typeof(CL_HAS_NAMED_VECTOR_FIELDS))) {
        enum CL_HAS_NAMED_VECTOR_FIELDS = 1;
    }




    static if(!is(typeof(CL_HAS_HI_LO_VECTOR_FIELDS))) {
        enum CL_HAS_HI_LO_VECTOR_FIELDS = 1;
    }






}
