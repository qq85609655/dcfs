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
	if(id==unlockPolicy){//������˺��Զ�����������ת�������2���˺��Զ��������Ե�ID���������ID�仯���Ը�������
		document.srcForm.action=path+"poAccUnlock/poAccList.action";
		document.srcForm.submit();
	}
}
function _changeStatus(id,status){
	if(status=='1'){
		if(confirm('ȷ��Ҫ������?')){
			document.srcForm.action=path+"securityPolicy/updateSecurityPolicy.action?id="+id+"&&status="+status+"";
			document.srcForm.submit();
		  }
		  else{
			  return;
		  }
	}else{
		if(confirm('ȷ��Ҫͣ����?')){
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
<div class="heading" align="center">��ȫ��������</div>
<table class="contenttable" border="1"   style= "BORDER-COLLAPSE:   collapse" >
<thead class="heading">
<tr align="center">
		<th>��������</th><th>״̬</th><th>����</th><th>����</th><th>����</th>
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
		<font color="red">ͣ��</font>
		<%
	 		}	
			if(data.getString("STATUS").equals("1")){
		%>
		<font color="green">����</font>
		<%
			}
		%>
		</td>
		<td>
		<%
		if(data.getString("STATUS").equals("0")){
		%>
		<input type="button" class="button_start" value="����" onclick="_changeStatus('<%=data.getString("ID") %>',1)" />
		&nbsp;
		<input type="button" class="button_stop" value="ͣ��"  onclick="_changeStatus('<%=data.getString("ID") %>',0)" disabled="disabled"/>
		<%
		}
		%>
		<%
		if(data.getString("STATUS").equals("1")){
		%>
		<input type="button" class="button_start" value="����" onclick="_changeStatus('<%=data.getString("ID") %>',1)" disabled="disabled"/>
		&nbsp;
		<input type="button" class="button_stop" value="ͣ��"  onclick="_changeStatus('<%=data.getString("ID") %>',0)"/>
		<%
		}
		%>
		</td>
		<td>
		<span style="cursor:hand;">
		<a  onclick="_skip('<%=data.getString("ID") %>');return false;">����</a>
		</span>
		</td>
		<td><%=data.getString("MEMO") %></td>
</tr>
		<%
	   }
}
else{
	System.out.println("��ȫ��������ҳ���õ�dataListΪnull");
}
%>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>