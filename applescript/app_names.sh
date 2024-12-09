#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: KhulnaSoft Ltd
#  Date: 2024-11-18 17:03:28 +0400 (Mon, 18 Nov 2024)
#
#  https///github.com/BuildScale/DevOps-Scripts
#
#  License: see accompanying KhulnaSoft Ltd LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/company/khulnasoft
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ $# -gt 0 ]; then
    cat <<EOF
Prints sorted list of Applications running in the name format that can be passed to
the adjacent script set_frontmost_process.scpt
EOF
    exit 3
fi

"$srcdir/get_application_names.scpt" |
sort -fu # money
