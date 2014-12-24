<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	String audit_type = (String) request.getAttribute("audit_type");
%>
<BZ:html>
<BZ:head>
	<title>审核部预批审核意见模板修改</title>
	<BZ:webScript edit="true"/>
	<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	<script>
	
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	});
	
	function _save() {
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			document.srcForm.action = path + "sce/opinionTem/saveOpinionTem.action";
			document.srcForm.submit();
			window.opener.open_tijiao();
			window.close();
		}
	}
	
	</script>
</BZ:head>

<BZ:body codeNames="WJMBLX;WJSHYJ;WJSHJB;WJJBRSH;WJBMZRFH;WJFGZRSP" property="shmbData">
	<BZ:form name="srcForm" method="post">
	
	<BZ:input prefix="P_" field="AAM_ID" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
		<!-- 标题区域 begin -->
		<div class="ui-state-default bz-edit-title" desc="标题">
			<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
			<div>审核意见模板信息</div>
		</div>
		<!-- 标题区域 end -->
		<div class="bz-edit-data-content clearfix" desc="内容体">
			<table class="bz-edit-data-table" border="0">
				<tr>
					<td class="bz-edit-data-title" width="20%">模板名称</td>
					<td class="bz-edit-data-value" width="30%">
						<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title" width="20%">模板类型</td>
					<td class="bz-edit-data-value" width="30%">
						<BZ:dataValue field="IS_CONVENTION_ADOPT" defaultValue="" codeName="WJMBLX" onlyValue="true"/>
					</td>
				</tr>
				<tr>
					<td class="bz-edit-data-title">审核意见</td>
					<td class="bz-edit-data-value">
						<BZ:dataValue field="AUDIT_OPTION" defaultValue="" codeName="WJSHYJ" onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title">审核级别</td>
					<td class="bz-edit-data-value">
						<BZ:dataValue field="AUDIT_TYPE" defaultValue="" codeName="WJSHJB" onlyValue="true"/>
					</td>
				</tr>
				<tr>
					<td class="bz-edit-data-title poptitle"><font color="red">*</font>模板内容</td>
					<td class="bz-edit-data-value" colspan="3">
						<BZ:input field="AUDIT_MODEL_CONTENT" id="P_AUDIT_MODEL_CONTENT" type="textarea" prefix="P_" formTitle="模板内容" defaultValue="" notnull="请输入模板内容" style="width:88%" maxlength="2000"/>
					</td>
				</tr>
			</table>
		</div>
	</div>
	</div>
	<br/>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区" id="print1">
			<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="_save();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
