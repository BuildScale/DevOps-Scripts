#!/usr/bin/env bash
#
#  Author: KhulnaSoft Ltd
#  Date: 2019-10-08 16:48:17 +0100 (Tue, 08 Oct 2019)
#
#  https://github.com/BuildScale/DevOps-Scripts
#
#  License: see accompanying LICENSE file
#
#  https://www.linkedin.com/company/khulnasoft
#

# Installs SDKman's most commonly used build tools e.g Java, Scala, Groovy + Maven, SBT, Gradle
#
# you may need to run ./install_sdkman.sh first

set -eo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sdks="
java
scala
groovy
maven
gradle
sbt
"

if ! type sdk &>/dev/null; then
    "$srcdir/install_sdkman.sh"
fi

if [ -s ~/.sdkman/bin/sdkman-init.sh ]; then
    # shellcheck disable=SC1090,SC1091
    . ~/.sdkman/bin/sdkman-init.sh
fi

for x in $sdks; do
    set +o pipefail
    yes | sdk install "$x"
done
