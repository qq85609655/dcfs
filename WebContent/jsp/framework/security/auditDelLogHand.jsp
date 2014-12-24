
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<BZ:html>
<BZ:head>
<title>审计日志手动删除页面</title>
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
			alert("请选择审计日志类型");
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
<div class="heading">审计日志手动删除</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td nowrap="nowrap">审计日志类型：</td>
<td>
   <input type="checkbox" value="1" name="P_DATA_TYPE">系统管理行为审计日志 &nbsp;&nbsp;
   <!--  <input type="checkbox" value="2" name="P_DATA_TYPE">系统访问控制审计日志<br/>-->
   <input type="checkbox" value="3" name="P_DATA_TYPE">用户登录行为审计日志 &nbsp;&nbsp;
   <input type="checkbox" value="4" name="P_DATA_TYPE">应用操作行为审计日志<br>
</td>
<td></td>
</tr>
<tr>
<td></td>
<td width="5%">数据范围：</td>
<td><BZ:select field="DATA_PERIOD"  prefix="P_" defaultValue="0" formTitle="" isCode="true" codeName="LOGRANGE" property="data" >
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