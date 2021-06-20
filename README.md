# LibXSLT


## Updating to the latest upstream version

- Clone the libxslt repository at https://gitlab.gnome.org/GNOME/libxslt
    - `git clone https://gitlab.gnome.org/GNOME/libxslt.git`
- Check out the tag for the version to be used.
    - `git checkout v1.1.34`
- Build it, to ensure that it works and generate necessary headers with the right defines and version numbers.
    - `./autogen.sh`
    - `make`
- In this repository, checkout the branch `vendor`.
    - `git checkout vendor`
- Create a new branch in the form `vendor-<X>.<Y>.<Z>`.
    - `git checkout -b vendor-1.1.34`
- Run the `copy-libxslt.sh <directory>` to update the sources to the this version.
    - `./copy-libxslt.sh ~/external/libxslt`
- Add any extra files that have been created and commit the changes.
    - `git add libxslt/*.c libxslt/*.h libexslt/*.c libexslt/*.h xsltproc/*.c xsltproc/*.h`
    - `git commit -m "Import of version 1.1.34"`
- Merge the branch into the vendor branch.
    - `git checkout vendor`
    - `git merge vendor-1.1.34`
- Check out the master branch to return to the current version of the OS.
    - `git checkout master`
- Create a new branch for merging in the vendor branch in the form `merging-<X>.<Y>.<Z>`.
    - `git checkout -b merging-1.1.34`
- Merge in the vendor branch.
    - `git merge vendor-1.1.34`
- Link any new files into the RISC OS file structures.
    - `./link-upstream.sh`
- Update the `MakefileLib,fe1` to add any extra files that need building or exporting
- Build everything, from clean.
    - `cd RISCOS`
    - `./build-binaries.sh --clean`
- Fix any breakages caused by conflicts in the merge, and repeat.
- Add new files which are linked by the build process
    - `git add libxslt/c/* libxslt/h/* libexslt/c/* libexslt/h/* xsltproc/c/* xsltproc/h/*`
- Commit the merged version of the vendor branch.
    - `git commit`
- Update the `VersionNum` file with a new version number.
- Test the new version and add any changed files.
- Commit changes to the merging branch.
    - `git commit`
- Merge into the master branch, and tag in the form `libxslt-<X>.<Y>.<Z>`.
    - `git checkout master`
    - `git merge merging-1.1.34`
    - `git tag libxslt-1.1.34`
- Push the changes to the repository.
