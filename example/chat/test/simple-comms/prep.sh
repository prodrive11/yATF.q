#!/bin/bash

nohup q $BUILD_DIR/chat/src/chatserver.q  -p $BPORT </dev/null 2>&1 &
sleep 0.8
nohup q $BUILD_DIR/chat/src/chatclient.q  -p $(($BPORT+1)) </dev/null 2>&1 &
nohup q $BUILD_DIR/chat/src/chatclient.q  -p $(($BPORT+2)) </dev/null 2>&1 &
sleep 0.2 

ps -ef | grep ${BPORT:0:4} | grep -v grep 
