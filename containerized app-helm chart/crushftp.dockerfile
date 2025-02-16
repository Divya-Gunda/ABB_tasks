FROM openjdk:13-alpine
RUN apk update
RUN apt-get update; apt-get install -y --no-install-recommends ca-certificates p11-kit ; rm -rf /var/lib/apt/lists/* 

ENV LANG=C.UTF-8

RUN apk update --no-cache && apk --no-cache add bash bash-completion bash-doc ca-certificates curl wget && update-ca-certificates

WORKDIR /var/opt
RUN wget -O /tmp/CrushFTP10.zip https://www.crushftp.com/early10/CrushFTP10.zip 
RUN unzip -o -q /tmp/CrushFTP10.zip -x "*users/*" -d /var/opt 
RUN rm -f /tmp/CrushFTP10.zip 
RUN chmod +x /var/opt/CrushFTP10/crushftp_init.sh 
RUN sed -i "s/-Xmx512M -jar plugins\/lib\/CrushFTPJarProxy\.jar/-Xmx2G -Dcrushftp.prefs=\/var\/opt\/CrushFTP10\/settings\/ -jar plugins\/lib\/CrushFTPJarProxy.jar/g" /var/opt/CrushFTP10/crushftp_init.sh # buildkit
RUN wget -O /tmp/sqljdbc_9.4.0.0_enu.zip https://download.microsoft.com/download/b/c/5/bc5e407f-97ff-42ea-959d-12f2391063d7/sqljdbc_9.4.0.0_enu.zip # buildkit
RUN mkdir /tmp/sqljdbc_9.4.0.0_enu
RUN unzip /tmp/sqljdbc_9.4.0.0_enu.zip -d /tmp/sqljdbc_9.4.0.0_enu # buildkit
RUN cd /tmp/sqljdbc_9.4.0.0_enu && cp -RT 'sqljdbc_9.4\enu' /var/opt/CrushFTP10 # buildkit
RUN rm -f /tmp/sqljdbc_9.4.0.0_enu.zip # buildkit
RUN rm -rf /tmp/sqljdbc_9.4.0.0_enu 

ADD ./startup.sh /var/opt/startup.sh

ENTRYPOINT /var/opt/startup.sh
CMD ["-c"]
ARG CRUSHFTP_VERSION=11.2.3
ENV ADMIN_USER=crushadmin ADMIN_PASSWORD= WEB_PROTOCOL=http WEB_PORT=8080 SOURCE_ZIP=/tmp/crushftp.zip CRUSHFTP_VERSION=11.2.3
HEALTHCHECK --interval=1m --timeout=3s \
 CMD curl -f ${CRUSH_ADMIN_PROTOCOL}://localhost:${CRUSH_ADMIN_PORT}/favivon.ico -H 'Connection: close' || exit 1
ENV CRUSH_ADMIN_PROTOCOL=http
ENV CRUSH_ADMIN_PORT=8080
EXPOSE 21/tcp 2222/tcp 443/tcp 8080/tcp