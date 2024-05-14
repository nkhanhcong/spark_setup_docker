# Use an official OpenJDK runtime as a parent image
FROM openjdk:8-jdk

# Set the Spark and Hadoop versions
ENV SPARK_VERSION=3.5.1
ENV HADOOP_VERSION=3

# Set environment variables
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin

# Download and install Spark
RUN mkdir -p /opt && \
    curl -sL --retry 3 \
    "https://downloads.apache.org/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz" \
    | tar -xz -C /opt && \
    mv /opt/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION $SPARK_HOME

# Copy entrypoint script
COPY entrypoint.sh /opt/

# Set the entrypoint script as executable
RUN chmod +x /opt/entrypoint.sh

# Set the working directory
WORKDIR $SPARK_HOME

# Expose ports for Spark UI
EXPOSE 4040 8080 

# Set the entrypoint
ENTRYPOINT ["/opt/entrypoint.sh"]
