#!/bin/bash
# Copyright 2012 Willy Sudiarto Raharjo <willysr@slackware-id.org>
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

# This simple script is used to find any other packages in SBo repository 
# that depends on certain package. 
# In the example below, i used ffmpeg which is used in many packages in SBo

# Put the top level directory where you place the SlackBuild Git Repositories
# Place different directories by adding space in between
# Here i have 2 different SlackBuild repository collection
SBOPATH="/home/willysr/slackbuilds/ /home/willysr/SlackHacks/SlackBuilds"

if [ -z $1 ]; then
  echo "usage $0 <package name>"
  echo "example: ./depends.sh ffmpeg"
else
  for DIR in $SBOPATH
  do
    find $DIR -mindepth 2 -maxdepth 3 -name "*.info" -exec grep -lE "REQUIRES=\".*$1.*\"" {} + | awk -F'/' '{print $(NF-2)"/"$(NF-1)}' | sort
  done
fi
