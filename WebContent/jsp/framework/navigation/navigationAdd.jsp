
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
request.setAttribute("data",new Data());
%>
<BZ:html>
<BZ:head>
<title>导航栏添加页面</title>
<BZ:script/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
			}
	document.srcForm.action=path+"navigation/navigationAdd.action";
 	document.srcForm.submit();
	}
	function _back(){
 	document.srcForm.action=path+"navigation/navigationList.action";
 	document.srcForm.submit();
	}
	
	function showapp(){
	   var appid=window.showModalDialog(path+"navigation/selectApp.action","","dialogWidth=800px;dialogHeight=400px");
	   if(appid!=""&&appid!="undefined"){
	   var returnvalue=appid.split('#');
       document.getElementById("P_APP_ID").value=returnvalue[0];
       document.getElementById("P_APP_NAME").value=returnvalue[1];
       }
	}
	
	function qingkong(){
	document.getElementById("P_APP_ID").value="";
      document.getElementById("P_APP_NAME").value="";
	}
	
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post" token="navigationAdd">
<BZ:input field="URL_PROMPT" type="hidden" prefix="P_"/>
<input type="hidden" value="" name="P_APP_ID" id="P_APP_ID"/>
<div class="kuangjia">
<div class="heading">导航栏添加</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">导航栏名称</td>
<td width="20%"><BZ:input field="NAV_NAME" type="String" prefix="P_" notnull="请输入导航栏名称" formTitle="导航栏名称"/></td>
<td width="10%">显示顺序</td>
<td width="20%"><BZ:input field="SEQ_NUM" type="String" prefix="P_" notnull="请输入显示顺序" restriction="int" formTitle="显示顺序"/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>选择应用</td>
<td><BZ:input field="APP_NAME" type="String" prefix="P_" onclick="showapp()" notnull="请选择应用" id="P_APP_NAME"/>&nbsp;&nbsp;<input type="button" value="清空" class="button_reset" onclick="qingkong()"/></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td></td>
<td>菜单URL前缀</td>
<td colspan="3"><BZ:input field="URL_PREFIX" type="String" prefix="P_"  size="50" formTitle="菜单URL前缀" defaultValue=""/></td>
<td></td>
</tr>
<tr>
<tr>
<td></td>
<td>首页面URL</td>
<td colspan="3"><BZ:input field="NAV_URL" type="String" prefix="P_" size="50" defaultValue=""/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>帮助文件路径</td>
<td colspan="3"><BZ:input field="HELP_FILE_PATH" type="String" prefix="P_" size="50" defaultValue=""/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>状态</td>
<td colspan="3"><BZ:select field="STATUS" formTitle="状态" property="data" prefix="P_" width="130px" ><BZ:option value="1">启用</BZ:option><BZ:option value="0">停用</BZ:option></BZ:select></td>
<td></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>