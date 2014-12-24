<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>


<BZ:html>
<BZ:head>
	<title>安置、交文期限参数设置</title>
	<BZ:webScript edit="true" tree="false"/>
	<script>
	function _submit() {
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			document.srcForm.action = path + "sce/setSettle/saveSettleMonth.action";
			document.srcForm.submit();
			window.opener.open_tijiao();
		    window.close();
		}
	}
	
	</script>
</BZ:head>
<BZ:body property="modData">
	<BZ:form name="srcForm" method="post">
	<BZ:input prefix="R_" field="SETTLE_ID" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="编辑区域">
			<table class="bz-edit-data-table" border="0" style="height:80px;">
				<tr><td style="text-align: center;">
				<font color="red">*</font>安置期限：&nbsp;<BZ:input field="SETTLE_MONTHS" id="R_SETTLE_MONTHS" prefix="R_" restriction="number" defaultValue="" notnull="请输入安置期限" /> 日
				</td></tr>
				<tr><td style="text-align: center;">
				<font color="red">*</font>交文期限：&nbsp;<BZ:input field="DEADLINE" id="R_DEADLINE" prefix="R_" restriction="number" defaultValue="" notnull="请输入交文期限" /> 日
				</td></tr>
			</table>
			<br/>
			<br/>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="关闭" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
