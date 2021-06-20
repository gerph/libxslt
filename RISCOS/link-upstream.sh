#!/bin/bash
##
# Create links for the RISC OS format of the source.
#


# Source files
for dir in libxslt libexslt xsltproc ; do
    mkdir -p $dir/c $dir/h
    for file in ../upstream/$dir/*.c ; do
        if [[ -f "$file" ]] ; then
            ln -sf ../../"$file" "$dir"/c/$(basename "$file" .c)
        fi
    done
    for file in ../upstream/$dir/*.h ; do
        if [[ -f "$file" ]] ; then
            ln -sf ../../"$file" "$dir"/h/$(basename "$file" .h)
        fi
    done
done
