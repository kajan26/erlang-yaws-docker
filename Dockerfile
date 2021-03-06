FROM erlang:22-alpine

RUN apk add --no-cache --virtual .build-deps \
        autoconf \
        automake \
        g++ \
        gawk \
        gcc \
        libtool \
        linux-pam-dev \
        make \
        git \
    && git clone https://github.com/klacke/yaws.git /yaws-src \
    && cd /yaws-src \
    && autoreconf -fi \
    && ./configure --localstatedir=/var --sysconfdir=/etc \
    && make && make install \
    && cd /var \
    && rm -rf /yaws-src \
    && apk del .build-deps

CMD yaws -i
