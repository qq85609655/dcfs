
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.hx.framework.shortinfo.vo.Sms_Magzine"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<% 
	Data data=(Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
<title>添加页面</title>
<BZ:script isEdit="true"/>
<script>
	function _back(){
		window.history.back();
	}
	function _save(){
		document.srcForm.action = path + "magzine/modify.action";
		document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="Magzine_ID" value="<%=data.getString(Sms_Magzine.ID) %>"/>
<div class="kuangjia">
<div class="heading">添加</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">标题</td>
<td width="20%">
	<BZ:input field="TITLE" prefix="Magzine_" defaultValue=""/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">总期</td>
<td width="20%">	
	<BZ:input field="ALL_ISSUE" prefix="Magzine_" defaultValue=""/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">期号</td>
<td width="20%">
	<BZ:input field="ISSUE" prefix="Magzine_" defaultValue=""/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">是否发布</td>
<td width="20%">	
	<input name="Magzine_PUBLISH" type="radio" value="0" <%="0".equals(data.getString(Sms_Magzine.PUBLISH))?"checked='checked'":"" %>/>否&nbsp;&nbsp;<input name="Magzine_PUBLISH" type="radio" value="1" <%="1".equals(data.getString(Sms_Magzine.PUBLISH))?"checked='checked'":"" %>/>是
</td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>说明</td>
<td colspan="4">
	<textarea rows="6" style="width:80%" name="Magzine_MAKE"><%=data.getString(Sms_Magzine.MAKE) %></textarea>
</td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2">
	<input type="button" value="保存" class="button_save" onclick="_save()"/>
	<input type="button" value="返回" class="button_back" onclick="_back()"/>
</td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>