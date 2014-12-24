<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>    
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	String eleSortId=(String)request.getAttribute("eleSortId");
	Data data = (Data)request.getAttribute("data");
	String noback=request.getParameter("noback");
	if(noback==null){
		noback="";
	}
%>
<BZ:html>
<BZ:head>
<title>数据元修改页面</title>
<BZ:script/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
			}
		document.srcForm.action=path+"EleSortServlet?method=editSaveDataEle";
	 	document.srcForm.submit();
	}
	function _back(){
	 	document.srcForm.action=path+"EleSortServlet?method=codelist&ELE_SORT_ID=<%=eleSortId%>";
	 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="P_ELE_SORT_ID"  value="<%=eleSortId %>"/>
<input type="hidden" name="P_UUID"  value="<%=data.getString("UUID") %>"/>
<input type="hidden" name="noback"  value="<%=noback %>"/>
<div class="kuangjia">
<div class="heading">数据元修改</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">标示符</td>
<td width="20%"><BZ:input field="DATA_ELE_ID" prefix="P_" notnull="请输入标示符" formTitle="标示符" defaultValue=""/></td>
<td width="10%">中文名称</td>
<td width="20%"><BZ:input field="ELE_NAME_ZH" prefix="P_" notnull="请输入中文名称" formTitle="中文名称" defaultValue=""/></td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">英文名称</td>
<td width="20%"><BZ:input field="ELE_NAME_EN" prefix="P_" formTitle="英文名称" defaultValue=""/></td>
<td width="10%">同义名称</td>
<td width="20%"><BZ:input field="ELE_NAME_SYN" prefix="P_" formTitle="同义名称" defaultValue=""/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>定义</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_DEFINITION"><%=data.getString("DEFINITION") %></textarea></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">数据类型</td>
<td width="20%"><BZ:input field="DATA_TYPE" prefix="P_" notnull="请输入数据类型" formTitle="数据类型" defaultValue=""/></td>
<td width="10%">分类模式</td>
<td width="20%"><BZ:input field="SORT_MODE" prefix="P_" notnull="请输入分类模式" formTitle="分类模式" defaultValue=""/></td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">表示形式</td>
<td width="20%"><BZ:input field="SHOW_FORM" prefix="P_" notnull="请输入表示形式" formTitle="表示形式" defaultValue=""/></td>
<td width="10%">表示格式</td>
<td width="20%"><BZ:input field="SHOW_FORMAT" prefix="P_" notnull="请输入表示格式" formTitle="表示格式" defaultValue=""/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>允许值</td>
<td colspan="4"><BZ:input field="ALLOW_VALUE" prefix="P_" size="80" formTitle="允许值" defaultValue=""/></td>
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