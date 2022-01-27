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

Example: 01-import.rakutest and t/testimporting.rakumod. 

Ref: https://docs.raku.org/language/modules#Introspection

AUTHOR
======

https://github.com/wukgdu

COPYRIGHT AND LICENSE
=====================

Copyright 2022 

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

