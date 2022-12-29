use v6;
use Test;
plan *;

use Math::StoppingConditions;
use Math::ConvergenceMethods;

sub f ($x) {return $x + 1;}

sub f2 ($x) {return $x/3 + 1/2}

{
    is-approx necessary-iterations(1,2), 49, "necessary-iterations working as expected";
    is-approx derivative(&f, 2), 1, "derivative working as expected";
}
{
    nok diff(2, 0);
    ok diff(2, 0, 3);
    ok diff(0, 0);
}
{
    nok relative-diff(2, 0);
    ok relative-diff(2, 0, 3);
    nok relative-diff(1, 0);
}
{
    nok residue(2);
    ok residue(2, 3);
    nok residue(1);
}

{
    is-approx functional-iteration(&f2, -2, -1), -3/2, "functional-iteration method converge as expected";
    dies-ok { functional-iteration(&f2, 3, 2) }, "throws Invalid interval correctly";
}
{
    is-approx steffsen(&f2, -2, -1), -3/2, "steffsen method converge as expected";
    dies-ok { steffsen(&f2, 3, 2) }, "throws Invalid interval correctly";
}
done-testing;
