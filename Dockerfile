FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -y wget curl netcat cron python

RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
    python get-pip.py && \
    pip install awscli

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main 9.5" >/etc/apt/sources.list.d/postgresql.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update && \
    apt-get install -y postgresql-10 curl && \
    curl https://dl.minio.io/client/mc/release/linux-amd64/mc > /usr/local/bin/mc && \
    chmod +x /usr/local/bin/mc && \ 
    mkdir /backup


ENV CRON_TIME="0 0 * * *" \
    POSTGRES_DB="--all-databases"

ADD restic_app /usr/local/bin/restic
RUN chmod +x /usr/local/bin/restic

ADD run.sh /run.sh
ADD archive.sh /archive.sh
RUN chmod +x /run.sh /archive.sh 
VOLUME ["/backup"]

CMD ["/run.sh"]
# RUN pip install cryptography==2.2.2

