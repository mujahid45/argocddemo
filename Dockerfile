FROM  alpine-jdk:latest as alpha
RUN jlink \
     --module-path /opt/java/jmods \
     --compress=2 \
     --add-modules java.base,java.logging,java.sql,java.security.jgss,java.desktop,java.management,java.instrument \
     --strip-debug \
     --no-header-files \
     --no-man-pages \
     --ignore-signing-information \
     --output /lib/runtime
FROM scratch
#USER 1000080000
COPY --chown=1000080000:1000080000 --from=alpha /lib /lib
COPY --chown=1000080000 --from=alpha /tmp /tmp
#ADD  --chown=1000080000 app.jar /opt/app/
#EXPOSE 8080
#CMD ["/lib/runtime/bin/java", "-jar", "/opt/app/app.jar"]  
