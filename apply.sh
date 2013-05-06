#!/bin/sh
exec puppet apply --modulepath modules manifests/site.pp
