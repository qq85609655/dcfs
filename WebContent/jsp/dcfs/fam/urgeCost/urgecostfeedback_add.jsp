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
		<title>催缴通知反馈添加页面</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			});
			
			//提交预批申请审核
			function _submit(){
				//页面表单校验
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else if(confirm("确定提交吗？")){
					//表单提交
					document.srcForm.action = path+"fam/urgecost/UrgeCostFeedBackSave.action";
					document.srcForm.submit();
				}
			}
			
			//返回列表页面
			function _goback(){
				window.location.href=path+"fam/urgecost/UrgeCostList.action";
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="GJSY;JFFS;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
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
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>催缴通知信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">正常儿童数量</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="CHILD_NUM" defaultValue="0" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">特需儿童数量</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="S_CHILD_NUM" defaultValue="0" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">应缴金额</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">通知人</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NOTICE_USERNAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">通知日期</td>
							<td class="bz-edit-data-value"> 
								<BZ:dataValue field="NOTICE_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">缴费内容</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="PAID_CONTENT" defaultValue="" onlyValue="true" style="height:50px;width:96%;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">备注</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true" style="height:50px;width:96%;"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>催缴通知反馈信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">国家</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">收养组织</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>缴费方式</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:select prefix="R_" field="PAID_WAY" id="R_COST_TYPE" isCode="true" codeName="JFFS" notnull="缴费方式不能为空！" formTitle="" defaultValue="" width="65%">
									<BZ:option value="">--请选择--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>缴费票号</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="BILL_NO" id="R_BILL_NO" maxlength="22" notnull="缴费票号不能为空！" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>缴费票面金额</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="PAR_VALUE" id="R_PAR_VALUE" restriction="number" maxlength="22" notnull="缴费票面金额不能为空！" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>缴费人</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="PAY_USERNAME" id="R_PAY_USERNAME" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>缴费日期</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="PAY_DATE" id="R_PAY_DATE" type="Date" dateExtend="maxDate:'%y-%M-%d'" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">附件</td>
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