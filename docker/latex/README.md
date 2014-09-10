`mirror.sh` should be run to completion (will take a long time) before `docker build ...`

The docker host (e.g. a coreos instance running on vmware-fusion via vagrant) should have >= 25 GB disk space, as the build process for this image requires a large amount of free disk space.
