
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	Data data = (Data)request.getAttribute("data");
	String path = request.getContextPath();
%>
<BZ:html>
<BZ:head>
	<title>组织树</title>
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
		//处理
		if(confirm("确定要调整吗？")){
			document.getElementById("OrganPerson_ORG_ID").value=id;
			document.srcForm.submit();
			window.close();
		}
	}
	</script>
</BZ:head>
<BZ:body property="data">
	<BZ:form name="srcForm" method="post" action="person/Person!changeOrg.action">
		<!-- 组织机构与人员的ID -->
		<BZ:input field="ID" prefix="OrganPerson_" type="hidden"/>
		<!-- 调动前的组织机构ID -->
		<input name="ORG_ID" id="ORG_ID" type="hidden" value="<%=data.getString("ORG_ID")!=null?data.getString("ORG_ID"):"" %>"/>
		<!-- 调整后的组织机构ID -->
		<input name="OrganPerson_ORG_ID" id="OrganPerson_ORG_ID" type="hidden"/>
		<div class="kuangjia">
		<div class="list">
		<div class="heading">选择组织机构</div>
			<!-- 组织机构树形 -->
			<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/" topName="组织机构"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>