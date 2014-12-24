<%
/**   
 * @Title: extensionaudit_view.jsp
 * @Description:  ����������˲鿴ҳ
 * @author yangrt   
 * @date 2014-09-29
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
	<BZ:head>
		<title>����������˲鿴ҳ</title>
		<BZ:webScript edit="true"/>
		<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
			var state = $("#R_AUDIT_STATE").val();
			if(state == "1"){
				$("#AUDIT_RESULT").text("ͬ������");
			}else if(state == "2"){
				$("#AUDIT_RESULT").text("��ͬ������");
			}
		});
		
		function _goBack(){
			document.srcForm.action = path + "sce/extensionapply/ExtensionAuditList.action";
			document.srcForm.submit();
		}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="GJSY;ETXB;">
		<BZ:form name="srcForm" method="post">
		<!-- ��������begin -->
		<BZ:input type="hidden" field="AUDIT_STATE" prefix="R_" id="R_AUDIT_STATE" defaultValue="0"/>
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>��������������Ϣ</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">����</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">������֯</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">��������</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">Ů������</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ͯ����</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">�Ա�</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REQ_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">�ļ��ݽ�����</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����ԭ��</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="DEF_REASON" defaultValue="" onlyValue="true" style="width:96%;height:100px;"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�������������Ϣ</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">��˽��</td>
							<td class="bz-edit-data-value" width="30%">
								<span id="AUDIT_RESULT"></span>
							</td>
							<td class="bz-edit-data-title" width="20%">�ļ��µݽ�����</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="REQ_SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="AUDIT_CONTENT" defaultValue="" onlyValue="true" style="height:100px;"/>
							</td>
						</tr>
					</table>
				</div>
				<!-- �������� end -->
			</div>
		</div>
		<!-- �༭����end -->
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goBack();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
	</BZ:body>
</BZ:html>