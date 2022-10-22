#################
# Build the app #
#################
FROM node:16-alpine AS build
WORKDIR /usr/local/app
COPY ./ /usr/local/app/
RUN npm install
RUN npm run build --prod

################
# Run in NGINX #
################
FROM nginx:alpine
COPY --from=build /usr/local/app/dist/crudtuto-front /usr/share/nginx/html

EXPOSE 80

# When the container starts, replace the env.js with values from environment variables
#CMD ["/bin/sh",  "-c",  "envsubst < /usr/share/nginx/html/assets/env.template.js > /usr/share/nginx/html/assets/env.js && exec nginx -g 'daemon off;'"]
