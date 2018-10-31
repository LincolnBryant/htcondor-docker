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

RUN yum localinstall http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-9.2.148-1.x86_64.rpm -y
#RUN yum install cuda-drivers-390.12 xorg-x11-drv-nvidia-390.12 xorg-x11-drv-nvidia-devel-390.12 xorg-x11-drv-nvidia-gl-390.12 xorg-x11-drv-nvidia-libs-390.12 nvidia-kmod-390.12  -y
RUN yum install cuda-9.1.85 -y
RUN yum install supervisor -y

# run files
#RUN curl -OL http://us.download.nvidia.com/XFree86/Linux-x86_64/396.51/NVIDIA-Linux-x86_64-396.51.run
#RUN chmod +x NVIDIA-Linux-x86_64-396.51.run; ./NVIDIA-Linux-x86_64-396.51.run -s


RUN ln -s /usr/local/cuda-9.0 /usr/local/cuda

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''

# Configuration
COPY worker.conf /etc/condor/config.d/
COPY osgvo-node-advertise /usr/local/bin/
COPY wrapper.sh /usr/libexec/condor/
COPY set-hostname.sh /usr/local/bin/
COPY supervisord.conf /etc/
COPY sshd_config /etc/ssh/

RUN adduser osg

# We may mount /var/lib/docker from the host, so we chown that
ENTRYPOINT chown -R condor: /var/lib/condor && \
           /usr/local/bin/set-hostname.sh && \
           /usr/bin/supervisord -c /etc/supervisord.conf
