ZK_HOST := 127.0.0.1:2181

build:
	docker build -t jmorton/inferno runner
	docker tag jmorton/inferno jmorton/infero:latest

ipython:
	docker run -it --rm \
		--net=host \
		-e SPARK_MASTER="mesos://zk://$(ZK_HOST)/mesos" \
		-e SPARK_IMAGE="jmorton/inferno" \
		-e PYSPARK_DRIVER_PYTHON=ipython2 \
		jmorton/inferno:latest /opt/spark/bin/pyspark

shell:
	docker run -it \
		--net=host \
		-e SPARK_MASTER="mesos://zk://$(ZK_HOST)/mesos" \
		-e SPARK_IMAGE="jmorton/inferno" \
		-e PYSPARK_DRIVER_PYTHON=ipython2 \
		jmorton/inferno:latest /bin/bash

pi:
	docker run -it --rm \
		-e SPARK_MASTER="mesos://zk://$(ZK_HOST)/mesos" \
		-e SPARK_IMAGE="jmorton/inferno:latest" \
	 	-e PYSPARK_DRIVER_PYTHON=ipython2 \
		jmorton/inferno:latest /opt/spark/bin/spark-submit --driver-memory 500M \
	                                                	   --executor-memory 500M \
	                                               		   /opt/spark/examples/src/main/python/pi.py 10
