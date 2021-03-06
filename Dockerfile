#########################
### build environment ###
#########################

# base image
FROM node:10.16.0-jessie as builder

# install chrome for protractor tests
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -yq google-chrome-stable

# set working directory
RUN mkdir /usr/src/app
WORKDIR /usr/src/app

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json /usr/src/app/package.json
RUN npm install --production
RUN npm install -g @angular/cli --unsafe
RUN npm install @angular-devkit/build-angular --save-dev

# add app
COPY . /usr/src/app

# generate build
RUN npm run build

##################
### production ###
##################

# base image
FROM nginx:stable

# copy artifact build from the 'build environment'
COPY --from=builder /usr/src/app/dist/try-angular-cypress /usr/share/nginx/html

# expose port 80
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]
