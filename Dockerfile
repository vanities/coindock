# builder stage
FROM ubuntu:18.04 as builder

ARG VERSION
ENV VERSION ${VERSION}

ARG CHECKSUM
ENV CHECKSUM ${CHECKSUM}

RUN set -ex && \
    apt-get update && \
    apt-get --no-install-recommends --yes install \
      wget

RUN wget https://downloads.getmonero.org/cli/linux64 --no-check-certificate && \
    tar xvf linux64 && \
    mv monero-x86_64-linux-gnu-$VERSION /monero

RUN echo "$CHECKSUM linux64" | sha256sum -c - || exit 1

FROM ubuntu:18.04

COPY --from=builder /monero /monero

# Create monero user
RUN adduser --system --group --disabled-password monero && \
	mkdir -p /wallet /home/monero/.bitmonero && \
	chown -R monero:monero /home/monero/.bitmonero && \
	chown -R monero:monero /wallet

# switch to user monero
USER monero
