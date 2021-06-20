#!/bin/bash
##
# Build all the bits we need.
#

set -e

instdir=inst

clean=false
if [[ "$1" == '--clean' ]] ; then
    clean=true
fi

# Remove the installation directory ensure we build it again.
rm -rf "${instdir}"

for lib in libxslt libexslt ; do
    cd $lib
    if $clean ; then
        riscos-amu -f MakefileLib,fe1 clean
    fi
    riscos-amu -f MakefileLib,fe1 export
    cd ..
done

cd xsltproc
if $clean ; then
    riscos-amu -f MakefileTools,fe1 clean
fi
riscos-amu -f MakefileTools,fe1 install INSTDIR=${instdir}
