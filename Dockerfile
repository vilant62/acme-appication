FROM alpine:3.21

ARG APP_VERSION=1.0.0

ENV VERSION=${APP_VERSION}

WORKDIR /usr/src/app

COPY --chmod=+x ./bin/eVision-product-ops.linux.${VERSION} ./eVision

EXPOSE 8080

CMD [ "./eVision" ]
