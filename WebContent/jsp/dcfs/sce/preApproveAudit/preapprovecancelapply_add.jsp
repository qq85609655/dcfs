<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
%>
<BZ:html>
	<BZ:head>
		<title>Ԥ�������޸�ҳ��</title>
		<BZ:webScript edit="true" tree="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
				_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_PUB_ORGID');
			});
			
			function _setShowPublishInfo(obj){
				var val = obj.value;
				if(val == "1"){
					var pub_type=$("#P_PUB_TYPE").find("option:selected").val();
					if(pub_type=="1"){
						$("#P_COUNTRY_CODE").attr("notnull","���������");
						$("#P_ADOPT_ORG_ID").attr("notnull","�����뷢����֯");
						$("#P_PUB_MODE").attr("notnull","������㷢����");
					}else{
						$("#M_PUB_ORGID").attr("notnull","��ѡ�񷢲���֯");
					}
					$("#publishinfo").show();
				}else{
					$("#P_PUB_TYPE").removeAttr("notnull");
					$("#P_COUNTRY_CODE").removeAttr("notnull");
					$("#P_ADOPT_ORG_ID").removeAttr("notnull");
					$("#P_PUB_MODE").removeAttr("notnull");
					$("#M_PUB_ORGID").removeAttr("notnull");
					$("#publishinfo").hide();
				}
			}
			
			//���ݵ㷢��Ⱥ����̬չ���������
			function _dynamicFblx(){
				_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_PUB_ORGID');
				$("#M_PUB_ORGID").val("");
				$("#P_PUB_MODE").val("");
				$("#M_PUB_MODE").val("");
				$("#P_SETTLE_DATE_NORMAL").val("");
				$("#P_SETTLE_DATE_SPECIAL").val("");
				$("#M_SETTLE_DATE_NORMAL").val("");
				$("#M_SETTLE_DATE_SPECIAL").val("");
				$("#P_PUB_REMARKS").val("");
				var optionValue = $("#P_PUB_TYPE").find("option:selected").val();
				if(optionValue=="1"){//�㷢
					$("#P_COUNTRY_CODE").attr("notnull","���������");
					$("#P_ADOPT_ORG_NAME").attr("notnull","�����뷢����֯");
					$("#P_PUB_MODE").attr("notnull","������㷢����");
					$("#PUB_ORGID").removeAttr("notnull");
					
					$("#dfzz").show();
					$("#dflx").show();
					$("#dfbz").show();
					$("#qfzz").hide();
					$("#qflx").hide();
				}else{//Ⱥ��
					$("#PUB_ORGID").attr("notnull","��ѡ�񷢲���֯");
					$("#P_COUNTRY_CODE").removeAttr("notnull");
					$("#P_ADOPT_ORG_NAME").removeAttr("notnull");
					$("#P_PUB_MODE").removeAttr("notnull");
					
					$("#dfzz").hide();
					$("#dflx").hide();
					$("#dfbz").hide();
					$("#qfzz").show();
					$("#qflx").show();
				}
				
			}
			
			//��ð�������
			function _getAzqxForFb(){
				var is_df = $("#P_PUB_TYPE").find("option:selected").val();//��������  1���㷢  2��Ⱥ��
				var pub_mode = $("#P_PUB_MODE").find("option:selected").val();//�㷢����  
				
				if(""==pub_mode){
					pub_mode=null;
				}
				
				if("1"==is_df && (""==pub_mode||null==pub_mode)){
					return;
				}else{
					$.ajax({
						url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=getAZQXInfo&IS_DF='+is_df+'&PUB_MODE='+pub_mode,
						type: 'POST',
						dataType: 'json',
						timeout: 1000,
						success: function(data){
							var two_type1 = data[0].TWO_TYPE;//�Ƿ��ر��ע  0:��  1����
							var settle_months1 = data[0].SETTLE_MONTHS;
							//var two_type2 = data[1].TWO_TYPE;//�Ƿ��ر��ע  0:��  1����
							var settle_months2 = data[1].SETTLE_MONTHS;
							if("1"==is_df){//�㷢����
								if("0"==two_type1){//���ر��ע
									$("#P_SETTLE_DATE_NORMAL").val(settle_months1);
									$("#P_SETTLE_DATE_SPECIAL").val(settle_months2);
								}else {//�ر��ע
									$("#P_SETTLE_DATE_NORMAL").val(settle_months2);
									$("#P_SETTLE_DATE_SPECIAL").val(settle_months1);
								}
							}else {//Ⱥ������
								if("0"==two_type1){//���ر��ע
									$("#M_SETTLE_DATE_NORMAL").val(settle_months1);
									$("#M_SETTLE_DATE_SPECIAL").val(settle_months2);
								}else {//�ر��ע
									$("#M_SETTLE_DATE_NORMAL").val(settle_months2);
									$("#M_SETTLE_DATE_SPECIAL").val(settle_months1);
								}
							}
						}
					});
				}
			}
			
			//�����б�ҳ��
			function _goback(){
				window.location.href=path+"sce/preapproveaudit/PreApproveAuditListAZB.action";
			}
			
			//�ύԤ���������
			function _submit(){
				//ҳ���У��
				if (!runFormVerify(document.srcForm, false)) {
					alert();
					return;
				}else if(confirm("ȷ���ύ��")){
					//���ύ
					document.srcForm.action = path+"sce/preapproveaudit/PreApproveCancelApplySave.action";
					document.srcForm.submit();
				}
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="GJSY;PROVINCE;ADOPTER_CHILDREN_SEX;DFLX;SYS_ADOPT_ORG;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="RI_ID" id="R_RI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="PUB_ID" id="R_PUB_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="REVOKE_STATE" id="R_REVOKE_STATE" defaultValue="1"/>
		<BZ:input type="hidden" prefix="R_" field="REVOKE_TYPE" id="R_REVOKE_TYPE" defaultValue="1"/>
		<BZ:input type="hidden" prefix="C_" field="CI_ID" id="C_CI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="C_" field="SPECIAL_FOCUS" id="C_SPECIAL_FOCUS" defaultValue=""/>
		<!-- ��������end -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>Ԥ����Ϣ</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title">����</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">������֯</td>
							<td class="bz-edit-data-value" colspan="3"> 
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true" />
							</td>
							<td class="bz-edit-data-title">Ů������</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">ʡ��</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">����Ժ</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">��ͯ����</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME" defaultValue=""  onlyValue="true" />
							</td>
							<td class="bz-edit-data-title" width="10%">�Ա�</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">��������</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">�ر��ע</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SPECIAL_FOCUS" checkValue="0=��;1=��;" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<BZ:for property="ChildList" fordata="childdata">
						<tr>
							<td class="bz-edit-data-title" width="10%">��ͯ����</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME" property="childdata" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">�Ա�</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SEX" property="childdata" codeName="ADOPTER_CHILDREN_SEX" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">��������</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="BIRTHDAY" property="childdata" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">�ر��ע</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SPECIAL_FOCUS" property="childdata" checkValue="0=��;1=��;" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						</BZ:for>
						<tr>
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value" colspan="7">
								<BZ:dataValue field="REQ_DATE" type="Date" defaultValue="" onlyValue="true"/>
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
					<div>����������Ϣ</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>����ԭ��</td>
							<td class="bz-edit-data-value" width="90%">
								<BZ:input prefix="R_" field="REVOKE_REASON" id="R_REVOKE_REASON" type="textarea" defaultValue="" maxlength="1000" notnull="����ԭ����Ϊ�գ�" style="width:96%;height:50px;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�Ƿ��������</td>
							<td class="bz-edit-data-value"> 
								<BZ:select prefix="C_" field="IS_PUBLISH" formTitle="C_IS_PUBLISH" defaultValue="true" onchange="_setShowPublishInfo(this)" width="80px;">
									<BZ:option value="1" selected="true">��</BZ:option>
									<BZ:option value="0">��</BZ:option>
								</BZ:select>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="�༭����" id="publishinfo">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������Ϣ</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>��������</td>
							<td class="bz-edit-data-value">
								<BZ:select field="PUB_TYPE" id="P_PUB_TYPE" notnull="�����뷢������" formTitle="" prefix="P_" onchange="_dynamicFblx();_getAzqxForFb()" width="50%">
									<option value="1">�㷢</option>
									<option value="2">Ⱥ��</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>������֯</td>
							<td class="bz-edit-data-value" id="dfzz">
								<BZ:select field="COUNTRY_CODE" formTitle="" prefix="P_" id="P_COUNTRY_CODE" isCode="true" codeName="GJSY" onchange="_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_PUB_ORGID')">
									<option value="">--��ѡ�����--</option>
								</BZ:select>
								<BZ:select prefix="P_" field="ADOPT_ORG_ID" id="P_ADOPT_ORG_ID" notnull="������������֯" formTitle="" width="70%" onchange="_setOrgID('P_PUB_ORGID',this.value)">
									<option value="">--��ѡ�񷢲���֯--</option>
								</BZ:select>
								<BZ:input type="hidden" field="PUB_ORGID"  prefix="P_" id="P_PUB_ORGID"/>
							</td>
							<td class="bz-edit-data-value" id="qfzz" style="display:none">
								<BZ:input prefix="M_" field="PUB_ORGID" id="M_PUB_ORGID" type="helper" helperCode="SYS_ADOPT_ORG" helperTitle="ѡ�񷢲���֯" treeType="1" helperSync="true" showParent="false" defaultShowValue="" showFieldId="M_PUB_ORGID" notnull="��ѡ�񷢲���֯" style="height:13px;width:80%"  />
							</td>
						</tr>
						<tr id="dflx">
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>�㷢����</td>
							<td class="bz-edit-data-value"  >
								<BZ:select field="PUB_MODE" id="P_PUB_MODE" notnull="������㷢����" formTitle="" prefix="P_" isCode="true" codeName="DFLX" onchange="_getAzqxForFb()" width="50%">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%">��������</td>
							<td class="bz-edit-data-value" >
								<BZ:input field="SETTLE_DATE_SPECIAL" id="P_SETTLE_DATE_SPECIAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>���£��ر��ע��
								<BZ:input field="SETTLE_DATE_NORMAL" id="P_SETTLE_DATE_NORMAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>���£����ر��ע��
							</td>
						</tr>
						<tr id="qflx" style="display:none">
							<td class="bz-edit-data-title" width="10%">��������</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="SETTLE_DATE_SPECIAL" id="M_SETTLE_DATE_SPECIAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>���£��ر��ע��
								<BZ:input field="SETTLE_DATE_NORMAL" id="M_SETTLE_DATE_NORMAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>���£����ر��ע��
							</td>
							
						</tr>
						<tr id="dfbz">
							<td class="bz-edit-data-title poptitle">�㷢��ע</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="PUB_REMARKS" id="P_PUB_REMARKS" type="textarea" prefix="P_" formTitle="�㷢��ע" defaultValue="" style="width:80%"  maxlength="900"/>
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