## Build
FROM golang:1.19-buster as build

WORKDIR /go/src

COPY ./ /go/src

RUN go mod download && \
    go build -o /go/bin/go-healthcheck

## Deploy
FROM gcr.io/distroless/base-debian11

COPY --from=build /go/bin/go-healthcheck /go-healthcheck

EXPOSE 8000

ENTRYPOINT ["/go-healthcheck"]