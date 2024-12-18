#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: KhulnaSoft Ltd
#  Date: 2019-12-19 10:02:31 +0000 (Thu, 19 Dec 2019)
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
. "$srcdir/lib/aws.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Lists AWS IAM users password enabled and MFA enabled status

Output format is CSV with the following headers

user,password_enabled,mfa_active


Add this to your command pipeline

    | grep -B1 '<root_account>'

to check your root account isn't being used


Uses the adjacent script aws_iam_generate_credentials_report_wait.sh


See similar tools in the DevOps Python Tools repo and The Advanced Nagios Plugins Collection:

    - https://github.com/BuildScale/DevOps-Python-tools
    - https://github.com/BuildScale/Nagios-Plugins


$usage_aws_cli_required
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args=""

help_usage "$@"


"$srcdir/aws_iam_generate_credentials_report_wait.sh" >&2

# use --decode not -d / -D which varies between Linux and Mac
#if [ "$(uname -s)" = Darwin ]; then
#    base64_decode="base64 -D"
#else
#    base64_decode="base64 -d"
#fi

# not documented in 'aws iam get-credential-report help'
aws iam get-credential-report --query 'Content' --output text |
base64 --decode |
cut -d, -f1,4,8
