<%
/**   
 * @Title: advice_feedback_confirm.jsp
 * @Description: ���ò������������ȷ��
 * @author xugy
 * @date 2014-9-12����10:15:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");
String CI_ID = data.getString("CI_ID");//��ͯ����ID
String AF_ID = data.getString("AF_ID");//�������ļ�ID
%>
<BZ:html>
<BZ:head>
	<title>���ò������������ȷ��</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//����
function _goback(){
	document.srcForm.action=path+"advice/AZBAdviceList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="ETXB;PROVINCE;ETSFLX;SYS_COUNTRY_GOVMENT_CN_ALL;WJLX;SYLX;">
<BZ:form name="srcForm" method="post">
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">������֯</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title" width="15%">���ı�� </td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ļ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FAMILY_TYPE" defaultValue="" onlyValue="true" codeName="SYLX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��׼������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="GOVERN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="EXPIRE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����˼�ͥ��Ϣ</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;height: 498px;" src="<%=path%>/match/showAFInfoFirst.action?AF_ID=<%=AF_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>��ͯ��Ϣ</div>
			</div>
			<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;height: 157px;" src="<%=path%>/match/showCIInfoFourth.action?CI_ID=<%=CI_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="13%">��Լ����</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="IS_CONVENTION_ADOPT" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
						</td>
						<td class="bz-edit-data-title" width="14%">֪ͨ����</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="ADVICE_NOTICE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title" width="13%">�������</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="ADVICE_FEEDBACK_RESULT" defaultValue="" onlyValue="true" checkValue="1=ͬ��;2=��ͣ;3=����ƥ��;4=����;"/>
						</td>
					</tr>
					<tr>
						<tr>
						<td class="bz-edit-data-title">ȷ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADVICE_CFM_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ȷ������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADVICE_CFM_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title"></td>
						<td class="bz-edit-data-value"></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�������������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADVICE_GOV_ID" defaultValue="" onlyValue="true" codeName="SYS_COUNTRY_GOVMENT_CN_ALL"/>
						</td>
						<td class="bz-edit-data-title">ǩ������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADVICE_FEEDBACK_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="5">
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
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
