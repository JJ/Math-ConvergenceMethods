use v6;
use Test;
plan *;

use lib "lib";

use Math::StoppingConditions;
use Math::ConvergenceMethods;

sub f ($x) {return $x + 1;}

{
    is-approx necessary-iterations(1,2), 49;
    is-approx derivative(&f, 2), 1;
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
    is-approx bisection(&f, -2, 0), -1;
    dies-ok { bisection(&f, 3, 2) };
}
{
    is-approx regula-falsi(&f, -2, 0), -1;
    dies-ok { regula-falsi(&f, 3, 2) };
}
{
    is-approx seccant(&f, -2, 0), -1;
    dies-ok { seccant(&f, 3, 2) };
}
{
    is-approx newton-raphson(&f, -2, 0), -1;
    dies-ok { newton-raphson(&f, 3, 2) };
}
done-testing;