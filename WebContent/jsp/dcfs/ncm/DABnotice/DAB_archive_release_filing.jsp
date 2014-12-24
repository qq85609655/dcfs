<%
/**   
 * @Title: DAB_archive_release_filing.jsp
 * @Description: �������⵵
 * @author xugy
 * @date 2014-11-2����4:25:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>�������⵵</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//����
function _save(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	if (confirm('ȷ���⵵��')) {
		document.srcForm.action=path+"notice/saveDABReleaseFiling.action";
		document.srcForm.submit();
	}
}
//����
function _goback(){
	document.srcForm.action=path+"notice/DABArchiveFilingList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input prefix="AI_" field="ARCHIVE_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="AF_" field="AF_ID" defaultValue="" type="hidden"/>
<BZ:input prefix="CI_" field="CI_ID" defaultValue="" type="hidden"/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�⵵��Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<tr>
						<td class="bz-edit-data-title" width="20%">������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="ARCHIVE_NO" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">�鵵����</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="ARCHIVE_DATE" defaultValue="" type="date"/>
						</td>
					</tr>
					<tr>
						<tr>
						<td class="bz-edit-data-title">�⵵��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CANCLE_USERNAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�⵵����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CANCLE_DATE" defaultValue="" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>�⵵ԭ��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input type="textarea" prefix="AI_" field="CANCLE_REASON" defaultValue="" style="width:98%;height:60px;" notnull="�⵵ԭ����Ϊ��"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
