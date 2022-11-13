#!/bin/bash

sed -e 's/ /\n/g' animal.txt | grep -v '^$' | sort | uniq -c