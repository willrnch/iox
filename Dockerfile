###############################################

FROM ubuntu:22.04 as builder

RUN apt update -y
RUN apt install -y build-essential curl git protobuf-compiler clang lld

# Disable incremental compilation to avoid overhead. We are not preserving these files anyway.
ENV CARGO_INCREMENTAL="0"
# Disable full debug symbol generation to speed up CI build
# "1" means line tables only, which is useful for panic tracebacks.
ENV CARGO_PROFILE_DEV_DEBUG="1"

# https://github.com/rust-lang/cargo/issues/10280
ENV CARGO_NET_GIT_FETCH_WITH_CLI="true"

# Building job will be killed in docker for using to much ram.
# By using only one job, we limit the ram usage.
# ENV CARGO_BUILD_JOBS="1"

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

COPY influxdb_iox /influxdb_iox

WORKDIR /influxdb_iox

ARG COMMIT_HASH
ENV VERSION_HASH="$COMMIT_HASH"

RUN cargo build \
      --package="influxdb_iox" \
      --profile="release" \
      --no-default-features \
      --features="aws,gcp,azure,jemalloc_replacing_malloc"

RUN strip ./target/release/influxdb_iox

###############################################

FROM ubuntu:22.04

COPY --from=builder /influxdb_iox/target/release/influxdb_iox /bin/influxdb_iox

CMD ["influxdb_iox"]
