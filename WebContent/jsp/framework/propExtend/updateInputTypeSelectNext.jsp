<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data" %>
<%@ page import="hx.database.databean.DataList" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String inputType = request.getParameter("INPUT_TYPE");

	DataList dataList = (DataList)request.getAttribute("dataList");
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
		initSubData();
	}
	function initSubData(){
		var dataListSize = <%=dataList.size()%>;
		for(var i=0;i<dataListSize-1;i++){
			_addRow();
		}
		setValues();
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
		var propCodeOld = parent.document.getElementById('PROP_CODE_OLD').value;
		if(propCode == propCodeOld){
			return true ;
		}
		var str = getStr(ajax_url,"propCode="+propCode);
		
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
			alert("[���Դ���]�Ѵ��ڣ����������룡");
			return ;
		}
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		parent.document.getElementById("DATA_NAME").value = getValues("Prop_DATA_NAME");
		parent.document.getElementById("DATA_VALUE").value = getValues("Prop_DATA_VALUE");

		parent.srcForm.action=path+"prop/propExtend!doModifyProp.action";
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
	function setValues(){
		var index=0;
		var dataNames = document.getElementsByName("Prop_DATA_NAME");
		var dataValues = document.getElementsByName("Prop_DATA_VALUE");
		<%
		for(int i=0;i<dataList.size();i++){
			Data data = (Data)dataList.get(i);
		%>
		 	index=<%=i%>;
		 	dataNames[index].value='<%=data.getString("DATA_NAME")%>';
		 	dataValues[index].value='<%=data.getString("DATA_VALUE")%>';
		<%
		}
		%>
	}
	function _back(){
		window.history.go(-1);
	}
	//���ֵ������
	function _addRow(){
			var mynewrow=mtable.insertRow();
		    col1=mynewrow.insertCell(0);
		    col1.style.paddingLeft="0px";
		    col2=mynewrow.insertCell(1);
		    col2.style.paddingLeft="0px";
		    col1.innerHTML="�������ƣ�<input name=\"Prop_DATA_NAME\"  class=\"inputText\" formTitle=\"��������\" notnull=\"��������������\" type=\"text\" onkeyup=\"strFilter(this);\" onmouseout=\"_inputMouseOut(this);\" onmousemove=\"_inputMouseOver(this);\" onblur=\"_inputMouseBlur(this);error_onblur(this);hide(true);\" onfocus=\"_inputMouseFocus(this);this.select();\" onclick=\"error_onclick(this);\"/>";
		    col2.innerHTML="����ֵ��<input name=\"Prop_DATA_VALUE\"  class=\"inputText\" formTitle=\"����ֵ\" notnull=\"����������ֵ\" type=\"text\" onkeyup=\"strFilter(this);\" onmouseout=\"_inputMouseOut(this);\" onmousemove=\"_inputMouseOver(this);\" onblur=\"_inputMouseBlur(this);error_onblur(this);hide(true);\" onfocus=\"_inputMouseFocus(this);this.select();\" onclick=\"error_onclick(this);\"/>&nbsp;<img onclick='_delRow(this)' src='<BZ:resourcePath />/images/delete.png'></img>";
		}
		//ɾ��ֵ������
		function _delRow(obj){
			var tr=obj.parentNode.parentNode;
			var tbl=tr.parentNode;
			tbl.removeChild(tr); 
		}
	</script>
	<title>�������</title>
</BZ:head>
<BZ:body onload="init()">
	<BZ:form name="srcForm" method="post">
		<table border="0" width="100%" class="contenttable" align="center">
			<tr><td align="left"><div class="heading">ѡ������</div></td></tr>
			<tr id="radioTr" style="display:none">
				<td><input type="radio" checked/>��ѡ��ť <span>(��ѡ��ť ʹ�õ�ѡ��ťѡ��һ��ֵ)</span></td>
			</tr>
			<tr id="checkboxTr" style="display:none">
				<td><input type="checkbox" checked/>��ѡ��ť <span>(ʹ�ø�ѡ��ťѡ����ֵ)</span></td>
			</tr>
			<tr id="selectSingleTr" style="display:none">
				<td><input type="radio" checked/>��ѡ�б� <span>(ʹ�õ�ѡ�����б�,ѡ��һ��ֵ)</span></td>
			</tr>
			<tr id="selectMultiTr" style="display:none">
				<td><input type="checkbox" checked/>��ѡ�б� <span>(ʹ�ö�ѡ�б��ѡ����ֵ,Ĭ��ֵΪ3)</span></td>
			</tr>
			<tr>
				<td>
					<table border="0" width="60%">
						<tr>
						<td><table id="mtable" width="100%"  cellspacing="0" >
								<tr id="tr1" >
									<td style="padding-left: 0px">�������ƣ�<BZ:input field="DATA_NAME" prefix="Prop_" type="String" notnull="��������������" formTitle="��������" onkeyup="strFilter(this)"/></td>
									<td style="padding-left: 0px">����ֵ��<BZ:input field="DATA_VALUE" prefix="Prop_" type="String" notnull="����������ֵ" formTitle="����ֵ" onkeyup="strFilter(this)"/>&nbsp;<img onclick="_addRow()" src="<BZ:resourcePath />/images/add.png"></img></td>
								</tr>
							</table></td>
						</tr>
						<tr>
							<td align="center">
								<input type="button" class="button_preview" value="Ԥ��" onclick="preview()"/>
								
								<%if(!"true".equals(request.getParameter("view"))){ %>
								<input type="button" class="button_add" value="����" onclick="tijiao()"/>
								<%}%>
								<input type="button" class="button_back" onclick="_back();" value="����"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</BZ:form>
</BZ:body>
</BZ:html>