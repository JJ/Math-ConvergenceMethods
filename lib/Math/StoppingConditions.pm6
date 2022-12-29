use v6;

unit module Math::StoppingConditions;

subset PositiveNum of Numeric where * > 0;

sub diff (Numeric:D $x_1, Numeric:D $x_0, PositiveNum:D $epsilon = 10e-15) is export { 
    return abs( $x_1 - $x_0 ) < $epsilon ?? True !! False;
}

sub relative-diff (PositiveNum:D $x_1, Numeric:D $x_0, PositiveNum:D $epsilon = 10e-15) is export {
    return abs( ($x_1 - $x_0) / $x_1 ) < $epsilon ?? True !! False;
}

sub residue (Numeric:D $x, PositiveNum:D $epsilon = 10e-15) is export {
    return abs( $x ) < $epsilon;
}

