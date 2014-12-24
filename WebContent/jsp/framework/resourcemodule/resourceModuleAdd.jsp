
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String APP_ID=(String)request.getAttribute("APP_ID");
if(APP_ID==null){
	APP_ID="";
}
String PMOUDLE=(String)request.getAttribute("PMOUDLE");
if(PMOUDLE==null){
    PMOUDLE="";
}
String PNAME=(String)request.getAttribute("PNAME");
if(PNAME==null){
    PNAME="";
}
request.setAttribute("data",new Data());
%>
<BZ:html>
<BZ:head>
<title>模块添加页面</title>
<BZ:script tree="true"/>
<script type="text/javascript" language="javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
			}else{
				if(confirm('是否要生成菜单?')){
					document.srcForm.action=path+"module/resourceModuleAdd.action?flag=1";
					document.srcForm.submit();
				}	else{
					document.srcForm.action=path+"module/resourceModuleAdd.action?flag=2";
					document.srcForm.submit();
				}
		}
	}
	function _back(){
	document.srcForm.action=path+"module/resourceModuleList.action?APP_ID=<%=APP_ID%>&PMOUDLE=<%=PMOUDLE%>";
	document.srcForm.submit();
	}

	function showModuleTree(obj){
	var x=obj.offsetLeft,y=obj.offsetTop;
		while(obj=obj.offsetParent)
		{
			x+=obj.offsetLeft;
			y+=obj.offsetTop;
		}
	//document.getElementById('tujxzobj').value=tyjname;
	document.getElementById('moduleTreeDiv').style.left=x;
	document.getElementById('moduleTreeDiv').style.top=y+20;
	document.getElementById('moduleTreeDiv').style.display='';
	}

	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		//处理
	document.getElementById('moduleTreeDiv').style.display='none';
	if(id==''){
		id='0';
	}
	document.getElementById('PMOUDLE').value=id;
	document.getElementById('PNAME').value=tree.currentNode.T;
	}

	function _close(){
	document.getElementById('moduleTreeDiv').style.display='none';
	}

	function _qingkong(){
	document.getElementById('PMOUDLE').value="0";
	document.getElementById('PNAME').value="";
	document.getElementById('moduleTreeDiv').style.display='none';
	}

</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="resourceModuleAdd">
<input type="hidden" name="P_APP_ID" value="<%=APP_ID%>"/>
<BZ:input field="PMOUDLE" type="hidden" prefix="P_" defaultValue="<%=PMOUDLE %>" id="PMOUDLE"/>
<div id="moduleTreeDiv" style="position:absolute; width:150px; background-color:#646464; height:200px;z-index:199; display:none" onmouseleave="_close()">
<div style="height:175px; overflow:auto; margin-top:2px; margin-left:2px; margin-right:2px; background-color:#FFF">
<BZ:tree property="moduleTree" type="0"/>
</div>
<div align="center"><input type="button" name="qingchu" value="清空" onclick="_qingkong()"/></div>
</div>
<div class="kuangjia">
<div class="heading">模块添加</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">模块名称</td>
<td width="20%"><BZ:input field="CNAME" type="String" prefix="P_" defaultValue="" notnull="请输入模块名称" formTitle="模块名称"/></td>
<td width="12%">英文名称</td>
<td width="18%"><BZ:input field="ENNAME" type="String" prefix="P_" defaultValue="" notnull="请输入英文名称" formTitle="英文名称"/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>父模块</td>
<td><BZ:input field="PNAME" id="PNAME" type="String" prefix="P_" defaultValue="<%=PNAME %>" onclick="showModuleTree(this)"/></td>
<td>是否需要权限控制</td>
<td>是&nbsp;<BZ:radio field="NEED_RIGHT" prefix="P_"  value="1" property="data" formTitle="权限控制" defaultChecked="true"/>&nbsp;&nbsp;否&nbsp;<BZ:radio field="NEED_RIGHT" prefix="P_" formTitle="权限控制" value="0" property="data" /></td>
<td></td>
</tr>
<tr>
<td></td>
<td>是否可管理</td>
<td>是&nbsp;<BZ:radio field="ADMIN_FLAG" prefix="P_" formTitle="权限控制" value="1" property="data" defaultChecked="true"/>&nbsp;&nbsp;否&nbsp;<BZ:radio field="ADMIN_FLAG" prefix="P_" formTitle="权限控制" value="0" property="data" /></td>
<td>状态</td>
<td><BZ:select field="STATUS" formTitle="状态" property="data" prefix="P_" ><BZ:option value="1">启用</BZ:option><BZ:option value="0">停用</BZ:option></BZ:select></td>
<td></td>
</tr>
<tr>
<td></td>
<td>描述</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_MEMO"></textarea></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>