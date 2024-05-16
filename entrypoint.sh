#!/bin/bash

echo "Starting entrypoint script..."

# Set Spark Event Logging Configuration based on environment variables
if [ "$SPARK_EVENT_LOG_ENABLED" == "true" ]; then
    SPARK_LOGGING_OPTS="
        --conf spark.eventLog.enabled=true
        --conf spark.eventLog.dir=$SPARK_EVENT_LOG_DIR
    "
else
    SPARK_LOGGING_OPTS=""
fi

if [ "$SPARK_MODE" == "master" ]; then
    echo "Starting Spark master..."
    $SPARK_HOME/sbin/start-master.sh -h 0.0.0.0
    echo "Spark master started."
elif [ "$SPARK_MODE" == "worker" ]; then
    echo "Starting Spark worker..."
    echo "Connecting to Spark master at $SPARK_MASTER_URL"
    $SPARK_HOME/sbin/start-worker.sh $SPARK_MASTER_URL $SPARK_LOGGING_OPTS
    echo "Spark worker started."
elif [ "$SPARK_MODE" == "history" ]; then
    echo "Starting Spark history server..."
    $SPARK_HOME/sbin/start-history-server.sh $SPARK_LOGGING_OPTS
    echo "Spark history server started."
else
    echo "Please specify a valid SPARK_MODE: master, worker, or history"
    exit 1
fi

# Keep the container running
echo "Entrypoint script completed. Container will keep running."
tail -f /dev/null
