#use ruby 2.7.1 from docker hub as the base image
FROM ruby:2.7.4-alpine

#use or create a folder by the name below to store project files
WORKDIR /contacts-api

# copy all the applications to contacts-api
COPY . /contacts-api



#
RUN apk -U add --no-cache build-base git  postgresql-dev postgresql-client libxml2-dev \
tzdata && rm -rf /var/cache/apk/*

# copy all the applications to contacts-api

COPY Gemfile Gemfile.lock ./

RUN gem install bundler --version "$BUNDLE_VERSION" \
&& rm -rf $GEM_HOME/cache/*

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle check || bundle install

RUN adduser --disabled-password --gecos '' smeez

LABEL maintainer="mikel-codes" version="1.0.0" name="smeez"
EXPOSE 3000



#CMD [ "rails", "server", "-b", "0.0.0.0"]
