#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: KhulnaSoft Ltd
#  Date: 2019-03-14 19:08:01 +0000 (Thu, 14 Mar 2019)
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

usage(){
    if [ -n "$*" ]; then
        echo "$@" >&2
        echo >&2
    fi
    # multiple ${0##*/} inside here document causes usage to not be rendered, must be a bash bug
    script="${0##*/}"
    cat >&2 <<EOF

Recurses AD LDAP for all groups for which a given user DN belongs

Dumps LDAP group objects, follows group nesting

Uses Microsoft Active Directory LDAP extension, so is not portable to other LDAP servers

See the python version in the DevOps Python Tools repo for a more generalized version with nicer control and output

https://github.com/BuildScale/DevOps-Python-tools


usage: $script <user_dn> [<attribute_filter>]

$script CN=hari,OU=Users,DC=myDomain,DC=com

Example: if you don't know the DN and just want to search on any attribute such as CN, UID or sAMAccountName, then this is useful

$script \$(./ldapsearch.sh cn=hari dn | awk '/^dn: /{print \$2; exit}')

EOF
    exit 3
}

for x in "$@"; do
    case "$x" in
    -h|--help)  usage
                ;;
    esac
done

if [ $# -lt 1 ]; then
    usage "no user DN given"
fi

user_dn="$1"
shift

"$srcdir/ldapsearch.sh" "(&(objectClass=group)(member:1.2.840.113556.1.4.1941:=$user_dn))" "$@"
