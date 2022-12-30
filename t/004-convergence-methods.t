use Test;

use Math::ConvergenceMethods;

sub bar ($x) {return $x/3 + 1/2}

subtest {
    is-approx functional-iteration(&bar, -2, 1), 3/4,
            "Method functional-iteration converges as expected";
    dies-ok { functional-iteration(&bar, 3, 2) },
            "throws Invalid interval correctly";
}, "Testing functional iteration";

sub foo ($x) { $x/3 + 1/3}

subtest {
    is-approx steffensen(&foo, -2, 1), -1, "Method converges as expected";
    dies-ok { functional-iteration(&foo, 3, 2) },
            "throws Invalid interval correctly";
}, "Testing Steffensen";

done-testing;
