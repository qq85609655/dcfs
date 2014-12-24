<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>


<BZ:html>
<BZ:head>
	<title>修改暂停期限</title>
	<BZ:webScript edit="true" tree="false"/>
	<script>
	function _submit() {
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			document.srcForm.action = path + "ffs/pause/reviseDeadline.action";
			document.srcForm.submit();
			window.opener.mod_tijiao();
		    window.close();
		}
	}
	
	</script>
</BZ:head>

<BZ:body property="modData">
	<BZ:form name="srcForm" method="post">
	<BZ:input prefix="R_" field="AP_ID" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="编辑区域">
			<table class="bz-edit-data-table" border="0" style="height:80px;">
				<tr><td style="text-align: center;">
				暂停期限：&nbsp;<BZ:input field="END_DATE" id="R_END_DATE" prefix="R_" type="date" dateExtend="maxDate:'%y-{%M+6}-%d'"/>
				</td></tr>
			</table>
			<br/>
			<br/>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="关闭" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
