ZK_HOST := 127.0.0.1:2181
PRINCIPAL := user
ROLE := role
SECRET := secret

build:
	docker build -t jmorton/inferno runner
	docker tag jmorton/inferno jmorton/infero:latest

ipython:
	docker run -it --rm \
		--net=host \
		-e SPARK_MASTER="mesos://zk://$(ZK_HOST)/mesos" \
		-e SPARK_IMAGE="jmorton/inferno" \
		-e PYSPARK_DRIVER_PYTHON=ipython2 \
                -e SPARK_PRINCIPAL=$(PRINCIPAL) \
		-e SPARK_SECRET=$(SECRET) \
		-e SPARK_ROLE=$(ROLE) \
		jmorton/inferno:latest /opt/spark/bin/pyspark

shell:
	docker run -it \
		--net=host \
		-e SPARK_MASTER="mesos://zk://$(ZK_HOST)/mesos" \
		-e SPARK_IMAGE="jmorton/inferno" \
		-e PYSPARK_DRIVER_PYTHON=ipython2 \
                -e SPARK_PRINCIPAL=$(PRINCIPAL) \
		-e SPARK_SECRET=$(SECRET) \
		-e SPARK_ROLE=$(ROLE) \
		jmorton/inferno:latest /bin/bash

pi:
	docker run -it --rm \
		--net=host \
		-e SPARK_MASTER="mesos://zk://$(ZK_HOST)/mesos" \
		-e SPARK_IMAGE="jmorton/inferno:latest" \
	 	-e PYSPARK_DRIVER_PYTHON=ipython2 \
                -e SPARK_PRINCIPAL=$(PRINCIPAL) \
		-e SPARK_SECRET=$(SECRET) \
		-e SPARK_ROLE=$(ROLE) \
		jmorton/inferno:latest /opt/spark/bin/spark-submit /opt/spark/examples/src/main/python/pi.py 10
