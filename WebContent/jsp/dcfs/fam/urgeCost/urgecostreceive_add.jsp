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
		<title>预批申请修改页面</title>
		<BZ:webScript edit="true" list="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			});
			
			//提交
			function _submit(){
				//页面表单校验
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else if(confirm("确定提交吗？")){
					var yjVal = $("#R_PAID_SHOULD_NUM").val();	//应缴金额
					var dzVal = $("#R_ARRIVE_VALUE").val();	//到账金额
					if(dzVal >= yjVal){
						$("#R_ARRIVE_STATE").val("1");
					}else{
						$("#R_ARRIVE_STATE").val("2");
					}
					//表单提交
					document.srcForm.action = path+"fam/urgecost/UrgeCostReceiveSave.action";
					document.srcForm.submit();
				}
			}
			
			//返回列表页面
			function _goback(){
				window.location.href=path+"fam/urgecost/UrgeCostList.action";
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="GJSY;JFFS;FYLB;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="CHEQUE_ID" id="R_CHEQUE_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="PAID_SHOULD_NUM" id="R_PAID_SHOULD_NUM" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ARRIVE_STATE" id="R_ARRIVE_STATE" defaultValue=""/>
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>票据信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体" style="width: 100%;">
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
							<td class="bz-edit-data-title" width="15%">缴费编号</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">缴费方式</td>
							<td class="bz-edit-data-value"> 
								<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">费用类型</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="COST_TYPE" codeName="FYLB" defaultValue="" onlyValue="true" />
							</td>
							<td class="bz-edit-data-title">应缴金额</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">缴费票号</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BILL_NO" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">票面金额</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PAR_VALUE" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
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
					<div>到账确认信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%"><font color="red">*</font>到账金额</td>
							<td class="bz-edit-data-value" width="30%"> 
								<BZ:input prefix="R_" field="ARRIVE_VALUE" id="R_ARRIVE_VALUE" defaultValue="" restriction="number" maxlength="22" notnull="到账金额不能为空！"/>
							</td>
							<td class="bz-edit-data-title" width="20%"><font color="red">*</font>到账日期</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:input prefix="R_" field="ARRIVE_DATE" id="R_ARRIVE_DATE" type="Date" dateExtend="maxDate:'%y-%M-%d'" notnull="到账日期不能为空！" defaultValue=""/>
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