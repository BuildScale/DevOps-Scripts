#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: KhulnaSoft Ltd
#  Date: 2020-06-14 15:47:33 +0100 (Sun, 14 Jun 2020)
#
#  https://github.com/BuildScale/DevOps-Scripts
#
#  License: see accompanying KhulnaSoft Ltd LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/company/khulnasoft
#

# XXX: looks like this tool has disappeared from the website

# Installs MouseTools on Mac OS X
#
# http://www.hamsoftengineering.com/codeSharing/MouseTools/MouseTools.html

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
#srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$(uname -s)" != Darwin ]; then
    echo "Operating System is not Mac, cannot install MouseTools which is for Mac, aborting..."
    exit 0
fi

if type -P MouseTools &>/dev/null; then
    echo "MouseTools already installed"
    exit 0
fi

cd /tmp

wget -O MouseTools.zip http://www.hamsoftengineering.com/assets/MouseTools.zip

unzip -o -- MouseTools.zip

mv -iv -- MouseTools ~/bin

rm -- MouseTools.zip

echo
echo "MouseTools is now available at ~/bin - ensure that location is in $PATH"
