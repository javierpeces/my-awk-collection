#!/bin/bash

# environ-usage
#
# sample environment vars usage
#

thename="FRED"
export thename
awk 'BEGIN { nnn=ENVIRON["thename"]; } $1==nnn { print; } END { print "done"; }'
