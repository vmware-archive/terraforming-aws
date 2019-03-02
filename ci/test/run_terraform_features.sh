#!/bin/bash

function ensure_clarity_cli() {
  which clarity
  if [[ $? -gt 0 ]]; 
  then
    echo "Did not find clarity on your system. Downloading now"
    echo ""
    VERSION="v0.3.0"
    if [[ "$OSTYPE" == "darwin"* ]]; 
    then
      OS="osx"
    else
      OS="unix"
    fi
    curl -L https://github.com/xchapter7x/clarity/releases/download/${VERSION}/clarity_${OS} \
      -o /usr/local/bin/clarity \
      && \
      chmod +x /usr/local/bin/clarity
  fi
}

function run_suite() {
  ensure_clarity_cli
  declare -i EXITCODE=0;

  for i in `find . -name "*.feature"`;
  do 
    pushd $(dirname $i); 
    clarity .; 
    EXITCODE+=$?; 
    popd; 
  done;
  return $EXITCODE
}

run_suite
