use v6;
use Test;

plan 3;

use Constraint::Solver;

{
    my @solutions = solve q[
        my 1..3 $a;
        my 1..$a $b;
        my $b..3 $c;
    ];

    is +@solutions, 14, "right number of solutions";
}

dies_ok { solve q[
    my 1..$a $a;
] }, "range may not be bound by the variable being declared";

dies_ok { solve q[
    my 1..$b $a;
    my 1..3 $b;
] }, "range may not be bound by a variable that hasn't been declared";
