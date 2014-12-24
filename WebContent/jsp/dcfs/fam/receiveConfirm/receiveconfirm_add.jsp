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
		<title>����ȷ��ҳ��</title>
		<BZ:webScript edit="true" list="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
				$("#accountinfo").hide();
				$("#R_ACOUNT_REMARKS").val("");
			});
			
			//����ʹ������˻���Ϣ����ʾ������
			function _setAccountShow(obj){
				var val = obj.value;
				var arriveVal = $("#R_ARRIVE_VALUE").val();	//���˽��
				if(arriveVal == ""){
					alert("����д���˽�");
					$("#P_IS_USED").val("O");
					return;
				}else{
					if(val == "0"){
						$("#accountinfo").hide();
						$("#R_ARRIVE_ACCOUNT_VALUE").val("");
						$("#R_ACOUNT_REMARKS").val("");
						$("#R_ARRIVE_ACCOUNT_VALUE").removeAttr("notnull");
					}else if(val == "1"){
						var shouldVal = $("#R_PAID_SHOULD_NUM").val();	//Ӧ�ɽ��
						if(arriveVal >= shouldVal){
							alert("���˽����������Ҫʹ������˻��Ľ�");
							$("#P_IS_USED").val("O");
							return;
						}else{
							$("#accountinfo").show();
							$("#R_ARRIVE_ACCOUNT_VALUE").attr("notnull","����ʹ�ý���Ϊ�գ�");
						}
					}
				}
				
			}
			
			//����ʹ�ý�������˻����
			function _setAccountCurr(obj){
				var val = obj.value;	//����ʹ�ý��
				var curr = $("#P_ACCOUNT_CURR").val();	//�˻����
				var bzVal = $("#R_PAID_SHOULD_NUM").val() - $("#R_ARRIVE_VALUE").val();	//������
				if(val != ""){
					if(val > bzVal){
						alert("����ʹ��" + bzVal + "���Ϳ�����ѣ�����ʹ�ý��ܳ���" + bzVal + "��");
						$("#R_ARRIVE_ACCOUNT_VALUE").val("");
						return;
					}else{
						if(curr >= val){	//����˻���curr�����ڵ��ڱ���ʹ�ý�val��
							//�ж��Ƿ����
							if(val == bzVal){
								$("#R_ARRIVE_STATE").val("1");
							}else{
								$("#R_ARRIVE_STATE").val("2");
							}
						}else{	//�������˻����㣬��͸֧����˻����
							var limt = $("#R_ACCOUNT_LMT").val();
							if(val - curr <= limt){
								//�ж��Ƿ����
								if(val == bzVal){
									$("#R_ARRIVE_STATE").val("1");
								}else{
									$("#R_ARRIVE_STATE").val("2");
								}
							}else{
								alert("����ʹ�ý���ѳ������˻����޶");
								$("#R_ARRIVE_ACCOUNT_VALUE").val("");
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
					var yjVal = $("#R_PAID_SHOULD_NUM").val();	//Ӧ�ɽ��
					var dzVal = $("#R_ARRIVE_VALUE").val();	//���˽��
					var zhVal = $("#P_ACCOUNT_CURR").val();	//�˻����
					var isUsed = $("#P_IS_USED").val();
					if(isUsed == "1"){
						var bcsyVal = $("#R_ARRIVE_ACCOUNT_VALUE").val();	//����ʹ�ý��
						$("#P_ACCOUNT_CURR").val(zhVal - bcsyVal);
						$("#L_OPP_TYPE").val("1");	//��������(1������)
						$("#L_SUM").val(bcsyVal);	//�˵����
						$("#L_REMARKS").val($("#R_ACOUNT_REMARKS").val());	//������¼��ע
					}else{
						if(parseFloat(dzVal) > parseFloat(yjVal)){
							$("#P_ACCOUNT_CURR").val(parseFloat(zhVal) + parseFloat(dzVal) - parseFloat(yjVal));
							$("#L_OPP_TYPE").val("0");	//��������(0������)
							$("#L_SUM").val(dzVal - yjVal);	//�˵����
							$("#R_ARRIVE_STATE").val("1");
						}else if(dzVal == yjVal){
							$("#R_ARRIVE_STATE").val("1");
						}else{
							$("#R_ARRIVE_STATE").val("2");
						}
					}
					
					//���ύ
					document.srcForm.action = path+"fam/receiveconfirm/ReceiveConfirmSave.action";
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
		<BZ:input type="hidden" prefix="R_" field="CHEQUE_ID" id="R_CHEQUE_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPT_ORG_ID" id="R_ADOPT_ORG_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_NO" id="R_FILE_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ARRIVE_STATE" id="R_ARRIVE_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="PAID_SHOULD_NUM" id="R_PAID_SHOULD_NUM" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ACCOUNT_LMT" id="R_ACCOUNT_LMT" defaultValue=""/>
		<!-- ������֯����˻� -->
		<BZ:input type="hidden" prefix="P_" field="ORG_ID" id="R_ORG_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="P_" field="ACCOUNT_CURR" id="P_ACCOUNT_CURR" defaultValue=""/>
		<!-- ����˻�ʹ�ü�¼ -->
		<BZ:input type="hidden" prefix="L_" field="COUNTRY_CODE" id="L_COUNTRY_CODE" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="PAID_NO" id="L_PAID_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="BILL_NO" id="L_BILL_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="OPP_TYPE" id="L_OPP_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="SUM" id="L_SUM" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="REMARKS" id="L_REMARKS" defaultValue=""/>
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="page-content" style="width: 98%;margin-left: auto;margin-right: auto;">
			<div class="wrapper">
				<div class="bz-edit clearfix" desc="�༭����" style="width: 100%;">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- �������� begin -->
						<div class="ui-state-default bz-edit-title" desc="����">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>Ʊ����Ϣ</div>
						</div>
						<!-- �������� end -->
						<!-- �������� begin -->
						<div class="bz-edit-data-content clearfix" desc="������" style="width: 100%;">
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
									<td class="bz-edit-data-title">Ʊ����</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PAR_VALUE" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title">&nbsp;</td>
									<td class="bz-edit-data-value">&nbsp;</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<!--�б���Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 5%;">
									<div class="sorting_disabled">���</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled">���ı��</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled">�ļ�����</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting_disabled">��������</div>
								</th>
								<th style="width: 20%;">
									<div class="sorting_disabled">Ů������</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled">��ͯ����</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center"><BZ:i/></td>
								<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--�б���End -->
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>����ȷ����Ϣ</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>��������</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:input prefix="R_" field="ARRIVE_DATE" id="R_ARRIVE_DATE" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="�������ڲ���Ϊ�գ�" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>���˽��</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:input prefix="R_" field="ARRIVE_VALUE" id="R_ARRIVE_VALUE" defaultValue="" restriction="number" maxlength="22" notnull="���˽���Ϊ�գ�"/>
							</td>
							<td class="bz-edit-data-title" width="15%">�Ƿ���Ҫʹ�ý����˻�</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:select prefix="P" field="IS_USED" id="P_IS_USED" formTitle="" width="60%" onchange="_setAccountShow(this)">
									<BZ:option value="0" selected="true">��</BZ:option>
									<BZ:option value="1">��</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�տ�ժҪ</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="ARRIVE_REMARKS" id="R_ARRIVE_REMARKS" type="textarea" defaultValue="" maxlength="1000" style="height:50px;width:96%;"/>
							</td>
						</tr>
					</table>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������" id="accountinfo">
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
								<BZ:input prefix="R_" field="ARRIVE_ACCOUNT_VALUE" id="R_ARRIVE_ACCOUNT_VALUE" defaultValue="" restriction="number" maxlength="22" onblur="_setAccountCurr(this)"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�����˻�ʹ�ñ�ע</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="ACOUNT_REMARKS" id="R_ACOUNT_REMARKS" type="textarea" defaultValue="" maxlength="1000" style="height:50px;width:96%;"/>
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