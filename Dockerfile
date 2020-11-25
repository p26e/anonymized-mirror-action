FROM alpine/git:latest

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["bash /entrypoint.sh"]
