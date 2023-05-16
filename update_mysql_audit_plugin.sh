sed '/Security_context *\*sctx *= *thd->security_context();/a\
  event.general_database = thd->db();\
  event.general_examined_row_count = thd->get_examined_row_count();\
  if (thd->get_row_count_func() < 0) {\
    event.general_affected_row_count = 0;\
  } else {\
    event.general_affected_row_count = thd->get_row_count_func();\
  }\
  event.general_return_row_count = thd->get_sent_row_count();
' sql/sql_audit.cc > tmpfile && mv tmpfile sql/sql_audit.cc

sed '/MYSQL_LEX_CSTRING *general_ip;/a\
  MYSQL_LEX_CSTRING general_database;\
  unsigned long long general_examined_row_count;\
  unsigned long long general_affected_row_count;\
  unsigned long long general_return_row_count;
' include/mysql/plugin_audit.h > tmpfile && mv tmpfile include/mysql/plugin_audit.h

sed '/MYSQL_LEX_CSTRING *general_ip;/a\
  MYSQL_LEX_CSTRING general_database;\
  unsigned long long general_examined_row_count;\
  unsigned long long general_affected_row_count;\
  unsigned long long general_return_row_count;
' include/mysql/plugin_audit.h.pp > tmpfile && mv tmpfile include/mysql/plugin_audit.h.pp
