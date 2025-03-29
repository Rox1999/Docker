# Build stage
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

# Run stage
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/addressbook-*.jar addressbook.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "addressbook.jar"]