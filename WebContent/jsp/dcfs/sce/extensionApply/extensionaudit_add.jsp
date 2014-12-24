<%
/**   
 * @Title: extensionaudit_add.jsp
 * @Description:  ��������������ҳ
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
	<BZ:head>
		<title>��������������ҳ</title>
		<BZ:webScript edit="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
			});
			
			function _setShow(){
				$("#R_RESULT_NUM").val("");
				var result = $("#R_AUDIT_RESULT").find("option:selected").val();
				if(result == "1"){
					$("#selectNum").show();
					$("#R_RESULT_NUM").attr("disabled",false);
					$("#R_RESULT_NUM").attr("notnull","ͬ����ʱ�ݽ����޲���Ϊ�գ�");
				}else if(result == "2"){
					$("#selectNum").hide();
					$("#R_RESULT_NUM").attr("disabled",true);
					$("#R_RESULT_NUM").removeAttr("notnull");
				}
			}
			
			function _submit(){
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else if(confirm("ȷ���ύ��")){
					$("#R_AUDIT_STATE").val($("#R_AUDIT_RESULT").val());
					document.srcForm.action = path + "sce/extensionapply/ExtensionAuditSave.action";
					document.srcForm.submit();
				}
			}
			function _goBack(){
				document.srcForm.action = path + "sce/extensionapply/ExtensionAuditList.action";
				document.srcForm.submit();
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="GJSY;ETXB;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" field="DEF_ID" prefix="R_" id="R_DEF_ID" defaultValue=""/>
		<BZ:input type="hidden" field="RI_ID" prefix="R_" id="R_RI_ID" defaultValue=""/>
		<BZ:input type="hidden" field="SUBMIT_DATE" prefix="R_" id="R_SUBMIT_DATE" defaultValue=""/>
		<BZ:input type="hidden" field="AUDIT_STATE" prefix="R_" id="R_AUDIT_STATE" defaultValue=""/>
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
							<td class="bz-edit-data-title" width="20%"><font color="red">*</font>��˽��</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:select prefix="R_" field="AUDIT_RESULT" id="R_AUDIT_RESULT" formTitle="" defaultValue="" onchange="_setShow()" width="65%">
									<BZ:option value="1" selected="true">ͬ������</BZ:option>
									<BZ:option value="2">��ͬ������</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="20%"><font color="red" id="selectNum">*</font>ͬ����ʱ�ݽ�������</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:select prefix="R_" field="RESULT_NUM" id="R_RESULT_NUM" formTitle="" defaultValue="" notnull="ͬ����ʱ�ݽ����޲���Ϊ�գ�" width="65%">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="1">1����</BZ:option>
									<BZ:option value="2">2����</BZ:option>
									<BZ:option value="3">3����</BZ:option>
									<BZ:option value="4">4����</BZ:option>
									<BZ:option value="5">5����</BZ:option>
									<BZ:option value="6">6����</BZ:option>
									<BZ:option value="7">7����</BZ:option>
									<BZ:option value="8">8����</BZ:option>
									<BZ:option value="9">9����</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input type="textarea" prefix="R_" field="AUDIT_CONTENT" id="R_AUDIT_CONTENT" defaultValue="" maxlength="500" style="width:96%;height:100px;"/>
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
				<input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_submit();"/>
				<input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_goBack();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
	</BZ:body>
</BZ:html>