
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
		sId=id;
		if(id=='-1'){
			id="0";
			sId="";
		}else if(id=="0"){
			id="";
			sId="";
		}

		//����
		parent.mainFrame.location = "<%=request.getContextPath() %>/organ/Organ!queryChildrenPage.action?<%=Organ.PARENT_ID%>="+id+"&compositor=SEQ_NUM";
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="organ/Organ!generateTree.action">
		<!-- �޸���֯�����ı�־λ -->
		<input type="hidden" name="treeDispatcher" value="organTree"/>
		<div class="kuangjia">
		<div class="list">
		<!-- ��֯�������� -->
		<div class="heading">ѡ����֯����</div>
			<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/"  topName="��֯����"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>