-include_lib("kernel/include/logger.hrl").

-define(l_debug(Map), ?LOG_DEBUG({{name}}_log:log_map(Map), {{name}}_log:log_meta(Map))).
-define(l_info(Map), ?LOG_INFO({{name}}_log:log_map(Map), {{name}}_log:log_meta(Map))).
-define(l_notice(Map), ?LOG_NOTICE({{name}}_log:log_map(Map), {{name}}_log:log_meta(Map))).
-define(l_warning(Map), ?LOG_WARNING({{name}}_log:log_map(Map), {{name}}_log:log_meta(Map))).
-define(l_error(Map), ?LOG_ERROR({{name}}_log:log_map(Map), {{name}}_log:log_meta(Map))).
-define(l_critical(Map), ?LOG_CRITICAL({{name}}_log:log_map(Map), {{name}}_log:log_meta(Map))).
-define(l_alert(Map), ?LOG_ALERT({{name}}_log:log_map(Map), {{name}}_log:log_meta(Map))).
-define(l_emergency(Map), ?LOG_EMERGENCY({{name}}_log:log_map(Map), {{name}}_log:log_meta(Map))).
