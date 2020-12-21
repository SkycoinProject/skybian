#!/bin/env bash

# Since transport logs may have any names and the names may change when
# different visors/transports connect, we package an archive of all the
# logs manually, instead of running logrotate on *.log in the directory.
# The file generated by this script will then be rotated by logrotate.
# It has to be added to cron

TRANSPORT_LOGS_DIR="/var/log/skywire-visor/transports"
TRANSPORT_LOGS_TAR="/var/log/skywire-visor/transports.tar.gz"

rotate_dir() {
    local tar_rotated=false
    if [ ! -s $TRANSPORT_LOGS_TAR ]; then
        tar_rotated=true
    fi
    tar czf $TRANSPORT_LOGS_DIR -O $TRANSPORT_LOGS_TAR
    if [ "$tar_rotated" = true ] ; then
        rm "${TRANSPORT_LOGS_DIR}/*"
    fi
}

rotate_dir
