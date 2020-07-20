# Base Alpine Linux based image with OpenJDK JRE only
FROM openjdk:8-jre-alpine 
# copy spring-pet-clinc application jar
COPY target/spring-petclinic-*.jar /spring-petclinic.jar
# command to run the application
CMD ["java", "-jar", "spring-petclinic.jar"]