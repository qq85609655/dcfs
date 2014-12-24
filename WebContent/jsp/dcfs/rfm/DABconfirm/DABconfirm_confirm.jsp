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
	<title>����ȷ��ҳ��</title>
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
			if (confirm("ȷ��ȷ�ϸ�������Ϣ��")) {
				document.srcForm.action = path + "rfm/DABconfirm/DABconfirmSave.action";
				document.srcForm.submit();
			}
		}
	}
	
	//����
	function _goback(){
		window.location.href=path+'rfm/DABconfirm/DABconfirmList.action';
	}
	
	
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;WJWZ;TWLX" property="confirmData">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<BZ:input prefix="R_" field="AR_ID" type="hidden" defaultValue="" />
	<BZ:input prefix="R_" field="AF_ID" type="hidden" defaultValue="" />
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
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�ļ�����</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">Ů������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
						</td>
						<td class="bz-edit-data-title">������֯</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
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
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_DATE" type="date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_TYPE" codeName="TWLX" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title poptitle">����ԭ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="RETURN_REASON" defaultValue="" onlyValue="true"/>
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
			<input type="button" value="ȷ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
