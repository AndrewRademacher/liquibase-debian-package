#!/bin/bash

LIQUIBASE_VERSION=3.5.5
PG_JDBC_VERSION=42.2.4

mkdir -p build/download
(cd ./build/download && wget https://github.com/liquibase/liquibase/releases/download/liquibase-parent-${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}-bin.tar.gz)

mkdir -p build/pkg/usr/lib/liquibase
tar xvf ./build/download/liquibase-${LIQUIBASE_VERSION}-bin.tar.gz -C ./build/pkg/usr/lib/liquibase

# Additional Drivers
(cd ./build/pkg/usr/lib/liquibase/lib && wget https://jdbc.postgresql.org/download/postgresql-${PG_JDBC_VERSION}.jar)

# Symlinking
mkdir -p build/pkg/usr/bin
(cd ./build/pkg/usr/bin && ln -s /usr/lib/liquibase/liquibase liquibase)

# Packaging
cp -R DEBIAN build/pkg
dpkg -b build/pkg/ build/liquibase_3.5.5.deb