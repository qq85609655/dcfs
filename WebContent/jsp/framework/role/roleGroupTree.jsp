<%@page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>��֯��</title>
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
		//����
		parent.mainFrame.location = "<%=request.getContextPath()%>/role/RoleGroup!queryChildrenPage.action?<%=RoleGroup.PARENT_ID%>="+id;
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="role/RoleGroup!generateTree.action">
		<div class="kuangjia">
			<div class="list">
				<!-- ��֯�������� -->
				<div class="heading">ѡ���ɫ��</div>
					<!-- �޸Ľ�ɫ��ı�־λ -->
					<input type="hidden" name="treeDispatcher" value="roleGroupTree"/>
					<BZ:tree property="dataList" type="0" topName="��ɫ������"/>
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>