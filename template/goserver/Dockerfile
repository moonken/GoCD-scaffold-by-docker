FROM registry.docker-cn.com/gocd/gocd-server:v18.3.0
COPY --chown=go:go .ssh /home/go/.ssh
COPY --chown=go:go ./passwd /go-server/passwd
COPY --chown=go:go scripts/. /docker-entrypoint.d
