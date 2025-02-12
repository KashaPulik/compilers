#!/bin/sh

DIR="."

IDENTIFIER="[A-Za-z_]+[A-Za-z_0-9]*"
INT="[0-9]+[Xxb]?([']?[0-9A-Fa-f]+)*[Zz]?[UuLl]?[UuLl]?[UuLl]?[Zz]?"

SUBSCRIPT="$IDENTIFIER\[($IDENTIFIER|$INT)\]"
INDIRECTION="\*$IDENTIFIER"
ADDRESSOF="\&$IDENTIFIER"
MEMBEROFOBJECT="$IDENTIFIER\.$IDENTIFIER"
MEMBEROFPOINTER="$IDENTIFIER->$IDENTIFIER"
POINTERTOMEMBEROFOBJECT="$IDENTIFIER\.\*$IDENTIFIER"
POINTERTOMEMBEROFPOINTER="$IDENTIFIER->\*$IDENTIFIER"

REGEXP="$SUBSCRIPT|$INDIRECTION|$ADDRESSOF|$MEMBEROFOBJECT|$MEMBEROFPOINTER|$POINTERTOMEMBEROFOBJECT|$POINTERTOMEMBEROFPOINTER"

for f in $(find $DIR -name "test.cpp"); do
    echo "*** File $f"
    sed -e '/\/\*/ { :b; /\*\//!{N; bb}; s|/\*.*\*/|| }' -e 's|//.*||' "$f" |
    grep -v '^#' |
    grep -Eo "$REGEXP"
done