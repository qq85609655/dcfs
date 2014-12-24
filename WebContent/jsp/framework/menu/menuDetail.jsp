
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
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
%>
<BZ:html>
<BZ:head>
<title>菜单详细页面</title>
<BZ:script/>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function _back(){
	document.srcForm.action=path+"menu/menuList.action?NAV_ID=<%=NAV_ID%>";
	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data" codeNames="MENU_VIEW">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="P_NAV_ID" value="<%=NAV_ID%>"/>
<input type="hidden" name="PARENT_ID" value="<%=parentId%>"/>
<div class="kuangjia">
<div class="heading">菜单详细</div>
<table class="contenttable">
<tr>
<td></td>
<td>菜单名称</td>
<td><BZ:input field="MENU_NAME" type="String" prefix="P_" defaultValue="" notnull="请输入菜单名称" formTitle="菜单名称" disabled="true"/></td>
<td>菜单类型</td>
<td><BZ:select field="MENU_TYPE" formTitle="菜单类型" property="data" prefix="P_" disabled="true"><BZ:option value="1">资源菜单</BZ:option><BZ:option value="2">外部url</BZ:option></BZ:select></td>
<td></td>
</tr>
<tr>
<td></td>
<td>父菜单</td>
<td><BZ:input field="PNAME" id="PNAME" type="String" prefix="DS_" defaultValue="" onclick="showModuleTree2(this)" disabled="true"/></td>
<td>是否左侧显示下级菜单</td>
<td>
	<BZ:select field="IS_LEFT" formTitle="显示" property="data" prefix="P_" disabled="true">
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
		<BZ:input field="MODULE_NAME" id="MODULE_NAME" type="String" prefix="P_" defaultValue="" onclick="showModuleTree(this)" disabled="true"/>
		<BZ:input field="MODULE_ID" id="MODULE_ID" type="hidden" prefix="P_" defaultValue="" />
</td>
<td>菜单对应资源</td>
<td><BZ:input id="RES_NAME" field="RES_NAME" type="String" prefix="P_" defaultValue="" readonly="true" onclick="selectRes()" disabled="true"/>
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
<td ><BZ:input id="MENU_URL" field="MENU_URL" type="String" prefix="P_" defaultValue="" size="40" disabled="true"/></td>
<td>页面滚动方式</td>
<td>
<BZ:select field="PAGE_SCROLL"  prefix="P_" defaultValue="0" formTitle="" isCode="true" codeName="MENU_VIEW" property="data" disabled="true" >
</BZ:select>
</td>
<td></td>
</tr>
<tr>
<td></td>
<td>帮助文件路径</td>
<td><BZ:input  field="HELP_FILE_PATH" type="String" prefix="P_"  size="40" defaultValue="" disabled="true"/></td>
<td>是否模块入口</td>
<td>
	<BZ:select field="IS_MODULE_ENTRY" formTitle="模块入口" property="data" prefix="P_" disabled="true">
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
<td><BZ:input field="TARGET" type="String" prefix="P_" defaultValue="" disabled="true"/></td>-->
<td>菜单序号</td>
<td><BZ:input field="SEQ_NUM" type="String" prefix="P_" defaultValue="" notnull="请输入菜单序号" formTitle="菜单序号" restriction="int" disabled="true"/></td>
<td>状态</td>
<td >
	<BZ:select field="STATUS" formTitle="状态" property="data" prefix="P_" disabled="true">
		<BZ:option value="1">启用</BZ:option>
		<BZ:option value="2">禁用</BZ:option>
	</BZ:select>
</td>
<td></td>
</tr>

</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>