use v6;
use Test;
plan *;

use lib "lib";
use Math::StoppingConditions;

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