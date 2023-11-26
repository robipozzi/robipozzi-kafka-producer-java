FROM openjdk:17
LABEL maintainer="Roberto Pozzi <r.robipozzi@gmail.com>"
LABEL version="1.0"
LABEL description="Spring Boot Kafka producer"
COPY target/robipozzi-kafka-producer-java-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]