#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: KhulnaSoft Ltd
#  Date: 2024-10-08 05:24:37 +0300 (Tue, 08 Oct 2024)
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

# shellcheck disable=SC1090,SC1091
. "$srcdir/lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Runs local Prometheus Node Exporter

Installs it to \$PATH if not already available
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="[<node_exporter_args>]"

help_usage "$@"

if ! type -P node_exporter &>/dev/null; then
    "$srcdir/../install/install_prometheus_node_exporter.sh"
fi

node_exporter "$@"
