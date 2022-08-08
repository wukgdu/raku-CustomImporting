unit module CustomImporting;

# use experimental :macros;

sub find-item(@arr, $exported-items, $our-items, $mo) {
    @arr.map(-> $a {
        if ($exported-items{$a}:exists) {
            $exported-items{$a};
        } elsif ($our-items{$a}:exists) {
            $our-items{$a};
        } else {
            warn "[CustomImporting] warn: $a doesn't exist in {$mo}";
            Any;
        }
    });
}

our sub from-import-rt(Str $mname, $f) is export {
    require ::($mname);
    from-import(::($mname), $f);
}

our sub from-import(\mo, $f) is export {
    my $our-items = mo.WHO;
    my $exported-items = mo.WHO{"EXPORT"}.WHO{"ALL"}.WHO; # EVAL "mo::EXPORT::ALL::";
    my $res = find-item(@$f, $exported-items, $our-items, mo.raku);
    return $res[0] if not $f ~~ Iterable;
    return $res;
}
