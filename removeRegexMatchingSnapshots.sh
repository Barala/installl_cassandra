#!/bin/bash
#Author:: Varun Barala

CASSANDRA_DATA_DIR="/var/lib/cassandra/data/"
MAINTAIN_LIST="deleteAll.txt"

findBackupDirs(){
    find $CASSANDRA_DATA_DIR -type d -name "hue-*" > $MAINTAIN_LIST
}

deleteFiles(){
    while read line
    do
         if [[ $line = *snapshots* ]]
                then
                        snapshotName=`echo $(basename $line)`
                        echo $snapshotName >> snapshotList.txt 
         fi
    done < $MAINTAIN_LIST
    sort snapshotList.txt | uniq > finalSnapshotList.txt
    rm snapshotList.txt
    while read line
    do
        echo "clearing snapshot :: $line"
        nodetool -u cassandra -pw pass clearsnapshot -t $line
    done < finalSnapshotList.txt
}


main(){
    deleteFiles
}

main
