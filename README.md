# Inferno

It. Burns.

## Usage

Start Zookeeper, Mesos, Marathon, and Cassandra:

```
docker-compose up
```

Build the Docker image:

```
docker build -t jmorton/inferno runner
```

Run Spark client:

```
docker run -it --rm \
  -e SPARK_MASTER="mesos://zk://127.0.0.1:2181/mesos" \
  -e SPARK_IMAGE="jmorton/inferno" \
  -e PYSPARK_DRIVER_PYTHON=ipython2 \
  jmorton/inferno /opt/spark/bin/pyspark
```

### TO-DO-ING

* Example Spark Client invoked by HTTP
* Store RDD in Cassandra

### Acknowledgements

[Derived from work done by Bernardo Gomez Palacio](https://github.com/berngp/mesos-spark-docker).
