RELX_REPLACE_OS_VARS ?= true
{{name_upper}}_VMARGS_SNAME ?= {{name}}
{{name_upper}}_VMARGS_COOKIE ?= {{name}}
{{name_upper}}_VMARGS_LIMIT_ETS ?= 1024
{{name_upper}}_VMARGS_LIMIT_PROCESSES ?= 100000
{{name_upper}}_VMARGS_LIMIT_PORTS ?= 10000
{{name_upper}}_VMARGS_LIMIT_ATOMS ?= 100000
{{name_upper}}_VMARGS_ASYNC_THREADS ?= 8
{{name_upper}}_VMARGS_KERNEL_POLL ?= true
{{name_upper}}_APP_LOGGER_LOG_ROOT ?= $({{name_upper}}_DIR_LOGS)
{{name_upper}}_APP_LOGGER_LOG_LEVEL ?= debug

{{name_upper}}_APP_ ?= value
