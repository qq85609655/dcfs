<%
/**   
 * @Title: ST_appointment_accept_detail.jsp
 * @Description: ʡ��ԤԼ����鿴
 * @author xugy
 * @date 2014-10-2����4:21:34
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<BZ:html>
<BZ:head>
	<title>ʡ��ԤԼ����鿴</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//�ر�
function _close(){
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
}

</script>
<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;">
<BZ:form name="srcForm" method="post">
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>ԤԼ������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title">֪ͨ���</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="SIGN_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">����</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">������֯</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">Ů������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����Ժ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ա�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ԤԼ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORDER_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��ϵ�绰</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORDER_PHONE" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORDER_TEL" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ԤԼʱ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORDER_DATE" defaultValue="" type="dateTime" dateFormat="yyyy-MM-dd HH:mm" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">������֯��ע</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>ԤԼȷ��</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="20%">�����</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEEDBACK_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEEDBACK_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��˽��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORDER_STATE" defaultValue="" onlyValue="true" checkValue="1=��ȷ��;2=ͨ��;3=��ͨ��;"/>
						</td>
						<td class="bz-edit-data-title">����ʱ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SUGGEST_DATE" defaultValue="" type="dateTime" dateFormat="yyyy-MM-dd HH:mm" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REMARKS1" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_close()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
