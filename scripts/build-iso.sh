#!/bin/bash

# This script is meant to be run inside Docker or locally on ARM64

PROJECT_ROOT=$(git rev-parse --show-toplevel)

WORK_DIR=${PROJECT_ROOT}/work
OUTPUT_DIR=${PROJECT_ROOT}/output
PROJECT_DIR=${PROJECT_ROOT}/archiso
GPG_KEY=$1

echo "Running Docker build script.."

if [ -z "${GPG_KEY}" ]; then
echo "GPG key not supplied, creating one..."
export GNUPGHOME="$(mktemp -d)"

cat >foo <<EOF
	%echo Generating a basic OpenPGP key
	Key-Type: DSA
	Key-Length: 1024
	Subkey-Type: ELG-E
	Subkey-Length: 1024
	Name-Real: Joe Tester
	Name-Comment: with stupid passphrase
	Name-Email: joe@foo.bar
	Expire-Date: 0
	Passphrase: abc
	# Do a commit here, so that we can later print "done" :-)
	%commit
	%echo done
EOF

gpg --batch --generate-key foo
GPG_KEY=$(gpg --list-secret-keys | sed -n 4p | awk '{$1=$1};1')
echo "Key ID ${GPG_KEY} was created!"
fi

curl -O https://lecs.dev/repo/public.asc && \
pacman-key --add public.asc && \
pacman-key --lsign 9FD0B48BBBD974B80A3310AB6462EE0B8E382F3F

mkarchiso -v          \
	-w ${WORK_DIR}    \
	-o ${OUTPUT_DIR}  \
	-g ${GPG_KEY}     \
	${PROJECT_DIR}/configs/x13s