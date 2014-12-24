<%@page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
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
		parent.mainFrame.location = "<%=request.getContextPath()%>/role/RoleGroup!queryChildrenPage.action?<%=RoleGroup.PARENT_ID%>="+id;
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="role/RoleGroup!generateTree.action">
		<div class="kuangjia">
			<div class="list">
				<!-- 组织机构树形 -->
				<div class="heading">选择角色组</div>
					<!-- 修改角色组的标志位 -->
					<input type="hidden" name="treeDispatcher" value="roleGroupTree"/>
					<BZ:tree property="dataList" type="0" topName="角色分组树"/>
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>