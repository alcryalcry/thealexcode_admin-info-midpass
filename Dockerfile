FROM node:14
# Installing libvips-dev for sharp Compatability
RUN apt-get update && apt-get install -y libvips-dev
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
WORKDIR /opt/
COPY ./package.json ./yarn.lock ./
ENV PATH /opt/node_modules/.bin:$PATH
RUN yarn config set network-timeout 600000 -g && yarn install
WORKDIR /opt/app
COPY ./ .
RUN yarn build
EXPOSE 1339
CMD ["yarn", "start"]