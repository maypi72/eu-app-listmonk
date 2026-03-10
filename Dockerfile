# Etapa 1: build
FROM golang:1.26 AS builder

WORKDIR /app
COPY . .

RUN go mod download
RUN go build -o listmonk ./cmd/listmonk

FROM debian:stable-slim
WORKDIR /app

COPY --from=builder /app/listmonk /app/listmonk
COPY --from=builder /app/config.toml /app/config.toml

EXPOSE 9000
CMD ["/app/listmonk"]
