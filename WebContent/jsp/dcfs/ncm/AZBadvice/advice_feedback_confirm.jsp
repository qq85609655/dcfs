<%
/**   
 * @Title: advice_feedback_confirm.jsp
 * @Description: ���ò������������ȷ��
 * @author xugy
 * @date 2014-9-12����10:15:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");
String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT");

String CI_ID = data.getString("CI_ID");//��ͯ����ID
String AF_ID = data.getString("AF_ID");//�������ļ�ID


TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>���ò������������ȷ��</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//
function _change(obj){
	var ADVICE_FEEDBACK_RESULT = obj.value;
	var tab = document.getElementById("tab");
	var tr = document.getElementById("insertTr");
	var index = tr.rowIndex + 1;
	
	var id = tab.rows[index].id;
	if(id == "returnReason"){
		var returnReason = document.getElementById("returnReason");
		var rowIndex =  returnReason.rowIndex;
		tab.deleteRow(rowIndex);
	}
	
	var endDateTitle = document.getElementById("endDateTitle");
	var endDateValue = document.getElementById("endDateValue");
	endDateTitle.innerHTML="";
	endDateValue.innerHTML="";
	if(ADVICE_FEEDBACK_RESULT == "4"){
		document.getElementById("F_ADVICE_FEEDBACK_OPINION").value = "����";
		
		var newTr = tab.insertRow(index);
		newTr.id="returnReason";
		var newTd1 = newTr.insertCell();
		newTd1.className="bz-edit-data-title";
		var newTd2 = newTr.insertCell();
		newTd2.className="bz-edit-data-value";
		newTd2.colSpan="3";
		
		var title=document.getElementById("title-one").innerHTML;
		newTd1.innerHTML=title;
		var value=document.getElementById("value-one").innerHTML;
		newTd2.innerHTML=value;
	}else if(ADVICE_FEEDBACK_RESULT == "3"){
		document.getElementById("F_ADVICE_FEEDBACK_OPINION").value = "����ƥ��";
	}else if(ADVICE_FEEDBACK_RESULT == "2"){
		document.getElementById("F_ADVICE_FEEDBACK_OPINION").value = "��ͣ";
		
		var title1=document.getElementById("title-three").innerHTML;
		endDateTitle.innerHTML=title1;
		var value1=document.getElementById("value-three").innerHTML;
		endDateValue.innerHTML=value1;
		
		var newTr = tab.insertRow(index);
		newTr.id="returnReason";
		var newTd1 = newTr.insertCell();
		newTd1.className="bz-edit-data-title";
		var newTd2 = newTr.insertCell();
		newTd2.className="bz-edit-data-value";
		newTd2.colSpan="3";
		
		var title=document.getElementById("title-two").innerHTML;
		newTd1.innerHTML=title;
		var value=document.getElementById("value-two").innerHTML;
		newTd2.innerHTML=value;
	}else if(ADVICE_FEEDBACK_RESULT == "1"){
		document.getElementById("F_ADVICE_FEEDBACK_OPINION").value = "ͬ��";
	}
}
//����
function _save(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"advice/feedbackConfirmSave.action";
	document.srcForm.submit();
}
//����
function _goback(){
	document.srcForm.action=path+"advice/AZBAdviceList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="ETXB;PROVINCE;ETSFLX;WJLX;SYLX;">
<div id="title-one" style="display: none;">
	<font color="red">*</font>����ԭ��
</div>
<div id="value-one" style="display: none;">
	<BZ:input type="textarea" prefix="R_" field="RETURN_REASON" defaultValue="" style="width:98%;height:60px;" maxlength="1000" notnull="����д����ԭ��"/>
</div>
<div id="title-two" style="display: none;">
	<font color="red">*</font>��ͣԭ��
</div>
<div id="value-two" style="display: none;">
	<BZ:input type="textarea" prefix="R_" field="PAUSE_REASON" defaultValue="" style="width:98%;height:60px;" maxlength="1000" notnull="����д��ͣԭ��"/>
</div>
<div id="title-three" style="display: none;">
	<font color="red">*</font>��ͣ����
</div>
<div id="value-three" style="display: none;">
	<BZ:input prefix="R_" field="END_DATE" defaultValue="" type="date" notnull="��ͣ���޲���Ϊ��"/>
</div>
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input type="hidden" field="MI_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">������֯</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">���ı�� </td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ļ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��׼������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="GOVERN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="EXPIRE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����˼�ͥ��Ϣ</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showAFInfoFirst.action?AF_ID=<%=AF_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>��ͯ��Ϣ</div>
			</div>
			<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showCIInfoFourth.action?CI_ID=<%=CI_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>����ȷ��</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="15%">��Լ����</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="IS_CONVENTION_ADOPT" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
						</td>
						<td class="bz-edit-data-title" width="15%">֪ͨ����</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="ADVICE_NOTICE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<%
					if("1".equals(IS_CONVENTION_ADOPT)){
					%>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>�������������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:select prefix="F_" field="ADVICE_GOV_ID" defaultValue="" isCode="true" codeName="COUNTRY_GOVMENT_LIST" width="50%" formTitle="�������������" notnull="��ѡ���������������">
								<BZ:option value="">--��ѡ��--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>ǩ������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="F_" field="ADVICE_FEEDBACK_DATE" defaultValue="" type="date" notnull="ǩ�����ڲ���Ϊ��"/>
						</td>
					</tr>
					<%} %>
					<tr id="insertTr">
						<td class="bz-edit-data-title"><font color="red">*</font>�������</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="F_" field="ADVICE_FEEDBACK_RESULT" formTitle="�������" onchange="_change(this)">
								<BZ:option value="1">ͬ��</BZ:option>
								<BZ:option value="2">��ͣ</BZ:option>
								<BZ:option value="3">����ƥ��</BZ:option>
								<BZ:option value="4">����</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title" id="endDateTitle"></td>
						<td class="bz-edit-data-value" id="endDateValue"></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>�������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input type="textarea" prefix="F_" field="ADVICE_FEEDBACK_OPINION" id="F_ADVICE_FEEDBACK_OPINION" defaultValue="ͬ��" style="width:98%;height:60px;" notnull="����д�������" maxlength="1000"/>
						</td>
					</tr>
					
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input type="textarea" prefix="F_" field="ADVICE_FEEDBACK_REMARKS" defaultValue="" style="width:98%;height:60px;" maxlength="1000"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="ȷ&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
