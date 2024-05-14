#!/bin/bash

if [ "$SPARK_MODE" == "master" ]; then
    # Start Spark master
    $SPARK_HOME/sbin/start-master.sh -h 0.0.0.0
elif [ "$SPARK_MODE" == "worker" ]; then
    # Start Spark worker and link it to the master
    $SPARK_HOME/sbin/start-worker.sh $SPARK_MASTER_URL
elif ["$SPARK_MODE" == "history"]; then
    #Start Spark history server
    $SPARK_HOME/sbin/start-history-server.sh
else
    echo "Please specify a valid SPARK_MODE: master or worker"
    exit 1
fi

# Keep the container running
tail -f /dev/null
