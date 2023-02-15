FROM zabbix/zabbix-server-mysql:alpine-6.0.13

LABEL maintainer="mr.lioncub" \
      link1="https://github.com/zabbix/zabbix-docker/tree/6.0/server-mysql/alpine" \
      link2="https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server"

USER root

RUN set -x \
  && tempDir="$(mktemp -d)" \
  && chown nobody:nobody $tempDir \
  && cd $tempDir \
  && wget https://download.microsoft.com/download/8/6/8/868e5fc4-7bfe-494d-8f9d-115cbcdb52ae/msodbcsql18_18.1.2.1-1_amd64.apk \
  && wget https://download.microsoft.com/download/8/6/8/868e5fc4-7bfe-494d-8f9d-115cbcdb52ae/mssql-tools18_18.1.1.1-1_amd64.apk \
  && apk add --allow-untrusted msodbcsql18_18.1.1.1-1_amd64.apk \
  && apk add --allow-untrusted mssql-tools18_18.1.1.1-1_amd64.apk \
  && apk add coreutils \
  && rm -rf $tempDir \
  && rm -rf /var/cache/apk/*

USER 1997
