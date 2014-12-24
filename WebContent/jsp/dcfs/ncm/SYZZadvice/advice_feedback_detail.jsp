<%
/**   
 * @Title: advice_feedback_detail.jsp
 * @Description: ������֯������������鿴
 * @author xugy
 * @date 2014-9-12����6:56:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data=(Data)request.getAttribute("data");
String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT");
%>
<BZ:html>
<BZ:head language="EN">
	<title>������֯������������鿴</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//����
function _goback(){
	document.srcForm.action=path+"advice/SYZZAdviceList.action";
	document.srcForm.submit();
}
</script>
<BZ:body property="data" codeNames="ETXB;SYS_COUNTRY_GOVMENT_CN_ALL;">
<BZ:form name="srcForm" method="post">
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
						<td class="bz-edit-data-title" width="20%">��ͯ���</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="CHILD_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�ļ����</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������������<br>Adoptive father</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">Ů����������<br>Adoptive mother</td>
						<td class="bz-edit-data-value">
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
							<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB" isShowEN="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������˳�������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">֪ͨ����<br>Date of notification</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADVICE_NOTICE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<%
					if("1".equals(IS_CONVENTION_ADOPT)){
					%>
					<tr>
						<td class="bz-edit-data-title">�������������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADVICE_GOV_ID" defaultValue="" onlyValue="true" codeName="SYS_COUNTRY_GOVMENT_CN_ALL" isShowEN="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ǩ������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADVICE_FEEDBACK_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<%} %>
					<tr>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADVICE_FEEDBACK_OPINION" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�������ȷ����Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">���ò�ȷ��״̬</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="ADVICE_STATE" defaultValue="" onlyValue="true" checkValue="2=to be confirmed;3=confirmed;"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�������<br>Results</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="ADVICE_FEEDBACK_RESULT" defaultValue="" onlyValue="true" checkValue="1=Approved;2=suspension;3=re-matching;4=withdrawal;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע<br>Remarks</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADVICE_FEEDBACK_REMARKS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
