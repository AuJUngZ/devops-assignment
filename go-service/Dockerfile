FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY . .

RUN go build -o server .

# ------------
FROM scratch

COPY --from=builder /app/server /server

EXPOSE 8080

# Run the binary
ENTRYPOINT ["/server"]
