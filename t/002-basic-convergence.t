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

done-testing;
