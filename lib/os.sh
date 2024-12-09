#!/bin/sh
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: KhulnaSoft Ltd
#  Date: 2015-05-25 01:38:24 +0100 (Mon, 25 May 2015)
#
#  https://github.com/BuildScale/DevOps-Scripts
#
#  License: see accompanying KhulnaSoft Ltd LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/company/khulnasoft
#

set -eu
[ -n "${DEBUG:-}" ] && set -x

is_linux(){
    if [ "$(uname -s)" = "Linux" ]; then
        return 0
    fi
    return 1
}

is_mac(){
    if [ "$(uname -s)" = "Darwin" ]; then
        return 0
    fi
    return 1
}
