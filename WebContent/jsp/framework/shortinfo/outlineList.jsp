<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.shortinfo.vo.Sms_Send"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	String path = request.getContextPath();
	DataList list = (DataList)request.getAttribute("list");
	String reValue = (String)request.getAttribute("reValue");

	Data sdata = (Data)request.getAttribute("sdata");
	if(sdata == null){
		sdata = new Data();
	}

	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
%>
<BZ:html>
<BZ:head>
<title>草稿</title>
<link href="<BZ:resourcePath />/main/css/wpage.css" rel="stylesheet" type="text/css" />
<BZ:script isList="true" isDate="true"/>
<script>
	function tijiao()
	{
		document.srcForm.action=path+"doneinfo/send.action";
		document.srcForm.submit();
	}
	function _back(){
		document.srcForm.action=path+"doneinfo/list.action";
		document.srcForm.submit();
	}
		function _del(id){
		if(confirm("点击'确认'删除该信息，点击'取消'不删除该信息。")){
			document.srcForm.action = path+"outline/delete.action?sendId="+id;
			document.srcForm.submit();
		}
	}
	function _send(id)
	{
		if(!confirm('确定发送吗？')){
			return;
		}
			document.srcForm.action=path+"doneinfo/send.action?sendId="+id;
			document.srcForm.submit();
	}
	function _adit()
	{
			document.srcForm.action=path+"doneinfo/toadit.action";
			document.srcForm.submit();
	}
	function _edit(id){
				document.srcForm.action = path + "sendMessage/toedit.action?ID="+id;
				document.srcForm.submit();
	}
	function _search(){
		document.srcForm.page.value=1;
			document.srcForm.action = path + "outline/list.action";
			document.srcForm.submit();
	}

	function _onload(){
			document.body.className = "bodyGround";
			if('<%=reValue%>'!='null'&&'<%=reValue%>'!=""){
				alert('<%=reValue%>');
			}
		}
</script>
<style type="text/css">
.style1 {
	background-color:silver;
}
.style2 {
	background-color: #FFFFFF;
	font-size:12px;
	text-align:left;
	text-indent:2px;
	height:25px;
	white-space: nowrap;

}
.style3 {
	background-color:#F5F5F5;
	font-size:12px;
	text-align:right;
	height:25px;
	width: 10%;
}
.style4 {
	background-color: #FFFFFF;
	font-size:12px;
	text-align:left;
	text-indent:2px;
	height:25px;
	width:90%;
}
.style6 {
	background-color: #e9f2fd;
	font-size: 14px;
	text-align: left;
	height: 25px;
	text-indent:2px;
	width: 10%;
}
</style>
</BZ:head>
<BZ:body onload="_onload();" property="sdata">
<BZ:form name="srcForm" method="post" action="outline/list.action">
<div class="mainShort">
<!--bg start-->
<div class="xxbg">&nbsp;</div>
<!--bg end-->

<div class="mainD">

<div class="xx_T" >
<table border="0" cellspacing="0" cellpadding="0" width="100%" >
	<tr>
		<td colspan="4" valign="middle" class="xx_Ttab1">查询条件</td>
	</tr>
	<tr>
		<td align="left" style="padding-left:10px;" bgcolor="#F5F5F5" width="80px">编写日期：</td>
		<td width="295px" class="style2"><BZ:input field="START_TIME" prefix="Send_" id="Send_START_TIME" defaultValue="" type="date" dateExtend="maxDate:'#F{$dp.$D(\\'Send_END_TIME\\')}',readOnly:true"/>-<BZ:input field="END_TIME" prefix="Send_" defaultValue="" id="Send_END_TIME" type="date" dateExtend="minDate:'#F{$dp.$D(\\'Send_START_TIME\\')}',readOnly:true"/></td>
		<td align="left" style="padding-left:10px;" bgcolor="#F5F5F5" width="108px">接收者：</td>
		<td width="140px"><input style="width:70%" name="Send_RECEIVENAME" value='<%=sdata.getString("RECEIVENAME")!=null?sdata.getString("RECEIVENAME"):"" %>' /></td>
	</tr>
	<tr>
		<td align="left" style="padding-left:10px;" bgcolor="#F5F5F5">信息内容：</td>
		<td class="style2"><input style="width: 99%" name="Send_CONTENT" value='<%=sdata.getString("CONTENT")!=null?sdata.getString("CONTENT"):"" %>' /></td>
		<td class="style2" colspan="2"><input type="button" class="button_search" value="搜索" onclick="_search()"></td>
	</tr>
</table>
</div>
</div>

<div class="xx_F">
<table style="width: 100%;">
<tr>
	<td>
	<%
		for(int i=0;i<list.size();i++){
			Data data = list.getData(i);
	%>
	<div class="xx_Ftab">
		<table style="width: 100%" cellspacing="1" class="style1">
			<tr>
				<td  class="style3" nowrap>编写日期：</td>
				<td class="style2"><%=data.getString(Sms_Send.SEND_TIME) %></td>
				<td class="style3" nowrap>编&nbsp;&nbsp;写&nbsp; 者：</td>
				<td class="style2"><%=data.getString("SENDER_CNAME") %></td>
				<td class="style3" nowrap>处&nbsp;&nbsp;&nbsp; 室：</td>
				<td class="style2" nowrap><%=data.getString("ORG_CNAME") %></td>
				<td class="style3" nowrap>操&nbsp;&nbsp;&nbsp; 作：</td>
				<td class="style2" nowrap >
				<input type="button" onclick="_edit('<%=data.getString(Sms_Send.ID) %>');" class="button_update" value="编辑">&nbsp;<input type="button" class="button_send" onclick="_send('<%=data.getString(Sms_Send.ID) %>');" value="发送">&nbsp;<input type="button" class="button_delete"  onclick="_del('<%=data.getString(Sms_Send.ID) %>')" value="删除">&nbsp;</td>
			</tr>
			<tr>
				<td class="style3" nowrap>接&nbsp; 收&nbsp; 者：</td>
				<td colspan="7" class="style4"><%=data.getString("reciversName") %></td>
			</tr>
			<tr>
				<td class="style3" nowrap>信息内容：</td>
				<td colspan="7" class="style4">
				<%=data.getString(Sms_Send.CONTENT) %></td>
			</tr>
	</table>
	</div>
	<%
		}
	%>
	</td>
</tr>
</table>
<table width="100%">
<tr>
<td colspan="2"><BZ:page form="srcForm1" property="list" type="1"/></td>
</tr>
</table>
</div>

</div>
</BZ:form>
</BZ:body>
</BZ:html>

