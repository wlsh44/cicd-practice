FROM openjdk:17

ARG JAR_FILE=build/libs/*.jar

COPY ${JAR_FILE} app.jar

ENTRYPOINT ["java", "-jar", "-Dspring.config.location=file:/root/", "-Dspring.profiles.active=prod", "/app.jar"]