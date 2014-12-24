<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
%>
<BZ:html>
	<BZ:head>
		<title>�߽�֪ͨ�������ҳ��</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource/>
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
					document.srcForm.action = path+"fam/urgecost/UrgeCostFeedBackSave.action";
					document.srcForm.submit();
				}
			}
			
			//�����б�ҳ��
			function _goback(){
				window.location.href=path+"fam/urgecost/UrgeCostList.action";
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="GJSY;JFFS;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="RM_ID" id="R_RM_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="COUNTRY_CODE" id="R_COUNTRY_CODE" defaultValue="" />
		<BZ:input type="hidden" prefix="R_" field="ADOPT_ORG_ID" id="R_ADOPT_ORG_ID" defaultValue="" />
		<BZ:input type="hidden" prefix="R_" field="NAME_CN" id="R_NAME_CN" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="NAME_EN" id="R_NAME_EN" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="PAID_NO" id="R_PAID_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="COST_TYPE" id="R_COST_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="PAID_SHOULD_NUM" id="R_PAID_SHOULD_NUM" defaultValue="" />
		<BZ:input type="hidden" prefix="R_" field="PAID_CONTENT" id="R_PAID_CONTENT" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="NOTICE_STATE" id="L_NOTICE_STATE" defaultValue="2"/>
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�߽�֪ͨ��Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">������ͯ����</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="CHILD_NUM" defaultValue="0" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">�����ͯ����</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="S_CHILD_NUM" defaultValue="0" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">Ӧ�ɽ��</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">֪ͨ��</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NOTICE_USERNAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">֪ͨ����</td>
							<td class="bz-edit-data-value"> 
								<BZ:dataValue field="NOTICE_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�ɷ�����</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="PAID_CONTENT" defaultValue="" onlyValue="true" style="height:50px;width:96%;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ע</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true" style="height:50px;width:96%;"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�߽�֪ͨ������Ϣ</div>
				</div>
				<!-- �������� end -->
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
								<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>�ɷѷ�ʽ</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:select prefix="R_" field="PAID_WAY" id="R_COST_TYPE" isCode="true" codeName="JFFS" notnull="�ɷѷ�ʽ����Ϊ�գ�" formTitle="" defaultValue="" width="65%">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>�ɷ�Ʊ��</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="BILL_NO" id="R_BILL_NO" maxlength="22" notnull="�ɷ�Ʊ�Ų���Ϊ�գ�" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>�ɷ�Ʊ����</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="PAR_VALUE" id="R_PAR_VALUE" restriction="number" maxlength="22" notnull="�ɷ�Ʊ�����Ϊ�գ�" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>�ɷ���</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="PAY_USERNAME" id="R_PAY_USERNAME" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>�ɷ�����</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="PAY_DATE" id="R_PAY_DATE" type="Date" dateExtend="maxDate:'%y-%M-%d'" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����</td>
							<td class="bz-edit-data-value" colspan="5"> 
								<up:uploadBody 
									attTypeCode="OTHER" 
									bigType="<%=AttConstants.FAM %>"
									smallType="<%=AttConstants.FAW_JFPJ %>"
									id="R_FILE_CODE" 
									name="R_FILE_CODE"
									packageId="" 
									autoUpload="true"
									queueTableStyle="padding:2px" 
									diskStoreRuleParamValues="class_code=FAM"
									queueStyle="border: solid 1px #CCCCCC;width:380px"
									selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:380px;"
									proContainerStyle="width:380px;"
									firstColWidth="15px"
									/>
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