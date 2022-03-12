FROM telemark/docker-node-unoconv:10.20.1

WORKDIR /app
COPY . .

ENV HOSTNAME 0.0.0.0
ENV PORT 4000
RUN yarn && yarn cache clean

ARG uid=687

RUN groupadd --gid ${uid} -r app \
 && useradd --uid ${uid} -r -g app -M app \
 && yarn \
 && yarn cache clean \
 && chown app:app /app \
 && chown app:app /home

USER ${uid}
EXPOSE 4000

CMD ["start"]

ENTRYPOINT ["./unoconv-server"]
