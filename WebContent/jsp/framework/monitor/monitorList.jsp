<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ page import="hx.database.databean.*"%>
<%@page import="hx.database.databean.Data"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.*"%>

<%
	DataList datalist = (DataList)request.getAttribute("pList");
	
	 String compositor=(String)request.getParameter("compositor");
	    if(compositor==null){
	    	compositor="";
	    }
	    String ordertype=(String)request.getParameter("ordertype");
	    if(ordertype==null){
	    	ordertype="";
	    }
	%>
<BZ:html>
<BZ:head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>������Ա��ع���</title>
	<BZ:script isList="true" />
	
	<script type="text/javascript">
	
	function _onload(){
		  	
	 }
	function _logOutForce(id) {
		
		if(confirm('ȷ��Ҫǿ���˳����˺���?')){
			  document.srcForm.action=path+"monitor/logoutAction.action?personId="+id;
			  document.srcForm.submit();
		}
		
	
	}
	
</script>
</BZ:head>
<BZ:body onload="_onload()" >
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
	<BZ:form name="srcForm" method="post" action="monitor/Monitor">
	<input type="hidden" name="compositor" value="<%=compositor%>"/>
	<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
	<BZ:input field="PERSON_ID" prefix="Person_" type="hidden" />
		<BZ:frameDiv property="clueTo" className="kuangjia">
			<div class="list">
			<div class="heading">������Ա�б�</div>
			<BZ:table tableid="tableGrid" tableclass="tableGrid">
				<BZ:thead theadclass="titleBackGrey">
					<BZ:th name="���" sortType="none" width="5%" sortplan="jsp"></BZ:th>
					<BZ:th name="�˺�ID" sortType="string" width="20%" sortplan="jsp"></BZ:th>
					<BZ:th name="����" sortType="string" width="20%" sortplan="jsp"></BZ:th>
					<BZ:th name="��¼ʱ��" sortType="string" width="25%" sortplan="jsp"></BZ:th>
					<BZ:th name="����" sortType="none" width="15%" sortplan="jsp"></BZ:th>
				</BZ:thead>
				<BZ:tbody>
				
				<BZ:for property="pList" fordata="data">
				<tr >
					<td tdvalue="<BZ:data field="personId" onlyValue="true"/>"><BZ:i></BZ:i></td>
					<td><BZ:data field="PERSONID" onlyValue="true"/></td>
					<td><BZ:data field="CNAME" onlyValue="true"/></td>
					<td><BZ:data field="LOGTIME" onlyValue="true"/></td>
					<td><input type="button" class="button_stop" value="ǿ���˳�"  onclick="_logOutForce('<BZ:data field="personId" onlyValue="true"/>')"/></td>
				</tr>
				</BZ:for>
				</BZ:tbody>
			</BZ:table></div>
		</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>