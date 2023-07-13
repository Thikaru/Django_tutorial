FROM python:3.9
ENV PYTHONUNBUFFERED 1

RUN mkdir /code
RUN mkdir /code/backend

# Install Node.js and Yarn
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    yarn \
    nodejs \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /code/backend

ADD /backend /code/backend/

RUN pip install -r requirements.txt
# RUN cd node && yarn install