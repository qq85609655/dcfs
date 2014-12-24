<!-- jsp/framework/sync/setTree.jsp -->
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>

<BZ:html>
<BZ:head>
	<title>功能菜单树</title>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript">
	$(document).ready(function(){
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
		if(id=='targetSysMgr'){
			parent.mainFrame.location = "<%=request.getContextPath() %>/sync/TargetSys.action";
		}
		if(id=='syncConfigMgr'){
			parent.mainFrame.location = "<%=request.getContextPath() %>/sync/SyncConfig.action";
		}
		if(id=='syncRecMgr'){
			parent.mainFrame.location = "<%=request.getContextPath() %>/sync/SyncRecord.action";
		}
		if(id=='dataSyncInit'){
			parent.mainFrame.location = "<%=request.getContextPath() %>/sync/SyncInit.action";
		}
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="">
		<div class="kuangjia">
			<div class="list">
				<div class="heading">数据同步</div>
				<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/"/>
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>