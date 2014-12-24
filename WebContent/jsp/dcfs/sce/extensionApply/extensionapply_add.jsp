<%
/**   
 * @Title: extensionapply_add.jsp
 * @Description:  ���������������ҳ
 * @author yangrt   
 * @date 2014-09-29
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
%>
<BZ:html>
	<BZ:head language="EN">
		<title>���������������ҳ</title>
		<BZ:webScript edit="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
			});
			function _submit(){
				var val = $("#R_DEF_REASON").val();
				if (val == "") {
					alert("reasons for applying for extension cannot be empty!");
					return;
				}else if(confirm("Are you sure you want to submit?")){
					document.srcForm.action = path + "sce/extensionapply/ExtensionApplySave.action";
					document.srcForm.submit();
				}
			}
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
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" field="RI_ID" prefix="R_" id="R_RI_ID" defaultValue=""/>
		<BZ:input type="hidden" field="REQ_USERID" prefix="R_" id="R_REQ_USERID" defaultValue=""/>
		<BZ:input type="hidden" field="REQ_USERNAME" prefix="R_" id="R_REQ_USERNAME" defaultValue=""/>
		<BZ:input type="hidden" field="REQ_DATE" prefix="R_" id="R_REQ_DATE" defaultValue=""/>
		<BZ:input type="hidden" field="SUBMIT_DATE" prefix="R_" id="R_SUBMIT_DATE" defaultValue=""/>
		<BZ:input type="hidden" field="AUDIT_STATE" prefix="R_" id="R_AUDIT_STATE" defaultValue="0"/>
		<!-- ��������end -->
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
							<td class="bz-edit-data-title">��ǰ��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/>
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
							<td class="bz-edit-data-title"><font color="red">*</font>�������ڽ���ԭ��<br>Reason for extending submission</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input type="textarea" prefix="R_" field="DEF_REASON" id="R_DEF_REASON" defaultValue="" notnull="" maxlength="1000" style="width:96%;height:100px;"/>
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
				<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit();"/>
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goBack();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
	</BZ:body>
</BZ:html>