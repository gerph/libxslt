#!/bin/bash
##
# Copy the sources from a released libxslt directory to the 'upstream' directory.
#

set -e

base_dir=$1
if [[ "$base_dir" == "" ]] ; then
    echo "Syntax: $0 <libxslt directory>" >&2
    exit 1
fi

if [[ ! -d "${base_dir}/libxslt" ]] ; then
    echo "This does not look like a libxslt directory" >&2
    exit 1
fi

rm -rf upstream/libxslt upstream/libexslt upstream/xsltproc
mkdir -p upstream/libxslt upstream/libexslt upstream/xsltproc
for dir in libxslt libexslt xsltproc ; do
    cp "${base_dir}/$dir"/*.c "upstream/$dir/"
    if [[ "$dir" != 'xsltproc' ]] ; then
        cp "${base_dir}/$dir"/*.h "upstream/$dir/"
    fi
done

cp "${base_dir}"/COPYING upstream/
