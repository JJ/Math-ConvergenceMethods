use Test;

use Math::ConvergenceMethods;

sub foo ($x) {return $x + 1;}

sub f2 ($x) {return $x/3 + 1/2}

for [ &bisection, &regula-falsi, &seccant, &newton-raphson ] -> &f {
    subtest {
        is-approx f(&foo, -2, 0), -1, "bisecction method converge as expected";
        dies-ok { f(&foo, 3, 2) }, "throws Invalid interval correctly";
    }, "Testing function";
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
