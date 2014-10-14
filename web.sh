#!/bin/bash

##
## A script for deploying the siigna website by 
## listening for connections and pulling from GitHub
##
## Author: jensep@gmail.com

function pullWeb {
	wget "https://raw.githubusercontent.com/siigna/web/master/index.html" -O html #/srv/web/siigna
	wget "https://raw.githubusercontent.com/siigna/web/master/target/scala-2.11/web-fastopt.js" -O js #/srv/web/target/scala-2.11/web-fastopt.js
}

nc -lk -p 8080 | while read line
do
	match=$(echo $line | grep -c 'keep-alive')
	if [ $match -eq 1 ] ; then
		pullWeb
	fi
done
