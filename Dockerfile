FROM golang:1.26 as base
WORKDIR /app
#dependencies
COPY go.mod .
#cache
RUN go mod download
COPY . .
RUN go build -o main .

#final stage with distroless image
FROM gcr.io/distroless/base
COPY --from=base /app/main .
COPY --from=base /app/static ./static
EXPOSE 8080
CMD [ "./main" ]


