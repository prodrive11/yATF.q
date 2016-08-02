
##### Table of Contents  
[About](#about)  
[Features](#features)  
[Structure](#structure)  
[Manual](#manual)  
[Example](#example)  

<a name="about"/>
# About **yATF.q**
yet Another Test Framework for q/kdb+  
Very simple but functional and CI ready
![alt text](https://raw.githubusercontent.com/prodrive11/yATF.q/master/res/jenkins%201.png "yATF.q in Jenkins")

Designed for and presented during [London KX Meetup 2015](https://docs.google.com/presentation/d/1SFtNVjchf_HPOWd-aAR1uEP8e20bFLE7nATYFpRCmTM/edit?usp=sharing)


<a name="features"/>
# Features

* single script **bladeR** to run within Jenkins
* Converts report to Junit.xml format - jenkins default 
* Runs various severity of tests: unit, integration, system - based on your selection in TT files (a.t, u.t, i.t or s.t)
* Looks for *(bashrc|prep.sh|tear.sh)* files in *$BUILD_DIR/test* to prepare environment

    ie. to start/stop whole system, kill afterwards and delete all data

<a name="structure"/>
# Structure

```
($BUILD_DIR|$WORKSPACE_ROOT)/
---->/bladeR
---->/app1/
--------->/bin
--------->/src                                  ## contains all source files
--------->/test/                                ## default test folder
-------------->/a.t                             ## module Test Type - list of modules to test 
-------------->/basicsuite/
------------------------->/a.t                  ## test suite Test Type - list of files to run
------------------------->/genericT.q
------------------------->/mod1T.q
-------------->/systemsuite/
------------------------->/a.t                  
------------------------->/bashrc               ## environment file, loaded before running tests within suite
------------------------->/prep.sh              ## prepare env for integ/system tests - start whole system
------------------------->/tear.sh              ## purges environment after all test from suite were run
------------------------->/first.q
------------------------->/second.q
```

<a name="manual"/>
# Manual

## Test environemnt variables
| Assertion    | Description  | Example |
| ------------- |:-------------| -----:|
| $BUILD_DIR      |  Optional for Jenkins - as in example | |
| $TT      |  **T**est **T**ype, default 'a' for all test | |
| $QHOME      | Needed to run q/kdb+      |    |
| $PATH      | Add $QHOME/<os> to start q from any location   |    |

Tests using a list of test to run from particular test type : 

| Test Type file  | Description    |
| ------------- |:-------------|
| a.t | all suits from a module |
| u.t | unit suits from a module |
| i.t | integration suits from a module |
| s.t | system tests from a module |

## Assertions

| Assertion        | Example           | Description  |
| ------------- |:-------------| -----:|
| **.t.T**      | .t.T "B">"A" | **True** => 1b |
| **.t.E**      | .t.E ("not same"; 84)      |   **E**qual => 0b  |
| **.t.N**      | .t.N (`notEqual; 101)      |  **N**ot equal => 1b   |
| **.t.G**      | .t.G (500; 101)      |  **G**reater than => 1b   |

## Examples

```javascript
.t.E ((1 1 2 3); asc[1 3 2 1]);
.t.G 6000, system "t asc[1 2 1]";

.t.N (`dssadf; 1 2 3);
.t.T (`f; 1 2 3);
```

<a name="example"/>
# **'example'** project

Example project contains two individual apps/modules:
* app1

   collection of few simple util functions
   Tests runs basic unit tests

* chat

   Have full chat,  
   tests simulates whole ecosystem system ie. few clients and server started from prepare.sh
   it's all wiped when tests are finished within teardown.sh
   
   
## Jenkins config

[Example config for this project](https://raw.githubusercontent.com/prodrive11/yATF.q/master/example/jenkins-config.xml)

Works with local git server, and *hudson.plugins.git.GitSCM* plugin for Jenkins.

Basic Git confing in Jenkins job
![alt text](https://raw.githubusercontent.com/prodrive11/yATF.q/master/res/Jenkins%20job%20-git%20cfg.png "Git confing in Jenkins job")

Git polling schedule in Jenkins job (each 15mins)
![alt text](https://raw.githubusercontent.com/prodrive11/yATF.q/master/res/Jenkins%20job%20-git%20poll.png "Git poll schedule")

Actual build and report location config example
![alt text](https://raw.githubusercontent.com/prodrive11/yATF.q/master/res/Jenkins%20job%20-build%20test%20report%20.png "Actual build and report location config")


### Setting up basic environment on Ubuntu server
```bash
#GIT USER:
    5  mkdir .ssh
    7  chmod 700 .ssh
    9  touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys
   13  ssh-keygen -t rsa -C "jenkins@silenthill.com"
   16  cat id_rsa.jenkins.pub >> .ssh/authorized_keys
   20  chmod a+rw id_rsa.jenkins*
   21  cat >> .ssh/authorized_keys #//prodrive11 pub key
   22  cd /opt
   24  mkdir git
   25  cd git
   28  mkdir app1.git chat.git
   29  cd app1.git
   30  git init --bare
   31  cd ../chat.git/
   32  git init --bare
```

```bash
#as Jenkins user:
    5  cd /var/lib/jenkins/
    8  mkdir .ssh
   10  cd .ssh
   15  cp /home/git/id_rsa.jenkins id_rsa
   16  cp /home/git/id_rsa.jenkins.pub id_rsa.pub
```

```bash
#as prodrive11 user:
 #get jenkins
 555 wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
 556 sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
 557 sudo apt-get update
 558 sudo apt-get install jenkins
``` 
 
```bash
 #setup git
 1069  cd .ssh
 1070  mkdir .ssh
 1071  ssh-keygen -t rsa -C "prodrive11@silenthill.com"
 1113  sudo adduser git
 1114  sudo su git
 1118  sudo su jenkins -s /bin/bash
 1075  cd /opt
 1077  mkdir git
 1078  sudo mkdir git
 1080  sudo chown git:git git/
```
```bash
 #init repo
 1090  mkdir workspace
 1091  cd workspace/
 1092  mkdir app1
 1093  cd app1/
 1094  git init
 1098  git config --global user.email "prodrive11@silenthill.com"
 1099  git config --global user.name "Patryk"
 1101  git remote add origin git@silenthill:/opt/git/app1.git
 1102  add some files
 1103  git push origin master
```




