FROM alpine/git:latest

COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache bash
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["bash /entrypoint.sh"]
