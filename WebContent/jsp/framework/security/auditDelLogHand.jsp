
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<BZ:html>
<BZ:head>
<title>�����־�ֶ�ɾ��ҳ��</title>
<BZ:script isEdit="true"/>
<script type="text/javascript" language="javascript">
	function tijiao()
	{
		var DATA_TYPE=document.getElementsByName("P_DATA_TYPE");
		var s=0;
		for(var i=0;i<DATA_TYPE.length;i++){
			if(DATA_TYPE[i].checked){
				s+=1;
			}
		}
		if(s<=0){
			alert("��ѡ�������־����");
		}else{
			document.srcForm.action=path+"clearLog/handDelLog.action";
		 	document.srcForm.submit();
		}
	}
	function _back()
	{
		document.srcForm.action=path+"clearLog/queryDelList.action";
	 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data" codeNames="LOGRANGE">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="P_ID" value=""></input>
<div class="kuangjia">
<div class="heading">�����־�ֶ�ɾ��</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td nowrap="nowrap">�����־���ͣ�</td>
<td>
   <input type="checkbox" value="1" name="P_DATA_TYPE">ϵͳ������Ϊ�����־ &nbsp;&nbsp;
   <!--  <input type="checkbox" value="2" name="P_DATA_TYPE">ϵͳ���ʿ��������־<br/>-->
   <input type="checkbox" value="3" name="P_DATA_TYPE">�û���¼��Ϊ�����־ &nbsp;&nbsp;
   <input type="checkbox" value="4" name="P_DATA_TYPE">Ӧ�ò�����Ϊ�����־<br>
</td>
<td></td>
</tr>
<tr>
<td></td>
<td width="5%">���ݷ�Χ��</td>
<td><BZ:select field="DATA_PERIOD"  prefix="P_" defaultValue="0" formTitle="" isCode="true" codeName="LOGRANGE" property="data" >
</BZ:select></td>
<td ></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="ȷ��" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="reset" value="����" class="button_reset" />&nbsp;&nbsp;<input type="button" value="����" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>