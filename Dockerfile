FROM zabbix/zabbix-server-mysql:alpine-5.0-latest

LABEL maintainer="mr.lioncub" \
      release-date="2020–08–16" \
      link1="https://github.com/zabbix/zabbix-docker/tree/5.0/server-mysql/alpine" \
      link2="https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server"

USER root

RUN set -x \
  && tempDir="$(mktemp -d)" \
  && chown nobody:nobody $tempDir \
  && cd $tempDir \
  && wget "https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.6.1.1-1_amd64.apk" \
  && wget "https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/mssql-tools_17.6.1.1-1_amd64.apk" \
  && apk add --allow-untrusted msodbcsql17_17.6.1.1-1_amd64.apk \
  && apk add --allow-untrusted mssql-tools_17.6.1.1-1_amd64.apk \
  && apk add coreutils \
  && rm -rf $tempDir \
  && rm -rf /var/cache/apk/*

USER 1997
