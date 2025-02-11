#!/bin/sh

DIR="folly"

REGEXP="0([']?[0-7]+)+[Zz]?[UuLl]?[UuLl]?[UuLl]?[Zz]?"

for f in $(find $DIR -name "*.cpp"); do
    echo "*** File $f"
    sed -e '/\/\*/ { :b; /\*\//!{N; bb}; s|/\*.*\*/|| }' -e 's|//.*||' "$f" |
    grep -v '^#' |
    grep -Eo "[\=\ \(\+\-\*\/\%\~\&\|\^\<\>]0([']?[0-7]+)+[Zz]?[UuLl]?[UuLl]?[UuLl]?[Zz]?" |
    grep -Eo "$REGEXP"
done