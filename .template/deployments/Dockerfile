FROM golang:1.15-buster AS build

WORKDIR /app

COPY ./go.mod ./
COPY ./go.sum ./
RUN go mod tidy && go mod download
COPY ./ ./
RUN go build ../cmd/server/main.go -o ./app
RUN ls

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /app/.env /app/.env
COPY --from=build /app/app /app/app

EXPOSE 4040

ENTRYPOINT ["/app/app"]