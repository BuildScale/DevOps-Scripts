#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: KhulnaSoft Ltd
#  Date: 2020-07-24 16:18:10 +0100 (Fri, 24 Jul 2020)
#
#  https://github.com/BuildScale/DevOps-Scripts
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

# shellcheck disable=SC1090,SC1091
. "$srcdir/lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Fetches and parses Atlassian's IP ranges API, outputting the CIDR ranges, one per line"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="[--ipv4 / --ipv6]"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_switches="
   --ipv4           Output only IPv4 CIDR ranges
   --ipv6           Output only IPv6 CIDR ranges
"

help_usage "$@"

for arg; do
    case "$arg" in
        --ipv4)     IPV4_ONLY=1
                    ;;
        --ipv6)     IPV6_ONLY=1
                    ;;
    esac
done

if [ -n "${IPV4_ONLY:-}" ] &&
   [ -n "${IPV6_ONLY:-}" ]; then
    usage "IPv4 and IPv6 filters are mutually exclusive"
fi

url="https://ip-ranges.atlassian.com/"

curl -sSf "$url" |
#jq -r '.items[] | [.network, .mask_len | tostring ] | join("/")'
jq -r '.items[] | .cidr' |
if [ -n "${IPV4_ONLY:-}" ]; then
    grep -v -e '[:alpha:]' -e ':'
elif [ -n "${IPV6_ONLY:-}" ]; then
    grep -e '[:alpha:]' -e ':'
else
    cat
fi
