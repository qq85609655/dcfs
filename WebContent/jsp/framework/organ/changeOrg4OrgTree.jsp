
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
		//����
		if(confirm("ȷ��Ҫ������")){
			document.getElementById("Organ_PARENT_ID").value=id;
			document.srcForm.submit();
			window.close();
		}
	}
	</script>
</BZ:head>
<BZ:body property="data">
	<BZ:form name="srcForm" method="post" action="organ/Organ!changeOrg.action">
		<!-- ��֯��������Ա��ID -->
		<BZ:input field="ID" prefix="Organ_" type="hidden"/>
		<!-- ����ǰ����֯����ID -->
		<input name="PARENT_ID" id="PARENT_ID" type="hidden" value="<%=data.getString("PARENT_ID")!=null?data.getString("PARENT_ID"):"" %>"/>
		<!-- ���������֯����ID -->
		<input name="Organ_PARENT_ID" id="Organ_PARENT_ID" type="hidden"/>
		<div class="kuangjia">
		<div class="list">
		<div class="heading">ѡ����֯����</div>
			<!-- ��֯�������� -->
			<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/" />
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>