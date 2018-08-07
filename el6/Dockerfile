FROM opensciencegrid/osg-wn:3.4-devel-el7

MAINTAINER Lincoln Bryant <lincolnb@uchicago.edu>

# Build in one RUN
#RUN #rpm --import http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor && \ 
    #curl https://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-development-rhel6.repo > /etc/yum.repos.d/htcondor-development-rhel6.repo && \
    # libXt needed for some application
    # tcsh needed for fsurf
    # ATLAS needs unzip, gcc at least.
RUN yum -y install condor \ 
                   openssh-clients \ 
                   openssh-server \
                   libXt \
                   tcsh \
                   gcc \
                   libXpm \
                   libXpm-devel \
                   unzip && \
    yum clean all

RUN yum localinstall http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-9.2.148-1.x86_64.rpm -y && \
    yum install cuda-libraries-9-0 cuda-cudart-dev-9-0 cuda-libraries-dev-9-0 cuda-toolkit-9-0 -y && \
    yum clean all 

RUN ln -s /usr/local/cuda-9.0 /usr/local/cuda

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
