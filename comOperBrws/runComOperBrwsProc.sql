set serveroutput on size unlimited;
DECLARE
  v_value   VARCHAR2(32000);
BEGIN
  dbms_output.enable;
  D53.LOAD_COM_OPERBRWS(v_value);
  dbms_output.put_line(v_value);
END;
/
exit;
