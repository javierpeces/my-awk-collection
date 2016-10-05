#!/bin/bash

# 
# awk count-rows
#
# want to know how many inserts are into a mysql text dump file
# if expected this...
#
#    INSERT INTO table VALUES (cell1, cell2, cell3)
#    INSERT INTO table VALUES (cell1, cell2, cell3)
#    INSERT INTO table VALUES (cell1, cell2, cell3)
#
# then forget.

#
# our starting dataset is dump.sql
#

test -f dump.sql || exit 1

#
# Let's filter INSERT statements only
#

awk '/INSERT INTO/ {print}' dump.sql > all_insert_statements.sql

#
# Now let's count how many statements we have inside the file
#

awk 'BEGIN {i=0} /INSERT INTO/ {i++} END {print i}' all_insert_statements.sql

# 2
# Just two?
# MySQL dumps are built in terms of maximum performance and space savings.
# You propably got very long lines like this inside the file:
#    
#    INSERT INTO tabla VALUES (col1,col2,col3) , (col1,col2,col3) , (col1,col2,col3) , (col1,col2,col3) , (col1,col2,col3) , (col1,col2,col3) , etc.
#
# Being 'etc.' an extremely long bunch of values. 
#
# Fortunately, we may count rows using the closing parenthesis as the line separator,
# and the opening one as the string we search for.
#

awk 'BEGIN {RS=")"} /\(/ {print}' all_insert_statements.sql

#
# and even count the number of insertions:
# 

awk 'BEGIN {i=0; RS=")"} /\(/ {i++; print} END {print i}' all_insert_statements.sql

# that's all folks
