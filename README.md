# Overview

Docker image to extend the stock PostgreSQL image with Oracle database client
libraries and Foreign Data Wrapper support. The image also includes PostGIS
extensions.

## Instructions

To update the image, modify the download URLs for the following external resources:

- `instantclient-basic-linux.x64-19.31.0.0.0dbru.zip`: <https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html>
- `instantclient-sdk-linux.x64-19.31.0.0.0dbru.zip`: <https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html>
- `ORACLE_FDW_2_8_0.zip`: <https://github.com/laurenz/oracle_fdw/releases/>

Modify the lines setting `ORACLE_HOME` and `LD_LIBRARY_PATH`, as well as the location for `ORACLE_FDW`.

Build the image like so:

```console
docker image build --tag ghcr.io/dbca-wa/postgres-oracle-fdw .
```
