
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
		//处理
		if(id=='-1'){
			id=0;
		}
		parent.mainFrame.location="<%=request.getContextPath() %>/person/Person!queryPersonAppList.action?<%=OrganPerson.ORG_ID%>="+id;
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="organ/Organ!generateTree.action">
		<!-- 修改组织机构的标志位 -->
		<input type="hidden" name="treeDispatcher" value="personAppAuthorizeTree"/>
		<div class="kuangjia">
		<div class="list">
		<div class="heading">选择组织机构</div>
			<!-- 组织机构树形 -->
			<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/" topName="组织机构" />
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>