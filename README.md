NAME
====

CustomImporting - import and rename items from modules

SYNOPSIS
========

```raku
use CustomImporting;

# import in run time
my &to-json = from-import-rt("JSON::Fast", '&to-json')

# or need & alias
need JSON::Fast;
need JSON::Tiny;

my (&from-json1, &to-json1) = from-import(JSON::Fast, <&from-json &to-json>)
my (&from-json2, &to-json2) = from-import(JSON::Tiny, <&from-json &to-json>)
```

DESCRIPTION
===========

CustomImporting is a small helper to select items for importing from modules and make aliases.

It uses `need` instead of `use` to avoid conflicts between similar modules. It will search `export`ed items, and then `our` items in modules.

Note:
```raku
# for values, `:=` should be used instead of `=` for binding

# module
unit module XXX;
our @arr is export = [1, 2, 3];
our $arr2 is export = [1, 2, 3];
our $v is export = 42;

# use it after `need`
my @arr := from-import(XXX, <@arr>); # works
my $arr2 := from-import(XXX, <$arr2>); # works
my ($v1 is rw) := from-import(XXX, ['$v1']); # work in List and marked with `is rw`, but strange
my $v1 = from-import(XXX, <$v1>); # not work: get value, but not bound to it
my $v1 := from-import(XXX, <$v1>); # not work: get value, but cause 'Cannot assign to a readonly variable or a value' when try to modify it
```

Example: t/01-import.rakutest and t/testimporting.rakumod. 

Ref: https://docs.raku.org/language/modules#Introspection

AUTHOR
======

https://github.com/wukgdu

COPYRIGHT AND LICENSE
=====================

Copyright 2022 

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

