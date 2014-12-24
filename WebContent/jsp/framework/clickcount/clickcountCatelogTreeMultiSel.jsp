
<%@ page language="java" contentType="text/html; charset=GBK"  pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<BZ:html>
<BZ:head>
<title>分类树</title>
<base target="_self"/>
<BZ:script isList="true" tree="true"/>
<script type="text/javascript">
var requiredType="<%=request.getParameter("type")%>"; //前一页面所选择的类型[分类/资源];1 分类
function L(id,selNode){
	reValue = new Array();
	if(!selNode || selNode=="false"){
		isSelNode=false;
	}
	//处理
}

var isShowParentString = "<BZ:attribute key="showParent" defaultValue="false"/>";
var isShowParent = false;
if ("true" == isShowParentString) {
	isShowParent = true;
}
function _ok(){
	if (tree.useCheckbox) {
		var nodes = tree.nodes;
		var sel = false;
		var isSelect=false;
		for ( var i in nodes) {
			if (nodes[i].checked) {
				sel = true;
				break;
			}
		}
		if(tree.onlyCheckChild){
			if (!sel && isSelect){
				alert("您只能选择叶子节点，在选择的节点中不包含叶子节点，请重新选择。");
				return;
			}
		}
		if (!sel) {
			alert("请选择内容。");
			return;
		}
	} else {
		if(tree.onlyCheckChild){
			var node = tree.selectedNode;
			if(node.hasChild){
				alert("只能选择叶子节点，请重新选择。");
				return;
			}
		}
		if (tree.selectedNode.id == null) {
			alert("请选择内容。");
			return;
		}
	}
	var reValue = null;
	if (tree.useCheckbox && !tree.onlySelectSelf) {
		reValue = getSelectValue(tree, isShowParent, true);
	} else {
		reValue = getSelectValue(tree, isShowParent, false);
	}
	window.returnValue=reValue;
	//alert(reValue+"    "+reValue.length);
	var sfdj=0;
	for(var i=0 ;i<reValue.length;i++){
		reValue[i]["value"]=reValue[i]["value"].substring(2);
		sfdj++;
	}

	if(sfdj==0){
		   alert('请选择要统计的页面分类');
		   return;
	}
	window.close();
}

function confirmSelect_(){
	
	//if(_sel()){
	if(isSelNode){
		
		alert(reValue["value"]);
		alert(reValue["name"]);
		if("0"==requiredType && reValue["value"].indexOf("1_")==0){
			alert("请选择页面！");
			return;
		}
	    window.returnValue=reValue ;//|| {name:"",value:""}
		window.close();
	}else{
		if(requiredType==1){
			alert("请选择一个分类");
		}else{
			alert("请选择一个页面");
		}
	}
}
function indexOf(str,chr) {
	for(var i=0;i<str.length;i++){
        if(str.charCodeAt(i)==chr) {
	        return true;
        }
   }
   return false;
}


function closeWin_(){    
    window.returnValue=null;
	window.close();
}

function reset_(){		
	window.returnValue={};
    window.close();
}
</script>
</BZ:head>
<BZ:body codeNames="codeList" >
	   <div class="kuangjia">
			<div class="list">
				<!-- 组织机构树形 -->
				<div class="heading">选择页面分类</div>
				<table>
				<tr>
				<td style="padding-left:15px">
				    <input type="button" class="button_change" value="全部展开" onclick="tree.expandAll();">
				    <input type="button" class="button_change" value="全选" onclick="tree.expandAll();tree.selectAll('checked');">
				    <input type="button" class="button_change" value="全不选" onclick="tree.selectAll('');">
				    <input type="button" class="button_add" value="确定" onclick="_ok();">
				    <input type="button" value="清空" class="button_back" onclick="reset_()"/>
				</td>
				</tr>
					<tr>
						<td>
						<% if("1".equals(request.getParameter("type"))){%>
							<BZ:tree property="codeList" type="1" iconPath="/images/tree_org/"/>
						<%}else{ %>
							<BZ:tree property="codeList" type="1" />
						<%} %>
						
						</td>
					</tr>
				</table>
			</div>
	   </div>	
</BZ:body>
</BZ:html>