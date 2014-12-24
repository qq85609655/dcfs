<%
/**   
 * @Title: adoption_regis_add.jsp
 * @Description: �����Ǽ����
 * @author xugy
 * @date 2014-9-23����2:21:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
Data data=(Data)request.getAttribute("data");
//�ļ�����
String FILE_TYPE = data.getString("FILE_TYPE");
//��������
String FAMILY_TYPE = data.getString("FAMILY_TYPE");
//�������Ա�
String ADOPTER_SEX = data.getString("ADOPTER_SEX");

String MI_ID = data.getString("MI_ID");

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>�����Ǽ����</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//
function _changeType(type){
	if(type == "1"){
		//alert($("#deleteHtml span:eq(2)"));
		$("#deleteHtml span:eq(2)").remove();
	}
	if(type == "2"){
		var adregNo=document.getElementById("adregNo").innerHTML;
		$("#insertSelect").append(adregNo);
	}
}
//
function _changeResult(result){
	var tab = document.getElementById("tab");
	var tr = document.getElementById("insertTd");
	if(result == "1"){
		tr.deleteCell(3);
		tr.deleteCell(2);
		document.getElementById("adregResult").colSpan="3";
		tab.deleteRow(3);
	}
	if(result == "2"){
		document.getElementById("adregResult").colSpan="1";
		var newTd1 = tr.insertCell();
		newTd1.className="bz-edit-data-title";
		var newTd2 = tr.insertCell();
		newTd2.className="bz-edit-data-value";
		
		var dealTypeTitle=document.getElementById("dealTypeTitle").innerHTML;
		newTd1.innerHTML=dealTypeTitle;
		var dealTypeValue=document.getElementById("dealTypeValue").innerHTML;
		newTd2.innerHTML=dealTypeValue;
		
		var newTr = tab.insertRow(3);
		newTr.id="adregInvalidReason";
		var newTd1 = newTr.insertCell();
		newTd1.className="bz-edit-data-title";
		var newTd2 = newTr.insertCell();
		newTd2.className="bz-edit-data-value";
		newTd2.colSpan="3";
		
		var invalidReasonTitle=document.getElementById("invalidReasonTitle").innerHTML;
		newTd1.innerHTML=invalidReasonTitle;
		var invalidReasonValue=document.getElementById("invalidReasonValue").innerHTML;
		newTd2.innerHTML=invalidReasonValue;
	}
}
//����
function _submit(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"adoptionRegis/saveAdoptionReg.action";
	document.srcForm.submit();
}
//����
function _goback(){
	document.srcForm.action=path+"adoptionRegis/adoptionRegisList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="ETXB;ETSFLX;GJ;">
<div id="adregNo" style="display: none;">
	<BZ:select field="ADREG_NO" defaultValue="" isCode="true" codeName="OLD_FAR_SN_LIST" formTitle="�Ǽ�֤��" width="148px" notnull="�Ǽ�֤�Ų���Ϊ��">
		<BZ:option value="">--��ѡ��--</BZ:option>
	</BZ:select>
</div>
<div id="dealTypeTitle" style="display: none;">
	<font color="red">*</font>��ͥ������������
</div>
<div id="dealTypeValue" style="display: none;">
	<BZ:select prefix="MI_" field="ADREG_DEAL_TYPE" defaultValue="" width="148px" formTitle="��ͥ������������">
		<BZ:option value="0">������������</BZ:option>
		<BZ:option value="1">��ͥ�˳�����</BZ:option>
	</BZ:select>
</div>
<div id="invalidReasonTitle" style="display: none;">
	<font color="red">*</font>��Ч�Ǽ�ԭ��
</div>
<div id="invalidReasonValue" style="display: none;">
	<BZ:input prefix="MI_" field="ADREG_INVALID_REASON" type="textarea" defaultValue="" style="width:98%;height:60px;" formTitle="��Ч�Ǽ�ԭ��" notnull="��Ч�Ǽ�ԭ����Ϊ��"/>
</div>
<BZ:form name="srcForm" method="post" token="<%=token %>">
<input type="hidden" id="ids" name="ids" value="<%=MI_ID %>"/>
<input type="hidden" id="MI_ID" name="MI_ID" value="<%=MI_ID %>"/>
<BZ:input type="hidden" prefix="MI_" field="MI_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="CI_" field="CI_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="AF_" field="AF_ID" defaultValue=""/>
<BZ:input type="hidden" field="IS_CONVENTION_ADOPT" defaultValue=""/><!-- �Ƿ�Լ���� -->
<BZ:input type="hidden" field="COUNTRY_CODE" defaultValue=""/><!-- ʡ��code -->
<BZ:input type="hidden" field="PROVINCE_ID" defaultValue=""/><!-- ʡ��code -->
<BZ:input type="hidden" field="FILE_TYPE" defaultValue=""/><!-- �ļ����� -->
<BZ:input type="hidden" field="FAMILY_TYPE" defaultValue=""/><!-- �������� -->
<BZ:input type="hidden" field="ADOPTER_SEX" defaultValue=""/><!-- �������Ա� -->
<BZ:input type="hidden" field="SIGN_DATE" defaultValue=""/><!-- ǩ������ -->
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>����������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">����</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>�Ա�</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:select prefix="CI_" field="SEX" isCode="true" codeName="ETXB" defaultValue="" formTitle="�Ա�">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>��������</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="BIRTHDAY" type="date" defaultValue="" formTitle="��������" notnull="�������ڲ���Ϊ��"/>
						</td>
						<td class="bz-edit-data-title"><font color="red">*</font>���֤��</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="ID_CARD" defaultValue="" formTitle="���֤��" notnull="���֤�Ų���Ϊ��"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>���</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="CI_" field="CHILD_IDENTITY" type="helper" helperCode="ETSFLX" helperTitle="ѡ���ͯ���" treeType="-1" helperSync="true" showParent="false" defaultShowValue="" showFieldId="CHILD_IDENTITY" notnull="��ͯ��ݲ���Ϊ��" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="SENDER" defaultValue="" formTitle="������"/>
						</td>
						<td class="bz-edit-data-title">�����ˣ�Ӣ�ģ�</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="SENDER_EN" defaultValue="" formTitle="������"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����˵�ַ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="CI_" field="SENDER_ADDR" defaultValue="" formTitle="�����˵�ַ" style="width:98%;"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>��������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<%
					if("33".equals(FILE_TYPE)){//����Ů����
					    if("1".equals(ADOPTER_SEX)){//��������
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						
						<td class="bz-edit-data-title" width="20%">�Ա�</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="" defaultValue="��" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title"><font color="red">*</font>����</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_NATION" isCode="true" codeName="GJ" defaultValue="" width="148px" formTitle="����" notnull="��ѡ�������˹���">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>���պ���</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="MALE_PASSPORT_NO" defaultValue="" formTitle="���պ���" notnull="���պ��벻��Ϊ��"/>
						</td>
					</tr>
					<%
					    }
					    if("2".equals(ADOPTER_SEX)){//Ů������
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�Ա�</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="" defaultValue="Ů" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title"><font color="red">*</font>����</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_NATION" isCode="true" codeName="GJ" defaultValue="" width="148px" formTitle="����" notnull="��ѡ�������˹���">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>���պ���</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="FEMALE_PASSPORT_NO" defaultValue="" formTitle="���պ���" notnull="���պ��벻��Ϊ��"/>
						</td>
					</tr>
					<%        
					    }
					}else{//�Ǽ���Ů����
					    if("1".equals(FAMILY_TYPE)){//˫������
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%"></td>
						<td class="bz-edit-data-title" width="40%" style="text-align: center;"><b>��������</b></td>
						<td class="bz-edit-data-title" width="40%" style="text-align: center;"><b>Ů������</b></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>����</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_NATION" isCode="true" codeName="GJ" defaultValue="" width="148px" formTitle="����" notnull="��ѡ�������˹���">
							</BZ:select>
						</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_NATION" isCode="true" codeName="GJ" defaultValue="" width="148px" formTitle="����" notnull="��ѡ�������˹���">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>���պ���</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="MALE_PASSPORT_NO" defaultValue="" formTitle="���պ���" notnull="���պ��벻��Ϊ��"/>
						</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="AF_" field="FEMALE_PASSPORT_NO" defaultValue="" formTitle="���պ���" notnull="���պ��벻��Ϊ��"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>��ͥסַ</td>
						<td class="bz-edit-data-value" colspan="2">
							<BZ:input prefix="AF_" field="ADDRESS" defaultValue="" style="width:98%;" formTitle="��ͥסַ" notnull="��ͥסַ����Ϊ��"/>
						</td>
					</tr>
					<%
					    }
						if("2".equals(FAMILY_TYPE)){//��������
						    if("1".equals(ADOPTER_SEX)){//��������
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						
						<td class="bz-edit-data-title" width="20%">�Ա�</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="" defaultValue="��" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title"><font color="red">*</font>����</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="MALE_NATION" isCode="true" codeName="GJ" defaultValue="" width="148px" formTitle="����" notnull="��ѡ�������˹���">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>���պ���</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="MALE_PASSPORT_NO" defaultValue="" formTitle="���պ���" notnull="���պ��벻��Ϊ��"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>��ͥסַ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="ADDRESS" defaultValue="" style="width:98%;" formTitle="��ͥסַ" notnull="��ͥסַ����Ϊ��"/>
						</td>
					</tr>
					<%	        
						    }
							if("2".equals(ADOPTER_SEX)){//Ů������
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%">������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�Ա�</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="" defaultValue="Ů" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title"><font color="red">*</font>����</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="AF_" field="FEMALE_NATION" isCode="true" codeName="GJ" defaultValue="" width="148px" formTitle="����" notnull="��ѡ�������˹���">
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>���պ���</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="FEMALE_PASSPORT_NO" defaultValue="" formTitle="���պ���" notnull="���պ��벻��Ϊ��"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>��ͥסַ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="AF_" field="ADDRESS" defaultValue="" style="width:98%;" formTitle="��ͥסַ" notnull="��ͥסַ����Ϊ��"/>
						</td>
					</tr>
					<%		    
							}
						}
					}
					%>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����Ǽ���Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>�Ǽ�֤��</td>
						<td class="bz-edit-data-value" width="30%" id="deleteHtml" colspan="3">
						<span id="insertSelect">
							<BZ:select field="NUMBER_TYPE" onchange="_changeType(this.value)" defaultValue="" width="148px" formTitle="�Ǽ�֤�����ɷ�ʽ">
								<BZ:option value="1">�Զ�����</BZ:option>
								<BZ:option value="2">ʹ�þɺ�</BZ:option>
							</BZ:select>
						</span>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>�뼮����</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="CI_" field="NATION_DATE" type="date" defaultValue="" formTitle="�뼮����" notnull="�뼮���ڲ���Ϊ��"/>
						</td>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>�����������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:input prefix="CI_" field="CHILD_NAME_EN" defaultValue="" formTitle="�����������" notnull="��������Ϊ��"/>
						</td>
					</tr>
					<tr id="insertTd">
						<td class="bz-edit-data-title"><font color="red">*</font>�Ǽǽ��</td>
						<td class="bz-edit-data-value" id="adregResult" colspan="3">
							<BZ:select field="ADREG_RESULT" onchange="_changeResult(this.value)" defaultValue="" width="148px" formTitle="�Ǽǽ��">
								<BZ:option value="1">�Ǽǳɹ�</BZ:option>
								<BZ:option value="2">��Ч�Ǽ�</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input prefix="MI_" field="ADREG_REMARKS" type="textarea" defaultValue="" style="width:98%;height:60px;" formTitle="��ע"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ǽ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title"><font color="red">*</font>�Ǽ�����</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="MI_" field="ADREG_DATE" type="date" readonly="readonly" defaultValue="" formTitle="�Ǽ�����" notnull="�Ǽ����ڲ���Ϊ��"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="ȷ&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
