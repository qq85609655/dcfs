<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
DataList grouplist = (DataList)request.getAttribute("grouplist");
Data data = grouplist.getData(0);
%>
<BZ:html>
<BZ:head>
<title>设置分组</title>
<BZ:script isEdit="true" isDate="true"/>
<script type="text/javascript">
</script>
<style type="text/css">
.style1 {
	font-size:12px;
	text-align:center;
	height:25px;
	font-weight:bold;
	}
.style3 {
	font-size: 12px;
	text-align: right;
	text-indent: 12px;
	height: 25px;
}

</style>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post">
<input type="hidden" name="IDS" id="ids"/>
<input type="hidden" name="Type" id="type" value="2"/>
<input type="hidden" name="ID" value="<%=data.getString("ID")%>"/>
<div class="kuangjia" style="width: 500px;">
<div class="heading">查看分组</div>
<table class="contenttable" width="500px" align="center">
	<tr>
		<td class="style1" style="width:20%;text-align:right"  nowrap>分组名称：</td>
		<td style="width:80%"><%=data.getString("GROUPNAME") %></td>
	</tr>
	<tr>
		<td class="style1" style="width:20%;text-align:right">人&nbsp;&nbsp;&nbsp;&nbsp;员：</td>
		<td>
		<select style="width:100%; height: 220px;" multiple="true" name="d2" id="d2" disabled="disabled">
		<%
			for(int i=0;i<grouplist.size();i++)
			{
				Data user = grouplist.getData(i);
				StringBuffer str = new StringBuffer("");
				str.append(user.getString("CNAME")).append("(").append(user.getString("MOBILE")).append(")");
		 %>
		 <option value="<%=user.getString("PERSONID") %>"><%=str.toString() %></option>
		 <%} %>
		</select></td>
	</tr>
	<tr>
		<td class="style3" nowrap colspan="2"><input type="button" value="关闭" class="button_close" onclick="window.close();"/></td>
	</tr>
	</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>
