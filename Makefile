ZK_HOST := 192.168.42.4:2181
PRINCIPAL := user
ROLE := role
SECRET := secret

build:
	docker build -t jmorton/inferno runner
	docker tag jmorton/inferno jmorton/infero:latest

shell:
	docker run -it \
		--net=inferno_mesos \
		-e SPARK_MASTER="mesos://zk://$(ZK_HOST)/mesos" \
		-e SPARK_IMAGE="jmorton/inferno" \
		-e PYSPARK_DRIVER_PYTHON=ipython2 \
                -e SPARK_PRINCIPAL=$(PRINCIPAL) \
		-e SPARK_SECRET=$(SECRET) \
		-e SPARK_ROLE=$(ROLE) \
		jmorton/inferno:latest /bin/bash

ipython:
	docker run -it --rm \
		--net=inferno_mesos \
		-e SPARK_MASTER="mesos://zk://$(ZK_HOST)/mesos" \
		-e SPARK_IMAGE="jmorton/inferno:latest" \
		-e PYSPARK_DRIVER_PYTHON=ipython2 \
		jmorton/inferno:latest /opt/spark/bin/pyspark

pi:
	docker run -it --rm \
		--net=inferno_mesos \
		-e SPARK_MASTER="mesos://zk://$(ZK_HOST)/mesos" \
		-e SPARK_IMAGE="jmorton/inferno:latest" \
	 	-e PYSPARK_DRIVER_PYTHON=ipython2 \
		jmorton/inferno:latest /opt/spark/bin/spark-submit /opt/spark/examples/src/main/python/pi.py 10
