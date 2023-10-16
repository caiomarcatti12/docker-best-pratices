FROM golang:1.21.0-bullseye as dev
WORKDIR /app

FROM dev as build
WORKDIR /app
COPY . /app
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /app/api-cloud-properties-crud

FROM alpine:3.18.3 as prod
WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /app
USER appuser

COPY --from=build /app/api-cloud-properties-crud /app/api-cloud-properties-crud
CMD ["/app/api-cloud-properties-crud"]
HEALTHCHECK --interval=10s --timeout=3s CMD curl -f http://localhost:8080/ || exit 1
