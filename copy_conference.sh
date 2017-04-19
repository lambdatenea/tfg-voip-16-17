#!/bin/bash

CONFIGBRIDGEDIR=/var/spool/asterisk/confbridge
CONFIGBRIDGEPATH=$(ls $CONFIGBRIDGEDIR | tail -1)
CONFIGBRIDGEPATH=$(echo "$CONFIGBRIDGEDIR/$CONFIGBRIDGEPATH")
VMDEAULTDIR=/var/spool/asterisk/voicemail/default
EXTENS=(1001 1234)
NUMEXTENS=$(echo ${#EXTENS[@]})


for ((i=0; i<$NUMEXTENS; i++))
do
	VMDEAULTPATH="$VMDEAULTDIR/${EXTENS[$i]}/Work"
	NUMFILE=$(ls $VMDEAULTPATH | tail -1 | cut -c4-7)
	NUMFILE=$((NUMFILE+1))
	NUMNOZEROS=$(echo "${#NUMFILE}")

	if [ $NUMNOZEROS -eq 1 ]
    then
    	#echo "3 ceros"
    	NUMFILE="000$NUMFILE"
    fi

    if [ $NUMNOZEROS -eq 2 ]
    then
    	#echo "3 ceros"
    	NUMFILE="00$NUMFILE"
    fi

    if [ $NUMNOZEROS -eq 3 ]
    then
    	#echo "3 ceros"
    	NUMFILE="0$NUMFILE"
    fi

    if [ ! -d $VMDEAULTPATH ]
    then
    	mkdir $VMDEAULTPATH
    fi
	VMDEAULTPATH="$VMDEAULTPATH/msg$NUMFILE.wav"

	cp $CONFIGBRIDGEPATH $VMDEAULTPATH
done