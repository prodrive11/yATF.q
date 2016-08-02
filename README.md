# yATF.q
yet Another Test Framework for q/kdb+  

Very simple but functional and CI ready

![alt text](https://raw.githubusercontent.com/prodrive11/yATF.q/master/res/jenkins%201.png "yATF.q in Jenkins")


##### Table of Contents  
[Features](#features)  
[Structure](#structure)  
[Manual](#manual)  
[Exmple](#example)  

<a name="features"/>
# Features

* single script **bladeR** to run within Jenkins

* Converts report to Junit.xml format - jenkins can read those

* Looks for *(bashrc|prepare.sh|teardown.sh)* files in *$BUILD_DIR/test* to prepare environment
   
    ie. to start/stop whole system, kill afterwards and delete all data

<a name="structure"/>
# Structure

- bladeR

<a name="manual"/>
# Manual


<a name="example"/>
# **'example'** project
