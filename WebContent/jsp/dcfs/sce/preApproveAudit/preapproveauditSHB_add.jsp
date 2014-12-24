<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
	
	String af_id = (String)request.getAttribute("AF_ID");
	String ri_id = (String)request.getAttribute("RI_ID");
	String rau_id = (String)request.getAttribute("RAU_ID");
	String flag = (String)request.getAttribute("Flag");
%>
<BZ:html>
	<BZ:head>
		<title>Ԥ�������޸�ҳ��</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
			a:hover{
				text-decoration:underline;
			} 
		</style>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
				var level = $("#R_AUDIT_LEVEL").val();
				if(level == "0"){
					$("#TwoLevel").hide();
					$("#ThreeLevel").hide();
					$("#R_RESULT_TWO").removeAttr("notnull");
					$("#R_RESULT_THREE").removeAttr("notnull");
				}else if(level == "1"){
					$("#OneLevel").hide();
					$("#ThreeLevel").hide();
					$("#R_RESULT_ONE").removeAttr("notnull");
					$("#R_RESULT_THREE").removeAttr("notnull");
				}else{
					$("#OneLevel").hide();
					$("#TwoLevel").hide();
					$("#R_RESULT_ONE").removeAttr("notnull");
					$("#R_RESULT_TWO").removeAttr("notnull");
				}
			});
			
			//Tabҳjs
			function change(flag){
				if(flag==1){
					document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=infoCN&type=show";
					document.getElementById("act1").className="active";
					document.getElementById("act2").className="";
					document.getElementById("act3").className="";
					document.getElementById("act4").className="";
					document.getElementById("act5").className="";
					document.getElementById("act6").className="";
					document.getElementById("act7").className="";
					document.getElementById("act8").className="";
					document.getElementById("act9").className="";
					$("#topinfoCN").show();
				}	
				if(flag==2){
					document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=infoEN&type=show";
					document.getElementById("act1").className="";
					document.getElementById("act2").className="active";
					document.getElementById("act3").className="";
					document.getElementById("act4").className="";
					document.getElementById("act5").className="";
					document.getElementById("act6").className="";
					document.getElementById("act7").className="";
					document.getElementById("act8").className="";
					document.getElementById("act9").className="";
					$("#topinfoCN").show();
				}
				if(flag==3){
					document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=planCN&type=show";
					document.getElementById("act1").className="";
					document.getElementById("act2").className="";
					document.getElementById("act3").className="active";
					document.getElementById("act4").className="";
					document.getElementById("act5").className="";
					document.getElementById("act6").className="";
					document.getElementById("act7").className="";
					document.getElementById("act8").className="";
					document.getElementById("act9").className="";
					$("#topinfoCN").hide();
				}
				if(flag==4){
					document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=planEN&type=show";
					document.getElementById("act1").className="";
					document.getElementById("act2").className="";
					document.getElementById("act3").className="";
					document.getElementById("act4").className="active";
					document.getElementById("act5").className="";
					document.getElementById("act6").className="";
					document.getElementById("act7").className="";
					document.getElementById("act8").className="";
					document.getElementById("act9").className="";
					$("#topinfoCN").hide();
				}
				if(flag==5){
					document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=opinionCN&type=show";
					document.getElementById("act1").className="";
					document.getElementById("act2").className="";
					document.getElementById("act3").className="";
					document.getElementById("act4").className="";
					document.getElementById("act5").className="active";
					document.getElementById("act6").className="";
					document.getElementById("act7").className="";
					document.getElementById("act8").className="";
					document.getElementById("act9").className="";
					$("#topinfoCN").hide();
				}
				if(flag==6){
					document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=opinionEN&type=show";
					document.getElementById("act1").className="";
					document.getElementById("act2").className="";
					document.getElementById("act3").className="";
					document.getElementById("act4").className="";
					document.getElementById("act5").className="";
					document.getElementById("act6").className="active";
					document.getElementById("act7").className="";
					document.getElementById("act8").className="";
					document.getElementById("act9").className="";
					$("#topinfoCN").hide();
				}
				if(flag==7){
					document.getElementById("iframe").src=path+"/sce/preapproveaudit/PreApproveSuppleRecordsList.action?RI_ID=<%=ri_id %>&type=SHB";
					document.getElementById("act1").className="";
					document.getElementById("act2").className="";
					document.getElementById("act3").className="";
					document.getElementById("act4").className="";
					document.getElementById("act5").className="";
					document.getElementById("act6").className="";
					document.getElementById("act7").className="active";
					document.getElementById("act8").className="";
					document.getElementById("act9").className="";
					$("#topinfoCN").hide();
				}
				if(flag==8){
					document.getElementById("iframe").src=path+"/sce/preapproveaudit/PreApproveAuditRecordsList.action?RI_ID=<%=ri_id %>&type=SHB";
					document.getElementById("act1").className="";
					document.getElementById("act2").className="";
					document.getElementById("act3").className="";
					document.getElementById("act4").className="";
					document.getElementById("act5").className="";
					document.getElementById("act6").className="";
					document.getElementById("act7").className="";
					document.getElementById("act8").className="active";
					document.getElementById("act9").className="";
					$("#topinfoCN").hide();
				}
				if(flag==9){
					document.getElementById("iframe").src=path+"/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=childEN&type=show";
					document.getElementById("act1").className="";
					document.getElementById("act2").className="";
					document.getElementById("act3").className="";
					document.getElementById("act4").className="";
					document.getElementById("act5").className="";
					document.getElementById("act6").className="";
					document.getElementById("act7").className="";
					document.getElementById("act8").className="";
					document.getElementById("act9").className="active";
					$("#topinfoCN").hide();
				}
			}
			
			function _setSuppleShow(obj){
				var val = obj.value;
				$("#R_AUDIT_OPTION").val(val);
				if(val == '4'){
					$("#R_OPERATION_STATE").val("1");	//����״̬��������(OPERATION_STATE:1)
					$(".SuppleInfo").show();
					$("#P_NOTICE_CONTENT").attr("notnull","����֪ͨ���ݲ���Ϊ�գ�");
					$(".SuppleTranslationInfo").hide();
					$("#T_AA_CONTENT").val("");
					$("#T_AA_CONTENT").removeAttr("notnull");
					$("#AuditOpinionInfo").hide();
					$("#R_AUDIT_CONTENT_CN").val("");
					$("#R_AUDIT_REMARKS").val("");
				}else{
					$("#R_OPERATION_STATE").val("2");	//����״̬���Ѵ���(OPERATION_STATE:2)
					$(".SuppleInfo").hide();
					$("#P_NOTICE_CONTENT").val("");
					$("#P_NOTICE_CONTENT").removeAttr("notnull");
					$(".SuppleTranslationInfo").hide();
					$("#T_AA_CONTENT").val("");
					$("#T_AA_CONTENT").removeAttr("notnull");
					$(".AuditOpinionInfo").show();
				}
				
				//������𡢹�Լ���͡���˼�����������̬���������ģ������
				var level = $("#R_AUDIT_LEVEL").val();
				var gy_type = $('#R_IS_CONVENTION_ADOPT').val();//�Ƿ�Լ����
				if(null!=val&&""!=val){
					$.ajax({
						url: path+'AjaxExecute?className=com.dcfs.ffs.audit.OpinionTemAjax&method=getAuditModelContent&TYPE=10&AUDIT_TYPE='+level+'&AUDIT_OPTION='+val+'&GY_TYPE='+gy_type,
						type: 'POST',
						timeout:1000,
						dataType: 'json',
						success: function(data){
							$("#R_AUDIT_CONTENT_CN").val(data.AUDIT_MODEL_CONTENT);//������
						}
				  	});
				}
			}
			
			//�����б�ҳ��
			function _goback(){
				var flag = "<%=flag %>";
				if(flag == "bc"){
					window.location.href=path+"sce/additional/findAddList.action?type=SHB";
				}else if(flag == "bf"){
					window.location.href=path+"sce/addTranslation/addTranslationList.action?type=SHB";
				}else{
					var level = $("#R_AUDIT_LEVEL").val();
					if(level == "0"){
						level = "one";
					}else if(level == "1"){
						level = "two";
					}else if(level == "2"){
						level = "three";
					}
					window.location.href=path+"sce/preapproveaudit/PreApproveAuditListSHB.action?Level=" + level;
				}
			}
			
			//�ύԤ���������
			function _submit(){
				//ҳ���У��
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else if(confirm("ȷ���ύ��")){
					var result = $("#R_AUDIT_OPTION").val();
					if(result == "4"){
						var last_state = $("#R_LAST_STATE").val();
						if(last_state == "" || last_state == "null" || last_state == "2"){
							//���ύ
							document.srcForm.action = path+"sce/preapproveaudit/PreApproveAuditSave.action?type=SHB&Flag=<%=flag %>";
							document.srcForm.submit();
						}else{
							alert("��Ԥ����¼���ڲ�������У����ܽ����ٴβ��䣡");
							return;
						}
					}else if(result == "6"){
						var atranslation_state = $("#R_ATRANSLATION_STATE").val();
						if(atranslation_state == "" || atranslation_state == "null" || atranslation_state == "2"){
							//���ύ
							document.srcForm.action = path+"sce/preapproveaudit/PreApproveAuditSave.action?type=SHB&Flag=<%=flag %>";
							document.srcForm.submit();
						}else{
							alert("��Ԥ����¼���ڲ��䷭���У����ܽ����ٴβ��䷭�룡");
							return;
						}
					}else{
						//���ύ
						document.srcForm.action = path+"sce/preapproveaudit/PreApproveAuditSave.action?type=SHB&Flag=<%=flag %>";
						document.srcForm.submit();
					}
				}
			}
			
			function _showPreFile(file_no){
				var url = path+"sce/preapproveaudit/PreFileShow.action?FILE_NO=" + file_no;
				_open(url,"�ļ�������Ϣ�鿴",900,600);
			}
			
			function _showPreApprove(req_no){
				url = path+"sce/preapproveaudit/PreApproveShow.action?REQ_NO=" + req_no;
				_open(url,"Ԥ����Ϣ�鿴",900,600);
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="SDFS;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="RAU_ID" id="R_RAU_ID" defaultValue="<%=rau_id %>"/>
		<BZ:input type="hidden" prefix="R_" field="RI_ID" id="R_RI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AUDIT_USERID" id="R_AUDIT_USERID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AUDIT_USERNAME" id="R_AUDIT_USERNAME" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AUDIT_DATE" id="R_AUDIT_DATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AUDIT_LEVEL" id="R_AUDIT_LEVEL" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="OPERATION_STATE" id="R_OPERATION_STATE" defaultValue="2"/>
		<BZ:input type="hidden" prefix="R_" field="AUDIT_OPTION" id="R_AUDIT_OPTION" defaultValue=""/>
		<BZ:input type="hidden" prefix="P_" field="ADD_TYPE" id="P_ADD_TYPE" defaultValue="1"/>
		<BZ:input type="hidden" prefix="R_" field="PUB_TYPE" id="R_PUB_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="PUB_MODE" id="R_PUB_MODE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="SPECIAL_FOCUS" id="R_SPECIAL_FOCUS" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="LAST_STATE" id="R_LAST_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ATRANSLATION_STATE" id="R_ATRANSLATION_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="IS_CONVENTION_ADOPT" id="R_IS_CONVENTION_ADOPT" defaultValue=""/>
		<!-- ��������end -->
		<!-- Tab��ǩҳbegin -->
		<div class="widget-header">
			<div class="widget-toolbar">
				<ul class="nav nav-tabs" id="recent-tab">
					<li id="act1" class="active"> 
						<a href="javascript:change(1);">������Ϣ���У�</a>
					</li>
					<li id="act2" class="">
						<a href="javascript:change(2);">������Ϣ���⣩</a>
					</li>
					<li id="act3" class="">
						<a href="javascript:change(3);">�����ƻ����У�</a>
					</li>
					<li id="act4" class=""> 
						<a href="javascript:change(4);">�����ƻ����⣩</a>
					</li>
					<li id="act5" class="">
						<a href="javascript:change(5);">��֯������У�</a>
					</li>
					<li id="act6" class="">
						<a href="javascript:change(6);">��֯������⣩</a>
					</li>
					<li id="act7" class=""> 
						<a href="javascript:change(7);">�����¼</a>
					</li>
					<li id="act8" class="">
						<a href="javascript:change(8);">��˼�¼</a>
					</li>
					<li id="act9" class="">
						<a href="javascript:change(9);">��ͯ������Ϣ</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- Tab��ǩҳend -->
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%" id="topinfoCN">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title">������֯(CN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������֯(EN)</td>
							<td class="bz-edit-data-value" colspan="3"> 
								<BZ:dataValue field="ADOPT_ORG_NAME_EN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������ʽ</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="LOCK_MODE" codeName="SDFS" defaultValue="" onlyValue="true" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">Ԥ�����</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="REQ_NO" defaultValue="" onlyValue="true"/>
							</td>
						
							<td class="bz-edit-data-title" width="20%">Ԥ��״̬</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="RI_STATE" defaultValue="" onlyValue="true" checkValue="1=�����;2=�����;3=��˲�ͨ��;4=���ͨ��;5=δ����;6=������;7=��ƥ��;9=��Ч;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ǰ���ı��<br></td>
							<td class="bz-edit-data-value">
								<a href="#" onclick="_showPreFile('<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue=""  onlyValue="true" />')" style="color: blue;">
									<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue=""  onlyValue="true" />
								</a>
							</td>
							
							<td class="bz-edit-data-title">��ǰԤ��������<br></td>
							<td class="bz-edit-data-value">
								<a href="#" onclick="_showPreApprove('<BZ:dataValue field="PRE_REQ_NO" defaultValue="" onlyValue="true"/>')" style="color: blue;">
									<BZ:dataValue field="PRE_REQ_NO" defaultValue="" onlyValue="true"/>
								</a>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">Ԥ������״̬<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REVOKE_STATE" checkValue="0=��ȷ��;1=��ȷ��;" defaultValue="" onlyValue="true"/>
							</td>
						
							<td class="bz-edit-data-title">����ԭ��<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REVOKE_REASON" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- iframe��ʾ����begin -->
		<div class="widget-box no-margin" style=" width:100%; margin: 0 auto">
			<iframe id="iframe" name="iframe" scrolling="no" src="<%=path %>/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=infoCN&type=show" style="border:none; width:100%; height:px; overflow:hidden;  frameborder="0"></iframe>
		</div>
		<!-- iframe��ʾ����end -->
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">�������</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="AUDIT_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">�����</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>��˽��</td>
							<td class="bz-edit-data-value" width="19%" id="OneLevel">
								<BZ:select prefix="R_" field="RESULT_ONE" id="R_RESULT_ONE" defaultValue="" formTitle="" notnull="��˽������Ϊ��" onchange="_setSuppleShow(this)">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="2">ͨ��</BZ:option>
									<BZ:option value="3">��ͨ��</BZ:option>
									<BZ:option value="4">������Ϣ</BZ:option>
									<BZ:option value="1">�ϱ�</BZ:option>	
									<%-- <BZ:option value="6">���䷭��</BZ:option> --%>
								</BZ:select>
							</td>
							<td class="bz-edit-data-value" width="19%" id="TwoLevel">
								<BZ:select prefix="R_" field="RESULT_TWO" id="R_RESULT_TWO" defaultValue="" formTitle="" notnull="��˽������Ϊ��" onchange="_setSuppleShow(this)">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="2">ͨ��</BZ:option>
									<BZ:option value="3">��ͨ��</BZ:option>
									<BZ:option value="8">�ϱ�����</BZ:option>
									<BZ:option value="7">�˻ؾ�����</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-value" width="19%" id="ThreeLevel">
								<BZ:select prefix="R_" field="RESULT_THREE" id="R_RESULT_THREE" defaultValue="" formTitle="" notnull="��˽������Ϊ��" onchange="_setSuppleShow(this)">
									<BZ:option value="">--��ѡ��--</BZ:option>
									<BZ:option value="2">ͨ��</BZ:option>
									<BZ:option value="3">��ͨ��</BZ:option>
									<BZ:option value="7">�˻ؾ�����</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr class="SuppleInfo" style="display: none">
							<td class="bz-edit-data-title">�����޸Ļ�����Ϣ</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:radio prefix="P_" field="IS_MODIFY" value="0" formTitle="" defaultChecked="true">��</BZ:radio>
								<BZ:radio prefix="P_" field="IS_MODIFY" value="1" formTitle="" >��</BZ:radio>
							</td>
						</tr>
						<tr class="SuppleInfo" style="display: none">
							<td class="bz-edit-data-title"><font color="red">*</font>����֪ͨ����</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="P_" field="NOTICE_CONTENT" id="P_NOTICE_CONTENT" type="textarea" defaultValue="" formTitle="" maxlength="1000" style="width:86%;height:50px;"/>
							</td>
						</tr>
						<tr class="SuppleTranslationInfo" style="display: none">
							<td class="bz-edit-data-title"><font color="red">*</font>���䷭������</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="T_" field="AA_CONTENT" id="T_AA_CONTENT" type="textarea" defaultValue="" formTitle="" maxlength="1000" style="width:86%;height:50px;"/>
							</td>
						</tr>
						<tr class="AuditOpinionInfo">
							<td class="bz-edit-data-title">������</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="AUDIT_CONTENT_CN" id="R_AUDIT_CONTENT_CN" type="textarea" defaultValue="" formTitle="" maxlength="500" style="width:86%;height:50px;"/>
							</td>
						</tr>
						<tr class="AuditOpinionInfo">
							<td class="bz-edit-data-title">��ע</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="AUDIT_REMARKS" id="R_AUDIT_REMARKS" type="textarea" defaultValue="" formTitle="" maxlength="1000" style="width:86%;height:50px;"/>
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