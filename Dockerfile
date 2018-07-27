FROM afian/filerun

ENV APACHE_RUN_USER=mediadepot \
    APACHE_RUN_GROUP=mediadepot

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

