FROM debian AS gprolog
MAINTAINER "spa@debian.org"

ENV SRC=/usr/src
ENV PKG=gprolog

ENV STD=/usr/lib/${PKG}-iso/bin
ENV CX=/usr/lib/${PKG}-cx/bin

ENV PATH=/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${STD}

ENV WORKDIR=/root/code
WORKDIR ${WORKDIR}

# -----------------------------------------------------------------------------

RUN echo "## Update and install packages" \
    && apt-get -y update \
    && apt-get install -y --no-install-recommends \
        binutils \
        build-essential \
        ca-certificates \
        file \
        git \
        autoconf \
        gcc \
    && apt-get clean \
    && echo "## Done" \
    && mkdir -p ${SRC}

# -- Clone from the github repo -----------------------------------------------

RUN echo "## Clone git repo" \
    && cd ${SRC} \
    && git clone https://github.com/didoudiaz/gprolog ${PKG}

RUN echo "## Configure and make GNU Prolog" \
    && cd ${SRC}/${PKG}/src \
    && git checkout master \
    && ./configure --prefix=/usr/lib/gprolog-iso \
    && make \
    && make install-system install-links

CMD gprolog
