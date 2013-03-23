#!/bin/bash

cd `dirname $0`/vim/bundle

# no need to recurse
for dir in * ; do
  if [ -d ${dir} ] ; then
      cd ${dir}
      git checkout master
      git pull
      cd ..
  fi
done
