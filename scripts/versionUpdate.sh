#!/bin/bash

usage() {
    echo "usage: scripttoincrmentversion.sh -v <VERSION> -b <BUMP>"
    echo "-v Version number to bump"
    echo "-b is for Bump, example: major, minor or patch only"
}

while [ "$1" != "" ]; do
    case $1 in
    -v | --VERSION)
        shift
        CURRENTVERSION=$1
        ;;
    -b | --Bump)
        shift
        BUMP=$1
        ;;
    *)
        usage
        exit 1
        ;;
    esac
    shift
done

# As the function increment_version takes only integers we change the bump type to 0, 1, 2
case $BUMP in
major)
    BUMPVALUE="0"
    ;;
minor)
    shift
    BUMPVALUE="1"
    ;;
patch)
    BUMPVALUE="2"
    ;;
*)
    BUMPVALUE=""
    echo ERROR: incorrect Bump value, can only be major, minor or patch
    exit 1
    ;;
esac

# echo Bump\'s new value is $BUMPVALUE

# https://stackoverflow.com/a/64390598/3964697
### Increments the part of the string
## $1: version itself
## $2: number of part: 0 – major, 1 – minor, 2 – patch

increment_version() {
    local delimiter=.
    local array=($(echo "$1" | tr $delimiter '\n'))
    array[$2]=$((array[$2] + 1))
    if [ $2 -lt 2 ]; then array[2]=0; fi
    if [ $2 -lt 1 ]; then array[1]=0; fi
    echo $(
        local IFS=$delimiter
        echo "${array[*]}"
    )
}

NEWVERSION=$(increment_version $CURRENTVERSION $BUMPVALUE)
#NEWVERSION=$(increment_version 0.0.99 0)

# echo Bumping up the $BUMP version
echo $NEWVERSION
