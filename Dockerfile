# Dockerfile for Marand Think!EHR Demographics

FROM openjdk:8-jre-alpine

LABEL org.label-schema.vendor="Marand" \
      org.label-schema.url="http://marand.si/" \
      org.label-schema.name="ThinkEHR Demographics" \
      org.label-schema.version="$DEMOGRAPHICS_VER" \
      org.label-schema.docker.schema-version="1.0" \
      com.inidus.maintainer="Inidus" \
      com.inidus.contact="Inidus <contact@inidus.com>"

# Docker - Set ENV in container
ENV DEMOGRAPHICS_SLEEP=10 \
    PSQL_URL=https://jdbc.postgresql.org/download \
    PSQL_JDBC=postgresql-42.2.0.jar \
    DEMOGRAPHICS_JAR=$DEMOGRAPHICS_JAR

WORKDIR /demographics

# Inidus - Fetch PostgreSQL JDBC
RUN apk add --update curl && \
    curl -SL ${PSQL_URL}/${PSQL_JDBC} -o ${PSQL_JDBC} && \
    apk del curl && \
    rm -rf /tmp/* /var/cache/apk/*


# Inidus - Include Think!EHR Demographics config
COPY ./source/*.jar ${DEMOGRAPHICS_JAR}
COPY ./conf/application.properties application.properties

EXPOSE 8384

# Inidus - run .jar
CMD echo "The application will start in ${DEMOGRAPHICS_SLEEP}s..." && \
    sleep ${DEMOGRAPHICS_SLEEP} && \
    LOG_FILE='logs/demographics_app.log' java -Xmx2048m -jar ./${DEMOGRAPHICS_JAR}
