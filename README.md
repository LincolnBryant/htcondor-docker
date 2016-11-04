#htcondor-docker

this is our kustomized worker node image that connects to a fixed htcondor
central manager. the intent here is to run HTCondor as a container while
using it to launch more containers.

##usage
edit the condor config to your liking, and then
```
docker build . 
docker run --net=host -v /var/run/docker.sock:/var/run/docker.sock <image id>
```

##thanks

thanks to Andy Pohl @ UW-Madison for building the first version of this
dockerfile that I have thoroughly butchered.
