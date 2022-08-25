FROM gprolog AS gprolog-cx
MAINTAINER "spa@debian.org"

ENV SRC=/usr/src
ENV PKG=gprolog

ENV STD=/usr/lib/${PKG}-iso/bin
ENV CX=/usr/lib/${PKG}-cx/bin

ENV PATH=/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${CX}

ENV WORKDIR=/root/code
WORKDIR ${WORKDIR}

# -----------------------------------------------------------------------------

RUN echo "## Configure and make Contexts branch" \
    && cd ${SRC}/${PKG}/src \
    && git checkout contexts \
    && make distclean \
    && ./configure --prefix=/usr/lib/gprolog-cx \
    && for DIR in Pl2wam EnginePl Wam2Ma EngineFD Ma2asm TopComp; do \
         make -C ${DIR}; done \
    && rm -fv */*.a \
    && make \
    && make install-system install-links

CMD gplc
CMD gprolog-cx
