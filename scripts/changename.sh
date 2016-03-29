#!/bin/bash
# Copyright 2013 Willy Sudiarto Raharjo <willysr@slackware-id.org>
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
# EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Put the directory where you place the SlackBuild Git Repository
SBOPATH="/home/willysr/slackbuilds/"

# Put the name of the maintainer you want to search for
OLDNAME=${OLDNAME:-Willy}
NEWNAME=${NEWNAME:-Willy Sudiarto Raharjo}

L=`find $SBOPATH -mindepth 2 -maxdepth 3 -name "*.info" -exec grep -l "$OLDNAME" {} +`
for list in $L
do
  sed -i "s/MAINTAINER=\"$OLDNAME\"/MAINTAINER=\"$NEWNAME\"/" $list

done
