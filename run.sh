# from spark submit
docker cp ./app.py spark-master:/tmp/app.py

# to run docker 
docker exec -it spark-master spark-submit \
  --master spark://spark-master:7077 \
  /tmp/app.py