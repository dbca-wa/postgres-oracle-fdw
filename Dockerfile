# syntax=docker/dockerfile:1
FROM busybox AS builder_base
# Download & unpack external libraries to /opt
WORKDIR /downloads
RUN wget -q --no-check-certificate https://github.com/laurenz/oracle_fdw/archive/refs/tags/ORACLE_FDW_2_8_0.zip\
  && wget -q --no-check-certificate https://download.oracle.com/otn_software/linux/instantclient/1931000/instantclient-basic-linux.x64-19.31.0.0.0dbru.zip \
  && wget -q --no-check-certificate https://download.oracle.com/otn_software/linux/instantclient/1931000/instantclient-sdk-linux.x64-19.31.0.0.0dbru.zip \
  && for file in `ls /downloads/*.zip`; do unzip -q -o $file -d /opt/; done

##################################################################################

FROM postgis/postgis:16-3.5
LABEL org.opencontainers.image.authors=asi@dbca.wa.gov.au
LABEL org.opencontainers.image.source=https://github.com/dbca-wa/postgres-oracle-fdw

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends apt-utils libaio1 libaio-dev build-essential make postgresql-server-dev-16 \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder_base /opt /opt
ENV ORACLE_HOME=/opt/instantclient_19_31
ENV LD_LIBRARY_PATH=/opt/instantclient_19_31
RUN cd /opt/oracle_fdw-ORACLE_FDW_2_8_0 \
  && make PG_CONFIG=/usr/bin/pg_config \
  && make install

USER postgres
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 5432
CMD ["postgres"]
