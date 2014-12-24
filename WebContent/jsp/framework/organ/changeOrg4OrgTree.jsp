
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
		//处理
		if(confirm("确定要调整吗？")){
			document.getElementById("Organ_PARENT_ID").value=id;
			document.srcForm.submit();
			window.close();
		}
	}
	</script>
</BZ:head>
<BZ:body property="data">
	<BZ:form name="srcForm" method="post" action="organ/Organ!changeOrg.action">
		<!-- 组织机构与人员的ID -->
		<BZ:input field="ID" prefix="Organ_" type="hidden"/>
		<!-- 调动前的组织机构ID -->
		<input name="PARENT_ID" id="PARENT_ID" type="hidden" value="<%=data.getString("PARENT_ID")!=null?data.getString("PARENT_ID"):"" %>"/>
		<!-- 调整后的组织机构ID -->
		<input name="Organ_PARENT_ID" id="Organ_PARENT_ID" type="hidden"/>
		<div class="kuangjia">
		<div class="list">
		<div class="heading">选择组织机构</div>
			<!-- 组织机构树形 -->
			<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/" />
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>