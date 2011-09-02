#!/bin/bash

#       ovidownload.sh 
#       Version 1.0
#       2011 razorblade(Petruhin Alexandr) <razblade@gmail.com>
#       
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#       
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#       
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.

# Get file name as param
FILE=$*

# Bytes for strip
BYTES=85

#Get full filename
FILENAME=`echo $FILE | awk 'BEGIN { RS = "/" }; END {print $1}'`

#Get filename
FNAME=`echo $FILENAME | awk 'BEGIN {FS = "."}; END {print $1}'`

#Get extension
EXTENSION=`echo $FILENAME | awk 'BEGIN { RS = "." }; END {print $1}'`

#echo \'$FILENAME $EXTENSION\'
if [ -e $FILE ]; then
	# Get temp file
	case $EXTENSION in
		dm)
			#OK, its sis.dm or sisx.dm. Cutoff first 84 bytes, and save at home directory
			
			#crate temp file
			TEMP=`mktemp --dry-run`
			
			#get middle extension sis or sisx
			SISXORSIS=`echo $FILENAME | awk 'BEGIN {FS = ".dm"}; END{print $1}' | awk 'BEGIN {RS = "."}; END{print $1}'`
			
			#cutoff first 84 butes
			tail -c +$BYTES $FILE > $TEMP
			
			#Move new file to home directory
			mv $TEMP $HOME/$FNAME.$SISXORSIS
			
			#alert success
			zenity --info --text 'File download finish: '$FNAME.$SISXORSIS
			;;
		jad)
			#OK, its jad. Get link to jar, download and save at home directory
			
			#Get link to jar file from jad file
			JARLINK=`cat $FILE | grep 'MIDlet-Jar-URL:' | tail -c+17`
			
			#download jar file to home directory
			wget $JARLINK -O $HOME/$FNAME.jar
			
			#alert success
			zenity --info --text 'File download finish: '$HOME/$FNAME'.jar'
			;;
		*)
			#This is not jar or dm file - just save at home directory
			mv $FILE $HOME/$FILENAME
			
			#alert success
			zenity --info --text 'File download finish: '$HOME/$FILENAME
			;;
	esac
fi

#That's all
