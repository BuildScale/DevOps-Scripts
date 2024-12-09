#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: KhulnaSoft Ltd
#  Date: 2024-11-07 06:52:16 +0400 (Thu, 07 Nov 2024)
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
Uploads a file to https://0x0.st and copies the resulting URL to your clipboard

If the content is ASCII then prompts to confirm the content before uploading for your safe review as this is PUBLIC

Does not do this for non-ASCII files since we can't print media content to the terminal

Expiry defaults to 24 hours

Recommended: for text use anonymize.py or anonymize.pl from the adjacent DevOps-Python-tools or DevOps-Perl-tools repos

Optional: for code - decomment.sh

Knowledge Base page: https://github.com/BuildScale/Knowledge-Base/blob/main/upload-sites.md
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="<filename> [<expiry_hours>]"

help_usage "$@"

min_args 1 "$@"

url="https://0x0.st"

file="$1"
expiry="${2:-${OXO_EXPIRY:-24}}"

if ! [[ "$expiry" =~ ^[[:digit:]]+$ ]]; then
    usage "Invalid value for expiry arg, must be an integer of hours"
fi

# Do not allow reading from stdin because it does not allow the prompt safety
#if [ "$file" = '-' ]; then
#    timestamp "reading from stdin"
    #file="/dev/stdin"
#else
#    timestamp "reading from file: $file"
#fi

if file "$file" | grep -q ASCII; then
    content="$(cat "$file")"
    echo

    cat <<EOF
Here is what will be pasted to https://0x0.st:

$content

EOF

    read -r -p "Continue? [y/N] " answer
    echo

    check_yes "$answer"
    echo
fi

{
command curl -sSlf "$url" \
             -F "file=@$file" \
             -F "expires=$expiry" ||
    {
        timestamp "FAILED: repeating without the curl -f switch to get the error from the API:"
        command curl -sSl "$url" \
                     -F "file=@$file" \
                     -F "expires=$expiry"
        echo
        exit 1
    }
} |
tee /dev/stderr |
"$srcdir/../bin/copy_to_clipboard.sh"
echo