use v6;
use Test;

plan 23;

use Constraint::Solver;

{
    my @solutions = solve q[
        my 1..3 $a;
    ];

    is +@solutions, 3, "right number of solutions";
    is @solutions[0]<a>, 1, "solution 1";
    is @solutions[1]<a>, 2, "solution 2";
    is @solutions[2]<a>, 3, "solution 3";
}

{
    my @solutions = solve q[
        my 1..3 $a;
        my 1..3 $b;
    ];

    is +@solutions, 9, "right number of solutions";
    is @solutions[0]<a>, 1, "solution 1 a";
    is @solutions[0]<b>, 1, "solution 1 b";
    is @solutions[1]<a>, 1, "solution 2 a";
    is @solutions[1]<b>, 2, "solution 2 b";
    is @solutions[2]<a>, 1, "solution 3 a";
    is @solutions[2]<b>, 3, "solution 3 b";

    is @solutions[3]<a>, 2, "solution 4 a";
    is @solutions[3]<b>, 1, "solution 4 b";
    is @solutions[4]<a>, 2, "solution 5 a";
    is @solutions[4]<b>, 2, "solution 5 b";
    is @solutions[5]<a>, 2, "solution 6 a";
    is @solutions[5]<b>, 3, "solution 6 b";

    is @solutions[6]<a>, 3, "solution 7 a";
    is @solutions[6]<b>, 1, "solution 7 b";
    is @solutions[7]<a>, 3, "solution 8 a";
    is @solutions[7]<b>, 2, "solution 8 b";
    is @solutions[8]<a>, 3, "solution 9 a";
    is @solutions[8]<b>, 3, "solution 9 b";
}
