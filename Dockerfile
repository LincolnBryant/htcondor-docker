FROM centos:centos7

MAINTAINER Lincoln Bryant <lincolnb@uchicago.edu>

# Build in one RUN
RUN yum -y install \
         openssh-clients \
         docker && \
    rpm --import http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor && \ 
    curl https://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-development-rhel7.repo > /etc/yum.repos.d/htcondor-develo-ment-rhel7.repo && \
    yum -y install condor && \
    yum clean all 

# KNOBS and startup script
COPY condor_config.docker_image /etc/condor/config.d/
COPY start-condor.sh /usr/sbin/

# Grab the docker socket's GID and add that to groups, then add condor as a member of that group before starting condor.
ENTRYPOINT groupadd docker -g $(stat -c "%g" /var/run/docker.sock) && \
           usermod -g docker condor && \ 
           /usr/sbin/start-condor.sh
