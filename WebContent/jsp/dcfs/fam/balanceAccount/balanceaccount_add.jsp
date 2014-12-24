<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
%>
<BZ:html>
	<BZ:head>
		<title>������֯�����˻����ҳ��</title>
		<BZ:webScript edit="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
			});
			
			//�ύԤ���������
			function _submit(){
				//ҳ���У��
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else if(confirm("ȷ���ύ��")){
					//���ύ
					document.srcForm.action = path+"fam/balanceaccount/BalanceAccountSave.action";
					document.srcForm.submit();
				}
			}
			
			//�����б�ҳ��
			function _goback(){
				window.location.href=path+"fam/balanceaccount/BalanceAccountList.action";
			}
		</script>
	</BZ:head>
	<BZ:body property="data">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<!-- Ʊ����Ϣ -->
		<BZ:input type="hidden" prefix="R_" field="ADOPT_ORG_ID" id="R_ADOPT_ORG_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ACCOUNT_MODIFYUSER" id="R_OPP_USERID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ACCOUNT_MODIFYDATE" id="R_OPP_USERNAME" defaultValue=""/>
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�����˻���Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">����</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="COUNTRY_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="20%">������֯</td>
							<td class="bz-edit-data-value" width="30%"> 
								<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ǰ���</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ACCOUNT_CURR" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>͸֧���</td>
							<td class="bz-edit-data-value"> 
								<BZ:input prefix="R_" field="ACCOUNT_LMT" id="R_ACCOUNT_LMT" defaultValue="" restriction="int" maxlength="22" notnull="͸֧��Ȳ���Ϊ�գ�"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">ά����</td>
							<td class="bz-edit-data-value"> 
								<BZ:dataValue field="MODIFYUSER_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">ά������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ACCOUNT_MODIFYDATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_submit();"/>
				<input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		
		</BZ:form>
	</BZ:body>
</BZ:html>