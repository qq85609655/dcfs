
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
  Data accData = (Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
<title>�����־�ֶ��鵵ҳ��</title>
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
			document.srcForm.action=path+"clearLog/handLogClear.action";
		 	document.srcForm.submit();
		}
	}
	function _back()
	{
		document.srcForm.action=path+"clearLog/queryList.action";
	 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data" codeNames="LOGRANGE">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<div class="heading">�����־�ֶ��鵵</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td nowrap="nowrap">�����־���ͣ�</td>
<td>
   <BZ:checkbox field="DATA_TYPE" value="1" formTitle="" prefix="P_">ϵͳ������Ϊ�����־</BZ:checkbox>&nbsp;&nbsp;
   <!--<BZ:checkbox field="DATA_TYPE" value="2" formTitle="" prefix="P_">ϵͳ���ʿ��������־</BZ:checkbox><br/>-->
   <BZ:checkbox field="DATA_TYPE" value="3" formTitle="" prefix="P_">�û���¼��Ϊ�����־</BZ:checkbox>&nbsp;&nbsp;
   <BZ:checkbox field="DATA_TYPE" value="4" formTitle="" prefix="P_">Ӧ�ò�����Ϊ�����־</BZ:checkbox><br/>
</td>
<td></td>
</tr>
<tr>
<td></td>
<td width="5%">���ݷ�Χ��</td>
<td><BZ:select field="LOGRANGE"  prefix="P_" defaultValue="0" formTitle="" isCode="true" codeName="LOGRANGE" property="data" >
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