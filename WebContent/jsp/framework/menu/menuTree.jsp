
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
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
		if(id=='-1'){
			id=0;
		}
		parent.mainFrame.location = "<%=request.getContextPath() %>/menu/menuList.action?NAV_ID=<%=request.getParameter("NAV_ID")%>&PARENT_ID="+id;
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="menu/menuTree.action">
		<!-- �޸���֯�����ı�־λ -->
		<input type="hidden" name="treeDispatcher" value="menuTree" />
		<div class="kuangjia">
		<div class="list">
		<div class="heading">ѡ��˵�</div>
			<!-- ��֯�������� -->
			<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/" topName="�˵�" selectvalue="selectValue"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>