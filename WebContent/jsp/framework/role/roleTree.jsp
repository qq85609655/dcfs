
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>��ɫ����</title>
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
		//����
		parent.mainFrame.location = "<%=request.getContextPath() %>/role/Role!queryChildren.action?<%=RoleGroup.PARENT_ID%>="+id;
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="role/RoleGroup!generateTree.action">
		<!-- �޸Ľ�ɫ��ı�־λ -->
		<input type="hidden" name="treeDispatcher" value="roleTree"/>
		<div class="kuangjia">
		<div class="list">
		<!-- ��֯�������� -->
		<div class="heading">ѡ���ɫ��</div>
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