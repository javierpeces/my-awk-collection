#!/bin/bash

# simple search and replace

cat file.txt | \
awk '{
	FROM=match( $0,/from=/ );
	TO=match( $0,/to=/ );
	print FROM, TO, substr( $0, FROM+5, TO-FROM-6 );
}'

# end of file
