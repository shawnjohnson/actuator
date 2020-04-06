FROM maven:3-jdk-8 AS build_img
RUN mkdir /app 
WORKDIR /app
COPY . /app 
RUN mvn package -B

FROM openjdk:8u111-jdk-alpine
VOLUME /tmp
COPY --from=build_img /app/target/actuator-sample-0.0.1-SNAPSHOT.jar app.jar 
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

