use v6;
use Test;

plan 2;

use Constraint::Solver;

{
    my @solutions = solve q[
        use distinct;

        my 1..3 $a;
        my 1..3 $b;
    ];

    is +@solutions, 6, "right number of solutions";
}

{
    my @solutions = solve q[
        use distinct;

        my 1..2 $a;
        my 2..3 $b;
        my 3..3 $c;
    ];

    is +@solutions, 1, "right number of solutions";
}
