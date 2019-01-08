FROM ruby:2.6.0-stretch

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN apt-get update && apt-get install -y nodejs wget postgresql-client-9.6

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz \
    && rm dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz

WORKDIR /usr/src/app

COPY Gemfile ./
COPY Gemfile.lock ./
RUN bundle install

COPY . .
COPY config/database.yml.docker config/database.yml
