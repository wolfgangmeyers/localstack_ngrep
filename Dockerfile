FROM localstack/localstack

RUN apk update && apk add ngrep
