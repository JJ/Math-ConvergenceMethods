use Test;

use Math::ConvergenceMethods;

sub foo ($x) {return $x + 1;}

sub bar ($x) {return $x/3 + 1/2}

for [ &bisection, &regula-falsi, &seccant, &newton-raphson ] -> &f {
    subtest {
        is-approx f(&foo, -2, 0), -1, "Method converge as expected";
        is-approx f(&foo,-2,1), 0.5, "Method with differeng sign";
        dies-ok { f(&foo, 3, 2) }, "throws Invalid interval correctly";
    }, "Testing function";
}

for [&functional-iteration,&steffsen] -> &f {
    subtest {
        is-approx f(&bar, -2, -1), -3/2, "functional-iteration method converge
as expected";
        dies-ok { f(&bar, 3, 2) }, "throws Invalid interval correctly";
    }
}

done-testing;
