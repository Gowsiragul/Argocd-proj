FROM golang: 1.23 as base

WORKDIR /app

COPY go.mod    #depency

RUN go mod download

COPY . .

RUN go build -o main

#find stage -Distroless image

FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD [" ./main "]
