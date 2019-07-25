#!/bin/sh
# Script to build the code and Run.

sh dependencies/kafka_2.11-2.2.1/bin/zookeeper-server-start.sh dependencies/kafka_2.11-2.2.1/config/zookeeper.properties&

sh dependencies/kafka_2.11-2.2.1/bin/kafka-server-start.sh dependencies/kafka_2.11-2.2.1/config/server.properties&

chmod  +x dependencies/redis-stable/src/redis-server && dependencies/redis-stable/src/redis-server&