-----------------//批量提交insert into select 存储过程-------------------------
create or replace procedure largedata_insert(ip_table_name in varchar2, --目标表
                                          ip_table_column in varchar2, --目标字段
                                          ip_table_select in varchar2, --SELECT 查询语句
                                          return_result   out number --返回的结果1,表示成功，０表示失败
                                          ) as
--适合大数据量的插入模板  create Templates by chenzhoumin 20110614
  runTime number;
  i       number;
  amount  number;
  s_sql   varchar2(5000);
  inu     number; 
begin
  return_result := 0; --开始初始化为0
  --核必逻辑内容，可根据具体的业务逻辑来定义
  s_sql := 'select count(1) from (' || ip_table_select || ')';
  execute immediate s_sql
    into amount;
  --每1000提交一次
  runTime := amount mod 1000;
  if (runTime > 0) then
    runTime := 1 + trunc(amount / 1000);
  end if;
  if (runTime = 0) then
    runTime := 0 + trunc(amount / 1000);
  end if;
  inu :=0;
  FOR i IN 1 .. runTime LOOP
    execute immediate 'insert into ' || ip_table_name || ' (' ||
                      ip_table_column || ')
     select ' || ip_table_column || ' from (select selectSec.*, rownum rownumType
          from (' || ip_table_select ||
                      ') selectSec
         WHERE ROWNUM <= ' || i * 1000 || ')
 WHERE rownumType > ' || (i - 1) * 1000;
    --提交
    commit;
    inu := inu+1;
    DBMS_OUTPUT.PUT_LINE('1000条提交成功');
  END LOOP;
  return_result := 1;
  dbms_output.put_line('结束' || to_char(sysdate, 'yyyymmddhh24miss'));
  return;
exception
  when others then
    return_result := 0;
    raise;
    return;
end;
---------------------//代码转换函数:负责将老系统中的交接代码转换成新系统的交接代码-------------------------------------------
CREATE OR REPLACE FUNCTION transfer_Code (v_transfer_code VARCHAR2)
RETURN VARCHAR2
AS
	return_value VARCHAR2(200);
BEGIN
	CASE v_transfer_code
	WHEN '90219151' THEN  
		return_value := '11';
	WHEN '91519023' THEN  
		return_value := '12';
	WHEN '90239025' THEN  
		return_value := '13';
	WHEN '90249151' THEN  
		return_value := '21';
	WHEN '91519024' THEN  
		return_value := '22';
	WHEN '90249025' THEN  
		return_value := '23';
	WHEN '90219031' THEN  
		return_value := '31';
	WHEN '90259151' THEN  
		return_value := '41';
	WHEN '91519025' THEN  
		return_value := '42';
	WHEN '90259021' THEN  
		return_value := '91';
	WHEN '90239021' THEN  
		return_value := '92';
	WHEN '91519021' THEN  
		return_value := '93';
	WHEN '90219025' THEN  
		return_value := '94';
	WHEN '90259024' THEN
	    return_value := '61';
	ELSE return_value := '';
	END CASE ;
	RETURN return_value;
END transfer_Code ; 


-------------------//部门名称转换：负责通过原系统的部门ID获得新系统的部门名称（紫光原系统）-----------------------------------------------------------
CREATE OR REPLACE FUNCTION get_dept_name (v_dept_id VARCHAR2)
RETURN VARCHAR2
AS
	return_value VARCHAR2(200);
BEGIN
	SELECT NAME_CN INTO return_value FROM ZGXT.SYS_DEPT WHERE ID = v_dept_id;
	RETURN return_value;
END get_dept_name ;

 
-------------------//数据补充函数样例  通过部门ID获取部门名称(breeze 系统)-----------------------------------------
CREATE OR REPLACE FUNCTION query_dept_name (v_dept_id VARCHAR2)
RETURN VARCHAR2
AS
dept_name VARCHAR2(200);
BEGIN
	select CNAME INTO dept_name from pub_organ WHERE ID = v_dept_id;
	RETURN dept_name;
END query_dept_name;


------------------//通过用户id 获取用户姓名---------------
CREATE OR REPLACE FUNCTION get_user_name (user_id VARCHAR2)
RETURN VARCHAR2
AS
	return_value VARCHAR2(200);
BEGIN
	select  name into return_value from zgxt.gos_user where id = user_id;
	RETURN return_value;
END get_user_name ; 


------------------//TRANSFER_INFO 表迁移查询sql语句-------------------------------
SELECT T.ID AS TI_ID,T.TRANSFER_DEPT_ID AS TRANSFER_DEPT_ID,T.YJR_ID AS TRANSFER_USERID,T.TRANSFER_DATE AS TRANSFER_DATE,T.RECEIVER_DATE AS RECEIVER_DATE,T.CONNECT_NO AS CONNECT_NO,T.RECEIVER_DEPT_ID AS RECEIVER_DEPT_ID,T.CONNECT_COPIES AS COPIES,T.JSR_ID AS RECEIVER_USERID,T.REMARK AS REMARK,W.STATE_VALUE AS AT_STATE,get_dept_name(TRANSFER_DEPT_ID) AS TRANSFER_DEPT_NAME,get_dept_name(RECEIVER_DEPT_ID) AS RECEIVER_DEPT_NAME,transfer_code(w.transfer_code) as TRANSFER_CODE,get_user_name(t.yjr_id) AS TRANSFER_USERNAME,get_user_name(T.JSR_ID) AS RECEIVER_USERNAME FROM ZGXT.TRANSFER_INFO T JOIN ZGXT.TRANSFER_INFO_CONTROL_WF W ON T.ID = W.TRANSFER_ID 


------------------//transfer_info表字段列表------------------------------
TI_ID,TRANSFER_DEPT_ID,TRANSFER_USERID,TRANSFER_DATE,RECEIVER_DATE,CONNECT_NO,RECEIVER_DEPT_ID,COPIES,RECEIVER_USERID,REMARK,AT_STATE,TRANSFER_DEPT_NAME,RECEIVER_DEPT_NAME,TRANSFER_CODE,TRANSFER_USERNAME,RECEIVER_USERNAME


------------------//transfer_info 调用语句-----------------------------------------
SET SERVEROUTPUT ON size 100000;
VARIABLE TX VARCHAR2(2);
EXEC largedata_insert('dcfs.transfer_info','TI_ID,TRANSFER_DEPT_ID,TRANSFER_USERID,TRANSFER_DATE,RECEIVER_DATE,CONNECT_NO,RECEIVER_DEPT_ID,COPIES,RECEIVER_USERID,REMARK,AT_STATE,TRANSFER_DEPT_NAME,RECEIVER_DEPT_NAME,TRANSFER_CODE,TRANSFER_USERNAME,RECEIVER_USERNAME','SELECT T.ID AS TI_ID,T.TRANSFER_DEPT_ID AS TRANSFER_DEPT_ID,T.YJR_ID AS TRANSFER_USERID,T.TRANSFER_DATE AS TRANSFER_DATE,T.RECEIVER_DATE AS RECEIVER_DATE,T.CONNECT_NO AS CONNECT_NO,T.RECEIVER_DEPT_ID AS RECEIVER_DEPT_ID,T.CONNECT_COPIES AS COPIES,T.JSR_ID AS RECEIVER_USERID,T.REMARK AS REMARK,W.STATE_VALUE AS AT_STATE,get_dept_name(TRANSFER_DEPT_ID) AS TRANSFER_DEPT_NAME,get_dept_name(RECEIVER_DEPT_ID) AS RECEIVER_DEPT_NAME,transfer_code(w.transfer_code) as TRANSFER_CODE,get_user_name(t.yjr_id) AS TRANSFER_USERNAME,get_user_name(T.JSR_ID) AS RECEIVER_USERNAME FROM ZGXT.TRANSFER_INFO T JOIN ZGXT.TRANSFER_INFO_CONTROL_WF W ON T.ID = W.TRANSFER_ID',:TX);


------------------//transfer_info_detail表迁移查询sql语句-----------------------------------
SELECT TT.ID AS TID_ID,TT.TRANSFER_ID AS TI_ID,TT.APPLICATION_ID AS APP_ID,transfer_Code(TT.TRANSFER_CODE) AS TRANSFER_CODE,TI.STATE_VALUE AS TRANSFER_STATE FROM ZGXT.TRANSFER_INFO_DETAIL TT JOIN ZGXT.TRANSFER_INFO_CONTROL_WF TI ON TT.TRANSFER_ID = TI.TRANSFER_ID where VALID_FLAG <> '0'


------------------//transfer_info_detail表字段列表-------------------------------------------
TID_ID,TI_ID,APP_ID,TRANSFER_CODE,TRANSFER_STATE


------------------//transfer_info_detail 调用语句-----------------------------------------
SET SERVEROUTPUT ON size 100000;
VARIABLE TX VARCHAR2(2);
EXEC largedata_insert('dcfs.transfer_info_detail','TID_ID,TI_ID,APP_ID,TRANSFER_CODE,TRANSFER_STATE','SELECT TT.ID AS TID_ID,TT.TRANSFER_ID AS TI_ID,TT.APPLICATION_ID AS APP_ID,transfer_Code(TT.TRANSFER_CODE) AS TRANSFER_CODE,TI.STATE_VALUE AS TRANSFER_STATE FROM ZGXT.TRANSFER_INFO_DETAIL TT JOIN ZGXT.TRANSFER_INFO_CONTROL_WF TI ON TT.TRANSFER_ID = TI.TRANSFER_ID',:TX);