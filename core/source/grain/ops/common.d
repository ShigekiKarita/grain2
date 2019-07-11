module grain.ops.common;

auto apply(Ops, Args...)(Ops ops, Args args)
{
    // merge all forward overloads
    import grain : forward;
    return ops.forward(args);
}
