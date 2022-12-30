use Test;

use Math::ConvergenceMethods;

sub bar ($x) {return $x/3 + 1/2}

for [&functional-iteration,&steffsen] -> &f {
    subtest {
        is-approx f(&bar, -2, 1), 3/4, "Method converges as expected";
        dies-ok { f(&bar, 3, 2) }, "throws Invalid interval correctly";
    }, "Testing {&f.name}";
}

done-testing;
