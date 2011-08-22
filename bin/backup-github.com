#!/bin/bash

usage() {
    echo >&2 "Usage: $0 <USER>/<REPO>"
    exit 1
}

set -e

test $# -eq 1 || usage
REPO="$1"
TSTAMP=`date "+%Y%m%d-%H%M%S"`
BACKUP_DIR=`echo ~/Jilles-Lifetime-Archive/Development/github/`$REPO
BACKUP_BASE_NAME=${REPO/\//-}

# Make Backup Directory if it doesn't exist
mkdir -p $BACKUP_DIR
cd $BACKUP_DIR/../

# Clone a mirror
git clone --mirror git@github.com:$REPO.git $BACKUP_BASE_NAME.git

# Tarball it up
tar zcf $BACKUP_BASE_NAME.tar.gz $BACKUP_BASE_NAME.git

# Clean Up
rm -rf $BACKUP_BASE_NAME.git
mv $BACKUP_BASE_NAME.tar.gz $BACKUP_DIR

