#!/bin/bash

# my.sql -- sample database client connection

# NO, this is not a panacea in terms of security.
# But it helps when you have to publish scripts and 
# want to ensure that no password is left inside.

# Create a hidden file named ~/.pass.txt and protect it as much as you can.
# Should contain one line per host, service, user and password. Much like:
#
#    $ cat ~/.pass.txt
#    dbserver1 mysql root daPassVoid&
#    webserver unix  root Th3B1gB055C4111ng
#    dbserver2 mysql adm1 An0th3rp455w0rd_

HOSTNAME="dbserver2"
SERVICE="mysqld"
USERNAME="root"
PASSFILE="~/.pass.txt"

# Obtain password for user 'root' and service 'mysql' at host 'the.databas...'
# Option "-v" creates an awk variable named HOST with content from HOSTNAME
# shell variable content.

PASSWORD=`awk -v HOST="${HOSTNAME}" -v SUBJ="${SUBJECT}" -v USER="${USERNAME}" \
     '$1 == HOST && $2 == SUBJ && $3 == USER {print $4}' ${PASSFILE}`
     
# No data meets this criteria? Exit gracefully...

test -z "${PASSWORD}" && exit 1

# Now we may login to the MySQL server without typing its password if granted to.

mysql -h ${HOSTNAME} -u ${USERNAME} -p${PASSWORD} $*

# If all your scripts make it like this, you got a central password repo. 
# Next time will cypher/decyper.

# end of it all.
