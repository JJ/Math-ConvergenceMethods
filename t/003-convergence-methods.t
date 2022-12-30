use Test;

use Math::ConvergenceMethods;

sub foo ($x) {return $x + 1;}

sub bar ($x) {return $x/3 + 1/2}

for [ &bisection, &regula-falsi, &seccant ] -> &f {
    subtest {
        is-approx f(&foo, -2, 0), -1, "Method converge as expected";
        is-approx f(&foo,-2,1), -1, "Method with differeng sign";
        dies-ok { f(&foo, 3, 2) }, "throws Invalid interval correctly";
    }, "Testing function {&f.name}";
}

subtest {
    is-approx newton-raphson(&foo, -2, 0), -1, "Method converge as expected";
    is-approx newton-raphson(&foo, -2, 0, -1.01), -1, "Method converge as expected";
    dies-ok { newton-raphson(&foo, 3, 2) }, "throws Invalid interval correctly";
}, "Testing Newton-Raphson";

done-testing;
