-----------------//�����ύinsert into select �洢����-------------------------
create or replace procedure largedata_insert(ip_table_name in varchar2, --Ŀ���
                                          ip_table_column in varchar2, --Ŀ���ֶ�
                                          ip_table_select in varchar2, --SELECT ��ѯ���
                                          return_result   out number --���صĽ��1,��ʾ�ɹ�������ʾʧ��
                                          ) as
--�ʺϴ��������Ĳ���ģ��  create Templates by chenzhoumin 20110614
  runTime number;
  i       number;
  amount  number;
  s_sql   varchar2(5000);
  inu     number; 
begin
  return_result := 0; --��ʼ��ʼ��Ϊ0
  --�˱��߼����ݣ��ɸ��ݾ����ҵ���߼�������
  s_sql := 'select count(1) from (' || ip_table_select || ')';
  execute immediate s_sql
    into amount;
  --ÿ1000�ύһ��
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
    --�ύ
    commit;
    inu := inu+1;
    DBMS_OUTPUT.PUT_LINE('1000���ύ�ɹ�');
  END LOOP;
  return_result := 1;
  dbms_output.put_line('����' || to_char(sysdate, 'yyyymmddhh24miss'));
  return;
exception
  when others then
    return_result := 0;
    raise;
    return;
end;
---------------------//����ת������:������ϵͳ�еĽ��Ӵ���ת������ϵͳ�Ľ��Ӵ���-------------------------------------------
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


-------------------//��������ת��������ͨ��ԭϵͳ�Ĳ���ID�����ϵͳ�Ĳ������ƣ��Ϲ�ԭϵͳ��-----------------------------------------------------------
CREATE OR REPLACE FUNCTION get_dept_name (v_dept_id VARCHAR2)
RETURN VARCHAR2
AS
	return_value VARCHAR2(200);
BEGIN
	SELECT NAME_CN INTO return_value FROM ZGXT.SYS_DEPT WHERE ID = v_dept_id;
	RETURN return_value;
END get_dept_name ;

 
-------------------//���ݲ��亯������  ͨ������ID��ȡ��������(breeze ϵͳ)-----------------------------------------
CREATE OR REPLACE FUNCTION query_dept_name (v_dept_id VARCHAR2)
RETURN VARCHAR2
AS
dept_name VARCHAR2(200);
BEGIN
	select CNAME INTO dept_name from pub_organ WHERE ID = v_dept_id;
	RETURN dept_name;
END query_dept_name;


------------------//ͨ���û�id ��ȡ�û�����---------------
CREATE OR REPLACE FUNCTION get_user_name (user_id VARCHAR2)
RETURN VARCHAR2
AS
	return_value VARCHAR2(200);
BEGIN
	select  name into return_value from zgxt.gos_user where id = user_id;
	RETURN return_value;
END get_user_name ; 


------------------//TRANSFER_INFO ��Ǩ�Ʋ�ѯsql���-------------------------------
SELECT T.ID AS TI_ID,T.TRANSFER_DEPT_ID AS TRANSFER_DEPT_ID,T.YJR_ID AS TRANSFER_USERID,T.TRANSFER_DATE AS TRANSFER_DATE,T.RECEIVER_DATE AS RECEIVER_DATE,T.CONNECT_NO AS CONNECT_NO,T.RECEIVER_DEPT_ID AS RECEIVER_DEPT_ID,T.CONNECT_COPIES AS COPIES,T.JSR_ID AS RECEIVER_USERID,T.REMARK AS REMARK,W.STATE_VALUE AS AT_STATE,get_dept_name(TRANSFER_DEPT_ID) AS TRANSFER_DEPT_NAME,get_dept_name(RECEIVER_DEPT_ID) AS RECEIVER_DEPT_NAME,transfer_code(w.transfer_code) as TRANSFER_CODE,get_user_name(t.yjr_id) AS TRANSFER_USERNAME,get_user_name(T.JSR_ID) AS RECEIVER_USERNAME FROM ZGXT.TRANSFER_INFO T JOIN ZGXT.TRANSFER_INFO_CONTROL_WF W ON T.ID = W.TRANSFER_ID 


------------------//transfer_info���ֶ��б�------------------------------
TI_ID,TRANSFER_DEPT_ID,TRANSFER_USERID,TRANSFER_DATE,RECEIVER_DATE,CONNECT_NO,RECEIVER_DEPT_ID,COPIES,RECEIVER_USERID,REMARK,AT_STATE,TRANSFER_DEPT_NAME,RECEIVER_DEPT_NAME,TRANSFER_CODE,TRANSFER_USERNAME,RECEIVER_USERNAME


------------------//transfer_info �������-----------------------------------------
SET SERVEROUTPUT ON size 100000;
VARIABLE TX VARCHAR2(2);
EXEC largedata_insert('dcfs.transfer_info','TI_ID,TRANSFER_DEPT_ID,TRANSFER_USERID,TRANSFER_DATE,RECEIVER_DATE,CONNECT_NO,RECEIVER_DEPT_ID,COPIES,RECEIVER_USERID,REMARK,AT_STATE,TRANSFER_DEPT_NAME,RECEIVER_DEPT_NAME,TRANSFER_CODE,TRANSFER_USERNAME,RECEIVER_USERNAME','SELECT T.ID AS TI_ID,T.TRANSFER_DEPT_ID AS TRANSFER_DEPT_ID,T.YJR_ID AS TRANSFER_USERID,T.TRANSFER_DATE AS TRANSFER_DATE,T.RECEIVER_DATE AS RECEIVER_DATE,T.CONNECT_NO AS CONNECT_NO,T.RECEIVER_DEPT_ID AS RECEIVER_DEPT_ID,T.CONNECT_COPIES AS COPIES,T.JSR_ID AS RECEIVER_USERID,T.REMARK AS REMARK,W.STATE_VALUE AS AT_STATE,get_dept_name(TRANSFER_DEPT_ID) AS TRANSFER_DEPT_NAME,get_dept_name(RECEIVER_DEPT_ID) AS RECEIVER_DEPT_NAME,transfer_code(w.transfer_code) as TRANSFER_CODE,get_user_name(t.yjr_id) AS TRANSFER_USERNAME,get_user_name(T.JSR_ID) AS RECEIVER_USERNAME FROM ZGXT.TRANSFER_INFO T JOIN ZGXT.TRANSFER_INFO_CONTROL_WF W ON T.ID = W.TRANSFER_ID',:TX);


------------------//transfer_info_detail��Ǩ�Ʋ�ѯsql���-----------------------------------
SELECT TT.ID AS TID_ID,TT.TRANSFER_ID AS TI_ID,TT.APPLICATION_ID AS APP_ID,transfer_Code(TT.TRANSFER_CODE) AS TRANSFER_CODE,TI.STATE_VALUE AS TRANSFER_STATE FROM ZGXT.TRANSFER_INFO_DETAIL TT JOIN ZGXT.TRANSFER_INFO_CONTROL_WF TI ON TT.TRANSFER_ID = TI.TRANSFER_ID where VALID_FLAG <> '0'


------------------//transfer_info_detail���ֶ��б�-------------------------------------------
TID_ID,TI_ID,APP_ID,TRANSFER_CODE,TRANSFER_STATE


------------------//transfer_info_detail �������-----------------------------------------
SET SERVEROUTPUT ON size 100000;
VARIABLE TX VARCHAR2(2);
EXEC largedata_insert('dcfs.transfer_info_detail','TID_ID,TI_ID,APP_ID,TRANSFER_CODE,TRANSFER_STATE','SELECT TT.ID AS TID_ID,TT.TRANSFER_ID AS TI_ID,TT.APPLICATION_ID AS APP_ID,transfer_Code(TT.TRANSFER_CODE) AS TRANSFER_CODE,TI.STATE_VALUE AS TRANSFER_STATE FROM ZGXT.TRANSFER_INFO_DETAIL TT JOIN ZGXT.TRANSFER_INFO_CONTROL_WF TI ON TT.TRANSFER_ID = TI.TRANSFER_ID',:TX);