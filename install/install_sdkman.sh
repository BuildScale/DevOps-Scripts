#!/usr/bin/env bash
#
#  Author: KhulnaSoft Ltd
#  Date: 2019-10-04 16:36:18 +0100 (Fri, 04 Oct 2019)
#        (circa 2016 originally)
#
#  https://github.com/BuildScale/DevOps-Scripts
#
#  License: see accompanying LICENSE file
#
#  https://www.linkedin.com/company/khulnasoft
#

# Installs SDKMan

# https://sdkman.io/install

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

curl -sS "https://get.sdkman.io" | bash
