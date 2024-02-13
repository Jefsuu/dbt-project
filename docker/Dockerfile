FROM docker.io/bitnami/postgresql:16 as postgresql

USER root
RUN apt-get update && apt-get upgrade -y && \
    apt-get install ruby-full -y && \
    apt-get install wget -y && \
    apt-get install unzip

USER 1001
RUN mkdir -p /bitnami/postgresql/downloads && \
    cd /bitnami/postgresql/downloads && \
    wget -O AdventureWorks-oltp-install-script.zip https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks-oltp-install-script.zip && \
    mkdir -p AdventureWorks && \
    unzip -o AdventureWorks-oltp-install-script.zip -d AdventureWorks && \
    cd AdventureWorks && \
    wget -O install.sql https://raw.githubusercontent.com/lorint/AdventureWorks-for-Postgres/master/install.sql && \
    wget -O update_csvs.rb https://raw.githubusercontent.com/lorint/AdventureWorks-for-Postgres/master/update_csvs.rb && \
    ruby update_csvs.rb
