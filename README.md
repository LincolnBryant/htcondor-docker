[![Docker Automated buil](https://img.shields.io/docker/automated/lincolnbryant/coreos-osg-wn.svg)]()

HTCONDOR-DOCKER:
This is our customized worker node image at MWT2 that connects to a fixed htcondor
central manager. The intent here is to run HTCondor as a container while
using it to launch more containers.

The reason we do it this way is to allow "vanilla" universe jobs to run on a generic SL6 image, but allow more advanced "docker universe" workloads to run as well.

USAGE:

edit the condor config to your liking, and then
```
docker build . 
docker run --net=host -v /var/run/docker.sock:/var/run/docker.sock \ 
-v /var/lib/condor:/var/lib/condor -v /cvmfs:/cvmfs:slave <image id> 
```
