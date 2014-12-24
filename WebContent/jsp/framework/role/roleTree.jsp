
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>角色组树</title>
	<BZ:script tree="true" />
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		//处理
		parent.mainFrame.location = "<%=request.getContextPath() %>/role/Role!queryChildren.action?<%=RoleGroup.PARENT_ID%>="+id;
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="role/RoleGroup!generateTree.action">
		<!-- 修改角色组的标志位 -->
		<input type="hidden" name="treeDispatcher" value="roleTree"/>
		<div class="kuangjia">
		<div class="list">
		<!-- 组织机构树形 -->
		<div class="heading">选择角色组</div>
		<table>
			<tr>
				<td><BZ:tree property="dataList" type="0"/></td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>