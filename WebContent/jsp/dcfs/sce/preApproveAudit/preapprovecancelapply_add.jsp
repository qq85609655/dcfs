<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
%>
<BZ:html>
	<BZ:head>
		<title>预批申请修改页面</title>
		<BZ:webScript edit="true" tree="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//公共功能，框架元素自适应
				_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_PUB_ORGID');
			});
			
			function _setShowPublishInfo(obj){
				var val = obj.value;
				if(val == "1"){
					var pub_type=$("#P_PUB_TYPE").find("option:selected").val();
					if(pub_type=="1"){
						$("#P_COUNTRY_CODE").attr("notnull","请输入国家");
						$("#P_ADOPT_ORG_ID").attr("notnull","请输入发布组织");
						$("#P_PUB_MODE").attr("notnull","请输入点发类型");
					}else{
						$("#M_PUB_ORGID").attr("notnull","请选择发布组织");
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
			
			//根据点发、群发动态展现相关区域
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
				if(optionValue=="1"){//点发
					$("#P_COUNTRY_CODE").attr("notnull","请输入国家");
					$("#P_ADOPT_ORG_NAME").attr("notnull","请输入发布组织");
					$("#P_PUB_MODE").attr("notnull","请输入点发类型");
					$("#PUB_ORGID").removeAttr("notnull");
					
					$("#dfzz").show();
					$("#dflx").show();
					$("#dfbz").show();
					$("#qfzz").hide();
					$("#qflx").hide();
				}else{//群发
					$("#PUB_ORGID").attr("notnull","请选择发布组织");
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
			
			//获得安置期限
			function _getAzqxForFb(){
				var is_df = $("#P_PUB_TYPE").find("option:selected").val();//发布类型  1：点发  2：群发
				var pub_mode = $("#P_PUB_MODE").find("option:selected").val();//点发类型  
				
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
							var two_type1 = data[0].TWO_TYPE;//是否特别关注  0:否  1：是
							var settle_months1 = data[0].SETTLE_MONTHS;
							//var two_type2 = data[1].TWO_TYPE;//是否特别关注  0:否  1：是
							var settle_months2 = data[1].SETTLE_MONTHS;
							if("1"==is_df){//点发类型
								if("0"==two_type1){//非特别关注
									$("#P_SETTLE_DATE_NORMAL").val(settle_months1);
									$("#P_SETTLE_DATE_SPECIAL").val(settle_months2);
								}else {//特别关注
									$("#P_SETTLE_DATE_NORMAL").val(settle_months2);
									$("#P_SETTLE_DATE_SPECIAL").val(settle_months1);
								}
							}else {//群发类型
								if("0"==two_type1){//非特别关注
									$("#M_SETTLE_DATE_NORMAL").val(settle_months1);
									$("#M_SETTLE_DATE_SPECIAL").val(settle_months2);
								}else {//特别关注
									$("#M_SETTLE_DATE_NORMAL").val(settle_months2);
									$("#M_SETTLE_DATE_SPECIAL").val(settle_months1);
								}
							}
						}
					});
				}
			}
			
			//返回列表页面
			function _goback(){
				window.location.href=path+"sce/preapproveaudit/PreApproveAuditListAZB.action";
			}
			
			//提交预批申请审核
			function _submit(){
				//页面表单校验
				if (!runFormVerify(document.srcForm, false)) {
					alert();
					return;
				}else if(confirm("确定提交吗？")){
					//表单提交
					document.srcForm.action = path+"sce/preapproveaudit/PreApproveCancelApplySave.action";
					document.srcForm.submit();
				}
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="GJSY;PROVINCE;ADOPTER_CHILDREN_SEX;DFLX;SYS_ADOPT_ORG;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="RI_ID" id="R_RI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="PUB_ID" id="R_PUB_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AF_ID" id="R_AF_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_TYPE" id="R_FILE_TYPE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="REVOKE_STATE" id="R_REVOKE_STATE" defaultValue="1"/>
		<BZ:input type="hidden" prefix="R_" field="REVOKE_TYPE" id="R_REVOKE_TYPE" defaultValue="1"/>
		<BZ:input type="hidden" prefix="C_" field="CI_ID" id="C_CI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="C_" field="SPECIAL_FOCUS" id="C_SPECIAL_FOCUS" defaultValue=""/>
		<!-- 隐藏区域end -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>预批信息</div>
				</div>
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title">国家</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">收养组织</td>
							<td class="bz-edit-data-value" colspan="3"> 
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">男收养人</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true" />
							</td>
							<td class="bz-edit-data-title">女收养人</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">省份</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">福利院</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="10%">儿童姓名</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME" defaultValue=""  onlyValue="true" />
							</td>
							<td class="bz-edit-data-title" width="10%">性别</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">出生日期</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">特别关注</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SPECIAL_FOCUS" checkValue="0=否;1=是;" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<BZ:for property="ChildList" fordata="childdata">
						<tr>
							<td class="bz-edit-data-title" width="10%">儿童姓名</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME" property="childdata" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">性别</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SEX" property="childdata" codeName="ADOPTER_CHILDREN_SEX" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">出生日期</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="BIRTHDAY" property="childdata" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="10%">特别关注</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="SPECIAL_FOCUS" property="childdata" checkValue="0=否;1=是;" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						</BZ:for>
						<tr>
							<td class="bz-edit-data-title">申请日期</td>
							<td class="bz-edit-data-value" colspan="7">
								<BZ:dataValue field="REQ_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>撤销申请信息</div>
				</div>
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>撤销原因</td>
							<td class="bz-edit-data-value" width="90%">
								<BZ:input prefix="R_" field="REVOKE_REASON" id="R_REVOKE_REASON" type="textarea" defaultValue="" maxlength="1000" notnull="撤销原因不能为空！" style="width:96%;height:50px;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">是否继续发布</td>
							<td class="bz-edit-data-value"> 
								<BZ:select prefix="C_" field="IS_PUBLISH" formTitle="C_IS_PUBLISH" defaultValue="true" onchange="_setShowPublishInfo(this)" width="80px;">
									<BZ:option value="1" selected="true">是</BZ:option>
									<BZ:option value="0">否</BZ:option>
								</BZ:select>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域" id="publishinfo">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>发布信息</div>
				</div>
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 100%;">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>发布类型</td>
							<td class="bz-edit-data-value">
								<BZ:select field="PUB_TYPE" id="P_PUB_TYPE" notnull="请输入发布类型" formTitle="" prefix="P_" onchange="_dynamicFblx();_getAzqxForFb()" width="50%">
									<option value="1">点发</option>
									<option value="2">群发</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>发布组织</td>
							<td class="bz-edit-data-value" id="dfzz">
								<BZ:select field="COUNTRY_CODE" formTitle="" prefix="P_" id="P_COUNTRY_CODE" isCode="true" codeName="GJSY" onchange="_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_PUB_ORGID')">
									<option value="">--请选择国家--</option>
								</BZ:select>
								<BZ:select prefix="P_" field="ADOPT_ORG_ID" id="P_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="70%" onchange="_setOrgID('P_PUB_ORGID',this.value)">
									<option value="">--请选择发布组织--</option>
								</BZ:select>
								<BZ:input type="hidden" field="PUB_ORGID"  prefix="P_" id="P_PUB_ORGID"/>
							</td>
							<td class="bz-edit-data-value" id="qfzz" style="display:none">
								<BZ:input prefix="M_" field="PUB_ORGID" id="M_PUB_ORGID" type="helper" helperCode="SYS_ADOPT_ORG" helperTitle="选择发布组织" treeType="1" helperSync="true" showParent="false" defaultShowValue="" showFieldId="M_PUB_ORGID" notnull="请选择发布组织" style="height:13px;width:80%"  />
							</td>
						</tr>
						<tr id="dflx">
							<td class="bz-edit-data-title" width="10%"><font color="red">*</font>点发类型</td>
							<td class="bz-edit-data-value"  >
								<BZ:select field="PUB_MODE" id="P_PUB_MODE" notnull="请输入点发类型" formTitle="" prefix="P_" isCode="true" codeName="DFLX" onchange="_getAzqxForFb()" width="50%">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="10%">安置期限</td>
							<td class="bz-edit-data-value" >
								<BZ:input field="SETTLE_DATE_SPECIAL" id="P_SETTLE_DATE_SPECIAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>个月（特别关注）
								<BZ:input field="SETTLE_DATE_NORMAL" id="P_SETTLE_DATE_NORMAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>个月（非特别关注）
							</td>
						</tr>
						<tr id="qflx" style="display:none">
							<td class="bz-edit-data-title" width="10%">安置期限</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="SETTLE_DATE_SPECIAL" id="M_SETTLE_DATE_SPECIAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>个月（特别关注）
								<BZ:input field="SETTLE_DATE_NORMAL" id="M_SETTLE_DATE_NORMAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>个月（非特别关注）
							</td>
							
						</tr>
						<tr id="dfbz">
							<td class="bz-edit-data-title poptitle">点发备注</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="PUB_REMARKS" id="P_PUB_REMARKS" type="textarea" prefix="P_" formTitle="点发备注" defaultValue="" style="width:80%"  maxlength="900"/>
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