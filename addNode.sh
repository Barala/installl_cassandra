#!/bin/bash
#Author :: Varun Barala
#Purpose :: add node in running cluster
#--------------------------------------


installCassandra(){
	#TODO integrate with ansible scripts
	echo "installing cassandra!!"
}

stopAndRmDir(){
	sudo service cassandra stop
	sudo rm -r /va/lib/cassandra/data
}

changeGossipSettings(){
	FILE=/etc/cassandra/cassandra.yaml
        sudo sed -i '/endpoint_snitch: SimpleSnitch/c\endpoint_snitch: GossipingPropertyFileSnitch' $FILE	
}

changeSeeds(){
	echo "chaning seeds"
}

changeRackProperties(){
	echo "change rack properties"
}

startCassandra(){
	sudo service cassandra start
}

checkSetUp(){
	#through nodetool api
	nodetool status
}


main(){
	installCassandra
	stopAndRmDir
	changeGossipSettings
	changeSeeds
	changeRackProperties
	startCassandra
	checkSetUp
}


main



