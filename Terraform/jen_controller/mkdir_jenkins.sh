#!/usr/bin/env bash

dir=/home/ec2-user
name=jenkins

if [ $PWD = "$dir" ]; then
    mkdir $name
else
    cd && mkdir $name
fi