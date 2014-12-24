<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	//�������ݶ���
	Data rzjgData = new Data();
	request.setAttribute("rzjgData",rzjgData);
	
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>��������</title>
	<BZ:webScript edit="true" isAjax="true"/>
	<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	<script>
	
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	});
	
	//�������ݸ�״̬
	function _caogao() {
		//ҳ���У��
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			var name = $("#P_NAME").val();
			var type = $("#P_TYPE").val();
			//���������Լ��֤������Ϣ�Ƿ�����ͬ��������
			var data = getData('com.dcfs.mkr.USAConvention.CertificationBodyAjax','name='+name+'&type='+type);
			var coa_id = data.getString("COA_ID","");
			if(coa_id != ""){
				var type_name = $("#P_TYPE").find("option:selected").text();
				alert(type_name+"�����д�����ͬ�������ƣ����������룡");
				return;
			}else{
				document.getElementById("P_STATE").value = "0";
				document.srcForm.action = path + "mkr/USAConvention/saveCerBody.action";
				document.srcForm.submit();
			}
		}
	}
	
	//��Ч
	function _submit() {
		//ҳ���У��
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			var name = $("#P_NAME").val();
			var type = $("#P_TYPE").val();
			//���������Լ��֤������Ϣ�Ƿ�����ͬ��������
			var data = getData('com.dcfs.mkr.USAConvention.CertificationBodyAjax','name='+name+'&type='+type);
			var coa_id = data.getString("COA_ID","");
			if(coa_id != ""){
				var type_name = $("#P_TYPE").find("option:selected").text();
				alert(type_name+"�����д�����ͬ�������ƣ����������룡");
				return;
			}else{
				if (confirm("ȷ����Ч��")) {
					document.getElementById("P_STATE").value = "1";
					document.srcForm.action = path + "mkr/USAConvention/saveCerBody.action";
					document.srcForm.submit();
				}
			}
		}
	}
	
	//ҳ�淵��
	function _goback(){
		window.location.href=path+'mkr/USAConvention/findBodyList.action';
	}
	
	</script>
</BZ:head>

<BZ:body codeNames="GYRZJGLX" property="rzjgData">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<input type="hidden" id="P_PAGEACTION" name="P_PAGEACTION" value="create" />
	<BZ:input prefix="P_" field="STATE" id="P_STATE" type="hidden" />
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
		<!-- �������� begin -->
		<div class="ui-state-default bz-edit-title" desc="����">
			<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
			<div>������Լ��֤��������</div>
		</div>
		<!-- �������� end -->
		<div class="bz-edit-data-content clearfix" desc="������">
			<table class="bz-edit-data-table" border="0">
				<tr>
					<td class="bz-edit-data-title" width="20%"><font color="red">*</font>����</td>
					<td class="bz-edit-data-value" width="30%">
						<BZ:select prefix="P_" field="TYPE" isCode="true" codeName="GYRZJGLX" notnull="����������" formTitle="����" defaultValue="" width="75%">
							<BZ:option value="">--��ѡ��--</BZ:option>
						</BZ:select>
					</td>
					<td class="bz-edit-data-title" width="20%"><font color="red">*</font>��������</td>
					<td class="bz-edit-data-value" width="30%">
						<BZ:input field="NAME" id="P_NAME" prefix="P_" type="String"  formTitle="��������" notnull="�������������" defaultValue="" style="width:75%" maxlength="200"/>
					</td>
				</tr>
				<tr>
					<td class="bz-edit-data-title"><font color="red">*</font>��ַ</td>
					<td class="bz-edit-data-value">
						<BZ:input field="ADDR" id="P_ADDR" prefix="P_" type="String"  formTitle="��ַ" notnull="�������ַ" defaultValue="" style="width:75%" maxlength="200"/>
					</td>
					<td class="bz-edit-data-title"><font color="red">*</font>��֤ʱ��</td>
					<td class="bz-edit-data-value">
						<BZ:input field="VALID_DATE" id="P_VALID_DATE" notnull="��������֤ʱ��" prefix="P_" type="date"/>
					</td>
				</tr>
				<tr>
					<td class="bz-edit-data-title">ʧЧʱ��</td>
					<td class="bz-edit-data-value">
						<BZ:input field="EXPIRE_DATE" id="P_EXPIRE_DATE" prefix="P_" type="date"/>
					</td>
					<td class="bz-edit-data-value" colspan="2">
						&nbsp;
					</td>
				</tr>
			</table>
		</div>
	</div>
	</div>
	<br/>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��" id="print1">
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_caogao();"/>&nbsp;
			<input type="button" value="��Ч" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
