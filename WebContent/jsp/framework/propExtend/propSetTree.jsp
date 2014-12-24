<!-- jsp/framework/propExtend/propSetTree.jsp -->
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>

<BZ:html>
<BZ:head>
	<title>设置选项树</title>
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
		if(id=='-1'){
			id="0";
		}
		parent.mainFrame.location = "<%=request.getContextPath() %>/prop/propExtend!gotoMainPage.action?parent_id="+id;
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="organ/Organ!generateTree.action">
		<div class="kuangjia">
			<div class="list">
				<div class="heading">属性扩展</div>
				<BZ:tree property="dataList" topName="属性扩展" type="0" iconPath="/images/tree_org/"/>
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>