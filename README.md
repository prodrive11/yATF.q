
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

Designed for and presented during ![alt text](https://docs.google.com/presentation/d/1SFtNVjchf_HPOWd-aAR1uEP8e20bFLE7nATYFpRCmTM/edit?usp=sharing "London KX Meetup 2015")


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
   
