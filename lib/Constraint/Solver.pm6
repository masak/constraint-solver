module Constraint::Solver;

grammar Constraint::Perl6 {
    regex TOP { ^ <declaration>* $ }

    rule declaration { 'my' <range> <varname> ';' }
    rule range { \d+ '..' \d+ }
    token varname { '$' \w+ }
}

sub solve($specification) is export {
    Constraint::Perl6.parse($specification) or die "Could not parse";
    my @code-start = "gather \{";
    my @code-end = "\}";
    my @variables;
    for $/<declaration> -> $decl {
        my $range = $decl<range>.trim;
        my $varname = $decl<varname>.trim;
        push @code-start, "for $range -> $varname \{";
        unshift @code-end, "\}";
        push @variables, $varname;
    }
    my $code-take
        = "take \{ " ~ (join ", ", map { ":$_" }, @variables) ~ "\};";
    eval @code-start.join() ~ $code-take ~ @code-end.join();
}
