################################################################

################################################################
# use a base image with nodejs and name it
# -> gives us the npm command
FROM node:10.15.3 AS BUILDER

# make a dir, add project and set as working dir (use .dockerignore)
RUN mkdir /kcgitdemo
COPY . /kcgitdemo
WORKDIR /kcgitdemo

# install angular cli -> gives us the ng command
RUN npm install @angular/cli -g

# install project dependencies and build the project
RUN npm install
RUN ng build --prod

################################################################
# use a base system with a webserver
FROM nginx:1.15.8-alpine

# add build artefact from BUILDER to the web dir
COPY --from=BUILDER /kcgitdemo/dist/KcGitDemo/ /usr/share/nginx/html
