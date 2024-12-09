#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: KhulnaSoft Ltd
#  Date: 2019-11-21 15:54:25 +0000 (Thu, 21 Nov 2019)
#
#  https://github.com/BuildScale/DevOps-Scripts
#
#  License: see accompanying KhulnaSoft Ltd LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/company/khulnasoft
#

# Quick script to make it a little easier to query the Google Cloud GCE Metadata API
#
# Must be run from inside GCE otherwise will fail with an error like this:
#
# curl: (6) Could not resolve host: metadata.google.internal

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

usage(){
    echo "
Simple query wrapper to GCE's Metadata API

Lists resources if no argument given

${0##*/} <resource>

eg. ${0##*/} instance/scheduling/preemptible
"
    exit 3
}

if [ $# -gt 1 ] ||
   [[ "${1:-}" =~ -.* ]]; then
    usage
fi

curl -sS -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/${1:-}"

# above doesn't output a trailing newline, when using in shell we usually want this
echo
