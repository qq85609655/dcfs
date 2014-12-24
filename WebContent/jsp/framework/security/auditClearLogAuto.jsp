
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
  Data adata = (Data)request.getAttribute("data");
  String s_dataType = adata.getString("DATA_TYPE");
  if(s_dataType==null)
  {
	  s_dataType="";
  }
%>
<BZ:html>
<BZ:head>
<title>审计日志自动归档设置页面</title>
<BZ:script isEdit="true"/>
<script type="text/javascript" language="javascript">
	function tijiao()
	{
		var flag=false;
		var d = document.getElementsByName("P_DATA_TYPE");
		var s = document.getElementsByName("P_STATUS");
		if(s[0].checked==false&&s[1].checked==false){
			alert("请选择是否启用自动归档");
			return;
			
		}
		for(var i = 0; i < d.length; i++)
		{
		if(d[i].checked==true){
		flag=true;
		document.srcForm.action=path+"clearLog/autoClearSetUp.action";
	 	document.srcForm.submit();
	 	break;
		}
		}
		if(flag==false){
		alert("请选择审计日志类型");
		document.all("P_DATA_TYPE").focus();
		return false;
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
<BZ:input field="ID" type="hidden" prefix="P_"/>
<div class="kuangjia">
<div class="heading">审计日志自动归档设置</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td nowrap="nowrap">审计日志类型：</td>
<td>
   <input type="checkbox" value="1" name="P_DATA_TYPE" <%if(!"".equals(s_dataType)&&s_dataType.contains("1")) {%>checked="checked"<%} %>>系统管理行为审计日志 &nbsp;&nbsp;
   <!-- <input type="checkbox" value="2" name="P_DATA_TYPE">系统访问控制审计日志<br/>-->
   <input type="checkbox" value="3" name="P_DATA_TYPE" <%if(!"".equals(s_dataType)&&s_dataType.contains("3")) {%>checked="checked"<%} %>>用户登录行为审计日志 &nbsp;&nbsp;
   <input type="checkbox" value="4" name="P_DATA_TYPE" <%if(!"".equals(s_dataType)&&s_dataType.contains("4")) {%>checked="checked"<%} %>>应用操作行为审计日志<br>
   <!--  
   <BZ:checkbox field="DATA_TYPE" value="1" formTitle="" prefix="P_" notnull="true">系统管理行为审计日志</BZ:checkbox>&nbsp;&nbsp;
   <BZ:checkbox field="DATA_TYPE" value="2" formTitle="" prefix="P_" notnull="true">系统访问控制审计日志</BZ:checkbox><br/>
   <BZ:checkbox field="DATA_TYPE" value="3" formTitle="" prefix="P_" notnull="true">用户登录行为审计日志</BZ:checkbox>&nbsp;&nbsp;
   <BZ:checkbox field="DATA_TYPE" value="4" formTitle="" prefix="P_" notnull="true">应用操作行为审计日志</BZ:checkbox><br/>
   -->
</td>
<td></td>
</tr>
<tr>
<td></td>
<td nowrap="nowrap">是否启用自动归档：</td>
<td>
  <BZ:radio field="STATUS" value="1" formTitle="" prefix="P_" >是</BZ:radio>&nbsp;&nbsp;&nbsp;&nbsp;<BZ:radio field="STATUS" value="0" formTitle="" prefix="P_" >否</BZ:radio>
</td>
<td ></td>
</tr>
<tr>
<td></td>
<td width="5%">数据范围：</td>
<td><BZ:select field="DATA_PERIOD"  prefix="P_" defaultValue="0" width="120px" formTitle="" isCode="true" codeName="LOGRANGE" property="data" >
</BZ:select></td>
<td ></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="确定" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="reset" value="重置" class="button_reset" />&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>