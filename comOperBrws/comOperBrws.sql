SET FEEDBACK ON
SET PAGESIZE 120
SET SPACE 1
SET HEADSEP OFF
SET LINESIZE 1000
SET HEADING ON
SET TERMOUT ON

column comp_name heading "Company Name" format a40;
column city heading "City" format a20;
column state heading "ST" format a2;
column date_modified heading "Date Modified" format a15;

SPOOL /home/oracle/scripts/comOperBrws/comOperBrws_EXTRACT.txt
/*
select comp_name,city,state,date_modified
       from com_operbrws
           where date_modified  is NOT NULL
           order by date_modified desc;
*/
SELECT comp_name,city,state,date_modified
       FROM       com_operbrws
           WHERE date_modified  is NOT NULL
             and ((date_modified = TO_DATE(SYSDATE-1))   /*Yesterday*/
               or (date_modified = TO_DATE(SYSDATE-3))   /*Friday?*/
               or (date_modified = TO_DATE(SYSDATE-4))   /*Three Day Weekend?*/
               or (date_modified = TO_DATE(SYSDATE-5)))  /*Thanksgiving or Christmas?*/
           ORDER BY date_modified DESC, state ASC, city ASC, comp_name ASC;
SPOOL OFF;
EXIT

