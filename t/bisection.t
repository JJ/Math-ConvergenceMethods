use v6;
use Test;

plan *;

use lib "lib";
use Math::ConvergenceMethods;

sub f ($x) {return $x + 1;}


{
    is-approx bisection(&f, -2, 0), -1;
    dies-ok { bisection(&f, 3, 2) };
}

done-testing;