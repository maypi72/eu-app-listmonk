# Etapa 1: build
FROM golang:1.26 AS builder

WORKDIR /app

# Copiamos todo el repo (porque hemos cambiado la estructura y no tenemos carpeta listmonk/)
COPY . .

RUN go mod download
RUN go build -o listmonk ./cmd/listmonk

# Etapa 2: runtime
FROM debian:stable-slim

WORKDIR /app

COPY --from=builder /app/listmonk /app/listmonk
COPY --from=builder /app/config.toml /app/config.toml

EXPOSE 9000

CMD ["/app/listmonk"]
