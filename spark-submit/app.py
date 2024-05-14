from pyspark.sql import SparkSession
import time

# Create a SparkSession
spark = SparkSession.builder \
    .appName("LineCount") \
    .getOrCreate()

# Define the string
input_string = """This is the first line.
This is the second line.
This is the third line."""

# Create an RDD from the string
lines = input_string.split('\n')
lines_rdd = spark.sparkContext.parallelize(lines)

# Count the number of lines
line_count = lines_rdd.count()

print(f"Number of lines in the string: {line_count}")
print("Sleeping for 30 seconds...")
print("Awake now!")
# Stop the SparkSession
spark.stop()
