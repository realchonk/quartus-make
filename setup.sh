#!/bin/sh

# Read project name.
printf "Project name: " >&2
read -r proj_name

# Check project name.
if ! printf "%s" "${proj_name}" | grep -q "^[a-zA-Z0-9_-]\+$"; then
    printf "setup.sh: Invalid project name: %s\n" "${proj_name}"
    exit 1
fi

# Read quartus path.
printf "Quartus bin: " >&2
read -r bin_path

# Check quartus installation.
if ! [ -x "${bin_path}/jtagconfig" ]; then
    printf "setup.sh: Invalid path to quartus: %s\n" "${bin_path}"
    exit 1
fi

# Fix names.
sed -i "s/^NAME =.*/NAME = ${proj_name}/" Makefile
sed -i "s/File(\"test.sof\")/File(\"${proj_name}.sof\")/" test.cdf

# Rename files.
mv -v 'test_assignment_defaults.qdf' "${proj_name}_assignment_defaults.qdf"
mv -v 'test.cdf' "${proj_name}.cdf"
mv -v 'test.qpf' "${proj_name}.qpf"
mv -v 'test.qsf' "${proj_name}.qsf"

echo "Project setup complete! You can now delete setup.sh!"
