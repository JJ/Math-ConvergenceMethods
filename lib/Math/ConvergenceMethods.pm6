use v6;

use Math::StoppingConditions;

unit module Math::ConvergenceMethods;

sub necessary-iterations($a, $b, $epsilon = 1e-15) {
    return (log(($b-$a) / $epsilon) / log(2) - 1).ceiling
}

# bisectioni method
sub bisection ($f, $a is copy, $b is copy) is export {
    die "Incorrect arguments" if $a >= $b;
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
    die "Incorrect arguments" if $a >= $b;
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
    die "Incorrect arguments" if $a >= $b;
    my $c = $b - ( $b - $a ) * $f($b) / ( $f($b) - $f($a) );

    {
        $a = $b;
        $b = $c;
        $c = $b - ( $b - $a ) * $f($b) / ( $f($b) - $f($a) );
    } while ! residue( $f( $c ) );

    return $c;
}
