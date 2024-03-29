use Math::StoppingConditions;

unit module Math::ConvergenceMethods;

sub derivative (&f, $x, $delta = 1e-4) is export {
    ( f( $x + $delta ) - f($x) ) / $delta
}

sub necessary-iterations ($a, $b, $epsilon = 1e-15) is export {
    (log(($b-$a) / $epsilon) / log(2) - 1).ceiling
}

sub bisection (&f, $a is copy, $b is copy where $a < $b) is export {
    my $n = necessary-iterations($a, $b);
    for 1 .. $n {
        state $c;
        $c = ($a+$b) / 2;

        # solution found
        return $c if residue( f($c) );

        if f( $a )*f( $c ) < 0 {
            $b=$c
        } else {
            $a=$c
        }

        LAST {return $c;}
    }
}

sub regula-falsi (&f, $a is copy, $b is copy where $a < $b) is export {
    my $c = $b - ( $b - $a ) * f($b) / ( f($b) - f($a) );

    {
        if f( $a )*f( $c ) < 0 {
            $b=$c
        } else {
            $a=$c
        }

        $c = $b - ( $b - $a ) * f($b) / ( f($b) - f($a) );
    } while ! residue( f( $c ) );

    return $c;
}

sub seccant (&f, $a is copy, $b is copy where $a < $b ) is export {
    my $c = $b - ( $b - $a ) * f($b) / ( f($b) - f($a) );

    {
        $a = $b;
        $b = $c;
        $c = $b - ( $b - $a ) * f($b) / ( f($b) - f($a) );
    } while ! residue( f( $c ) );

    return $c;
}

sub newton-raphson (&f, $a,
                    $b where $a < $b,
                    $x_0 is copy = ($a+$b) / 2.0) is export {
    my $x_1 = $x_0 -f($x_0) / derivative( &f, $x_0 );
    {
        $x_0 = $x_1;
        $x_1 = $x_0 -f($x_0) / derivative( &f, $x_0 );
    } while ! residue( f( $x_1 ) );

    return $x_1;
}

sub functional-iteration (&f, $a, $b where $a < $b) is export {
    my $x_0 = ($a+$b) / 2.0;
    $x_0 = f($x_0) while $x_0 != f($x_0);

    if $a <= $x_0 <= $b {
        return $x_0;
    } else {
        fail("Fixed point $x_0 does not fall between $a and $b")
    }
}

sub steffensen (&f, $a,
                $b where $a < $b,
                $x0 is copy = ($a+$b) / 2.0) is export {
    repeat {
        my $fx = f($x0);
        my $gx = f( $x0 + $fx )/$fx - 1;
        say "S $fx, $gx, $x0";
        $x0 -= $fx/$gx;
    } until residue( f( $x0 ) );

    return $x0;
}
