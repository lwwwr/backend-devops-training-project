FROM openjdk:8-jdk-slim

RUN mkdir /project

WORKDIR /project

EXPOSE 8080

USER root

COPY . /project

RUN ls -la

RUN ./gradlew build -x test

FROM java:jre-alpine

WORKDIR /project

COPY --from=0 /project/build/libs/project-0.0.1-SNAPSHOT.jar .

ENTRYPOINT java -jar project-0.0.1-SNAPSHOT.jar
