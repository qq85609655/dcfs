<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<BZ:script isEdit="true"/>
	<title>添加属性</title>
<script>
function changeButton(flag){
	if(flag==1){
		document.getElementById("qddiv").style.display="";
		document.getElementById("xybdiv").style.display='none';
	}
	else{
		document.getElementById('xybdiv').style.display = "";
		document.getElementById('qddiv').style.display = 'none';
	}
}
</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post">
		<table border="0" cellpadding="0" cellspacing="0" width="100%" class="contenttable">
			<tbody>
				<tr>
					<td class="bodytitle" height="24"><div class="heading">新增组织属性</div></td>
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
				<td width="80%"><BZ:input field="CNAME" type="String" notnull="请输入显示名称" formTitle="显示名称" defaultValue=""/>	</td>
			</tr>
			<tr align="left">
				<td>*属性编码：</td>
				<td><BZ:input field="CODE" type="String" notnull="请输入属性编码" formTitle="属性编码" defaultValue=""/>
			</td>
			</tr>
			<tr align="left">
				<td>*描述：</td>
				<td><BZ:input field="MEMO" type="String" notnull="请输入描述" formTitle="描述" defaultValue=""/></td>
			</tr>
		</table>
		<table border="0" width="100%" class="contenttable">
			<tr><td colspan="2" align="left"><div class="heading">选择类型</div></td></tr>
			<tr>
				<td><input type="radio" name="name" onclick="changeButton(1)"/>文本输入框 <span>(适合输入少量文本)</span></td>
				<td><input type="radio" name="name" onclick="changeButton(1)"/>文本域  <span>(输入区域较文本输入框大,适用于内容较多的文本)</span></td></tr>
			<tr>
				<td><input type="radio" name="name" onclick="changeButton(2)"/>单选按钮 <span>(单选按钮 使用单选按钮选择一个值)</span></td>
				<td><input type="radio" name="name" onclick="changeButton(2)"/>复选按钮 <span>(使用复选按钮选择多个值)</span></td>
			</tr>
			<tr>
				<td><input type="radio" name="name" onclick="changeButton(2)"/>单选列表 <span>(使用单选下拉列表,选择一个值)</span></td>
				<td><input type="radio" name="name" onclick="changeButton(2)"/>多选列表 <span>(使用多选列表框选择多个值,默认值为3)</span></td>
			</tr>
			<tr>
				<td><input type="radio" name="name" onclick="changeButton(1)"/>人员选择 <span>(使用Framework人员选择控件,输入一个人员)</span></td>
				<td><input type="radio" name="name" onclick="changeButton(1)"/>组织选择 <span>(使用Framework组织选择控件,输入一个组织)</span></td>
			</tr>
			<tr>
				<td><input type="radio" name="name" onclick="changeButton(1)"/>日期选择 <span>(使用日期选择控件输入日期)</span></td>
				<td></td>
			</tr>
			<tr>
				<td align="right">
					<div id="qddiv" style="display: none">
						<input id="qd" type="button" class="button_add" value="确定" />
					</div>
					<div id="xybdiv" style="display: none">
						<input id="xyb" type="button" class="button_goto" value="下一步" />
					</div>
				</td>
				<td align="left">
					<input type="button" class="button_back" onclick="javascript:window.close();" value="返回"/>
				</td>
			</tr>
		</table>
	</BZ:form>
</BZ:body>
</BZ:html>