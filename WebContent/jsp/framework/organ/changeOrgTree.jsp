
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	Data data = (Data)request.getAttribute("data");
	String path = request.getContextPath();
%>
<BZ:html>
<BZ:head>
	<title>��֯��</title>
	<base target="_self"/>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript">
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		if(id=='-1'){
			id="0";
		}
		//����
		if(confirm("ȷ��Ҫ������")){
			document.getElementById("OrganPerson_ORG_ID").value=id;
			document.srcForm.submit();
			window.close();
		}
	}
	</script>
</BZ:head>
<BZ:body property="data">
	<BZ:form name="srcForm" method="post" action="person/Person!changeOrg.action">
		<!-- ��֯��������Ա��ID -->
		<BZ:input field="ID" prefix="OrganPerson_" type="hidden"/>
		<!-- ����ǰ����֯����ID -->
		<input name="ORG_ID" id="ORG_ID" type="hidden" value="<%=data.getString("ORG_ID")!=null?data.getString("ORG_ID"):"" %>"/>
		<!-- ���������֯����ID -->
		<input name="OrganPerson_ORG_ID" id="OrganPerson_ORG_ID" type="hidden"/>
		<div class="kuangjia">
		<div class="list">
		<div class="heading">ѡ����֯����</div>
			<!-- ��֯�������� -->
			<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/" topName="��֯����"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>