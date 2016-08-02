# yATF.q
yet Another Test Framework for q/kdb+  

Very simple but functional and CI ready

![alt text](https://raw.githubusercontent.com/prodrive11/yATF.q/master/res/jenkins%201.png "yATF.q in Jenkins")


# Features

# Structure

- bladeR

Shell script to run within Jenkins

Defines yATF.q itself

Converts report to Junit.xml format - jenkins can read those

Looks for bashrc files in '$PROJ/test' to prepare environment

If exist runs prepare.sh - to ie. start system

If exist runs teardown.sh - to kill the system, delete data etc.

- 'example' project
