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
		<title>收养组织结余账户添加页面</title>
		<BZ:webScript edit="true"/>
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
					document.srcForm.action = path+"fam/balanceaccount/BalanceAccountSave.action";
					document.srcForm.submit();
				}
			}
			
			//返回列表页面
			function _goback(){
				window.location.href=path+"fam/balanceaccount/BalanceAccountList.action";
			}
		</script>
	</BZ:head>
	<BZ:body property="data">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<!-- 票据信息 -->
		<BZ:input type="hidden" prefix="R_" field="ADOPT_ORG_ID" id="R_ADOPT_ORG_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ACCOUNT_MODIFYUSER" id="R_OPP_USERID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ACCOUNT_MODIFYDATE" id="R_OPP_USERNAME" defaultValue=""/>
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>结余账户信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">国家</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="COUNTRY_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="20%">收养组织</td>
							<td class="bz-edit-data-value" width="30%"> 
								<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">当前金额</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ACCOUNT_CURR" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>透支额度</td>
							<td class="bz-edit-data-value"> 
								<BZ:input prefix="R_" field="ACCOUNT_LMT" id="R_ACCOUNT_LMT" defaultValue="" restriction="int" maxlength="22" notnull="透支额度不能为空！"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">维护人</td>
							<td class="bz-edit-data-value"> 
								<BZ:dataValue field="MODIFYUSER_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">维护日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="ACCOUNT_MODIFYDATE" type="Date" defaultValue="" onlyValue="true"/>
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