FROM ruby:2.6.5-slim

RUN apt-get update && \
    apt-get install -y build-essential libpq-dev && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app
ENTRYPOINT ["./entrypoint.sh"]
