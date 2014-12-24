<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*,java.util.*" %>
<%@ page import="com.hx.framework.common.*" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
DataList datalist = (DataList)request.getAttribute("dataList");
%>
<BZ:html>
<BZ:head>
<BZ:script/>
<script type="text/javascript">

var pwdPolicy="<%=Constants.SECURITY_POLICY_PWD%>";
var unlockPolicy="<%=Constants.SECURITY_POLICY_UNLOCK%>";

function _skip(id){
	if(id==pwdPolicy){
		document.srcForm.action=path+"pwdPolicy/tosetUp.action";
		document.srcForm.submit();
	}
	if(id==unlockPolicy){//如果是账号自动解锁设置跳转，这里的2是账号自动解锁策略的ID，如果数据ID变化可以更改这里
		document.srcForm.action=path+"poAccUnlock/poAccList.action";
		document.srcForm.submit();
	}
}
function _changeStatus(id,status){
	if(status=='1'){
		if(confirm('确认要启用吗?')){
			document.srcForm.action=path+"securityPolicy/updateSecurityPolicy.action?id="+id+"&&status="+status+"";
			document.srcForm.submit();
		  }
		  else{
			  return;
		  }
	}else{
		if(confirm('确认要停用吗?')){
			document.srcForm.action=path+"securityPolicy/updateSecurityPolicy.action?id="+id+"&&status="+status+"";
			document.srcForm.submit();
		  }
		  else{
			  return;
		  }
	}
}
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post">
<div class="kuangjia" >
<div class="heading" align="center">安全策略设置</div>
<table class="contenttable" border="1"   style= "BORDER-COLLAPSE:   collapse" >
<thead class="heading">
<tr align="center">
		<th>策略名称</th><th>状态</th><th>操作</th><th>设置</th><th>描述</th>
</tr>
</thead>
<%
if(datalist!=null&&datalist.size()!=0){
	   for(int i=0;i<datalist.size();i++)
	   {
		   Data data = datalist.getData(i);  
	   
%>
<tr align="center">
		<td><%=data.getString("CNAME") %></td>
		<td>
		<%
			if(data.getString("STATUS").equals("0")){
		%>
		<font color="red">停用</font>
		<%
	 		}	
			if(data.getString("STATUS").equals("1")){
		%>
		<font color="green">启用</font>
		<%
			}
		%>
		</td>
		<td>
		<%
		if(data.getString("STATUS").equals("0")){
		%>
		<input type="button" class="button_start" value="启用" onclick="_changeStatus('<%=data.getString("ID") %>',1)" />
		&nbsp;
		<input type="button" class="button_stop" value="停用"  onclick="_changeStatus('<%=data.getString("ID") %>',0)" disabled="disabled"/>
		<%
		}
		%>
		<%
		if(data.getString("STATUS").equals("1")){
		%>
		<input type="button" class="button_start" value="启用" onclick="_changeStatus('<%=data.getString("ID") %>',1)" disabled="disabled"/>
		&nbsp;
		<input type="button" class="button_stop" value="停用"  onclick="_changeStatus('<%=data.getString("ID") %>',0)"/>
		<%
		}
		%>
		</td>
		<td>
		<span style="cursor:hand;">
		<a  onclick="_skip('<%=data.getString("ID") %>');return false;">设置</a>
		</span>
		</td>
		<td><%=data.getString("MEMO") %></td>
</tr>
		<%
	   }
}
else{
	System.out.println("安全策略设置页面获得的dataList为null");
}
%>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>