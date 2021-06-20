#!/bin/bash
##
# Build the releases from the sources.
#

set -e

RELEASE_DIR=Release

./build-binaries.sh

rm -rf "${RELEASE_DIR}"

mkdir -p "${RELEASE_DIR}"
mkdir -p "${RELEASE_DIR}/Lib"
mkdir -p "${RELEASE_DIR}/Tools/XML/Help"

cp xsltproc/inst/XSLTProc,ff8 "${RELEASE_DIR}/Tools/XML/XSLTProc,ff8"
cp ../upstream/COPYING "${RELEASE_DIR}/COPYING"
cp -R "${LIB_DIR}/libxslt" "${RELEASE_DIR}/Lib/libxslt"
cp -R "${LIB_DIR}/libexslt" "${RELEASE_DIR}/Lib/libexslt"

# Obtain the help messages
# The help messages can only be reported by running the tool, so we send it off to the build service
# to run the tool and return the help messages so that we can put them in the right place.
tmpdir="${TMPDIR:-/tmp}/ro-libxslt.$$"
mkdir -p "$tmpdir"
cp help-robuild.yaml "$tmpdir/.robuild.yaml"
cp xsltproc/inst/* help-extract,feb "$tmpdir/"
(
    echo "Processing files in '$tmpdir'"
    cd "$tmpdir"
    zip -9r source-archive.zip XSLTProc* help-extract,feb .robuild.yaml

    if [[ "$(uname -s)" == 'Darwin' ]] ; then
        # Assume that it's already installed on the system
        rbo=riscos-build-online
    else
        curl -s -L -o "riscos-build-online" https://github.com/gerph/robuild-client/releases/download/v0.05/riscos-build-online && chmod +x riscos-build-online
        rbo=./riscos-build-online
    fi
    "$rbo" -i "$tmpdir/source-archive.zip" -o "$tmpdir/output" -t 20

    unzip "$tmpdir/output,a91"
)

# Now process those messages into our help.
./help-conversion.pl "$tmpdir/xsltproc-help" "${RELEASE_DIR}/Tools/XML/Help/XSLTProc" "$tmpdir/xsltproc-version"

rm -rf "$tmpdir"
