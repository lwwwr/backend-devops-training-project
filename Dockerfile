FROM openjdk:8-jdk-slim as builder

RUN groupadd -r gradleuser && useradd -rmg gradleuser gradleuser

USER gradleuser

COPY --chown=gradleuser:gradleuser . /home/gradleuser/src

WORKDIR /home/gradleuser/src

RUN ./gradlew build -x test
RUN ls -la build/libs 
FROM java:jre-alpine

WORKDIR /home/gradleuser/src

EXPOSE 8080

COPY --from=builder /home/gradleuser/src/build/libs/src-0.0.1-SNAPSHOT.jar .

#ARG DB_URL 
#ARG DB_USERNAME 
#ARG DB_PASSWORD
#ARG DB_PORT
#ARG DB_NAME
#ARG JDBC_DRIVER

#ENV DB_URL=${DB_URL:-"localhost"}
#ENV DB_USERNAME=${DB_USERNAME:-"postgres"}
#ENV DB_PASSWORD=${DB_PASSWORD:-"postgres"}
#ENV DB_PORT=${DB_PORT:-"5432"}
#ENV DB_NAME=${DB_NAME:-"postgres"}
#ENV JDBC_DRIVER=${JDBC_DRIVER:-"postgresql"}

ENTRYPOINT java -jar src-0.0.1-SNAPSHOT.jar
