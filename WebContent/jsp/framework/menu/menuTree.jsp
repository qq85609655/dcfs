
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>组织树</title>
	<BZ:script tree="true" />
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
		parent.mainFrame.location = "<%=request.getContextPath() %>/menu/menuList.action?NAV_ID=<%=request.getParameter("NAV_ID")%>&PARENT_ID="+id;
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="menu/menuTree.action">
		<!-- 修改组织机构的标志位 -->
		<input type="hidden" name="treeDispatcher" value="menuTree" />
		<div class="kuangjia">
		<div class="list">
		<div class="heading">选择菜单</div>
			<!-- 组织机构树形 -->
			<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/" topName="菜单" selectvalue="selectValue"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>