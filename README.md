
##### Table of Contents  
[About](#about)  
[Features](#features)  
[Structure](#structure)  
[Manual](#manual)  
[Exmple](#example)  

<a name="about"/>
# About **yATF.q**
yet Another Test Framework for q/kdb+  

Very simple but functional and CI ready

![alt text](https://raw.githubusercontent.com/prodrive11/yATF.q/master/res/jenkins%201.png "yATF.q in Jenkins")


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

## Test environemnt variables
| Assertion    | Description  | Example |
| ------------- |:-------------:| -----:|
| $BUILD_DIR      |  Optional for Jenkins - as in example | |
| $QHOME      | Needed to run q/kdb+      |    |
| $PATH      | Add $QHOME/<os> to start q from any location   |    |


## Assertions

| Assertion        | Example           | Description  |
| ------------- |:-------------:| -----:|
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
