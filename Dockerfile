FROM adoptopenjdk/maven-openjdk8:latest AS build_img
RUN mkdir /app
WORKDIR /app
COPY . /app
RUN mvn package -B

FROM adoptopenjdk/openjdk8:alpine-jre
VOLUME /tmp
COPY --from=build_img /app/target/actuator-sample-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
