FROM gcr.io/google_samples/k8skafka:v1

COPY ./certs/kafka.* /var/private/ssl/

RUN echo $'\n\    
    ssl.client.auth=required\n\
    security.protocol=SSL\n\
    security.inter.broker.protocol=SSL\n\
    ssl.keystore.location=/var/private/ssl/kafka.server.keystore.jks\n\
    ssl.keystore.password=test1234\n\
    ssl.key.password=test1234\n\
    ssl.truststore.location=/var/private/ssl/kafka.server.truststore.jks\n\
    ssl.truststore.password=test1234\n'\
>> /opt/kafka/config/server.properties
