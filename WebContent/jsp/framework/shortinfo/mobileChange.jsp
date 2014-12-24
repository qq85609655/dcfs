<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.sdk.PersonHelper"%>
<%@page language="java" contentType="text/html; charset=GBK" %>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>

<BZ:html>
<BZ:head>
<title>用户手机号码变更记录</title>
<BZ:script isList="true" isDate="true"/>
<style type="text/css">
.style1 {
	border-collapse: collapse;
	border: 1px solid #000000;
}
.style2{
	border: 1px solid #000000;
}
body td table span{
	font-size:12px;
}
td{
	padding:3px;
}
body{
	margin: 10px 5px 0px 5px;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	dyniframesize(['mainFrame']);
});
function _search(){
	document.srcForm.page.value=1;
	document.srcForm.submit();
}
function _keySearch(){
	var ev = window.event;
	//83=s/13=回车
	if((ev.keyCode && ev.keyCode==13)){
		_search();
	}
}
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post" action="linkman/mobileChange.action">
<table style="width: 100%">
	<tr>
		<td>变更时间：</td>
		<td><BZ:input type="date" formTitle="变更起始时间" field="START" defaultValue="" prefix="S_" property="search" id="S_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_END\\')}',readOnly:true"/>-<BZ:input formTitle="变更结束时间"  type="date" field="END" defaultValue="" prefix="S_" property="search" id="S_END" dateExtend="minDate:'#F{$dp.$D(\\'S_START\\')}',readOnly:true"/></td>
		<td>姓名：</td>
		<td><BZ:input onkeyup="_keySearch();"  type="String" formTitle="姓名" field="NAME" prefix="S_" defaultValue="" property="search"/></td>
		<td>状态：</td>
		<td><BZ:select onchange="_search();" field="STATE" formTitle="状态" prefix="S_" property="search">
		<BZ:option value="">全部</BZ:option>
		<BZ:option value="1">新增</BZ:option>
		<BZ:option value="2">更新</BZ:option>
		<BZ:option value="3">删除</BZ:option>
		</BZ:select></td>
		<td><input type="button" value="搜索" onclick="_search()"></td>

	</tr>
</table>

<table style="width: 100%" cellspacing="0" class="style1">
	<tr>
		<td class="style2">序号</td>
		<td class="style2">姓名</td>
		<td class="style2">原号码</td>
		<td class="style2">变更号码</td>
		<td class="style2">变更状态</td>
		<td class="style2">变更时间</td>
	</tr>
	<BZ:for property="List" fordata="d">
	<tr>
	<%
	Data data = (Data)pageContext.findAttribute("d");
	String uuid = data.getString("UUID","");
	String cname = PersonHelper.getPersonCNameById(uuid);
	%>
		<td class="style2"><BZ:i serial="true"/></td>
		<td class="style2"><%=cname%></td>
		<td class="style2"><BZ:data field="OLDTEL"/></td>
		<td class="style2"><BZ:data field="NEWTEL"/></td>
		<td class="style2"><BZ:data field="FLAG" checkValue="1=新增;2=更新;3=删除"/></td>
		<td class="style2"><BZ:data field="EDITTIME" type="Date"/></td>
	</tr>
	</BZ:for>
</table>
<BZ:page form="srcForm" property="List"/>
</BZ:form>
</BZ:body>
</BZ:html>