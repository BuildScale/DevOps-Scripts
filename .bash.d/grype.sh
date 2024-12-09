#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: KhulnaSoft Ltd
#  Date: 2022-01-10 17:58:03 +0000 (Mon, 10 Jan 2022)
#
#  https://github.com/BuildScale/DevOps-Scripts
#
#  License: see accompanying KhulnaSoft Ltd LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/company/khulnasoft
#

# ============================================================================ #
#                                   G r y p e
# ============================================================================ #

#set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

#eval "$(grype completion bash)"

# generates auto-completion file to avoid repeating running auto-completion command, and sources from there
#autocomplete grype
