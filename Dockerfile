# Use an appropriate base image with JDK and Maven installed
FROM maven:3.9.6-amazoncorretto-21 AS build 

# Set the working directory in the container
WORKDIR /coursemanager

# Copy the Maven project definition and dependencies
COPY pom.xml .
COPY src ./src

# Build the JAR file using Maven
RUN mvn clean package

# Use a lightweight base image for running the application
FROM amazoncorretto:21-alpine
# Set the working directory in the container
WORKDIR /coursemanager

# Copy the JAR file from the build stage to the final image
COPY --from=build /coursemanager/target/coursemanager-3.2.5.jar .

# Specify the command to run your application
CMD ["java", "-jar", "coursemanager-3.2.5.jar"]