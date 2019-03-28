use v6;

use Math::StoppingConditions;

unit module Math::ConvergenceMethods;

sub derivative ($f, $x, $delta = 1e-4) is export {
    ( $f( $x + $delta ) - $f($x) ) / $delta
}

sub necessary-iterations ($a, $b, $epsilon = 1e-15) is export {
    (log(($b-$a) / $epsilon) / log(2) - 1).ceiling
}

# bisectioni method
sub bisection ($f, $a is copy, $b is copy) is export {
    die "Invalid interval (a < b)" if $a >= $b;
    my $n = necessary-iterations($a, $b);
    for 1 .. $n {
        state $c;
        $c = ($a+$b) / 2;

        # solution found
        return $c if residue( $f($c) );

        if $f( $a )*$f( $c ) < 0 {
            $b=$c
        } else {
            $a=$c
        }

        LAST {return $c;}
    }
}


# regula-falsi method
sub regula-falsi ($f, $a is copy, $b is copy) is export {
    die "Invalid interval (a < b)" if $a >= $b;
    my $c = $b - ( $b - $a ) * $f($b) / ( $f($b) - $f($a) );

    {
        if $f( $a )*$f( $c ) < 0 {
            $b=$c
        } else {
            $a=$c
        }

        $c = $b - ( $b - $a ) * $f($b) / ( $f($b) - $f($a) );
    } while ! residue( $f( $c ) );

    return $c;
}

# seccant method
sub seccant ($f, $a is copy, $b is copy) is export {
    die "Invalid interval (a < b)" if $a >= $b;
    my $c = $b - ( $b - $a ) * $f($b) / ( $f($b) - $f($a) );

    {
        $a = $b;
        $b = $c;
        $c = $b - ( $b - $a ) * $f($b) / ( $f($b) - $f($a) );
    } while ! residue( $f( $c ) );

    return $c;
}

# newthon-raphson
sub newton-raphson ($f, $a, $b) is export {
    die "Invalid interval (a < b)" if $a >= $b;
    my $x_0 = ($a+$b) / 2.0;
    my $x_1 = $x_0 -$f($x_0) / derivative( $f, $x_0 );

    {
        $x_0 = $x_1;
        $x_1 = $x_0 -$f($x_0) / derivative( $f, $x_0 );

    } while ! residue( $f( $x_1 ) );

    return $x_1;

}
