FROM ruby:2.6.6
RUN mkdir /webapp
WORKDIR /webapp

RUN gem install bundler
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list
RUN apt update &&  apt install yarn -y

ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install
RUN apt install vim -y

ADD yarn.lock .
ADD package.json .
RUN yarn install --check-files

ADD . .
