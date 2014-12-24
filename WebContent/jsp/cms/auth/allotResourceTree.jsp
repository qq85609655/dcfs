<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>应用树</title>
	<base target="_self"/>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript">
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		//处理
	}

	function _ok(){
		if(!_sel()){
			alert("请选择内容！");
			return;
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

		if(sfdj=="0"){
			   alert('请选择要分配的数据');
			   return;
		}else{
			if(confirm('确认要分配吗?')){
			  document.getElementById("CHANNEL_IDS").value=appIds;
			  document.srcForm.action=path+"cms_auth/Auth!alotChannels.action";
			  document.srcForm.submit();
			}else{
			  return;
			}
		}
	}

	function _back(){
		document.srcForm.action=path+"role/Role!queryChildren.action?PARENT_ID=0";
 		document.srcForm.submit();
	}
	function _onload1(){
		try{
			tree.expandAll();
		}catch(e){}
	}
	</script>
</BZ:head>
<BZ:body onload="_onload1();">
	<BZ:form name="srcForm" method="post" action="">
		<div class="kuangjia">
		<!-- 选中的栏目的ID -->
		<input id="CHANNEL_IDS" name="CHANNEL_IDS" type="hidden"/>
		<!-- 角色组ID -->
		<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(RoleGroup.PARENT_ID) %>"/>
		<!-- 角色ID -->
		<input name="ROLE_ID" id="ROLE_ID" type="hidden" value="<%=request.getAttribute("ROLE_ID")!=null?request.getAttribute("ROLE_ID"):"" %>"/>
		<div class="list">
		<table border="0" cellpadding="0" cellspacing="0" class="operation">
		<tr>
		<td style="padding-left:15px"></td>
		<td align="right" style="padding-right:10px;height:35px;">
		    <input type="button" class="button_add" value="确定" onclick="_ok();">
		    <input type="button" value="返回" class="button_back" onclick="_back()"/>
		</td>
		</tr>
		</table>
		<div class="heading">选择要分配的栏目</div>
		<!-- 应用树 -->
		<BZ:tree property="dataList" type="4" selectvalue="ownResource"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>