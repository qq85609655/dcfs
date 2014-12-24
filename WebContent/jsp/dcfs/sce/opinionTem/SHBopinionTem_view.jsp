<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<BZ:html>
<BZ:head>
	<title>��˲�Ԥ��������ģ��鿴</title>
	<BZ:webScript edit="true" tree="false"/>
	<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	<script>
	
	
	</script>
</BZ:head>

<BZ:body codeNames="WJMBLX;WJSHYJ;WJSHJB" property="shmbData">
	<BZ:form name="srcForm" method="post">
	
	<BZ:input field="AAM_ID" id="P_AAM_ID" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
		<!-- �������� begin -->
		<div class="ui-state-default bz-edit-title" desc="����">
			<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
			<div>������ģ����Ϣ</div>
		</div>
		<!-- �������� end -->
		<div class="bz-edit-data-content clearfix" desc="������">
			<table class="bz-edit-data-table" border="0" align="center">
				<tr>
					<td class="bz-edit-data-title" width="20%">ģ������</td>
					<td class="bz-edit-data-value" width="30%">
						<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title" width="20%">ģ������</td>
					<td class="bz-edit-data-value" width="30%">
						<BZ:dataValue field="IS_CONVENTION_ADOPT" defaultValue="" codeName="WJMBLX" onlyValue="true"/>
					</td>
				</tr>
				<tr>
					<td class="bz-edit-data-title">������</td>
					<td class="bz-edit-data-value">
						<BZ:dataValue field="AUDIT_OPTION" defaultValue="" codeName="WJSHYJ" onlyValue="true"/>
					</td>
					<td class="bz-edit-data-title">��˼���</td>
					<td class="bz-edit-data-value">
						<BZ:dataValue field="AUDIT_TYPE" defaultValue="" codeName="WJSHJB" onlyValue="true"/>
					</td>
				</tr>
				<tr>
					<td class="bz-edit-data-title poptitle">ģ������</td>
					<td class="bz-edit-data-value" colspan="3">
						<BZ:dataValue field="AUDIT_MODEL_CONTENT" defaultValue="" onlyValue="true"/>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<br/>
	<br/>
	</div>
	</BZ:form>
</BZ:body>
</BZ:html>
