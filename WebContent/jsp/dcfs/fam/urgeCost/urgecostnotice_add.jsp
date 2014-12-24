<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
	String packageId = (String)request.getAttribute("packageId");
%>
<BZ:html>
	<BZ:head>
		<title>�߽�֪ͨ���ҳ��</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource cancelJquerySupport="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
				_findSyzzNameListForNew('R_COUNTRY_CODE','R_ADOPT_ORG_ID','R_HIDDEN_ADOPT_ORG_ID');
			});
			
			//����Ӧ�ɽ�����Ƿ��������
			function _setIsInput(){
				var val = $("#R_COST_TYPE").find("option:selected").text();
				if(val == "�����"){
					var childnum = $("#R_CHILD_NUM").val();
					var schildnum = $("#R_S_CHILD_NUM").val();
					if(childnum == ""){
						if(schildnum == ""){
							$("#R_PAID_SHOULD_NUM").val("");
							$("#R_PAID_SHOULD_NUM").attr("readonly","true");
						}else{
							$("#R_PAID_SHOULD_NUM").val(schildnum * 120);
							$("#R_PAID_SHOULD_NUM").attr("readonly","true");
						}
					}else{
						if(schildnum == ""){
							$("#R_PAID_SHOULD_NUM").val(childnum * 50);
							$("#R_PAID_SHOULD_NUM").attr("readonly","true");
						}else{
							$("#R_PAID_SHOULD_NUM").val(parseFloat(childnum * 50) + parseFloat(schildnum * 120));
							$("#R_PAID_SHOULD_NUM").attr("readonly","true");
						}
					}
				}else{
					$("#R_PAID_SHOULD_NUM").val("");
					$("#R_PAID_SHOULD_NUM").removeAttr("readonly");
				}
			}
			
			//����Ӧ�ɽ��
			function _setShouldValue(type){
				var val = $("#R_COST_TYPE").find("option:selected").text();
				if(val == "�����"){
					var childnum = $("#R_CHILD_NUM").val();
					var schildnum = $("#R_S_CHILD_NUM").val();
					if(type == "normal"){
						if(childnum == ""){
							if(schildnum == ""){
								alert("�����������ͯ��������ȫΪ�գ�");
								$("#R_PAID_SHOULD_NUM").val("");
								return;
							}else{
								$("#R_PAID_SHOULD_NUM").val(schildnum * 120);
							}
						}else{
							if(schildnum == ""){
								$("#R_PAID_SHOULD_NUM").val(childnum * 50);
							}else{
								$("#R_PAID_SHOULD_NUM").val(parseFloat(childnum * 50) + parseFloat(schildnum * 120));
							}
						}
					}else if(type == "special"){
						if(schildnum == ""){
							if(childnum == ""){
								alert("�����������ͯ��������ȫΪ�գ�");
								$("#R_PAID_SHOULD_NUM").val("");
								return;
							}else{
								$("#R_PAID_SHOULD_NUM").val(childnum * 50);
							}
						}else{
							if(childnum == ""){
								$("#R_PAID_SHOULD_NUM").val(schildnum * 120);
							}else{
								$("#R_PAID_SHOULD_NUM").val(parseFloat(childnum * 50) + parseFloat(schildnum * 120));
							}
						}
					}
				}
			}
			
			//�ύԤ���������
			function _submit(state){
				$("#R_NOTICE_STATE").val(state);	//֪ͨ״̬
				//ҳ���У��
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else if(confirm("ȷ���ύ��")){
					//���ύ
					document.srcForm.action = path+"fam/urgecost/UrgeCostNoticeSave.action";
					document.srcForm.submit();
				}
			}
			
			//�����б�ҳ��
			function _goback(){
				window.location.href=path+"fam/urgecost/UrgeCostList.action";
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="GJSY;FYLB;SYS_GJSY_CN">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="RM_ID" id="R_RM_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="NOTICE_STATE" id="R_NOTICE_STATE" defaultValue=""/>
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
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>����</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:select field="COUNTRY_CODE" formTitle="" prefix="R_" id="R_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="77%" onchange="_findSyzzNameListForNew('R_COUNTRY_CODE','R_ADOPT_ORG_ID','R_HIDDEN_ADOPT_ORG_ID')">
									<option value="">--��ѡ��--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>������֯</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:select prefix="R_" field="ADOPT_ORG_ID" id="R_ADOPT_ORG_ID" notnull="������������֯" formTitle="" notnull="������֯����Ϊ�գ�" width="77%" onchange="_setOrgID('R_HIDDEN_ADOPT_ORG_ID',this.value)">
									<option value="">--��ѡ��--</option>
								</BZ:select>
								<input type="hidden" id="R_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>��������</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:select prefix="R_" field="COST_TYPE" id="R_COST_TYPE" isCode="true" codeName="FYLB" formTitle="" defaultValue="" notnull="�������Ͳ���Ϊ�գ�" width="73%;" onchange="_setIsInput()">
									<BZ:option value="">--��ѡ��--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������ͯ����</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="CHILD_NUM" id="R_CHILD_NUM" defaultValue="" restriction="int" onblur="_setShouldValue('normal')"/>
							</td>
							<td class="bz-edit-data-title">�����ͯ����</td>
							<td class="bz-edit-data-value"> 
								<BZ:input prefix="R_" field="S_CHILD_NUM" id="R_S_CHILD_NUM" defaultValue="" restriction="int" onblur="_setShouldValue('special')"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>Ӧ�ɽ��</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="PAID_SHOULD_NUM" id="R_PAID_SHOULD_NUM" defaultValue="" restriction="number" maxlength="22" notnull="Ӧ�ɽ���Ϊ�գ�"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����</td>
							<td class="bz-edit-data-value" colspan="5"> 
								<up:uploadBody 
									attTypeCode="OTHER" 
									bigType="<%=AttConstants.FAM %>"
									smallType="<%=AttConstants.FAW_JFPJ %>"
									id="R_UPLOAD_ID" 
									name="R_UPLOAD_ID"
									packageId="<%=packageId %>" 
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
						<tr>
							<td class="bz-edit-data-title">�ɷ�����</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="PAID_CONTENT" id="R_PAID_CONTENT" type="textarea" defaultValue="" maxlength="1000" style="height:50px;width:96%;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ע</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="REMARKS" id="R_REMARKS" type="textarea" defaultValue="" maxlength="1000" style="height:50px;width:96%;"/>
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
				<input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_submit('0');"/>
				<input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_submit('1');"/>
				<input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		
		</BZ:form>
	</BZ:body>
</BZ:html>