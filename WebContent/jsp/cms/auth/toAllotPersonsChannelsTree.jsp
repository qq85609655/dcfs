<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.auth.vo.PersonChannelRela"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String role = (String) request.getAttribute(PersonChannelRela.ROLE);
	String personsId = (String) request.getAttribute("PERSONS_ID");
%>
<BZ:html>
<BZ:head>
	<base target="_self"/>
	<title>栏目树</title>
	<BZ:script tree="true" />
	<script type="text/javascript">

	var role = '<%=role %>';
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
			/* if (!sel) {
				alert("请选择内容。");
				return;
			} */
		} else {
			if(tree.onlyCheckChild){
				var node = tree.selectedNode;
				if(node.hasChild){
					alert("只能选择叶子节点，请重新选择。");
					return;
				}
			}
			/* if (tree.selectedNode.id == null) {
				alert("请选择内容。");
				return;
			} */
		}
		var reValue = null;
		if (tree.useCheckbox && !tree.onlySelectSelf) {
			reValue = getSelectValue(tree, isShowParent, true);
		} else {
			reValue = getSelectValue(tree, isShowParent, false);
		}
		window.returnValue=reValue;
		var name="";
		var value="";
		var appIds="";
		var sfdj=0;
		for(var i=0 ;i<reValue.length;i++){
			appIds=appIds + reValue[i]["value"]+"#";
			sfdj++;
		}
		
		if(confirm('确认要分配吗?')){
		  document.getElementById("CHANNEL_IDS").value=appIds;
		  if(role == '1'){
		  	document.srcForm.action=path+"cms_auth/Auth!writerChannels.action?RESULT=NO";
		  }
		  if(role == '2'){
		  	document.srcForm.action=path+"cms_auth/Auth!auditChannels.action?RESULT=NO";
		  }
		  document.srcForm.submit();
		  //关闭
		  window.close();
		}else{
		  return;
		}
	}
	/* $(document).ready(function(){
		  dyniframesize([ 'left1Frame','mainFrame' ]);
	}); */
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="">
		<div class="kuangjia">
		<!-- 选中的栏目的ID -->
		<input id="CHANNEL_IDS" name="CHANNEL_IDS" type="hidden"/>
		<!-- 人员ID -->
		<input name="PERSONS_IDS" id="PERSONS_IDS" type="hidden" value='<%=personsId!=null?personsId:"" %>'/>
		<div class="list">
		<table border="0" cellpadding="0" cellspacing="0" class="operation">
		<tr>
		<td style="padding-left:15px"></td>
		<td align="right" style="padding-right:10px;height:35px;">
		    <input type="button" class="button_add" value="分配权限" onclick="_ok();">
		    <input type="button" value="关闭" class="button_back" onclick="window.close();"/>
		</td>
		</tr>
		</table>
		<div class="heading">选择要分配的栏目</div>
		<BZ:tree property="dataList" type="2" selectvalue="ownResource" topName="栏目树"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>