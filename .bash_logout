#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: KhulnaSoft Ltd
#  Date: 2006-06-28 23:25:09 +0100 (Wed, 28 Jun 2006)
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
#                             B a s h   L o g o u t
# ============================================================================ #

# read all history lines not already read from the history file and append them to the history list
history -n

# destroy kerberos tickets in all caches (-A), quietly don't beep (-q)
kdestroy -A -q

clear

# From Ubuntu
## when leaving the console clear the screen to increase privacy
#
#if [ "$SHLVL" = 1 ]; then
#    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
#fi
