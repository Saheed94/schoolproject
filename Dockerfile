# Stage 1: Build the Java application using Maven
FROM maven:3.8.7-openjdk-17 AS build

# Set the working directory for the build
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .

# Download and cache dependencies without building the project
RUN mvn dependency:go-offline -B

# Copy the entire project (after dependencies are cached)
COPY . .

# Build the application and create a JAR file
RUN mvn clean package -DskipTests

# Stage 2: Create a lightweight runtime image
FROM openjdk:17-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar /app/myapp.jar

# Expose the port your application runs on
EXPOSE 8081

# Run the application
CMD ["java", "-jar", "/app/myapp.jar"]

