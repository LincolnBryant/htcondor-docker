FROM opensciencegrid/osg-3.3-wn-el6:latest

MAINTAINER Lincoln Bryant <lincolnb@uchicago.edu>

# Build in one RUN
RUN rpm --import http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor && \ 
    curl https://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-development-rhel6.repo > /etc/yum.repos.d/htcondor-development-rhel6.repo && \
    # libXt needed for some application Bala is using. 
    # tcsh needed for fsurf
    yum -y install condor \
                   openssh-clients \ 
                   openssh-server \
                   libXt \
                   tcsh && \
    yum -y remove singularity && \
    yum -y install https://yum.dockerproject.org/repo/main/centos/6/Packages/docker-engine-1.7.1-1.el6.x86_64.rpm && \ 
    yum clean all 

# Configuration
COPY worker.conf /etc/condor/config.d/
COPY start-condor.sh /usr/sbin/
COPY osgvo-node-advertise /usr/local/bin/
COPY wrapper.sh /usr/libexec/condor/
COPY set-hostname.sh /usr/local/bin/

# Grab the docker socket's GID and add that to groups, then add condor as a member of that group before starting condor.
# We may mount /var/lib/docker from the host, so we chown that too.
ENTRYPOINT groupmod docker -g $(stat -c "%g" /var/run/docker.sock) && \
           usermod -G docker condor && \ 
           chown -R condor: /var/lib/condor && \
           /usr/local/bin/set-hostname.sh && \
           /usr/sbin/start-condor.sh
