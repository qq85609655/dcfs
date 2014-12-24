<%
/**   
 * @Title: extensionapply_view.jsp
 * @Description:  ������������鿴ҳ
 * @author yangrt   
 * @date 2014-09-29
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
	<BZ:head language="EN">
		<title>������������鿴ҳ</title>
		<BZ:webScript edit="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
			});
			
			function _goBack(){
				document.srcForm.action = path + "sce/extensionapply/ExtensionApplyList.action";
				document.srcForm.submit();
			}
		</script>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<BZ:body property="data" codeNames="ETXB;">
		<BZ:form name="srcForm" method="post">
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>Ԥ��������Ϣ</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">��������<br>Adoptive father</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">Ů������<br>Adoptive mother</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ͯ����<br>Child name</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">�Ա�<br>Sex</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">��������<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<BZ:for property="childList" fordata="myData">
						<tr>
							<td class="bz-edit-data-title">��ͯ����<br>Child name</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME_PINYIN" property="myData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">�Ա�<br>Sex</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" property="myData" codeName="ETXB" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">��������<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" property="myData" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						</BZ:for>
						<tr>
							<td class="bz-edit-data-title">Ԥ����������<br>Pre-approval application date</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PRE_REQ_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">Ԥ��ͨ������<br>Pre-approved date</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PASS_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������������(Application to extend submission deadline)</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">������<br>Applicant</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="REQ_USERNAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="20%">��������<br>Date of application</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="REQ_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�������ڽ���ԭ��<br>Reason for extending submission</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="DEF_REASON" defaultValue="" onlyValue="true" style="height:100px;"/>
							</td>
						</tr>
					</table>
				</div>
				<!-- �������� end -->
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�����������</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">ԭ�ݽ�����<br>Original submission deadline</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							
							<td class="bz-edit-data-title" width="20%">�µݽ�����<br>Extended submission deadline</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="REQ_SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�����<br>Reviewed by</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">�������<br>Review date</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="AUDIT_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������<br>Review conclusion</td>
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