#!/bin/bash

##
## A script for deploying the siigna website by 
## listening for connections and pulling from GitHub
##
## Thanks to http://stackoverflow.com/questions/17990099/run-a-command-conditionally-with-netcat-and-grep
##
## Author: jensep@gmail.com

function pullWeb {
	wget "https://raw.githubusercontent.com/siigna/web/master/index.html" -O /srv/siigna/web/index.html
	wget "https://raw.githubusercontent.com/siigna/web/master/target/scala-2.11/web-fastopt.js" -O js /srv/siigna/web/target/scala-2.11/web-fastopt.js
}

nc -lk -p 8080 | while read line
do
	match=$(echo $line | grep -c 'keep-alive')
	if [ $match -eq 1 ] ; then
		pullWeb
	fi
done
