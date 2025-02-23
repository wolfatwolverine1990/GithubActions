# STAGE 1: Build the JAR file
FROM maven:3.9.2-eclipse-temurin-17 AS builder
WORKDIR /app

# Copy the project files and build the JAR
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# STAGE 2: Create the final lightweight image
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the application port (Change if needed)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
