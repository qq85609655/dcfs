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
		<title>调账添加页面</title>
		<BZ:webScript edit="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			});
			
			//根据使用金额设置账户余额
			function _setAccountCurr(obj){
				var val = parseFloat(obj.value);	//本次使用金额
				if(!isNaN(val)){
					var curr = farseFloat($("#P_ACCOUNT_CURR").val());	//账户余额
					var bzVal = farseFloat($("#R_BALANCE_VALUE").val());	//差额
					if(val > bzVal){
						alert("本次使用" + bzVal + "金额就可以完费，本次使用金额不能超过" + bzVal + "！");
						$("#L_SUM").val("");
						return;
					}else{
						if(curr >= val){	//如果账户余额（curr）大于等于本次使用金额（val）
							//判断是否完费
							if(val == bzVal){
								$("#R_ARRIVE_STATE").val("2");
							}else{
								$("#R_ARRIVE_STATE").val("1");
							}
						}else{	//如果余额账户不足，则透支余额账户金额
							var limt = $("#R_ACCOUNT_LMT").val();
							if(val - curr <= limt){
								$("#R_ARRIVE_STATE").val("2");
							}else{
								alert("本次使用金额已超出该账户的限额！");
								$("#L_SUM").val("");
								return;
							}
						}
					}
				}
			}
			
			//提交预批申请审核
			function _submit(){
				//页面表单校验
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else if(confirm("确定提交吗？")){
					//表单提交
					var yjsyVal = parseFloat($("#R_ARRIVE_ACCOUNT_VALUE").val());
					var cesyVal = parseFloat($("#L_SUM").val());
					var currVal = parseFloat($("#P_ACCOUNT_CURR").val());
					$("#R_ARRIVE_ACCOUNT_VALUE").val(yjsyVal + cesyVal);
					$("#P_ACCOUNT_CURR").val(currVal - cesyVal);	//设置余额账户金额
					document.srcForm.action = path+"fam/receiveconfirm/ReviseAccountSave.action";
					document.srcForm.submit();
				}
			}
			
			//返回列表页面
			function _goback(){
				window.location.href=path+"fam/receiveconfirm/ReceiveConfirmList.action";
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="JFFS;FYLB;WJLX;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<!-- 票据信息 -->
		<BZ:input type="hidden" prefix="R_" field="CHEQUE_ID" id="R_CHEQUE_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPT_ORG_ID" id="R_ADOPT_ORG_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ARRIVE_STATE" id="R_ARRIVE_STATE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FILE_NO" id="R_FILE_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ARRIVE_ACCOUNT_VALUE" id="R_ARRIVE_ACCOUNT_VALUE" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ACCOUNT_LMT" id="R_ACCOUNT_LMT" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="BALANCE_VALUE" id="R_BALANCE_VALUE" defaultValue=""/>
		<!-- 余额账户使用记录 -->
		<BZ:input type="hidden" prefix="L_" field="COUNTRY_CODE" id="L_COUNTRY_CODE" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="PAID_NO" id="L_PAID_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="BILL_NO" id="L_BILL_NO" defaultValue=""/>
		<BZ:input type="hidden" prefix="L_" field="OPP_TYPE" id="L_OPP_TYPE" defaultValue="1"/>
		<!-- 收养组织余额账户 -->
		<BZ:input type="hidden" prefix="P_" field="ACCOUNT_CURR" id="P_ACCOUNT_CURR" defaultValue=""/>
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>到账信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">缴费编号</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">缴费方式</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">费用类型</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="COST_TYPE" codeName="FYLB" defaultValue="" onlyValue="true" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">应缴金额</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">到账金额</td>
							<td class="bz-edit-data-value"> 
								<BZ:dataValue field="ARRIVE_VALUE" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">到账日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ARRIVE_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">已使用账户金额</td>
							<td class="bz-edit-data-value"> 
								<BZ:dataValue field="ARRIVE_ACCOUNT_VALUE" defaultValue="0" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">差额</td>
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
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>调账信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">当前账户余额</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="ACCOUNT_CURR" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">结余账户使用上限</td>
							<td class="bz-edit-data-value" width="18%"> 
								<BZ:dataValue field="ACCOUNT_LMT" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>本次使用金额</td>
							<td class="bz-edit-data-value" width="19%"> 
								<BZ:input prefix="L_" field="SUM" id="L_SUM" defaultValue="" restriction="number" maxlength="22" notnull="本次使用金额不能为空！" onblur="_setAccountCurr(this)"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">结余账户使用备注</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="L_" field="REMARKS" id="L_REMARKS" type="textarea" defaultValue="" maxlength="1000" style="height:50px;width:96%;"/>
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