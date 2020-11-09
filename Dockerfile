FROM openjdk:8-jre-slim

RUN mkdir -m 0755 -p /app/log
WORKDIR /app
//COPY entrypoint.sh ./entrypoint.sh
COPY target/*.jar ./service.jar
//RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["java", "-jar", "./service.jar"]
