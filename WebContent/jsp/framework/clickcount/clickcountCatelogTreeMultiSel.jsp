
<%@ page language="java" contentType="text/html; charset=GBK"  pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<BZ:html>
<BZ:head>
<title>������</title>
<base target="_self"/>
<BZ:script isList="true" tree="true"/>
<script type="text/javascript">
var requiredType="<%=request.getParameter("type")%>"; //ǰһҳ����ѡ�������[����/��Դ];1 ����
function L(id,selNode){
	reValue = new Array();
	if(!selNode || selNode=="false"){
		isSelNode=false;
	}
	//����
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
				alert("��ֻ��ѡ��Ҷ�ӽڵ㣬��ѡ��Ľڵ��в�����Ҷ�ӽڵ㣬������ѡ��");
				return;
			}
		}
		if (!sel) {
			alert("��ѡ�����ݡ�");
			return;
		}
	} else {
		if(tree.onlyCheckChild){
			var node = tree.selectedNode;
			if(node.hasChild){
				alert("ֻ��ѡ��Ҷ�ӽڵ㣬������ѡ��");
				return;
			}
		}
		if (tree.selectedNode.id == null) {
			alert("��ѡ�����ݡ�");
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
		   alert('��ѡ��Ҫͳ�Ƶ�ҳ�����');
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
			alert("��ѡ��ҳ�棡");
			return;
		}
	    window.returnValue=reValue ;//|| {name:"",value:""}
		window.close();
	}else{
		if(requiredType==1){
			alert("��ѡ��һ������");
		}else{
			alert("��ѡ��һ��ҳ��");
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
				<!-- ��֯�������� -->
				<div class="heading">ѡ��ҳ�����</div>
				<table>
				<tr>
				<td style="padding-left:15px">
				    <input type="button" class="button_change" value="ȫ��չ��" onclick="tree.expandAll();">
				    <input type="button" class="button_change" value="ȫѡ" onclick="tree.expandAll();tree.selectAll('checked');">
				    <input type="button" class="button_change" value="ȫ��ѡ" onclick="tree.selectAll('');">
				    <input type="button" class="button_add" value="ȷ��" onclick="_ok();">
				    <input type="button" value="���" class="button_back" onclick="reset_()"/>
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