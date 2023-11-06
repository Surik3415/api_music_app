# Use the Ruby image as the base image
FROM ruby:3.2.2

WORKDIR /app

COPY . .
RUN bundle install 

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]