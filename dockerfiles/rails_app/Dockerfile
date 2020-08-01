FROM ruby:2.6.6
RUN mkdir /webapp
WORKDIR /webapp

#install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list
RUN  apt update &&  apt install yarn -y

#install gems and npm dependencies
RUN gem install bundler
ADD Gemfile .
ADD Gemfile.lock .
# RUN bundle install --without development test
RUN bundle config set without 'development test'
RUN bundle install

#add app to container
ADD . /webapp

# precomplie assets, these get synced over to the nginx container in a post container command
RUN yarn install --check-files
RUN rails assets:precompile

#run migrations
RUN rails db:migrate
# RUN rails db:seed

#fix openshift permissions
RUN chgrp -R 0 /webapp \
  && chmod -R g+rwX /webapp



EXPOSE 3000
CMD rails s