# syntax=docker/dockerfile:experimental
FROM ruby:3.0.2-alpine
# Install node 16-LTS and yarn
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        bash \
        gcc \
        g++ \
        shadow \
        libc-dev \
        libxml2-dev \
        linux-headers \
        make \
        nodejs \
        sqlite-dev \
        tzdata \
        yarn \
        musl-dev \
        less && \
    apk add --virtual build-packs --no-cache \
        build-base \
        curl-dev
# RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN useradd -m -u 1000 rails

RUN apk add --update nodejs npm
RUN npm install -g yarn@1

ENV RAILS_ROOT /var/www/test_app
RUN mkdir -p $RAILS_ROOT && chown rails:rails $RAILS_ROOT

WORKDIR $RAILS_ROOT

COPY ./Gemfile ${RAILS_ROOT}
COPY ./Gemfile.lock ${RAILS_ROOT}

# RUN bundle config set app_config ${RAILS_ROOT}/.bundle
# RUN bundle config set path ${RAILS_ROOT}/.cache/bundle

# RUN --mount=type=cache,uid=1000,target=${RAILS_ROOT}/.cache/bundle bundle install && \
#   mkdir -p vendor && \
#   cp -ar .cache/bundle vendor/bundle

RUN --mount=type=cache,uid=1000
RUN gem install bundler
RUN bundle install

RUN apk del build-packs

COPY ./. ${RAILS_ROOT}
RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids

VOLUME $RAILS_ROOT/public
VOLUME $RAILS_ROOT/tmp

RUN chown -R rails:rails .

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
