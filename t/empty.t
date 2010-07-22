use v6;
use Test;

plan 4;

use Constraint::Solver;

{
    my @solutions = solve q[];

    is +@solutions, 1, "right number of solutions";
    is +@solutions[0], 0, "solution contains no entries";
}

{
    my @solutions = solve q[
    ];

    is +@solutions, 1, "right number of solutions";
    is +@solutions[0], 0, "solution contains no entries";
}
