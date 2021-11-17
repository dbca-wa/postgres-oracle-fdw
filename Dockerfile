FROM postgres:14.1
MAINTAINER asi@dbca.wa.gov.au
LABEL org.opencontainers.image.source https://github.com/dbca-wa/postgres-oracle-fdw

RUN apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends apt-utils libaio1 libaio-dev build-essential make unzip postgresql-server-dev-all postgresql-common \
  && rm -rf /var/lib/apt/lists/*

COPY libs\ /tmp
RUN unzip "/tmp/*.zip" -d /tmp
ENV ORACLE_HOME /tmp/instantclient_19_13
ENV LD_LIBRARY_PATH /tmp/instantclient_19_13
RUN cd /tmp/oracle_fdw-ORACLE_FDW_2_4_0 \
  && make \
  && make install

USER postgres
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 5432
CMD ["postgres"]
