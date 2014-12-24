<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<BZ:script tree="true" isDate="true"/>
	<style type="text/css">
		img{vertical-align:middle}
	</style>
	<script>
		function init(){
			var propName = "";
			var dataName = "";
			var dataValue = "";
			var inputType = "";
			var params = window.dialogArguments;
			var paramArr = params.split("&");
			if(paramArr.length==4){
				 propName = paramArr[0];
				 dataName = paramArr[1];
				 dataValue = paramArr[2];
				 inputType = paramArr[3];
			}else if(paramArr.length==2){
				 propName = paramArr[0];
				 inputType = paramArr[1];
			}
			initHTML(propName,dataName,dataValue,inputType);
		}
		function initHTML(propName,dataName,dataValue,inputType){
			var mynewrow=mtable.insertRow();
		    col1=mynewrow.insertCell(0);
		    col1.style.paddingLeft="0px";
		    col1.style.textAlign="right";
		    col1.style.width="40%";
		    col2=mynewrow.insertCell(1);
		    col2.style.paddingLeft="5px";
		    col1.innerHTML = propName;
		    var dataNameArr = dataName.split(",");
		    var dataValueArr = dataValue.split(",");
		    var htmlStr="";
		    if("selectSingle"==inputType){
				htmlStr="<select name=\"selectSingle\">";
			}else if("selectMulti"==inputType){
				htmlStr="<select name=\"selectMulti\" multiple size=3>";
			}
		    for(var i = 0 ; i<dataNameArr.length ; i++){
			  if("radio"==inputType){
				  htmlStr+="<input type=\"radio\" name=\"radio\" value=\""+dataValueArr[i]+"\">"+dataNameArr[i]+"&nbsp;&nbsp;";
			  }else if("checkbox"==inputType){
				  htmlStr+="<input type=\"checkbox\" name=\"checkbox\" value=\""+dataValueArr[i]+"\">"+dataNameArr[i]+"&nbsp;&nbsp;";
			  }else if("selectSingle"==inputType || "selectMulti"==inputType){
				  htmlStr+="<option value=\""+dataValueArr[i]+"\">"+dataNameArr[i]+"</option>";
			  }
			}
		    if("selectSingle"==inputType || "selectMulti"==inputType){
				htmlStr+="</select>";
			}
			if("text"==inputType){
				htmlStr = "<input type=\"text\" name=\"text\" />";
			}
			if("textarea"==inputType){
				htmlStr = "<textarea name=\"textarea\" cols=\"30\" rows=\"5\"></textarea>";
			}
			if("dateWidget"==inputType){
				htmlStr = "<input size=\"15\" class=\"Wdate\"  name=\"dateWidget\" onfocus=\"WdatePicker({minDate:'1900-01-01',maxDate:'2020-10-01'})\"/>";
			}
			if("organTree"==inputType){
				htmlStr = "<textarea name=\"AdminOrgan_ORGAN_ID\" style=\"display:none\"  id=\"ORGAN_ID\"  ></textarea> ";
			
				htmlStr+="<input name=\"AdminTemp_ORGAN_NAME\"  id=\"ORGAN_NAME\"  class=\"inputText\" formTitle=\"null\" type=\"text\" readonly ";
				htmlStr+="onkeyup=\"_check_one(this);\" onmouseout=\"_inputMouseOut(this);\" onmousemove=\"_inputMouseOver(this);\" ";
				htmlStr+="onblur=\"_inputMouseBlur(this);error_onblur(this);hide(true);\" onfocus=\"_inputMouseFocus(this);this.select();\" onclick=\"error_onclick(this);_selectOrgan();\" />";
			}
			if("personTree"==inputType){
				htmlStr ="<input inputType=\"helper\" name=\"TMP_TMP_PERSON_IDS_NAME\" id=\"PERSON_IDS_NAME\" type=\"text\" ";	
				htmlStr+=" onmouseout=\"_inputMouseOut(this);\" onmousemove=\"_inputMouseOver(this);\" ";
				htmlStr+=" onblur=\"_inputMouseBlur(this);hide(true);\" onfocus=\"_inputMouseFocus(this);this.select();\" ";
				htmlStr+=" ondblclick=\"_clearHelperValue('PERSON_IDS_NAME','Tmp_PERSON_IDS')\" readonly=\"readonly\" ";
				htmlStr+=" style=\"width:100%;height:18px;cursor:default;padding-top:2px;vertical-align: middle;border:0px;width:100px;\"/> ";
				htmlStr+=" <img src=\""+path+"/resources/resource1/images/ps1.gif\" title=\"点击选择\" onclick=\"_showHelper('PERSON_IDS_NAME','Tmp_PERSON_IDS','选择人员','SYS_ORGAN_PERSON','','','1');\"/>";
				htmlStr+=" <textarea name=\"Tmp_PERSON_IDS\" id=\"Tmp_PERSON_IDS\"  style=\"display:none\"></textarea>";
				
			}
		    col2.innerHTML = "&nbsp;"+htmlStr;
		}
		//选择组织机构
		function _selectOrgan(){
			var reValue = modalDialog(path+"organ/Organ!generateTree.action?treeDispatcher=selectOrganTree", this, 400,600);
			if(reValue){
				document.getElementById("ORGAN_ID").value = reValue["value"];
				document.getElementById("ORGAN_NAME").value = reValue["name"];
			}
		}
	</script>
	<title>效果预览</title>
</BZ:head>
<BZ:body onload="init()">
	<BZ:form name="srcForm" method="post">
		<table border="0" width="100%" class="contenttable" align="center">
			<tr><td align="left"><div class="heading">效果预览</div></td></tr>
			<tr>
				<td >
					<table id="mtable" width="100%" border="1" cellspacing="0" >
						<!-- 效果预览区域 -->
					</table>
				</td>
			</tr>
			<tr>
				<td align="center">
					<input type="button" class="button_close" onclick="javascript:window.close()" value="关闭"/>
				</td>
			</tr>
		</table>
	</BZ:form>
</BZ:body>
</BZ:html>