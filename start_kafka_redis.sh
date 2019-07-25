#!/bin/sh
# Script to build the code and Run.

sh dependencies/kafka_2.11-2.2.1/bin/zookeeper-server-start.sh dependencies/kafka_2.11-2.2.1/config/zookeeper.properties&
sh dependencies/kafka_2.11-2.2.1/bin/kafka-server-start.sh dependencies/kafka_2.11-2.2.1/config/server.properties&
tar -xvf dependencies/redis-stable.tar
chmod  +x redis-stable/src/redis-server && redis-stable/src/redis-server&
