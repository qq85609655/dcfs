
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>组织树</title>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript">
	function L(id,isSelNode,node,tree){
		var reValue = new Array();
		//alert(selNode);
		//alert((selNode || !tree.currentNode.hasChild));
		if(isSelNode || !tree.currentNode.hasChild){
			//alert(111);
			//判断是否是要显示上级的名称
			var show_parent = document.getElementsByName("showParent");
			var showName ="";
			if (show_parent!=null && show_parent.length>0){
				show_parent=show_parent[0];
				if (show_parent!=null){
					var showP = show_parent.value;
					alert(showP);
					if (showP.toUpperCase()=="TRUE"){
						showName=_show_all_name(tree.currentNode);
					}
				}
			}
			if (showName==""){
				showName=node.text;
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

	function reset_(){
		window.returnValue={'name':'','value':''};
			window.close();
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="organ/Organ!generateTree.action">
		<!-- 修改组织机构的标志位 -->
		<input type="hidden" name="treeDispatcher" value="organTree" />
		<div class="kuangjia">
		<div class="list">
		<div class="heading">选择组织机构</div>
		<!-- 组织机构树形 -->
		<table width="100%">
			<tr>
				<td align="right" style="padding-right:0px">
						<input type="button" value="清空" class="button_back" onclick="reset_()"/>
				</td>
			</tr>
			<tr>
				<td><BZ:tree property="dataList" type="0" iconPath="/images/tree_org/"/></td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>