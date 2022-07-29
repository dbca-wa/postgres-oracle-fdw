# Overview

Docker image to extend the stock PostgreSQL image with Oracle database client
libraries and Foreign Data Wrapper support. The image also includes PostGIS
extensions.

# Instructions

To build the image, download the following files into a `libs` directory in this
repository:

* `instantclient-basic-linux.x64-19.13.0.0.0dbru.zip`: https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
* `instantclient-sdk-linux.x64-19.13.0.0.0dbru.zip`: https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
* `oracle_fdw-ORACLE_FDW_2_4_0.zip`: https://github.com/laurenz/oracle_fdw/releases/tag/ORACLE_FDW_2_4_0

Build the image like so:

```console
docker build --tag ghcr.io/dbca-wa/postgres-oracle-fdw .
```
