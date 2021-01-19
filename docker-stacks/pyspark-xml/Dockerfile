ARG BASE_CONTAINER=jupyter/pyspark-notebook
FROM $BASE_CONTAINER

USER root
WORKDIR $SPARK_HOME/jars/
RUN wget https://repo1.maven.org/maven2/com/databricks/spark-xml_2.12/0.9.0/spark-xml_2.12-0.9.0.jar
WORKDIR $HOME

