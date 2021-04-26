FROM elixir:1.11-alpine

WORKDIR /application

COPY docker-entrypoint.sh /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/docker-entrypoint.sh"]

RUN addgroup -g 1000 -S local && \
    adduser -u 1000 -S local -G local

USER local

EXPOSE 4000

ENTRYPOINT ["/bin/sh", "/usr/local/bin/docker-entrypoint.sh"]