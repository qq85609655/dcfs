
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.Data"%>
<%
Data data=(Data)request.getAttribute("data");
%>

<BZ:html>
<BZ:head>
<title>资源修改页面</title>
<BZ:script/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
		}
		document.srcForm.action=path+"navigation/navigationModify.action";
	 	document.srcForm.submit();
	}
	function _back(){
	 	document.srcForm.action=path+"navigation/navigationList.action";
	 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="kuangjia">
<BZ:input field="URL_PROMPT" type="hidden" prefix="P_" size="50"/>
<BZ:input field="ID" type="hidden" prefix="P_" defaultValue=""/>
<div class="heading">导航栏修改</div>
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
<td>菜单URL前缀</td>
<td colspan="3"><BZ:input field="URL_PREFIX" type="String" prefix="P_" size="50" formTitle="菜单URL前缀" defaultValue=""/></td>
<td></td>
</tr>
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
<td colspan="3"><BZ:select field="STATUS" formTitle="状态" property="data" prefix="P_" width="130px"><BZ:option value="1"  >启用</BZ:option><BZ:option value="0">停用</BZ:option></BZ:select></td>
<td></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>