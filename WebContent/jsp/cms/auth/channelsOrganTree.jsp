<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>��֯��</title>
	<BZ:script tree="true" />
	<script type="text/javascript">
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		//����
		if(id=='-1'){
			id=0;
		}
		parent.mainFrame.location="<%=request.getContextPath() %>/cms_auth/Auth!personList.action?<%=OrganPerson.ORG_ID%>="+id;
	}
	$(document).ready(function() {
		dyniframesize(['left2Frame']);
	});
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="organ/Organ!generateTree.action">
		<!-- �޸���֯�����ı�־λ -->
		<input type="hidden" name="treeDispatcher" value="personTree"/>
		<div class="kuangjia">
		<div class="list">
		<div class="heading">ѡ����֯����</div>
			<!-- ��֯�������� -->
			<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/" topName="��֯��"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>