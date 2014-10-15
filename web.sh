#!/bin/bash

##
## A script for deploying the siigna website by 
## listening for connections and pulling from GitHub
##
## Thanks to http://stackoverflow.com/questions/17990099/run-a-command-conditionally-with-netcat-and-grep
##
## Author: jensep@gmail.com

function pullWeb {
	DIR=`pwd`
	cd /srv/siigna/web
	git pull
	git checkout -f
	cd $DIR
}

while true
do
	echo -e 'HTTP/1.1 200 OK\r\nEOF' | \
	nc -q 1 -l -p 8080 | \
	grep -i 'Host: siigna.com' | \
	while read unused
	do
		echo "Pulling web"
		pullWeb
		echo "Success"
	done
done
