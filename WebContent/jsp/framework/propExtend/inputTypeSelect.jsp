<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<BZ:script isEdit="true" isAjax="true"/>
	<script>
	function changeButton(obj,flag){
		parent.document.getElementById('INPUT_TYPE').value=obj.value;
		if(flag==1){
			document.getElementById("qddiv").style.display="";
			document.getElementById("xybdiv").style.display='none';
		}
		else{
			document.getElementById('xybdiv').style.display = "";
			document.getElementById('qddiv').style.display = 'none';
		}
	}
	function checkCode(){
		var flag = false;
		var ajax_url = "com.hx.framework.propExtend.CheckPropCodeAjax";
		var propCode = parent.document.getElementById('PROP_CODE').value;
		var str=getStr(ajax_url,"propCode="+propCode);
		if(str=='ok'){
			flag = true ;
		}
		return flag;
	}
	function tijiao()
	{
		if (!runFormVerify(parent.srcForm, false)) {
			return;
		}
		if(!checkCode()){
			alert("[属性代码]已存在，请重新输入！");
			return ;
		}
		parent.srcForm.action=path+"prop/propExtend!saveProp.action";
		parent.srcForm.submit();
	}
	function getInputType(){
		var inputTypes = document.getElementsByName("INPUT_TYPE");
		var val='';
		for(var i=0;i<inputTypes.length;i++){
			if(inputTypes[i].checked){
				val=inputTypes[i].value;
				break;
			}
		}
		return val;
	}
	/*下一步：*/
	function next(){
			if (!runFormVerify(parent.srcForm, false)) {
				return;
			}
			if(!checkCode()){
				alert("[属性代码]已存在，请重新输入！");
				return ;
			}
			document.srcForm.action=path+"prop/propExtend!gotoInputTypeNext.action";
			document.srcForm.submit();
	}
	function _back(){
		parent.srcForm.action=path+"prop/propExtend!gotoMainPage.action";
		parent.srcForm.submit();
	}
	function preview(){
		if (!runFormVerify(parent.srcForm, false)) {
			return;
		}
		var propName = parent.document.getElementById("PROP_NAME").value;
		var inputType = parent.document.getElementById('INPUT_TYPE').value;
		var param = propName+"&"+inputType;
		
		var url = "<BZ:url/>/jsp/framework/propExtend/preview.jsp";
		var dialogWidth="400";
		var dialogHeight="200";
		modalDialog(url,param,dialogWidth,dialogHeight);
	}
	</script>
	<title>添加属性</title>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post">
		<table border="0" width="100%" class="contenttable" align="center">
			<tr><td colspan="2" align="left"><div class="heading">选择类型</div></td></tr>
			<tr>
				<td><input type="radio" name="INPUT_TYPE" value="text" onclick="changeButton(this,1)"/>文本输入框 <span>(适合输入少量文本)</span></td>
				<td><input type="radio" name="INPUT_TYPE" value="textarea" onclick="changeButton(this,1)"/>文本域  <span>(输入区域较文本输入框大,适用于内容较多的文本)</span></td></tr>
			<tr>
				<td><input type="radio" name="INPUT_TYPE" value="radio" onclick="changeButton(this,2)"/>单选按钮 <span>(单选按钮 使用单选按钮选择一个值)</span></td>
				<td><input type="radio" name="INPUT_TYPE" value="checkbox" onclick="changeButton(this,2)"/>复选按钮 <span>(使用复选按钮选择多个值)</span></td>
			</tr>
			<tr>
				<td><input type="radio" name="INPUT_TYPE" value="selectSingle" onclick="changeButton(this,2)"/>单选列表 <span>(使用单选下拉列表,选择一个值)</span></td>
				<td><input type="radio" name="INPUT_TYPE" value="selectMulti" onclick="changeButton(this,2)"/>多选列表 <span>(使用多选列表框选择多个值,默认值为3)</span></td>
			</tr>
			<tr>
				<td><input type="radio" name="INPUT_TYPE" value="personTree" onclick="changeButton(this,1)"/>人员选择 <span>(使用Framework人员选择控件,输入一个人员)</span></td>
				<td><input type="radio" name="INPUT_TYPE" value="organTree" onclick="changeButton(this,1)"/>组织选择 <span>(使用Framework组织选择控件,输入一个组织)</span></td>
			</tr>
			<tr>
				<td><input type="radio" name="INPUT_TYPE" value="dateWidget" onclick="changeButton(this,1)"/>日期选择 <span>(使用日期选择控件输入日期)</span></td>
				<td></td>
			</tr>
			<tr>
				<td align="right">
					<div id="qddiv" style="display: none">
						<input id="yl" type="button" class="button_preview" value="预览" onclick="preview()"/>
						<input id="qd" type="button" class="button_add" value="保存" onclick="tijiao()"/>
					</div>
					<div id="xybdiv" style="display: none">
						<input id="xyb" type="button" class="button_goto" value="下一步" onclick="next()"/>
					</div>
				</td>
				<td align="left">
					<input type="button" class="button_back" onclick="_back();" value="返回"/>
				</td>
			</tr>
		</table>
	</BZ:form>
</BZ:body>
</BZ:html>