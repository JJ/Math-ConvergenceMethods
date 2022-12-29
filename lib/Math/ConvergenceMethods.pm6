use v6;

use Math::StoppingConditions;

unit module Math::ConvergenceMethods;

sub derivative ($f, $x, $delta = 1e-4) is export {
    ( $f( $x + $delta ) - $f($x) ) / $delta
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

sub newton-raphson (&f, $a, $b where $a < $b) is export {
    my $x_0 = ($a+$b) / 2.0;
    my $x_1 = $x_0 -f($x_0) / derivative( &f, $x_0 );

    {
        $x_0 = $x_1;
        $x_1 = $x_0 -f($x_0) / derivative( &f, $x_0 );

    } while ! residue( f( $x_1 ) );

    return $x_1;
}

# functional iteration
sub functional-iteration ($f, $a, $b where $a < $b) is export {
    my $x_0 = ($a+$b) / 2.0;

    {
        $x_0 = $f($x_0);
    } while ! residue( $f( $x_0 ) );

    return $x_0;
}

# steffsen
sub steffsen ($f, $a, $b where $a < $b) is export {
    my $x_1 = ($a+$b) / 2.0;
    my $x = $x_1;
    $x_1 = $f($x_1);
    my $x_2 = $f($x_1);

    {
      $x = $x - ( ($x_1-$x)**2 ) / ( $x_2-2*$x_1+$x );
      $x_1 = $f( $x );
      $x_2 = $f($x_1);
    } while ! residue( $f( $x ) );

    return $x;
}
