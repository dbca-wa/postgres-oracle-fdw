FROM busybox AS builder_base
COPY libs/ /tmp
RUN for file in `ls /tmp/*.zip`; do unzip -o $file -d /opt/; done

##################################################################################
FROM postgis/postgis:16-3.5
LABEL org.opencontainers.image.authors=asi@dbca.wa.gov.au
LABEL org.opencontainers.image.source=https://github.com/dbca-wa/postgres-oracle-fdw

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends apt-utils libaio1 libaio-dev build-essential make postgresql-server-dev-16 \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder_base /opt /opt
ENV ORACLE_HOME=/opt/instantclient_19_26
ENV LD_LIBRARY_PATH=/opt/instantclient_19_26
RUN cd /opt/oracle_fdw-ORACLE_FDW_2_7_0 \
  && make PG_CONFIG=/usr/bin/pg_config \
  && make install

USER postgres
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 5432
CMD ["postgres"]
