FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
RUN gem install bundler && bundle install --jobs 20 --retry 5
ADD . /myapp
CMD /myapp/bin/rails s -b 0.0.0.0
EXPOSE 3000
