FROM debian:forky AS build-essential

RUN set -eux; \
  apt-get update; \
  apt-get upgrade -y; \
  apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    checkinstall \
    cmake \
  ;

FROM build-essential AS build-pgdev

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    postgresql-server-dev-18 \
  ;

# =============================================================================
# pgRouting
#
FROM build-pgdev AS pgrouting

ARG pgrouting_release=3.8.0

ADD "https://github.com/pgRouting/pgrouting/releases/download/v${pgrouting_release}/pgrouting-${pgrouting_release}.tar.gz" \
  /tmp/pgrouting.tar.gz

RUN set -eux; \
  tar -xvf /tmp/pgrouting.tar.gz -C /tmp; \
  rm -rf /tmp/pgrouting.tar.gz;

# Installer les dépendances de compilation
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    libboost-all-dev \
  ;

WORKDIR /tmp/pgrouting-${pgrouting_release}/build
RUN cmake -DBUILD_HTML=OFF -DBUILD_DOXY=OFF ..

# Create debian package
RUN checkinstall -D --install=no --fstrans=no --backup=no --pakdir=/tmp \
  --pkgname=pgrouting --pkgversion=${pgrouting_release} \
  --nodoc

# =============================================================================
# TimescaleDB

FROM build-pgdev AS timescaledb

ARG timescaledb_release=2.23.1

# Download and extract
ADD "https://github.com/timescale/timescaledb/archive/refs/tags/${timescaledb_release}.tar.gz" \
  /tmp/timescaledb.tar.gz

RUN set -eux; \
  tar -xvf /tmp/timescaledb.tar.gz -C /tmp; \
  rm -rf /tmp/timescaledb.tar.gz;

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    libkrb5-dev \
  ;

# Build from source
WORKDIR /tmp/timescaledb-${timescaledb_release}
RUN ./bootstrap

WORKDIR /tmp/timescaledb-${timescaledb_release}/build
RUN make -j$(nproc)

# Create debian package
RUN checkinstall -D --install=no --fstrans=no --backup=no --pakdir=/tmp \
  --pkgname=timescaledb --pkgversion=${timescaledb_release} \
  --nodoc

# =============================================================================
# Étape 3 : image finale PostgreSQL propre
#
FROM postgres:18-trixie

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
  locales; \
  apt-get clean; \
  sed -i '/fr_FR.UTF-8/s/^# //' /etc/locale.gen; \
  locale-gen;

ENV TZ=Europe/Paris
ENV LANG=fr_FR.UTF-8
ENV LANGUAGE=fr_FR:fr
ENV LC_ALL=fr_FR.UTF-8

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
  # ca-certificates: for accessing remote raster files;
  #   fix: https://github.com/postgis/docker-postgis/issues/307
    ca-certificates \
    postgresql-postgis;

RUN set -eux; \
  apt-get install -y --no-install-recommends \
    postgresql-18-cron \
    postgresql-18-pgvector \
    postgresql-18-pgtap \
    postgresql-18-pglogical \
    postgresql-18-mobilitydb; \
  rm -rf /var/lib/apt/lists/*

# Copier uniquement les fichiers installés depuis le builder
COPY --from=pgrouting /tmp/*.deb /tmp
COPY --from=timescaledb /tmp/*.deb /tmp

ADD https://gitlab.com/dalibo/postgresql_anonymizer/-/package_files/248481847/download /tmp/postgresql_anonymizer_pg18-2.5.1.amd64.deb

RUN set -eux; \
  apt-get install \
  /tmp/*.deb \
  -y; \
  rm /tmp/*.deb;

CMD ["postgres", "-c", "shared_preload_libraries=pg_cron,timescaledb", "-c", "cron.database_name=iut"]
