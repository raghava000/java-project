# Stage 1: Build Stage (No changes needed here)
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Runtime Stage (The FIX)
# We use eclipse-temurin for a stable, modern Java 17 environment
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
# Copy the jar from the build stage
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
