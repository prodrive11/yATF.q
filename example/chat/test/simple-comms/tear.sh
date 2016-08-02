#!/bin/bash

sleep 0.2
ps -ef | grep ${BPORT:0:4} | grep -v grep | tr -s ' ' | cut -d ' ' -f 2 | xargs kill -9 
sleep 0.2
ps -ef | grep ${BPORT:0:4} | grep -v grep 
