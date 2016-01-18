#!/bin/bash
set -e

JINGO_APPLICATION_TITLE="${JINGO_APPLICATION_TITLE:-Jingo Wiki}"
JINGO_REPOSITORY="${JINGO_REPOSITORY:-/opt/wiki-content}"
JINGO_HOSTNAME="${JINGO_HOSTNAME:-localhost}"
JINGO_PORT="${JINGO_PORT:-8080}"

mkdir -p "$JINGO_REPOSITORY"

if [ ! -d "$JINGO_REPOSITORY/.git" ]; then
  pushd "$JINGO_REPOSITORY"
  git init
  touch Home.md
  git add -A Home.md
  git commit -m "Initial commit"
  popd
fi

sed -ri -e"s:JINGO_APPLICATION_TITLE:$JINGO_APPLICATION_TITLE:" /opt/jingo/config.yaml
sed -ri -e"s:JINGO_REPOSITORY:$JINGO_REPOSITORY:" /opt/jingo/config.yaml
sed -ri -e"s:JINGO_HOSTNAME:$JINGO_HOSTNAME:" /opt/jingo/config.yaml
sed -ri -e"s:JINGO_PORT:$JINGO_PORT:" /opt/jingo/config.yaml

cd /opt/jingo
npm start
