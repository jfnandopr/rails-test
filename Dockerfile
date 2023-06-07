ARG RUBY_VERSION=amd64/ruby:3.1.1-alpine

# builder
FROM $RUBY_VERSION AS builder
RUN apk add \
  build-base \
  postgresql-dev
COPY Gemfile Gemfile.lock ./
RUN bundle install

# runner
FROM $RUBY_VERSION AS runner
RUN apk add \
    tzdata \
    nodejs \
    postgresql-dev
WORKDIR /app
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY . .
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
