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
		<title>催缴通知添加页面</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource cancelJquerySupport="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//公共功能，框架元素自适应
				_findSyzzNameListForNew('R_COUNTRY_CODE','R_ADOPT_ORG_ID','R_HIDDEN_ADOPT_ORG_ID');
			});
			
			//这是应缴金额项是否可以输入
			function _setIsInput(){
				var val = $("#R_COST_TYPE").find("option:selected").text();
				if(val == "服务费"){
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
			
			//计算应缴金额
			function _setShouldValue(type){
				var val = $("#R_COST_TYPE").find("option:selected").text();
				if(val == "服务费"){
					var childnum = $("#R_CHILD_NUM").val();
					var schildnum = $("#R_S_CHILD_NUM").val();
					if(type == "normal"){
						if(childnum == ""){
							if(schildnum == ""){
								alert("正常和特需儿童数量不能全为空！");
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
								alert("正常和特需儿童数量不能全为空！");
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
			
			//提交预批申请审核
			function _submit(state){
				$("#R_NOTICE_STATE").val(state);	//通知状态
				//页面表单校验
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else if(confirm("确定提交吗？")){
					//表单提交
					document.srcForm.action = path+"fam/urgecost/UrgeCostNoticeSave.action";
					document.srcForm.submit();
				}
			}
			
			//返回列表页面
			function _goback(){
				window.location.href=path+"fam/urgecost/UrgeCostList.action";
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="GJSY;FYLB;SYS_GJSY_CN">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="RM_ID" id="R_RM_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="NOTICE_STATE" id="R_NOTICE_STATE" defaultValue=""/>
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
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>国家</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:select field="COUNTRY_CODE" formTitle="" prefix="R_" id="R_COUNTRY_CODE" isCode="true" codeName="SYS_GJSY_CN" width="77%" onchange="_findSyzzNameListForNew('R_COUNTRY_CODE','R_ADOPT_ORG_ID','R_HIDDEN_ADOPT_ORG_ID')">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>收养组织</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:select prefix="R_" field="ADOPT_ORG_ID" id="R_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" notnull="收养组织不能为空！" width="77%" onchange="_setOrgID('R_HIDDEN_ADOPT_ORG_ID',this.value)">
									<option value="">--请选择--</option>
								</BZ:select>
								<input type="hidden" id="R_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>费用类型</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:select prefix="R_" field="COST_TYPE" id="R_COST_TYPE" isCode="true" codeName="FYLB" formTitle="" defaultValue="" notnull="费用类型不能为空！" width="73%;" onchange="_setIsInput()">
									<BZ:option value="">--请选择--</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">正常儿童数量</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="CHILD_NUM" id="R_CHILD_NUM" defaultValue="" restriction="int" onblur="_setShouldValue('normal')"/>
							</td>
							<td class="bz-edit-data-title">特需儿童数量</td>
							<td class="bz-edit-data-value"> 
								<BZ:input prefix="R_" field="S_CHILD_NUM" id="R_S_CHILD_NUM" defaultValue="" restriction="int" onblur="_setShouldValue('special')"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>应缴金额</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="PAID_SHOULD_NUM" id="R_PAID_SHOULD_NUM" defaultValue="" restriction="number" maxlength="22" notnull="应缴金额不能为空！"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">附件</td>
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
							<td class="bz-edit-data-title">缴费内容</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="PAID_CONTENT" id="R_PAID_CONTENT" type="textarea" defaultValue="" maxlength="1000" style="height:50px;width:96%;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">备注</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="REMARKS" id="R_REMARKS" type="textarea" defaultValue="" maxlength="1000" style="height:50px;width:96%;"/>
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
				<input type="button" value="保 存" class="btn btn-sm btn-primary" onclick="_submit('0');"/>
				<input type="button" value="提 交" class="btn btn-sm btn-primary" onclick="_submit('1');"/>
				<input type="button" value="返 回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		
		</BZ:form>
	</BZ:body>
</BZ:html>