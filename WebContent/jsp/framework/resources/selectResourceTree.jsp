
<%@page import="com.hx.framework.role.vo.Role"%>
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>应用树</title>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript">
	function L(id,selNode){
		var isSelNode=false;
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}else{
			isSelNode=true;
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
			reValue["name"]=showName;
			reValue["value"]=id;
		}
		//处理
		if(confirm('确认选择组织机构吗?')){
			window.returnValue = reValue;
			window.close();
		}else{
		  return;
		}
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post">
		<div class="kuangjia">
		<div class="list">
		<!-- 应用树 -->
		<div class="heading">选择资源</div>
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