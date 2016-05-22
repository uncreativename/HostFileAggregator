#!/bin/bash
# Script that downloads and combines various hosts file maintainers
# malwaredomains, mvps, yoyo, disconnect.me

MVPS="mvps.txt"
YOYO='yoyo.txt'
DISC='disconnect.txt'
MALW='malwaredomains.txt'
HLIST='hlist.txt'
ADAW='adaway.txt'

# Download files;
# "-t" option to limit number of attempts to download to be nice to their servers
wget -t 3 'http://winhelp2002.mvps.org/hosts.txt' -O $MVPS
wget -t 3 'http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=1&mimetype=plaintext' -O $YOYO
wget -t 3 'https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt' -O $DISC
wget -t 3 'http://www.malwaredomainlist.com/hostslist/hosts.txt' -O $MALW
wget -t 3 'http://adaway.org/hosts.txt' -O $ADAW

# Remove weird characters
dos2unix $MVPS $YOYO $DISC $MALW $ADAW

# Remove any lines that contain the string "localhost"
sed -i '/localhost/d' $MVPS $YOYO $DISC $MALW $ADAW

# Remove comments to help reduce size
sed -i 's/#.*$//' $MVPS $YOYO $DISC $MALW $ADAW

# Remove blank lines
sed -i '/^$/d' $MVPS $YOYO $DISC $MALW $ADAW

# Prepends every line with '0.0.0.0' in disconnect.txt
sed -i 's/^/0.0.0.0 /' $DISC

# Changes '127.0.0.1' to '0.0.0.0'
# Increases speed? Something about not having to wait for timeout.
# Need further research
sed -i 's/^127\.0\.0\.1/0\.0\.0\.0/' $MVPS $YOYO $MALW $ADAW

# Remove a single space in malwaredomainlist to help standardize and have unique entries
sed -i 's/0.0.0.0 /0.0.0.0/' $MALW

# Sorts and removes duplicate lines
sort -u $MVPS $YOYO $DISC $MALW $ADAW -o $HLIST

# Delete uncessary files
rm $MVPS $YOYO $DISC $MALW $ADAW
