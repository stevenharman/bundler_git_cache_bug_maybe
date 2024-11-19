# syntax=docker/dockerfile:1

FROM ruby:3.3.6

ARG BUNDLER_VERSION=2.5.23

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
COPY vendor/cache/ vendor/cache/

RUN gem install bundler -v ${BUNDLER_VERSION} --no-document && \
    bundle _${BUNDLER_VERSION}_ config set --local deployment "true" && \
    bundle _${BUNDLER_VERSION}_ config set --local path "vendor/bundle" && \
    bundle _${BUNDLER_VERSION}_ check || bundle _${BUNDLER_VERSION}_ install --local --retry=3 && \
    bundle _${BUNDLER_VERSION}_ clean

COPY . .

CMD ["./hello"]
