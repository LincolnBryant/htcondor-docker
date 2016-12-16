#!/bin/sh
source /cvmfs/oasis.opensciencegrid.org/osg/modules/lmod/current/init/bash
export OSG_SITE_NAME="UC3"
export OSG_SQUID_LOCATION="uct2-squid.mwt2.org:3128"
exec "$@"
