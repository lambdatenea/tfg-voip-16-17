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
    	NUMFILE="000$NUMFILE"
    fi

    if [ $NUMNOZEROS -eq 2 ]
    then
    	NUMFILE="00$NUMFILE"
    fi

    if [ $NUMNOZEROS -eq 3 ]
    then
    	NUMFILE="0$NUMFILE"
    fi

    if [ ! -d $VMDEAULTPATH ]
    then
    	mkdir $VMDEAULTPATH
    fi
	VMDEAULTPATH="$VMDEAULTPATH/msg$NUMFILE.wav"

	cp $CONFIGBRIDGEPATH $VMDEAULTPATH
	
	echo "[message]" >> "$VMDEAULTPATH/msg$NUMFILE.txt"
	echo "origmailbox=$EXTENS[$i]" >> "$VMDEAULTPATH/msg$NUMFILE.txt"
	echo "context=exten=inter" >> "$VMDEAULTPATH/msg$NUMFILE.txt"
	echo "macrocontext=" >> "$VMDEAULTPATH/msg$NUMFILE.txt"
	echo "exten=s-BUSY" >> "$VMDEAULTPATH/msg$NUMFILE.txt"
	echo "priority=1" >> "$VMDEAULTPATH/msg$NUMFILE.txt"
	echo "callerchan=SIP/9990" >> "$VMDEAULTPATH/msg$NUMFILE.txt"
	echo "callerid=" <112>" >> "$VMDEAULTPATH/msg$NUMFILE.txt"
	echo "origdate=$(date)">> "$VMDEAULTPATH/msg$NUMFILE.txt"
	echo "origtime=$(date +%s)" >> "$VMDEAULTPATH/msg$NUMFILE.txt"
	echo "category=Work" >> "$VMDEAULTPATH/msg$NUMFILE.txt"
	echo "duration=" >> "$VMDEAULTPATH/msg$NUMFILE.txt"
	
done
