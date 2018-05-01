FROM opensciencegrid/osg-3.4-wn-el6:latest

MAINTAINER Lincoln Bryant <lincolnb@uchicago.edu>

# Build in one RUN
RUN rpm --import http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor && \ 
    curl https://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-development-rhel6.repo > /etc/yum.repos.d/htcondor-development-rhel6.repo && \
    # libXt needed for some application Bala is using. 
    # tcsh needed for fsurf
    # ATLAS needs unzip, gcc at least.
    yum -y install condor \
                   openssh-clients \ 
                   openssh-server \
                   libXt \
                   tcsh \
                   gcc \
                   unzip && \
    yum -y install libXpm libXpm-devel && \
    yum clean all 

# Configuration
COPY worker.conf /etc/condor/config.d/
COPY start-condor.sh /usr/sbin/
COPY osgvo-node-advertise /usr/local/bin/
COPY wrapper.sh /usr/libexec/condor/
COPY set-hostname.sh /usr/local/bin/

# We may mount /var/lib/docker from the host, so we chown that
ENTRYPOINT chown -R condor: /var/lib/condor && \
           /usr/local/bin/set-hostname.sh && \
           /usr/sbin/start-condor.sh
