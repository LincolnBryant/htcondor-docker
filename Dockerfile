FROM centos:centos7

MAINTAINER Lincoln Bryant <lincolnb@uchicago.edu>

# Build in one RUN
RUN yum -y install \
         yum-utils \
         openssh-clients && \
         docker
    curl -O http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor && \
    rpm --import RPM-GPG-KEY-HTCondor && \
    yum-config-manager --add-repo https://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-development-rhel7.repo && \
    yum -y install condor && \
    yum clean all && \
    rm -f RPM-GPG-KEY-HTCondor && \

# KNOBS and startup script
COPY condor_config.docker_image /etc/condor/config.d/
COPY start-condor.sh /usr/sbin/

CMD ["/usr/sbin/start-condor.sh"]
