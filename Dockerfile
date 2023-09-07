FROM openjdk:17

WORKDIR /app

COPY ./target/spring-petclinic-3.1.0.jar /app

CMD ["java", "-jar", "spring-petclinic-3.1.0.jar"]

