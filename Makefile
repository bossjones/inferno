build:
	docker build -t jmorton/inferno .
	docker tag jmorton/inferno jmorton/infero:latest

shell:
	docker run -it --rm \
		--net=host \
		-e SPARK_MASTER="mesos://zk://127.0.0.1:2181/mesos" \
		-e SPARK_IMAGE="jmorton/inferno" \
		-e PYSPARK_DRIVER_PYTHON=ipython2 \
		jmorton/inferno:latest /opt/spark/bin/pyspark
