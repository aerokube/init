FROM scratch

ARG TARGETARCH

COPY init-${TARGETARCH} /sbin/init
