#!/usr/bin/env bash

if [ $# -lt 1 ]; then
  echo "TAG_NAME is not defined"
  exit 1
fi

TAG_NAME=$1

git tag -d "${TAG_NAME}"
git push --delete origin "${TAG_NAME}"
git tag -a "${TAG_NAME}" -m "${TAG_NAME}"
git push origin "${TAG_NAME}"
