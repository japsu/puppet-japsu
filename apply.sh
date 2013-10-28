#!/bin/sh
git submodule update --init
exec sudo puppet apply --modulepath modules manifests/site.pp
