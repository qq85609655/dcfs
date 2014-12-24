<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String inputType = request.getParameter("INPUT_TYPE");
	System.out.println("inputType = "+ inputType);
%>
<BZ:html>
<BZ:head>
	<BZ:script isEdit="true" isAjax="true"/>
	<script>
	function init(){
		var inputType = '<%=inputType%>';
		if(inputType=="radio"){
			document.getElementById("radioTr").style.display="block";
		}
		if(inputType=="checkbox"){
			document.getElementById("checkboxTr").style.display="block";
		}
		if(inputType=="selectSingle"){
			document.getElementById("selectSingleTr").style.display="block";
		}
		if(inputType=="selectMulti"){
			document.getElementById("selectMultiTr").style.display="block";
		}
	}
	function preview(){
		if (!runFormVerify(parent.srcForm, false)) {
			return;
		}
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		var propName = parent.document.getElementById("PROP_NAME").value;
		var dataName = getValues("Prop_DATA_NAME");
		var dataValue = getValues("Prop_DATA_VALUE");
		var inputType = '<%=inputType%>';
		var param = propName+"&"+dataName+"&"+dataValue+"&"+inputType;
		
		var url = "<BZ:url/>/jsp/framework/propExtend/preview.jsp";
		var dialogWidth="400";
		var dialogHeight="200";
		modalDialog(url,param,dialogWidth,dialogHeight);
	}
	function strFilter(obj){
		if(obj.value!="" && obj.value.indexOf("&")!=-1){
			obj.value = obj.value.replace("&","");
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
		if (!runFormVerify(document.srcForm, false)) {
			return ;
		}
		if(!checkRepeat("Prop_DATA_NAME")){
			alert("[数据名称]不能重复，请重新输入！");
			return ;
		}
		if(!checkRepeat("Prop_DATA_VALUE")){
			alert("[数据值]不能重复，请重新输入！");
			return ;
		}
		parent.document.getElementById("DATA_NAME").value = getValues("Prop_DATA_NAME");
		parent.document.getElementById("DATA_VALUE").value = getValues("Prop_DATA_VALUE");

		parent.srcForm.action=path+"prop/propExtend!saveProp.action";
		parent.srcForm.submit();
	}
	function getValues(objName){
		var valArr = "";
		var dataVals = document.getElementsByName(objName);
		for(var i=0;i<dataVals.length;i++){
			valArr=valArr+dataVals[i].value;
			if(i<dataVals.length-1){
				valArr = valArr+",";
			}
		}
		return valArr;
	}
	/**
		检查是否存在重复数据值
	*/
	function checkRepeat(objName){
		var flag = true ; 
		var objVals = getValues(objName);
		if(objVals){
			var valArr = objVals.split(",");
			for(var i=0;i<valArr.length-1;i++){
				for(var j=i+1;j<valArr.length;j++){
					if(valArr[i]==valArr[j]){
						flag=false;
						break;
					}
				}
				if(!flag){
					break;
				}
			}
		}
		return flag ;
	}
	function _back(){
		document.srcForm.action=path+"prop/propExtend!gotoInputTypeSet.action?parent_id=<%=request.getParameter("parent_id") %>";
		document.srcForm.submit();
	}
	//添加值输入行
	function _addRow(){
			var mynewrow=mtable.insertRow();
		    col1=mynewrow.insertCell(0);
		    col1.style.paddingLeft="0px";
		    col2=mynewrow.insertCell(1);
		    col2.style.paddingLeft="0px";
		    col1.innerHTML="数据名称：<input name=\"Prop_DATA_NAME\"  class=\"inputText\" formTitle=\"数据名称\" notnull=\"请输入数据名称\" type=\"text\" onkeyup=\"strFilter(this);\" onmouseout=\"_inputMouseOut(this);\" onmousemove=\"_inputMouseOver(this);\" onblur=\"_inputMouseBlur(this);error_onblur(this);hide(true);\" onfocus=\"_inputMouseFocus(this);this.select();\" onclick=\"error_onclick(this);\"/>";
		    col2.innerHTML="数据值：<input name=\"Prop_DATA_VALUE\"  class=\"inputText\" formTitle=\"数据值\" notnull=\"请输入数据值\" type=\"text\" onkeyup=\"strFilter(this);\" onmouseout=\"_inputMouseOut(this);\" onmousemove=\"_inputMouseOver(this);\" onblur=\"_inputMouseBlur(this);error_onblur(this);hide(true);\" onfocus=\"_inputMouseFocus(this);this.select();\" onclick=\"error_onclick(this);\"/>&nbsp;<img onclick='_delRow(this)' src='<BZ:resourcePath />/images/delete.png'></img>";
		}
		//删除值输入行
		function _delRow(obj){
			var tr=obj.parentNode.parentNode;
			var tbl=tr.parentNode;
			tbl.removeChild(tr); 
		}
	</script>
	<title>添加属性</title>
</BZ:head>
<BZ:body onload="init()">
	<BZ:form name="srcForm" method="post">
		<table border="0" width="100%" class="contenttable" align="center">
			<tr><td align="left"><div class="heading">选择类型</div></td></tr>
			<tr id="radioTr" style="display:none">
				<td><input type="radio" checked/>单选按钮 <span>(单选按钮 使用单选按钮选择一个值)</span></td>
			</tr>
			<tr id="checkboxTr" style="display:none">
				<td><input type="checkbox" checked/>复选按钮 <span>(使用复选按钮选择多个值)</span></td>
			</tr>
			<tr id="selectSingleTr" style="display:none">
				<td><input type="radio" checked/>单选列表 <span>(使用单选下拉列表,选择一个值)</span></td>
			</tr>
			<tr id="selectMultiTr" style="display:none">
				<td><input type="checkbox" checked/>多选列表 <span>(使用多选列表框选择多个值,默认值为3)</span></td>
			</tr>
			<tr>
				<td>
					<table border="0" width="60%">
						<tr>
						<td><table id="mtable" width="100%"  cellspacing="0" >
								<tr id="tr1" >
									<td style="padding-left: 0px">数据名称：<BZ:input field="DATA_NAME" prefix="Prop_" type="String" notnull="请输入数据名称" formTitle="数据名称" onkeyup="strFilter(this)"/></td>
									<td style="padding-left: 0px">数据值：<BZ:input field="DATA_VALUE" prefix="Prop_" type="String" notnull="请输入数据值" formTitle="数据值" onkeyup="strFilter(this)"/>&nbsp;<img onclick="_addRow()" src="<BZ:resourcePath />/images/add.png"></img></td>
								</tr>
							</table></td>
						</tr>
						<tr>
							<td align="center">
								<input type="button" class="button_preview" value="预览" onclick="preview()"/>
								<input type="button" class="button_add" value="保存" onclick="tijiao()"/>
								<input type="button" class="button_back" onclick="_back();" value="返回"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</BZ:form>
</BZ:body>
</BZ:html>