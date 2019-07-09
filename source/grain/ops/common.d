module grain.ops.common;

auto apply(Ops, Args...)(Ops ops, Args args)
{
    return ops.forward(args);
}
