ARG BUILD_DIR=/build

FROM mikrosk/m68k-atari-mint-base:master as base
RUN apt -y update
RUN apt -y install make wget subversion

WORKDIR /src
COPY build.sh .

# renew the arguments
ARG BUILD_DIR

ENV LDG_BRANCH		    trunk
ENV LDG_URL		        https://svn.code.sf.net/p/ldg/code/${LDG_BRANCH}/ldg
ENV LDG_FOLDER          ldg-${LDG_BRANCH}
RUN svn export ${LDG_URL} ${LDG_FOLDER}

RUN cd ${LDG_FOLDER} \
    && ../build.sh ${BUILD_DIR}

FROM scratch

# renew the arguments
ARG BUILD_DIR

COPY --from=base ${BUILD_DIR} /
