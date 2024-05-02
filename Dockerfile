FROM golang:1.22-alpine as builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download && go mod tidy
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main .
FROM scratch
COPY --from=builder /main /main
EXPOSE 8080
CMD ["/main"]
