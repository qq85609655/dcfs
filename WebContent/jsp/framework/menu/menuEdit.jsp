
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String NAV_ID=(String)request.getAttribute("NAV_ID");
if(NAV_ID==null){
	NAV_ID="";
}
String parentId=(String)request.getParameter("PARENT_ID");
if(parentId==null){
	parentId="0";
}

StringBuilder resStr=new StringBuilder("[");
DataList codeList=(DataList)request.getAttribute("resList");
for(int i=0;i<codeList.size();i++) {
		Data d=(Data)codeList.get(i);
		resStr.append("{moduleId:'");
		resStr.append(d.get("MODULEID"));
		resStr.append("',value:'");
		resStr.append(d.get("VALUE"));
		resStr.append("',text:'");
		resStr.append(d.get("NAME"));
		resStr.append("'},");
}
resStr.append("{moduleId:'',value:'',text:''}]");  //允许选择为空;
%>
<BZ:html>
<BZ:head>
<title>菜单修改页面</title>
<BZ:script tree="true" isAjax="true"/>
<script type="text/javascript" language="javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	var resArr=<%=resStr%>;
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
			}
		if(document.getElementById("P_PARENT_ID").value==""){
			document.getElementById("P_PARENT_ID").value="0";
		}
		/**如果填写了MENU_URL，则须选择菜单对应的资源：（屏蔽此限制_20130514马志慧）
		if(!document.getElementById("P_MENU_URL").value==""){
			if(document.getElementById("P_RES_ID").value==""){
				alert("请选择菜单对应资源");
				document.all("P_RES_ID").focus();
				return;
			}
		}
		*/
		document.srcForm.action=path+"menu/menuModify.action";
		document.srcForm.submit();
	}
	function _back(){
		document.srcForm.action=path+"menu/menuList.action?NAV_ID=<%=NAV_ID%>";
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
		document.getElementById('moudleTreeDiv').style.left=x;
		document.getElementById('moudleTreeDiv').style.top=y+20;
		document.getElementById('moudleTreeDiv').style.display='';
		}
	function showModuleTree2(obj){
		var x=obj.offsetLeft,y=obj.offsetTop;
			while(obj=obj.offsetParent)
			{
				x+=obj.offsetLeft;
				y+=obj.offsetTop;
			}
		//document.getElementById('tujxzobj').value=tyjname;
		document.getElementById('menuTreeDiv').style.left=x;
		document.getElementById('menuTreeDiv').style.top=y+20;
		document.getElementById('menuTreeDiv').style.display='';
		}

	function L(id,t,selNode,tree){
		var treeName=tree.TreeObjName;
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}else{
			if(treeName=="moduleTree"){
				document.getElementById('moudleTreeDiv').style.display='none';
				document.getElementById('MODULE_ID').value=selNode.id;
				document.getElementById('MODULE_NAME').value=selNode.text;
				updateSelectOptions();
			}
			if(treeName=="menuTree"){
				document.getElementById('menuTreeDiv').style.display='none';
				document.getElementById('P_PARENT_ID').value=selNode.id;
				document.getElementById('PNAME').value=selNode.text;
			}
		}
	}

	function _close(){
		document.getElementById('moudleTreeDiv').style.display='none';
	}
	function _close2(){
		document.getElementById('menuTreeDiv').style.display='none';
		}

	function _qingkong(){
		document.getElementById('MODULE_NAME').value="";
		document.getElementById('MODULE_ID').value="";
		document.getElementById('menuTreeDiv').style.display='none';
	}
	function _qingkong2(){
		document.getElementById('P_PARENT_ID').value="";
		document.getElementById('PNAME').value="";
		document.getElementById('menuTreeDiv').style.display='none';
	}

	function updateSelectOptions(moduleId,selectedResId) {
			var res=document.getElementById("P_RES_ID");
				res.options.length=0; //清空select的option
				moduleId=document.getElementById("MODULE_ID").value;
				var option=new Option("","");
				option.selected=true;
			res.options.add(option);

				if(moduleId!="") {
						for(var i=0;i<resArr.length;i++) {
								if(resArr[i].moduleId==moduleId) {
									var option=new Option(resArr[i].text,resArr[i].value);
									if(selectedResId && selectedResId==resArr[i].value) {
													option.selected=true;
							}
									res.options.add(option);
								}
						}
				}else {

				}
		}

	window.onload=function() {
		// var moduleId=document.getElementById("MODULE_ID").value;
		//var selectedResId=document.getElementById("TEMP_RES_ID").value;
		//updateSelectOptions(moduleId,selectedResId);
		}
		function selectRes(){
		var reValue = window.showModalDialog(path+"app/toAllResource.action?SELECT_VALUE="+document.getElementById("RES_ID").value, this, "dialogWidth=300px;dialogHeight=500px;scroll=auto");
		document.getElementById("RES_NAME").value=reValue["name"];
		document.getElementById("RES_ID").value=reValue["value"];
		if(reValue["value"]){
			//根据资源ID动态加载资源URL：
			var resUrl=executeRequest("com.hx.framework.resource.app.NavAjax","RES_ID="+reValue["value"]);
			document.getElementById("MENU_URL").value=resUrl;
		}
	}
</script>
</BZ:head>
<BZ:body property="data" codeNames="MENU_VIEW">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="P_NAV_ID" value="<%=NAV_ID%>"/>
<input type="hidden" name="NAV_ID" value="<%=NAV_ID%>"/>
<input type="hidden" name="P_PARENT_ID" value="<%=parentId%>" id="P_PARENT_ID"/>
<input type="hidden" name="PARENT_ID" value="<%=parentId%>" id="PARENT_ID"/>


<BZ:input field="MENU_ID" type="hidden" prefix="P_" defaultValue="" />
<BZ:input field="PARENT_ID" type="hidden" prefix="P_" defaultValue="" id="PARENT_ID"/>

<div id="moudleTreeDiv" style="position:absolute; width:150px; background-color:#646464; height:200px;z-index:199; display:none;" onmouseleave="_close()">
<div style="height:175px; overflow:auto; margin-top:2px; margin-left:2px; margin-right:2px; background-color:#FFF">
<BZ:tree property="moduleList" treeName="moduleTree" type="0" />
</div>
<div align="center"><input type="button" name="qingchu" value="清空" onclick="_qingkong()"/></div>
</div>
<div id="menuTreeDiv" style="position:absolute; width:150px; background-color:#646464; height:200px;z-index:199; display:none;" onmouseleave="_close2()">
<div style="height:175px; overflow:auto; margin-top:2px; margin-left:2px; margin-right:2px; background-color:#FFF">
<BZ:tree property="menuTree" treeName="menuTree" type="0" />
</div>
<div align="center"><input type="button" name="qingchu" value="清空" onclick="_qingkong2()"/></div>
</div>
<div class="kuangjia">
<div class="heading">菜单修改</div>
<table class="contenttable">
<tr>
<td></td>
<td>菜单名称</td>
<td><BZ:input field="MENU_NAME" type="String" prefix="P_" defaultValue="" notnull="请输入菜单名称" formTitle="菜单名称"/></td>
<td>菜单类型</td>
<td><BZ:select field="MENU_TYPE" formTitle="菜单类型" property="data" prefix="P_" ><BZ:option value="1">资源菜单</BZ:option><BZ:option value="2">外部url</BZ:option></BZ:select></td>
<td></td>
</tr>
<tr>
<td></td>
<td>父菜单</td>
<td><BZ:input field="PNAME" id="PNAME" type="String" prefix="DS_" defaultValue="" onclick="showModuleTree2(this)"/></td>
<td>是否左侧显示下级菜单</td>
<td>
	<BZ:select field="IS_LEFT" formTitle="显示" property="data" prefix="P_">
		<BZ:option value="1">是</BZ:option>
		<BZ:option value="0">否</BZ:option>
	</BZ:select>
</td>
<td></td>
</tr>
<tr>
<td></td>
<td>菜单对应模块</td>
<td>
		<BZ:input id="MODULE_NAME" field="MODULE_NAME" type="String" prefix="P_" defaultValue="" onclick="showModuleTree(this)"/>
		<BZ:input id="MODULE_ID" field="MODULE_ID"  type="hidden" prefix="P_" defaultValue="" />
</td>
<td>菜单对应资源</td>
<td><BZ:input id="RES_NAME" field="RES_NAME" type="String" prefix="P_" defaultValue="" readonly="true" onclick="selectRes()" />
	<BZ:input id="RES_ID" field="RES_ID" type="hidden" prefix="P_" defaultValue="" readonly="true"/>
	</td>
<td></td>
</tr>
<!--
<tr>
<td></td>
<td>菜单对应模块</td>
<td>
		<BZ:input field="MODULE_NAME" id="MODULE_NAME" type="String" prefix="P_" defaultValue="" onclick="showModuleTree(this)"/>
		<BZ:input field="MODULE_ID" id="MODULE_ID" type="hidden" prefix="P_" defaultValue="" />
</td>
<td>菜单对应资源</td>
<td>
		<BZ:input field="RES_ID" type="hidden" prefix="TEMP_" id="TEMP_RES_ID"/>
		<BZ:select field="RES_ID" id="P_RES_ID" formTitle="" prefix="P_" defaultValue="">
				<BZ:option value="" selected="selected"></BZ:option>
		</BZ:select>
</td>
<td></td>
</tr>
-->
<tr>
<td></td>

<td>菜单URL</td>
<td ><BZ:input id="MENU_URL" field="MENU_URL" type="String" prefix="P_" defaultValue="" size="40"/></td>
<td>页面滚动方式</td>
<td>
<BZ:select field="PAGE_SCROLL"  prefix="P_" defaultValue="0" formTitle="" isCode="true" codeName="MENU_VIEW" property="data"  >
</BZ:select>
</td>
<td></td>
</tr>
<tr>
<td></td>
<td>帮助文件路径</td>
<td><BZ:input  field="HELP_FILE_PATH" type="String" prefix="P_"  size="40" defaultValue=""/></td>
<td>是否模块入口</td>
<td>
	<BZ:select field="IS_MODULE_ENTRY" formTitle="模块入口" property="data" prefix="P_" >
		<BZ:option value="1">是</BZ:option>
		<BZ:option value="0">否</BZ:option>
	</BZ:select>
</td>
<td></td>
</tr>
<tr>
<td></td>
<!--
<td>菜单内容显示区域</td>
<td><BZ:input field="TARGET" type="String" prefix="P_" defaultValue=""/></td>
-->
<td>菜单序号</td>
<td><BZ:input field="SEQ_NUM" type="String" prefix="P_" defaultValue="" notnull="请输入菜单序号" formTitle="菜单序号" restriction="int"/></td>
<td>状态</td>
<td >
	<BZ:select field="STATUS" formTitle="状态" property="data" prefix="P_">
		<BZ:option value="1">启用</BZ:option>
		<BZ:option value="2">禁用</BZ:option>
	</BZ:select>
</td>
<td></td>
</tr>

</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2">
	<input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;
	<input type="button" value="返回" class="button_back" onclick="_back()"/>
</td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>