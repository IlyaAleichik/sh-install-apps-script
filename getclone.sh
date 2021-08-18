#!/bin/bash
file="getlink.txt"
for var in $(cat $file)
do git clone "$var"
done