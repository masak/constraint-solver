module Constraint::Solver;

grammar Constraint::Perl6 {
    regex TOP { ^ <.ws> <pragma>* <declaration>* $ }

    rule pragma { 'use' <modname> ';' }
    token modname { \w+ }

    rule declaration { 'my' <range> <varname> ';' }
    rule range { \d+ '..' \d+ }
    token varname { '$' \w+ }
}

sub solve($specification) is export {
    Constraint::Perl6.parse($specification) or die "Could not parse";

    my $use-distinct = False;

    my @code-start = "gather \{";
    my @code-end = "\}";
    my @variables;

    for $/<pragma> -> $pragma {
        given ~$pragma<modname> {
            when 'distinct' { $use-distinct = True }
            default { die "Unknown pragma '$_'" }
        }
    }

    for $/<declaration> -> $decl {
        my $range = $decl<range>.trim;
        my $varname = $decl<varname>.trim;
        push @code-start, "for $range -> $varname \{";
        if $use-distinct {
            my $varlist =
                   @variables == 1 ?? @variables[0]
                !! @variables      ?? "any " ~ (join ", ", @variables)
                                   !! "";
            if $varlist {
                push @code-start, "next if $varname == $varlist;";
            }
        }
        unshift @code-end, "\}";
        push @variables, $varname;
    }

    my $code-take
        = "take \{ " ~ (join ", ", map { ":$_" }, @variables) ~ "\};";

    eval @code-start.join() ~ $code-take ~ @code-end.join();
}
