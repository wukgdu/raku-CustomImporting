unit module CustomImporting;

# use experimental :macros;

sub find-item($arr, $exported-items, $our-items) {
    $arr.map(-> $a {
        my $tmp = $exported-items{$a};
        if ($tmp.defined) {
            $tmp;
        } else {
            $tmp = $our-items{$a};
        }
    });
}

our sub from-import-rt(Str $mname, $f) is export {
    require ::($mname);
    from-import(::($mname), $f);
}

our sub from-import(\mo, $f) is export {
    my $our-items = mo::;
    my \mo1 = $our-items{"EXPORT"};
    my $tmp1 = mo1::;
    my \mo2 = $tmp1{"ALL"};
    my $exported-items = mo2::; # EVAL "mo::EXPORT::ALL::";
    my @res = find-item(@$f, $exported-items, $our-items);
    return @res[0] if not $f ~~ Iterable;
    return @res;
}
