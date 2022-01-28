unit module CustomImporting;

# use experimental :macros;

sub find-item(@arr, $exported-items, $our-items) {
    @arr.map(-> $a {
        my $tmp1 := $exported-items{$a};
        if ($tmp1.defined) {
            $tmp1;
        } else {
            $our-items{$a};
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
    my $res = find-item(@$f, $exported-items, $our-items);
    return $res[0] if not $f ~~ Iterable;
    return $res;
}
