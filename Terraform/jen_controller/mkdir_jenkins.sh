#!/usr/bin/env bash

name=jenkins

if [[ -d ~ ]]; then
    mkdir $name
else
    cd && mkdir $name
fi