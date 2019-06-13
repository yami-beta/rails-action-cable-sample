FROM ruby:2.6

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get update -qq && \
    apt-get install -y build-essential nodejs

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . /app

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
