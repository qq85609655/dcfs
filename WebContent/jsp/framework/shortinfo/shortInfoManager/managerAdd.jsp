
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.hx.framework.shortinfo.vo.Sms_ShortInfo_Manager"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<% 
	Data data=(Data)request.getAttribute("data");
	String magzine_id = (String)request.getAttribute(Sms_ShortInfo_Manager.MAGZINE_ID);
	DataList dataList = (DataList)request.getAttribute("dataList");
%>
<BZ:html>
<BZ:head>
<title>添加页面</title>
<BZ:script isEdit="true" isDate="true"/>
<script>
	function _back(){
		window.history.back();
	}
	function _save(){
		document.srcForm.action = path + "shortInfoManager/add.action";
		document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="<%=Sms_ShortInfo_Manager.MAGZINE_ID %>" value="<%=magzine_id %>"/>
<input type="hidden" name="MANAGER_MAGZINE_ID" value="<%=magzine_id %>"/>
<div class="kuangjia">
<div class="heading">添加</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">发送日期</td>
<td width="20%">
	<BZ:input field="SEND_TIME" prefix="MANAGER_" defaultValue="" type="date"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">接收人</td>
<td width="20%">	
	<BZ:input field="RECIEVERS" prefix="MANAGER_" defaultValue="" size="60"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">排序号</td>
<td width="20%">	
	<BZ:input field="SORTID" prefix="MANAGER_" defaultValue=""/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>内容</td>
<td colspan="4">
	<textarea rows="6" style="width:80%" name="MANAGER_CONTENT"></textarea>
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