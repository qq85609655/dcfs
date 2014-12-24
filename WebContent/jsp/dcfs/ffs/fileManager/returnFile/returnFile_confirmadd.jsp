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
<BZ:head language="EN">
	<title>��������ȷ��ҳ��</title>
	<BZ:webScript edit="true" tree="false"/>
	<style>
		.base .bz-edit-data-title{
			line-height:20px;
		}
	</style>
	<script>
	
	//��������ȷ���ύ
	function _submit() {
		//ҳ���У��
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			if (confirm("Are you sure to submit? You are not allowed to modify once submitted!")) {
				document.srcForm.action = path + "ffs/filemanager/ReturnFileSave.action";
				document.srcForm.submit();
			}
		}
	}
	
	//�������������б�
	function _goback(){
		window.location.href=path+'ffs/filemanager/ReturnApplyList.action';
	}
	
	//����������Ϣ�б�
	function _cancel(){
		if (confirm("Are you sure you want to cancel withdrawal application? ")){
			window.location.href=path+'ffs/filemanager/ReturnFileList.action';
		}
	}
	
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;SYZZ;TWCZFS_SYZZ;WJQJZT_SYZZ" property="confirmData">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<BZ:input prefix="R_" field="AF_ID" type="hidden" defaultValue="" />
	<BZ:input prefix="R_" field="FAMILY_TYPE" type="hidden" defaultValue="" />
	<BZ:input prefix="R_" field="COUNTRY_CODE" type="hidden" defaultValue="" />
	<BZ:input prefix="R_" field="ADOPT_ORG_ID" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�ļ�������Ϣ(INFORMATION ABOUT THE FILE)</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">���ı��<br>Log-in No.</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="FILE_NO" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������<br>Log-in date</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/>
							<BZ:input prefix="R_" field="REGISTER_DATE" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">�ļ�����<br>Document type</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" isShowEN="true" defaultValue="" onlyValue="true" />
							<BZ:input prefix="R_" field="FILE_TYPE" type="hidden" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������<br>Adoptive father</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="MALE_NAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">Ů������<br>Adoptive mother</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="FEMALE_NAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�ļ�״̬<br>File status</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AF_GLOBAL_STATE" codeName="WJQJZT_SYZZ" isShowEN="true" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ͣ״̬<br>Suspension status</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RECOVERY_STATE" defaultValue="" checkValue="1=suspeneded;9=non-suspended" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��ͣ����<br>Suspension date</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="PAUSE_DATE" defaultValue="" type="date" onlyValue="true"/>
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
					����������Ϣ(RETURN FILE APPLICATION INFORMATION)
				</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">������<br>Applicant</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_PERSON_NAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="APPLE_PERSON_ID" type="hidden"/>
							<BZ:input prefix="R_" field="APPLE_PERSON_NAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������<br>Date of application</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_DATE" type="date" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="APPLE_DATE" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>���Ĵ��÷�ʽ<br>Treatment of withdrawal</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:select field="HANDLE_TYPE" id="R_HANDLE_TYPE" notnull="please input treatment of withdrawal" formTitle="" prefix="R_" isCode="true" codeName="TWCZFS_SYZZ" isShowEN="true" width="70%">
								<option value="">--Please select--</option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title poptitle"><font color="red">*</font>����ԭ��<br>Reason for withdrawal</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:input field="RETURN_REASON" id="R_RETURN_REASON" type="textarea" prefix="R_" formTitle="Reason for withdrawal" defaultValue=""  style="width:75%" maxlength="1000"/>
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
			<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="Last step" class="btn btn-sm btn-primary" onclick="_goback();"/>&nbsp;
			<input type="button" value="Cancel" class="btn btn-sm btn-primary" onclick="_cancel();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
