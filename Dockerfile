FROM golang:1.16 as builder
WORKDIR /build
COPY . .
RUN make build

FROM alpine:3.14
RUN apk --update --no-cache upgrade && \
    apk add --no-cache ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/cache/apk/*
COPY --from=builder /build/dist/kube-consul-register /
WORKDIR /

ENTRYPOINT ["/kube-consul-register"]
