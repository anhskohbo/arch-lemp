#!/bin/sh

set -e

# Don't bother to do anything for lo.
if [ "$IFACE" = lo ]; then
    exit 0
fi

# Remove current site.
sed -i '/'$1'$/ d' /etc/hosts

# Add new site.
echo "${2:-127.0.0.1} $1 www.$1" >> /etc/hosts
