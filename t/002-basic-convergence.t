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
    is-approx bisection(&f, -2, 0), -1, "bisecction method converge as expected";
    dies-ok { bisection(&f, 3, 2) }, "throws Invalid interval correctly";
}
{
    is-approx regula-falsi(&f, -2, 0), -1, "regula-falsi method converge as expected";
    dies-ok { regula-falsi(&f, 3, 2) }, "throws Invalid interval correctly";
}
{
    is-approx seccant(&f, -2, 0), -1, "seccant method converge as expected";
    dies-ok { seccant(&f, 3, 2) }, "throws Invalid interval correctly";
}
{
    is-approx newton-raphson(&f, -2, 0), -1, "newton-raphson method converge as expected";
    dies-ok { newton-raphson(&f, 3, 2) }, "throws Invalid interval correctly";
}
{
    is-approx functional-iteration(&f2, -2, -1), -3/2, "functional-iteration method converge as expected";
    dies-ok { functional-iteration(&f2, 3, 2) }, "throws Invalid interval correctly";
}
done-testing;
