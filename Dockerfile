# Use a lightweight JDK runtime
FROM openjdk:17-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from your Maven project
COPY target/student-collator-1.0-SNAPSHOT.jar /app/student-collator-1.0-SNAPSHOT.jar

# Expose the port your application will run on
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "/app/student-collator-1.0-SNAPSHOT.jar"]

