<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>���Ĵ�¼ȷ��ҳ��</title>
	<BZ:webScript edit="true" tree="false"/>
	<style>
	</style>
	<script>
	
	//����ȷ���ύ
	function _submit() {
		//ҳ���У��
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			if (confirm("ȷ���ύ���ύ������ȷ����Ϣ�����޸ģ�")) {
				document.srcForm.action = path + "rfm/insteadRecord/insteadRecordSave.action";
				document.srcForm.submit();
			}
		}
	}
	
	//������һ�������Ĵ�¼ѡ���ļ��б�
	function _goback(){
		window.location.href=path+'rfm/insteadRecord/returnChoiceList.action';
	}
	
	//�������Ĵ�¼��Ϣ�б�
	function _cancel(){
		if (confirm("ȷ��ȡ������������")){
			window.location.href=path+'rfm/insteadRecord/insteadRecordList.action';
		}
	}
	
	
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;WJWZ;TWLX;TWCZFS_ALL" property="confirmData">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<BZ:input prefix="R_" field="AF_ID" type="hidden" defaultValue="" />
	<BZ:input prefix="R_" field="FAMILY_TYPE" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�ļ�������Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">���ı��</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="FILE_NO" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/>
							<BZ:input prefix="R_" field="REGISTER_DATE" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">�ļ�����</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true" />
							<BZ:input prefix="R_" field="FILE_TYPE" type="hidden" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="MALE_NAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">Ů������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="FEMALE_NAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">���ڲ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AF_POSITION" codeName="WJWZ" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="P_" field="AF_POSITION" type="hidden" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
							<BZ:input prefix="R_" field="COUNTRY_CODE" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">������֯</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="ADOPT_ORG_ID" type="hidden" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
			<!-- �������� end -->
		</div>
	</div>
	<br>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					���Ĵ�¼��Ϣ
				</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_PERSON_NAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="APPLE_PERSON_ID" type="hidden"/>
							<BZ:input prefix="R_" field="APPLE_PERSON_NAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_DATE" type="date" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="APPLE_DATE" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:select field="APPLE_TYPE" id="R_APPLE_TYPE" notnull="��������������" formTitle="" prefix="R_" isCode="true" codeName="TWLX" width="70%">
								<option value="">--��ѡ��--</option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>���Ĵ��÷�ʽ</td>
						<td class="bz-edit-data-value">
							<BZ:select field="HANDLE_TYPE" id="R_HANDLE_TYPE" notnull="���������Ĵ��÷�ʽ" formTitle="" prefix="R_" isCode="true" codeName="TWCZFS_ALL" width="70%">
								<option value="">--��ѡ��--</option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title poptitle"><font color="red">*</font>����ԭ��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="RETURN_REASON" id="R_RETURN_REASON" type="textarea" prefix="R_" formTitle="����ԭ��" defaultValue="" notnull="����������ԭ��" style="width:75%" maxlength="1000"/>
						</td>
					</tr>
				</table>
			</div>
			<!-- �������� end -->
		</div>
	</div>
	<br/>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="��һ��" class="btn btn-sm btn-primary" onclick="_goback();"/>&nbsp;
			<input type="button" value="ȡ��" class="btn btn-sm btn-primary" onclick="_cancel();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
