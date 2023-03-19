FROM erlang:25-slim
LABEL maintainer="{{author_name}} <{{author_email}}>"

# Installing required tools
RUN apt-get update -y && apt-get install -y bash make gcc g++ git curl lsof netcat nano
RUN mkdir -p /tmp

# Running build
COPY . src
RUN rm -rf src/_build src/log/*
RUN cd src && make release-prod

# Copying release
RUN mkdir -p /opt/
RUN mkdir -p /tmp/erl_pipes/
RUN cp -R src/_build/prod/rel/{{name}} /opt/.
RUN mkdir -p /var/log/{{name}}/

# Cleanup
RUN rm -rf src

# Environment
ENV PATH="/opt/{{name}}/bin:$PATH"
ENV RELX_REPLACE_OS_VARS=true
# VMARGS
ENV {{name_upper}}_VMARGS_SNAME={{name}}
ENV {{name_upper}}_VMARGS_COOKIE={{name}}-cookie
ENV {{name_upper}}_VMARGS_LIMIT_ETS=1024
ENV {{name_upper}}_VMARGS_LIMIT_PROCESSES=64535
ENV {{name_upper}}_VMARGS_LIMIT_PORTS=1024
ENV {{name_upper}}_VMARGS_LIMIT_ATOMS=1048576
ENV {{name_upper}}_VMARGS_ASYNC_THREADS=8
ENV {{name_upper}}_VMARGS_KERNEL_POLL=true
# Configuration
ENV {{name_upper}}_APP_LOGGER_LOG_ROOT=/var/log/{{name}}/
ENV {{name_upper}}_APP_LOGGER_LOG_LEVEL=debug

## App-specific options
ENV {{name_upper}}_APP_=value

# Runtime
EXPOSE ${{{name_upper}}_APP_}
HEALTHCHECK --interval=10s --timeout=5s --start-period=1m --retries=5 CMD ["{{name}}", "help"]
ENTRYPOINT ["{{name}}"]
CMD ["foreground"]
