<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="com.hx.framework.propExtend.vo.PropExtend"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
String parentId=(String)request.getParameter("parent_id");
if(parentId==null){
	parentId="";
}
String tableTitle="";
if(PropExtend.ORGAN_EXT.equals(parentId)){
	tableTitle="组织机构";
}else if(PropExtend.PERSON_EXT.equals(parentId)){
	tableTitle="人员";
}
%>
<BZ:html>
<BZ:head>
	<BZ:script isEdit="true"/>
	<title>添加属性</title>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post">
		<input type="hidden" name="parent_id" value="<%=request.getParameter("parent_id") %>"/>
		<input type="hidden" name="INPUT_TYPE" id="INPUT_TYPE" value=""/>
		<input type="hidden" name="DATA_NAME" id="DATA_NAME" value=""/>
		<input type="hidden" name="DATA_VALUE" id="DATA_VALUE" value=""/>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="contenttable">
			<tbody>
				<tr>
					<td class="bodytitle" height="24"><div class="heading">新增<%=tableTitle %>属性</div></td>
				</tr>
				<tr>
					<td class="titledesc" height="28">
					请指定新属性的显示名称，描述和类型，例如一个新属性【身高】的类型既可以是文本框让用户可以输入具体数值，又可以是选择类型让指定不同的身高范围让用户选择；若属性为选择类型则需为该属性配置可选项的值。
					</td>
				</tr>
			</tbody>
		</table>
		<table border="0" width="100%" class="contenttable" align="center">
			<tr align="left">
				<td width="20%">*显示名称：</td>
				<td width="80%"><BZ:input field="PROP_NAME" id="PROP_NAME" prefix="Prop_" type="String" notnull="请输入显示名称" formTitle="显示名称" defaultValue=""/>	</td>
			</tr>
			<tr align="left">
				<td>*属性代码：</td>
				<td><BZ:input field="PROP_CODE" id="PROP_CODE" type="String" prefix="Prop_" notnull="请输入属性代码" formTitle="属性代码" defaultValue=""/>
			</td>
			</tr>
			<tr align="left">
				<td>*排序号：</td>
				<td>
				<BZ:input field="SEQ_NUM" type="String" restriction="int" prefix="Prop_" notnull="请输入排序号" formTitle="排序号" defaultValue=""/>
				<!--  
				<BZ:select field="DATA_TYPE" prefix="Prop_" notnull="请选择数据类型" formTitle="数据类型" property="data">
				     	<BZ:option value="">--请选择--</BZ:option>
				     	<BZ:option value="char">字符型</BZ:option>
				     	<BZ:option value="int">整&nbsp;&nbsp;型</BZ:option>
				     	<BZ:option value="float">浮点型</BZ:option>
				</BZ:select>
			  -->
				     </td>
			</tr>
			
		</table>
		<iframe align="top" width="100%" height="100%" src="<%=request.getContextPath() %>/prop/propExtend!gotoInputTypeSet.action" id="setFrame" name="setFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
		
	</BZ:form>
</BZ:body>
</BZ:html>