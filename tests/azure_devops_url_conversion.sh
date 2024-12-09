#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: KhulnaSoft Ltd
#  Date: 2020-12-04 23:05:31 +0000 (Fri, 04 Dec 2020)
#
#  https://devops.azure.com/BuildScale/bash-tools
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

# shellcheck disable=SC1090
. "$srcdir/../lib/git.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Tests the git_to_azure_url function from lib/git.sh
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args=""

help_usage "$@"

src[0]='git@devops.azure.com:/BuildScale/pylib'
dest[0]='git@devops.azure.com:v3/buildscale/GitHub/pylib'

src[1]='git@devops.azure.com:/buildscale/nagios-plugin-kafka'
dest[1]='git@devops.azure.com:v3/buildscale/GitHub/nagios-plugin-kafka'

src[2]='git@devops.azure.com:BuildScale/DevOps-Scripts'
dest[2]='git@devops.azure.com:v3/buildscale/GitHub/DevOps-Scripts'

src[3]='git@devops.azure.com:BuildScale/DevOps-Golang-tools'
dest[3]='git@devops.azure.com:v3/buildscale/GitHub/DevOps-Golang-tools'

src[4]='git@devops.azure.com:BuildScale/Dockerfiles.git'
dest[4]='git@devops.azure.com:v3/buildscale/GitHub/Dockerfiles'

src[5]='git@devops.azure.com:BuildScale/HAProxy-configs'
dest[5]='git@devops.azure.com:v3/buildscale/GitHub/HAProxy-configs'

src[6]='git@devops.azure.com:BuildScale/Nagios-Plugins'
dest[6]='git@devops.azure.com:v3/buildscale/GitHub/Nagios-Plugins'

src[7]='git@devops.azure.com:BuildScale/SQL-scripts'
dest[7]='git@devops.azure.com:v3/buildscale/GitHub/SQL-scripts'

src[8]='git@devops.azure.com:BuildScale/Spotify-Playlists.git'
dest[8]='git@devops.azure.com:v3/buildscale/GitHub/Spotify-Playlists'

src[9]='git@devops.azure.com:BuildScale/Templates'
dest[9]='git@devops.azure.com:v3/buildscale/GitHub/Templates'

src[10]='git@devops.azure.com:buildscale/kubernetes-templates'
dest[10]='git@devops.azure.com:v3/buildscale/GitHub/kubernetes-templates'

src[11]='git@devops.azure.com:buildscale/spotify-tools.git'
dest[11]='git@devops.azure.com:v3/buildscale/GitHub/spotify-tools'

src[12]='git@devops.azure.com:buildscale/sql-keywords'
dest[12]='git@devops.azure.com:v3/buildscale/GitHub/sql-keywords'

src[13]='git@devops.azure.com:/BuildScale/Nagios-Plugin-Kafka'
dest[13]='git@devops.azure.com:v3/buildscale/GitHub/Nagios-Plugin-Kafka'

src[14]='git@devops.azure.com:/BuildScale/pylib'
dest[14]='git@devops.azure.com:v3/buildscale/GitHub/pylib'

src[15]='git@devops.azure.com:BuildScale/DevOps-Scripts'
dest[15]='git@devops.azure.com:v3/buildscale/GitHub/DevOps-Scripts'

src[16]='git@devops.azure.com:BuildScale/DevOps-Golang-tools'
dest[16]='git@devops.azure.com:v3/buildscale/GitHub/DevOps-Golang-tools'

src[17]='git@devops.azure.com:BuildScale/Dockerfiles.git'
dest[17]='git@devops.azure.com:v3/buildscale/GitHub/Dockerfiles'

src[18]='git@devops.azure.com:BuildScale/HAProxy-configs'
dest[18]='git@devops.azure.com:v3/buildscale/GitHub/HAProxy-configs'

src[19]='git@devops.azure.com:BuildScale/Nagios-Plugins'
dest[19]='git@devops.azure.com:v3/buildscale/GitHub/Nagios-Plugins'

src[20]='git@devops.azure.com:BuildScale/SQL-scripts'
dest[20]='git@devops.azure.com:v3/buildscale/GitHub/SQL-scripts'

src[21]='git@devops.azure.com:BuildScale/Spotify-Playlists.git'
dest[21]='git@devops.azure.com:v3/buildscale/GitHub/Spotify-Playlists'

src[22]='git@devops.azure.com:BuildScale/Spotify-tools.git'
dest[22]='git@devops.azure.com:v3/buildscale/GitHub/Spotify-tools'

src[23]='git@devops.azure.com:BuildScale/Templates'
dest[23]='git@devops.azure.com:v3/buildscale/GitHub/Templates'

src[24]='git@devops.azure.com:buildscale/kubernetes-templates'
dest[24]='git@devops.azure.com:v3/buildscale/GitHub/kubernetes-templates'

src[25]='git@devops.azure.com:buildscale/sql-keywords'
dest[25]='git@devops.azure.com:v3/buildscale/GitHub/sql-keywords'

src[26]='git@devops.azure.com:BuildScale/Spotify-Playlists.git'
dest[26]='git@devops.azure.com:v3/buildscale/GitHub/Spotify-Playlists'

src[27]='ssh://git@devops.azure.com/BuildScale/DevOps-Perl-tools'
dest[27]='ssh://git@devops.azure.com/v3/buildscale/GitHub/DevOps-Perl-tools'

src[28]='ssh://git@devops.azure.com/BuildScale/lib-java'
dest[28]='ssh://git@devops.azure.com/v3/buildscale/GitHub/lib-java'

src[29]='ssh://git@devops.azure.com/buildscale/lib'
dest[29]='ssh://git@devops.azure.com/v3/buildscale/GitHub/lib'

src[30]='ssh://git@devops.azure.com:/BuildScale/DevOps-Python-tools'
dest[30]='ssh://git@devops.azure.com:/v3/buildscale/GitHub/DevOps-Python-tools'

src[31]='ssh://git@devops.azure.com/BuildScale/lib-java'
dest[31]='ssh://git@devops.azure.com/v3/buildscale/GitHub/lib-java'

src[32]='ssh://git@devops.azure.com:/BuildScale/DevOps-Python-tools'
dest[32]='ssh://git@devops.azure.com:/v3/buildscale/GitHub/DevOps-Python-tools'

src[33]='ssh://git@ssh.devops.azure.com/BuildScale/DevOps-Perl-tools'
dest[33]='ssh://git@ssh.devops.azure.com/v3/buildscale/GitHub/DevOps-Perl-tools'

src[34]='ssh://git@ssh.devops.azure.com/BuildScale/lib'
dest[34]='ssh://git@ssh.devops.azure.com/v3/buildscale/GitHub/lib'

# expands to the list of indicies in the array, starting at zero - this is easier to work with that ${#src} which is a total
# that is off by one for index usage and doesn't support sparse arrays for any  missing/disabled test indicies
test_numbers="${!src[*]}"

for i in $test_numbers; do
    [ -n "${src[$i]:-}" ]  || { echo "code error: src[$i] not defined";  exit 1; }
    [ -n "${dest[$i]:-}" ] || { echo "code error: dest[$i] not defined"; exit 1; }
    echo "git_to_azure_url ${src[$i]}"
    converted_repo_url="$(git_to_azure_url "${src[$i]}")"
    if [ "$converted_repo_url" != "${dest[$i]}" ]; then
        echo "ERROR: unit test failed"
        echo
        echo "Expected: ${dest[$i]}"
        echo "Got:      $converted_repo_url"
        exit 2
    fi
    #echo "checking URL result '$converted_repo_url' is valid"
    #if ! git ls-remote "$converted_repo_url"; then
    #    echo "ERROR: unit test failed - URL failed git ls-remote test"
    #    exit 3
    #fi
    echo
done

echo
echo "SUCCESS: git_to_azure_url URL conversion tests passed"
