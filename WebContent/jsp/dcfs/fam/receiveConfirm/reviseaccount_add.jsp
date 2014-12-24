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
		<title>�������ҳ��</title>
		<BZ:webScript edit="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
			});
			
			//����ʹ�ý�������˻����
			function _setAccountCurr(obj){
				var val = parseFloat(obj.value);	//����ʹ�ý��
				if(!isNaN(val)){
					var curr = farseFloat($("#P_ACCOUNT_CURR").val());	//�˻����
					var bzVal = farseFloat($("#R_BALANCE_VALUE").val());	//���
					if(val > bzVal){
						alert("����ʹ��" + bzVal + "���Ϳ�����ѣ�����ʹ�ý��ܳ���" + bzVal + "��");
						$("#L_SUM").val("");
						return;
					}else{
						if(curr >= val){	//����˻���curr�����ڵ��ڱ���ʹ�ý�val��
							//�ж��Ƿ����
							if(val == bzVal){
								$("#R_ARRIVE_STATE").val("2");
							}else{
								$("#R_ARRIVE_STATE").val("1");
							}
						}else{	//�������˻����㣬��͸֧����˻����
							var limt = $("#R_ACCOUNT_LMT").val();
							if(val - curr <= limt){
								$("#R_ARRIVE_STATE").val("2");
							}else{
								alert("����ʹ�ý���ѳ������˻����޶");
								$("#L_SUM").val("");
								return;
							}
						}
					}
				}
			}
			
			//�ύԤ���������
			function _submit(){
				//ҳ���У��
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else if(confirm("ȷ���ύ��")){
					//���ύ
					var yjsyVal = parseFloat($("#R_ARRIVE_ACCOUNT_VALUE").val());
					var cesyVal = parseFloat($("#L_SUM").val());
					var currVal = parseFloat($("#P_ACCOUNT_CURR").val());
					$("#R_ARRIVE_ACCOUNT_VALUE").val(yjsyVal + cesyVal);
					$("#P_ACCOUNT_CURR").val(currVal - cesyVal);	//��������˻����
					document.srcForm.action = path+"fam/receiveconfirm/ReviseAccountSave.action";
					document.srcForm.submit();
				}
			}
			
			//�����б�ҳ��
			function _goback(){
				window.location.href=path+"fam/receiveconfirm/ReceiveConfirmList.action";
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="JFFS;FYLB;WJLX;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<!-- Ʊ����Ϣ -->
		<BZ:input type="hidden" prefix="R_" field="CHEQUE_ID" id="R_CHEQUE_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPT_ORG_ID" id="R_ADOPT_ORG_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ARRIVE_STATE" id="R_ARRIVE_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_NO" id="R_FILE_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ARRIVE_ACCOUNT_VALUE" id="R_ARRIVE_ACCOUNT_VALUE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ACCOUNT_LMT" id="R_ACCOUNT_LMT" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="BALANCE_VALUE" id="R_BALANCE_VALUE" defaultValue=""/>
		<!-- ����˻�ʹ�ü�¼ -->
		<BZ:input type="hidden" prefix="L_" field="COUNTRY_CODE" id="L_COUNTRY_CODE" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="PAID_NO" id="L_PAID_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="BILL_NO" id="L_BILL_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="OPP_TYPE" id="L_OPP_TYPE" defaultValue="1"/>
		<!-- ������֯����˻� -->
		<BZ:input type="hidden" prefix="P_" field="ACCOUNT_CURR" id="P_ACCOUNT_CURR" defaultValue=""/>
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">�ɷѱ��</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">�ɷѷ�ʽ</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">��������</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="COST_TYPE" codeName="FYLB" defaultValue="" onlyValue="true" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">Ӧ�ɽ��</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">���˽��</td>
							<td class="bz-edit-data-value"> 
								<BZ:dataValue field="ARRIVE_VALUE" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ARRIVE_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ʹ���˻����</td>
							<td class="bz-edit-data-value"> 
								<BZ:dataValue field="ARRIVE_ACCOUNT_VALUE" defaultValue="0" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">���</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BALANCE_VALUE" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">��ǰ�˻����</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="ACCOUNT_CURR" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">�����˻�ʹ������</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="ACCOUNT_LMT" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>����ʹ�ý��</td>
							<td class="bz-edit-data-value" width="19%"> 
								<BZ:input prefix="L_" field="SUM" id="L_SUM" defaultValue="" restriction="number" maxlength="22" notnull="����ʹ�ý���Ϊ�գ�" onblur="_setAccountCurr(this)"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�����˻�ʹ�ñ�ע</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="L_" field="REMARKS" id="L_REMARKS" type="textarea" defaultValue="" maxlength="1000" style="height:50px;width:96%;"/>
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