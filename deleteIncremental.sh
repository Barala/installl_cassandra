#!/bin/bash
#Author:: Varun Barala

CASSANDRA_DATA_DIR="/var/lib/cassandra/data/"
MAINTAIN_LIST="deleteAll.txt"

findBackupDirs(){
    find $CASSANDRA_DATA_DIR -type d -name "backups" > $MAINTAIN_LIST
}

deleteFiles(){
    findBackupDirs
    while read line
    do
        sudo rm -r $line
    done < $MAINTAIN_LIST
}


main(){
    deleteFiles
}

main
