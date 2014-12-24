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
		<title>预批申请修改页面</title>
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
				dyniframesize(['mainFrame']);//公共功能，框架元素自适应
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
			
			//Tab页js
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
					$("#R_OPERATION_STATE").val("1");	//操作状态：处理中(OPERATION_STATE:1)
					$(".SuppleInfo").show();
					$("#P_NOTICE_CONTENT").attr("notnull","补充通知内容不能为空！");
					$(".SuppleTranslationInfo").hide();
					$("#T_AA_CONTENT").val("");
					$("#T_AA_CONTENT").removeAttr("notnull");
					$("#AuditOpinionInfo").hide();
					$("#R_AUDIT_CONTENT_CN").val("");
					$("#R_AUDIT_REMARKS").val("");
				}else{
					$("#R_OPERATION_STATE").val("2");	//操作状态：已处理(OPERATION_STATE:2)
					$(".SuppleInfo").hide();
					$("#P_NOTICE_CONTENT").val("");
					$("#P_NOTICE_CONTENT").removeAttr("notnull");
					$(".SuppleTranslationInfo").hide();
					$("#T_AA_CONTENT").val("");
					$("#T_AA_CONTENT").removeAttr("notnull");
					$(".AuditOpinionInfo").show();
				}
				
				//根据类别、公约类型、审核级别、审核意见动态获得审核意见模板内容
				var level = $("#R_AUDIT_LEVEL").val();
				var gy_type = $('#R_IS_CONVENTION_ADOPT').val();//是否公约收养
				if(null!=val&&""!=val){
					$.ajax({
						url: path+'AjaxExecute?className=com.dcfs.ffs.audit.OpinionTemAjax&method=getAuditModelContent&TYPE=10&AUDIT_TYPE='+level+'&AUDIT_OPTION='+val+'&GY_TYPE='+gy_type,
						type: 'POST',
						timeout:1000,
						dataType: 'json',
						success: function(data){
							$("#R_AUDIT_CONTENT_CN").val(data.AUDIT_MODEL_CONTENT);//审核意见
						}
				  	});
				}
			}
			
			//返回列表页面
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
			
			//提交预批申请审核
			function _submit(){
				//页面表单校验
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else if(confirm("确定提交吗？")){
					var result = $("#R_AUDIT_OPTION").val();
					if(result == "4"){
						var last_state = $("#R_LAST_STATE").val();
						if(last_state == "" || last_state == "null" || last_state == "2"){
							//表单提交
							document.srcForm.action = path+"sce/preapproveaudit/PreApproveAuditSave.action?type=SHB&Flag=<%=flag %>";
							document.srcForm.submit();
						}else{
							alert("该预批记录正在补充材料中，不能进行再次补充！");
							return;
						}
					}else if(result == "6"){
						var atranslation_state = $("#R_ATRANSLATION_STATE").val();
						if(atranslation_state == "" || atranslation_state == "null" || atranslation_state == "2"){
							//表单提交
							document.srcForm.action = path+"sce/preapproveaudit/PreApproveAuditSave.action?type=SHB&Flag=<%=flag %>";
							document.srcForm.submit();
						}else{
							alert("该预批记录正在补充翻译中，不能进行再次补充翻译！");
							return;
						}
					}else{
						//表单提交
						document.srcForm.action = path+"sce/preapproveaudit/PreApproveAuditSave.action?type=SHB&Flag=<%=flag %>";
						document.srcForm.submit();
					}
				}
			}
			
			function _showPreFile(file_no){
				var url = path+"sce/preapproveaudit/PreFileShow.action?FILE_NO=" + file_no;
				_open(url,"文件基本信息查看",900,600);
			}
			
			function _showPreApprove(req_no){
				url = path+"sce/preapproveaudit/PreApproveShow.action?REQ_NO=" + req_no;
				_open(url,"预批信息查看",900,600);
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="SDFS;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
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
		<!-- 隐藏区域end -->
		<!-- Tab标签页begin -->
		<div class="widget-header">
			<div class="widget-toolbar">
				<ul class="nav nav-tabs" id="recent-tab">
					<li id="act1" class="active"> 
						<a href="javascript:change(1);">基本信息（中）</a>
					</li>
					<li id="act2" class="">
						<a href="javascript:change(2);">基本信息（外）</a>
					</li>
					<li id="act3" class="">
						<a href="javascript:change(3);">抚育计划（中）</a>
					</li>
					<li id="act4" class=""> 
						<a href="javascript:change(4);">抚育计划（外）</a>
					</li>
					<li id="act5" class="">
						<a href="javascript:change(5);">组织意见（中）</a>
					</li>
					<li id="act6" class="">
						<a href="javascript:change(6);">组织意见（外）</a>
					</li>
					<li id="act7" class=""> 
						<a href="javascript:change(7);">补充记录</a>
					</li>
					<li id="act8" class="">
						<a href="javascript:change(8);">审核记录</a>
					</li>
					<li id="act9" class="">
						<a href="javascript:change(9);">儿童基本信息</a>
					</li>
				</ul>
			</div>
		</div>
		<!-- Tab标签页end -->
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%" id="topinfoCN">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title">收养组织(CN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">收养组织(EN)</td>
							<td class="bz-edit-data-value" colspan="3"> 
								<BZ:dataValue field="ADOPT_ORG_NAME_EN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">锁定方式</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="LOCK_MODE" codeName="SDFS" defaultValue="" onlyValue="true" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">预批编号</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="REQ_NO" defaultValue="" onlyValue="true"/>
							</td>
						
							<td class="bz-edit-data-title" width="20%">预批状态</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="RI_STATE" defaultValue="" onlyValue="true" checkValue="1=待审核;2=审核中;3=审核不通过;4=审核通过;5=未启动;6=已启动;7=已匹配;9=无效;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">先前收文编号<br></td>
							<td class="bz-edit-data-value">
								<a href="#" onclick="_showPreFile('<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue=""  onlyValue="true" />')" style="color: blue;">
									<BZ:dataValue field="ORIGINAL_FILE_NO" defaultValue=""  onlyValue="true" />
								</a>
							</td>
							
							<td class="bz-edit-data-title">先前预批申请编号<br></td>
							<td class="bz-edit-data-value">
								<a href="#" onclick="_showPreApprove('<BZ:dataValue field="PRE_REQ_NO" defaultValue="" onlyValue="true"/>')" style="color: blue;">
									<BZ:dataValue field="PRE_REQ_NO" defaultValue="" onlyValue="true"/>
								</a>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">预批撤消状态<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REVOKE_STATE" checkValue="0=待确认;1=已确认;" defaultValue="" onlyValue="true"/>
							</td>
						
							<td class="bz-edit-data-title">撤销原因<br></td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REVOKE_REASON" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- iframe显示区域begin -->
		<div class="widget-box no-margin" style=" width:100%; margin: 0 auto">
			<iframe id="iframe" name="iframe" scrolling="no" src="<%=path %>/sce/preapproveapply/PlanOpinionShow.action?RI_ID=<%=ri_id %>&Flag=infoCN&type=show" style="border:none; width:100%; height:px; overflow:hidden;  frameborder="0"></iframe>
		</div>
		<!-- iframe显示区域end -->
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">审核日期</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="AUDIT_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">审核人</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>审核结果</td>
							<td class="bz-edit-data-value" width="19%" id="OneLevel">
								<BZ:select prefix="R_" field="RESULT_ONE" id="R_RESULT_ONE" defaultValue="" formTitle="" notnull="审核结果不能为空" onchange="_setSuppleShow(this)">
									<BZ:option value="">--请选择--</BZ:option>
									<BZ:option value="2">通过</BZ:option>
									<BZ:option value="3">不通过</BZ:option>
									<BZ:option value="4">补充信息</BZ:option>
									<BZ:option value="1">上报</BZ:option>	
									<%-- <BZ:option value="6">补充翻译</BZ:option> --%>
								</BZ:select>
							</td>
							<td class="bz-edit-data-value" width="19%" id="TwoLevel">
								<BZ:select prefix="R_" field="RESULT_TWO" id="R_RESULT_TWO" defaultValue="" formTitle="" notnull="审核结果不能为空" onchange="_setSuppleShow(this)">
									<BZ:option value="">--请选择--</BZ:option>
									<BZ:option value="2">通过</BZ:option>
									<BZ:option value="3">不通过</BZ:option>
									<BZ:option value="8">上报审批</BZ:option>
									<BZ:option value="7">退回经办人</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-value" width="19%" id="ThreeLevel">
								<BZ:select prefix="R_" field="RESULT_THREE" id="R_RESULT_THREE" defaultValue="" formTitle="" notnull="审核结果不能为空" onchange="_setSuppleShow(this)">
									<BZ:option value="">--请选择--</BZ:option>
									<BZ:option value="2">通过</BZ:option>
									<BZ:option value="3">不通过</BZ:option>
									<BZ:option value="7">退回经办人</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr class="SuppleInfo" style="display: none">
							<td class="bz-edit-data-title">允许修改基本信息</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:radio prefix="P_" field="IS_MODIFY" value="0" formTitle="" defaultChecked="true">否</BZ:radio>
								<BZ:radio prefix="P_" field="IS_MODIFY" value="1" formTitle="" >是</BZ:radio>
							</td>
						</tr>
						<tr class="SuppleInfo" style="display: none">
							<td class="bz-edit-data-title"><font color="red">*</font>补充通知内容</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="P_" field="NOTICE_CONTENT" id="P_NOTICE_CONTENT" type="textarea" defaultValue="" formTitle="" maxlength="1000" style="width:86%;height:50px;"/>
							</td>
						</tr>
						<tr class="SuppleTranslationInfo" style="display: none">
							<td class="bz-edit-data-title"><font color="red">*</font>补充翻译内容</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="T_" field="AA_CONTENT" id="T_AA_CONTENT" type="textarea" defaultValue="" formTitle="" maxlength="1000" style="width:86%;height:50px;"/>
							</td>
						</tr>
						<tr class="AuditOpinionInfo">
							<td class="bz-edit-data-title">审核意见</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="AUDIT_CONTENT_CN" id="R_AUDIT_CONTENT_CN" type="textarea" defaultValue="" formTitle="" maxlength="500" style="width:86%;height:50px;"/>
							</td>
						</tr>
						<tr class="AuditOpinionInfo">
							<td class="bz-edit-data-title">备注</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="AUDIT_REMARKS" id="R_AUDIT_REMARKS" type="textarea" defaultValue="" formTitle="" maxlength="1000" style="width:86%;height:50px;"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="提 交" class="btn btn-sm btn-primary" onclick="_submit();"/>
				<input type="button" value="返 回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		</BZ:form>
	</BZ:body>
</BZ:html>