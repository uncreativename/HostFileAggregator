#!/usr/bin/python3
# -*- coding: utf-8 -*-
from subprocess import call

def main():
    script = './hosts_compilation.sh'
    host_file = 'hlist.txt'

    # run shell script
    call([script])

    # Opens file and makes a list of all the lines in hlist.txt
    with open(host_file) as f:
        lines = f.readlines()

    # Checks to make sure each line starts with '0.0.0.0 '
    for i, line in enumerate(lines):
        if not line.startswith('0.0.0.0 '):
            print("Error with file:")
            print("On line :")
            print(i + 1)

if __name__ == "__main__":
    main()
