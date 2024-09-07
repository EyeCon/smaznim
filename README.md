# smaznim
This is a [Nim language](https://nim-lang.org/) wrapper for the [smaz short text compressor](https://github.com/antirez/smaz).

# API
```nim
proc compress*(s: openArray[char]): string
proc decompress*(s: openArray[char]): string
```

# Preparation

You have to copy the 2 files from the [smaz project](https://github.com/antirez/smaz):

* smaz.c
* smaz.h

For the test to pass, you have to copy them into the `src` directory of this repo.

You also have to configure the directory you are using for these files as an include directory. You can do that by passing the switch `--passC:"-I directoryname"` to the Nim compiler. You can also put the following in a file with the same name but with a .nims extension: `switch("passC", "-I directoryname")` (see also tests directory in the repo).

For details on the configuration, see: https://nim-lang.org/docs/nims.html

# Usage

```nim
import std/[strutils]

import smaz

let
  testStr = "Quick brown fox jumps over the lazy dog"
  compressed = compress(testStr)
  decompressed = decompress(compressed)

assert decompressed == testStr

echo testStr.len
echo compressed.len
echo compressed.toHex
echo decompressed
```
