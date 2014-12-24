
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>组织树</title>
	<base target="_self"/>
	<BZ:script isList="true" tree="true"/>
	<script type="text/javascript">
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		
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
		if(confirm('确认选择组织机构吗?')){
			reValue["name"]=showName;
			reValue["value"]=id;
			//if(id.length>2){
			//	reValue["value"]=id.substring(2,id.length);//////////////////////////////去掉前缀 
			//}
			window.returnValue = reValue;
			window.close();
		}else{
		  return;
		}
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" target="_self">
		<div class="kuangjia">
		<div class="list">
		<!-- 组织机构树形 -->
		<div class="heading">选择组织机构</div>
			<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>