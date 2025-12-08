FROM openjdk:11
WORKDIR /app
COPY target/timesheet-devops-1.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
