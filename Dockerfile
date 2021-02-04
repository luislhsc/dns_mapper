FROM ruby:3.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /dns_mapper
COPY Gemfile /dns_mapper/Gemfile
COPY Gemfile.lock /dns_mapper/Gemfile.lock
RUN bundle install
COPY . /dns_mapper

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
