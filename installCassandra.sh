#!/bin/bash
#Author :: Varun Barala

#Install java 8
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update
sudo apt-get install oracle-java8-installer

sudo apt-get install oracle-java8-set-default


#Add datastax repo into source list
echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

#Datastax repository key
curl -L https://debian.datastax.com/debian/repo_key | sudo apt-key add -

# here we are gonna install cassandra-2.1.13
sudo apt-get update
sudo apt-get install dsc21=2.1.13-1 cassandra=2.1.13
sudo apt-get install cassandra-tools=2.1.13 ## Optional utilities



# remove esiting things
sudo service cassandra stop
sudo rm -rf /var/lib/cassandra/data/system/*
