
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
<title>人员选择树</title>
<base target="_self"/>
<BZ:script isList="true" tree="true"/>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['leftFrame','mainFrame']);
});
function L(id,isSelNode,node,tree){

		var reValue = new Array();
	if(isSelNode || !tree.currentNode.hasChild){

		//判断是否是要显示上级的名称
		var show_parent = document.getElementsByName("showParent");
		var showName ="";
		if (show_parent!=null && show_parent.length>0){
			show_parent=show_parent[0];
			if (show_parent!=null){
				var showP = show_parent.value;
				if (showP.toUpperCase()=="TRUE"){
					showName=_show_all_name(tree.currentNode);
				}
			}
		}
		if (showName==""){
			showName=tree.currentNode.T;
		}

	}
	//处理
	if(id.indexOf("P_")==0){
		if(confirm('确认选择此人员吗?')){
			reValue["name"]=showName;
			reValue["value"]=id;
			if(id.length>2){
				reValue["value"]=id.substring(2,id.length);//////////////////////////////去掉前缀
			}
			window.returnValue = reValue;
			window.close();
		}else{
			return;
		}
	}
}
</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" target="_self">
		<div class="kuangjia">
		<div class="list">
		<!-- 组织机构树形 -->
		<div class="heading">选择人员</div>
			<BZ:tree property="personOrgCode" type="0"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>