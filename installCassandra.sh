#!/bin/bash
#Author :: Varun Barala

#Install java 8
installJava(){
	sudo add-apt-repository ppa:webupd8team/java -y
	sudo apt-get update
	sudo apt-get install oracle-java8-installer

	sudo apt-get install oracle-java8-set-default

}

addSource(){
	#add datastax repo into source list
	echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

	#Datastax repository key
	curl -L https://debian.datastax.com/debian/repo_key | sudo apt-key add -
}


installCassandra(){
	# here we are gonna install cassandra-2.1.13
	sudo apt-get update
	sudo apt-get install dsc21=2.1.13-1 cassandra=2.1.13
	sudo apt-get install cassandra-tools=2.1.13 ## Optional utilities
}


installJEMallocaAllocator(){
	sudo apt-get install gcc
	sudo apt-get install make
	wget https://github.com/jemalloc/jemalloc/releases/download/4.1.0/jemalloc-4.1.0.tar.bz2
	tar xjvf jemalloc-4.1.0.tar.bz2
	cd jemalloc-4.1.0
	./configure
	make
	sudo make install
	sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/cassandra.conf'
	sudo ldconfig
}


stopCassandraRemoveDir(){
	# remove esiting things
	sudo service cassandra stop
	sudo rm -rf /var/lib/cassandra/*
}

changeCassandraYaml(){
	#add as per your requirement, I'm adding for JEMallocAllocator
	FILE=/etc/cassandra/cassandra.yaml
        sudo sed -i '/# memory_allocator: NativeAllocator/c\memory_allocator: JEMALLOCATOR' $FILE
}


main(){
	installJava
	addSource
	installCassandra
	installJEMallocaAllocator
	stopCassandraRemoveDir
	changeCassandraYaml
}

# calling main fuction
main
