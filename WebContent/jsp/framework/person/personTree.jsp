
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>组织树</title>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['leftFrame','mainFrame']);
	});
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		sId=id;
		if(id=='-1'){
			id="0";
			sId="";
		}else if(id=="0"){
			id="";
			sId="";
		}

		//处理
		parent.mainFrame.location = "<%=request.getContextPath() %>/person/Person!query.action?<%=OrganPerson.ORG_ID%>="+id+"&S_ORG_ID="+sId+"&compositor=SEQ_NUM";
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="organ/Organ!generateTree.action">
		<!-- 修改组织机构的标志位 -->
		<input type="hidden" name="treeDispatcher" value="personTree"/>
		<div class="kuangjia">
		<div class="list">
		<!-- 组织机构树形 -->
		<div class="heading">选择组织机构</div>
			<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/"  topName="组织机构"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>