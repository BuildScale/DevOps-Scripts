#!/bin/sh
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: KhulnaSoft Ltd
#  Date: 2019-02-15 12:51:17 +0000 (Fri, 15 Feb 2019)
#
#  https://github.com/BuildScale/DevOps-Scripts
#
#  License: see accompanying KhulnaSoft Ltd LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/company/khulnasoft
#

# cannot -set -o pipefail because some docker images version of 'sh' do not support it, namely debian and ubuntu
set -eu
[ -n "${DEBUG:-}" ] && set -x

# cannot allow set -e because it will cause an exit before the exec to interactive
(
exec "${SHELL:-sh}" -i 3<<EOF 4<&0 <&3
  set +e
    $@
  exec 3>&- <&4
EOF
)
