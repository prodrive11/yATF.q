#!/bin/bash
export LOGDIR=/opt/uat/logs
nohup q $APP_DIR/chat/src/chatserver.q  -p $BPORT </dev/null > $LOGDIR/s.o 2>&1 &
sleep 0.8
nohup q $APP_DIR/chat/src/chatclient.q  -p $(($BPORT+1)) </dev/null > $LOGDIR/c1.o 2>&1 &
nohup q $APP_DIR/chat/src/chatclient.q  -p $(($BPORT+2)) </dev/null > $LOGDIR/c2.o 2>&1 &
sleep 0.2 

ps -ef | grep ${BPORT:0:4} | grep -v grep 
