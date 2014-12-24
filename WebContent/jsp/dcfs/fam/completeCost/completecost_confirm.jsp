<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>完费维护页面</title>
	<BZ:webScript edit="true" tree="false"/>
	<style>
	</style>
	<script>
	
	//查看缴费单
	function _billShow(paid_no){
		window.open(path + "fam/completeCost/billShow.action?PAID_NO=" + paid_no,"window","width=950,height=300,top=160,left=200,scrollbars=yes");
	}
	
	//完费维护提交
	function _submit() {
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			if (confirm("确定提交该完费信息吗？")) {
				document.srcForm.action = path + "fam/completeCost/completeCostSave.action";
				document.srcForm.submit();
			}
		}
	}
	
	//返回
	function _goback(){
		window.location.href=path+'fam/completeCost/completeCostList.action';
	}
	
	
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;" property="data">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<BZ:input prefix="P_" field="AF_ID" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>文件和票据信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">收文编号</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">收文日期</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">文件类型</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">国家</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
						</td>
						<td class="bz-edit-data-title">收养组织</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">应缴金额</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AF_COST" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">男收养人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">女收养人</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">缴费编号</td>
						<td class="bz-edit-data-value">
							<a href="#" onclick="_billShow('<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>');return false;" title="点击查看该票据缴费信息"><BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<!-- 内容区域 end -->
		</div>
	</div>
	<br>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					完费维护信息
				</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title poptitle">完费原因</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="AF_COST_CLEAR_REASON" id="P_AF_COST_CLEAR_REASON" type="textarea" prefix="P_" formTitle="完费原因" maxlength="1000" style="width:80%" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">操作人</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="AF_COST_CLEAR_USERNAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="P_" field="AF_COST_CLEAR_USERNAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">操作日期</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="AF_COST_CLEAR_DATE" type="date" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="P_" field="AF_COST_CLEAR_DATE" type="hidden" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
			<!-- 内容区域 end -->
		</div>
	</div>
	<br/>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="提&nbsp;&nbsp;交" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
