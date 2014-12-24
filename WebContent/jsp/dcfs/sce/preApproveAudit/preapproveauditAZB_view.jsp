<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	String af_id = (String)request.getAttribute("AF_ID");
	String ri_id = (String)request.getAttribute("RI_ID");
%>
<BZ:html>
	<BZ:head>
		<title>Ԥ������鿴ҳ��</title>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;  
				
			}
		</style>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
				$("#topinfoEN").hide();
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
					$("#topinfoEN").hide();
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
					$("#topinfoCN").hide();
					$("#topinfoEN").show();
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
					$("#topinfoEN").hide();
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
					$("#topinfoEN").hide();
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
					$("#topinfoEN").hide();
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
					$("#topinfoEN").hide();
				}
				if(flag==7){
					document.getElementById("iframe").src=path+"/sce/preapproveaudit/PreApproveSuppleRecordsList.action?RI_ID=<%=ri_id %>&type=AZB";
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
					$("#topinfoEN").hide();
				}
				if(flag==8){
					document.getElementById("iframe").src=path+"/sce/preapproveaudit/PreApproveAuditRecordsList.action?RI_ID=<%=ri_id %>&type=AZB";
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
					$("#topinfoEN").hide();
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
					$("#topinfoEN").hide();
				}
			}
			
			function _setSuppleShow(obj){
				var val = obj.value;
				if(val == '1'){
					$(".SuppleInfo").show();
					$("#P_NOTICE_CONTENT").attr("notnull","����֪ͨ���ݲ���Ϊ�գ�");
				}else{
					$(".SuppleInfo").hide();
					$("#P_NOTICE_CONTENT").val("");
					$("#P_NOTICE_CONTENT").removeAttr("notnull");
				}
			}
			
			//�����б�ҳ��
			function _goback(){
				var type = $("#R_FROM_TYPE").val();
				if(type == "AZBshow"){
					window.location.href=path+"sce/preapproveaudit/PreApproveAuditListAZB.action";
				}else if(type == "SHBshow"){
					var level = $("#R_AUDIT_LEVEL").val();
					window.location.href=path+"sce/preapproveaudit/PreApproveAuditListSHB.action?Level=" + level;
				}
				
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="SDFS;">
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="FROM_TYPE" id="R_FROM_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AUDIT_LEVEL" id="R_AUDIT_LEVEL" defaultValue=""/>
		<!-- ��������begin -->
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
								<BZ:dataValue field="RI_STATE" defaultValue="" onlyValue="true" checkValue="1=���ύ;2=�����;3=��˲�ͨ��;4=���ͨ��;5=δ����;6=������;7=��ƥ��;9=��Ч;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ǰ���ı��<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue=""  onlyValue="true" />
							</td>
							
							<td class="bz-edit-data-title">��ǰԤ��������<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PRE_REQ_NO" defaultValue="" onlyValue="true"/>
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
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%" id="topinfoEN">
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
								<BZ:dataValue field="RI_STATE" defaultValue="" onlyValue="true" checkValue="1=���ύ;2=�����;3=��˲�ͨ��;4=���ͨ��;5=δ����;6=������;7=��ƥ��;9=��Ч;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ǰ���ı��<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue=""  onlyValue="true" />
							</td>
							
							<td class="bz-edit-data-title">��ǰԤ��������<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PRE_REQ_NO" defaultValue="" onlyValue="true"/>
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
			<iframe id="iframe" scrolling="no" src="<%=path %>/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=infoCN&type=show" style="border:none; width:100%; height:px; overflow:hidden;  frameborder="0"></iframe>
		</div>
		<!-- iframe��ʾ����end -->
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="�� ��" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- ��ť����end -->
	</BZ:body>
</BZ:html>