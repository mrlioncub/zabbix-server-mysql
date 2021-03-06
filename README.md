# zabbix-server-mysql
[![Build Status](https://img.shields.io/docker/cloud/build/idscan/zabbix-server-mysql)](https://hub.docker.com/r/idscan/zabbix-server-mysql)
[![Docker Automated build](https://img.shields.io/docker/cloud/automated/idscan/zabbix-server-mysql)](https://hub.docker.com/r/idscan/zabbix-server-mysql)
[![Docker Image Size](https://img.shields.io/docker/image-size/idscan/zabbix-server-mysql)](https://hub.docker.com/r/idscan/zabbix-server-mysql)

Zabbix server uses MySQL database with Microsoft ODBC driver for SQL Server on Alpine docker images

## Uses

  * Official docker image Zabbix server (MySQL) 5.0
  * Microsoft ODBC driver for SQL Server 17

## Test

 1. Run Zabbix Server with this image idscan/zabbix-server-mysql
 2. Check ODBC Driver:
```bash
docker exec _container_name_ odbcinst -q -d -n "ODBC Driver 17 for SQL Server"
```
Result:
```
[ODBC Driver 17 for SQL Server]
Description=Microsoft ODBC Driver 17 for SQL Server
Driver=/opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.6.so.1.1
UsageCount=1
```
 3. Create odbc.ini:
```
[mssql-test]
Description = MS SQL test
Driver = ODBC Driver 17 for SQL Server
Server = tcp:192.168.100.100,1433
```
 4. [Mount](https://docs.docker.com/storage/bind-mounts/) our odbc.ini in docker _container_name_ (recreate container with -v|--mount or with volume in compose):
```
-v /path/our/odbc.ini:/etc/odbc.ini:ro
```
 5. Check DSN:
```bash
docker exec _container_name_ odbcinst -q -s -n
```
Result our DSN name:
```
[mssql-test]
```
and show our DSN mssql-test:
```bash
docker exec _container_name_ odbcinst -q -s -n mssql-test
```
Result will show the contents of our odbc.ini:
```
[mssql-test]
Description = MS SQL test
Driver = ODBC Driver 17 for SQL Server
Server = tcp:192.168.100.100,1433

```
 6. Check connect:
```bash
docker exec _container_name_ isql mssql sqluser sqlpassword
```
Result:
```
+---------------------------------------+
| Connected!                            |
|                                       |
| sql-statement                         |
| help [tablename]                      |
| quit                                  |
|                                       |
+---------------------------------------+
SQL>
```

## SQL query
Create login & grant permission for zabbix:
```sql
CREATE LOGIN zabbixlogin WITH PASSWORD='*Password*';
GRANT VIEW SERVER STATE TO zabbixlogin;
GRANT VIEW ANY DEFINITION TO zabbixlogin;
```
