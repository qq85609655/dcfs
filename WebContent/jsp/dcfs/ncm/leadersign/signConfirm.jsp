<%
/**   
 * @Title: advice_feedback_confirm.jsp
 * @Description: �����쵼ǩ��ȷ��
 * @author xugy
 * @date 2014-9-12����10:15:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("LeaderSign_form_data");

String AF_ID = data.getString("AF_ID");//�������ļ�ID
String CI_ID = data.getString("CI_ID");//��ͯ����ID

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>�����쵼ǩ��ȷ��</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//
//����
function _save(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"leaderSing/signConfirm.action";
	document.srcForm.submit();
}
//����
function _goback(){
	document.srcForm.action=path+"leaderSing/findSignlist.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="LeaderSign_form_data" codeNames="WJLX;SYLX;SDFS;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<input type="hidden"  name="MI_ID" id="MI_ID" value="<BZ:dataValue field="MI_ID" defaultValue="" onlyValue="true"/>"/>
<input type="hidden"  name="AF_ID" id="AF_ID" value="<BZ:dataValue field="AF_ID" defaultValue="" onlyValue="true"/>"/>
<input type="hidden"  name="CI_ID" id="CI_ID" value="<BZ:dataValue field="CI_ID" defaultValue="" onlyValue="true"/>"/>
<input type="hidden"  name="PROVINCE_ID" id="PROVINCE_ID" value="<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true"/>"/>
<input type="hidden"  name="COUNTRY_CODE" id="COUNTRY_CODE" value="<BZ:dataValue field="COUNTRY_CODE" defaultValue="" onlyValue="true"/>"/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<tr>
						<td class="bz-edit-data-title">������֯��CN��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<tr>
						<td class="bz-edit-data-title">������֯��EN��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_EN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">���ı��</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FILE_NO" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<tr>
						<td class="bz-edit-data-title">�ļ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" codeName="SYLX"/>
						</td>
					</tr>
					<tr>
						<tr>
						<td class="bz-edit-data-title">����������ʽ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="LOCK_MODE" defaultValue="" codeName="SDFS"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����˻�����Ϣ</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showAFInfoSign.action?AF_ID=<%=AF_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�������˻�����Ϣ</div>
			</div>
			<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showCIInfoSign.action?CI_ID=<%=CI_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>ǩ��ȷ��</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%"><font color="red">*</font>ǩ������</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:input prefix="F_" field="SIGN_DATE" defaultValue="" type="date" formTitle="ǩ������" notnull="ǩ�����ڲ���Ϊ��"/>
						</td>
						<td class="bz-edit-data-title" width="15%">ǩ�����</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:select prefix="F_" field="SIGN_STATE" formTitle="ǩ�����">
								<BZ:option value="1" selected="true">ͬ��</BZ:option>
								<BZ:option value="2">��ͬ��</BZ:option>
							</BZ:select>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="ȷ&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
