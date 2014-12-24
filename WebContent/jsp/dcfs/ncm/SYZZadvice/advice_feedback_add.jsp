<%
/**   
 * @Title: advice_feedback_add.jsp
 * @Description: ������֯�����������
 * @author xugy
 * @date 2014-9-11����8:26:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data=(Data)request.getAttribute("data");
String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT");

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head language="EN">
	<title>������֯�����������</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//�ύ
function _submit(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"advice/adviceFeedbackSave.action";
	document.srcForm.submit();
}
//����
function _goback(){
	document.srcForm.action=path+"advice/SYZZAdviceList.action";
	document.srcForm.submit();
}
</script>
<BZ:body property="data" codeNames="ETXB;SYS_COUNTRY_GOVMENT;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input type="hidden" field="MI_ID" defaultValue=""/>
<BZ:input type="hidden" field="IS_CONVENTION_ADOPT" defaultValue=""/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>ƥ����Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">������������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">Ů����������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������ˣ��У�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">���������Ա��У�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������ˣ�Ӣ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">���������Ա�Ӣ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������˳�������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">֪ͨ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADVICE_NOTICE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<%
					if("1".equals(IS_CONVENTION_ADOPT)){
					%>
					<tr>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>�������������</td>
						<td class="bz-edit-data-value" width="80%">
							<BZ:select prefix="F_" field="ADVICE_GOV_ID" defaultValue="" isCode="true" codeName="SYS_COUNTRY_GOVMENT" width="90%;" formTitle="�������������" notnull="Please select the Central Authority of Recriving State">
								<BZ:option value="">--Please secect--</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<%} %>
					<tr>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>�������</td>
						<td class="bz-edit-data-value" width="80%">
							<BZ:input type="textarea" prefix="F_" field="ADVICE_FEEDBACK_OPINION" defaultValue="" style="width:98%;height:60px;" maxlength="1000" notnull="Please fill in the opinion"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
