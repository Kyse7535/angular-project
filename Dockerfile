FROM php:8.1.1-fpm-alpine
ARG USERNAME
ARG UID
ARG EMAIL
ARG NAME

RUN echo "==============================="
RUN echo "$USERNAME ($UID)"
RUN echo "$NAME ($EMAIL)"
RUN echo "==============================="

# installation bash
RUN apk --no-cache update && apk --no-cache add bash git && apk --no-cache add npm && apk --no-cache add nodejs\
&& git config --global user.email $EMAIL \
&& git config --global user.name  $NAME

# installation de composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php composer-setup.php --install-dir=/usr/local/bin \
&& php -r "unlink('composer-setup.php');"

# installation de symfony
RUN wget https://get.symfony.com/cli/installer -O - | bash \
&& mv /root/.symfony/bin/symfony /usr/local/bin/symfony

# installation de Angular
RUN npm install -g typescript  && npm install -g @angular/cli

# gestion utilisateur
RUN adduser -h /home/$USERNAME -D -s /bin/bash -u $UID $USERNAME
USER $USERNAME

WORKDIR /var/www/html