#########################################
#        Build Flutter Web              #
# Base : Debian (Linux)                 #
#########################################
FROM debian:latest AS build

# Installation des dépendances
RUN apt-get update
RUN apt-get install -y curl git unzip

#########################################
#        Flutter SDK                    #
#########################################

# Version Flutter (Stable = derniere version stable)
ARG FLUTTER_VERSION=stable

# Destination du SDK
ENV FLUTTER_SDK=/usr/local/flutter

# Destination du projet
ENV APP=/app

# Installation du SDK
RUN git clone -b $FLUTTER_VERSION https://github.com/flutter/flutter.git $FLUTTER_SDK
ENV PATH="$FLUTTER_SDK/bin:$FLUTTER_SDK/bin/cache/dart-sdk/bin:${PATH}"
ENV TAR_OPTIONS="--no-same-owner"
RUN flutter doctor -v
RUN mkdir $APP

# Récupération des sources
COPY ./ $APP

# Installation gloable des dépendances
WORKDIR $APP
RUN flutter clean
RUN flutter pub get

# Build spécifique application
WORKDIR $APP/app
RUN flutter build web -t lib/main.dart --release

# Serveur web
FROM nginx:alpine AS release

# health-check
HEALTHCHECK --interval=60s --timeout=5s CMD \
    wget -qO- http://127.0.0.1:80/healthz || exit 1

# Fichiers HTML/JS/CSS
COPY --from=build /app/app/build/web /usr/share/nginx/html

# Configuration spécifique NGINX (SPA)
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Ports exposés
EXPOSE 80 443

# Lancement du serveur
CMD ["nginx", "-g", "daemon off;"]
