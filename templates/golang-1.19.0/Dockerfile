FROM golang:1.19.0 as dev
WORKDIR /app

FROM dev as build
WORKDIR /app
COPY . /app
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /app/application-golang

FROM alpine:3.16.2 as prod
WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /app
USER appuser

COPY --from=build /app/application-golang /app/application-golang
CMD ["/app/application-golang"]
HEALTHCHECK --interval=10s --timeout=3s CMD curl -f http://localhost:8080/ || exit 1
