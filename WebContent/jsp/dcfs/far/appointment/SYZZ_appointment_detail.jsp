<%
/**   
 * @Title: SYZZ_appointment_detail.jsp
 * @Description: ������֯ԤԼ����鿴
 * @author xugy
 * @date 2014-11-27����4:38:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<BZ:html>
<BZ:head language="EN">
	<title>������֯ԤԼ����鿴</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//����
function _goback(){
	document.srcForm.action=path+"appointment/SYZZAppointmentRecordList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="WJLX;PROVINCE;ETXB;">
<BZ:form name="srcForm" method="post">
<BZ:input type="hidden" prefix="AR_" field="AR_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>ԤԼ������Ϣ(Appointment information)</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">��������<br>Adoptive father</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">Ů������<br>Adoptive mother</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ļ�����<br>Document type</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX" isShowEN="true"/>
						</td>
						<td class="bz-edit-data-title">ʡ��<br>Province</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE" isShowEN="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����Ժ<br>SWI</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="WELFARE_NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����<br>Name</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ա�<br>Sex</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB" isShowEN="true"/>
						</td>
						<td class="bz-edit-data-title">��������<br>D.O.B</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ǩ����<br>Application number</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="SIGN_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����Ǽǻ������ƣ����ģ�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REG_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�����Ǽǻ������ƣ�Ӣ�ģ�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REG_ORG_NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ַ�����ģ�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="DEPT_ADDRESS_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ַ��Ӣ�ģ�</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="DEPT_ADDRESS_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ϵ�ˣ����ģ�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��ϵ�ˣ�Ӣ�ģ�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_NAMEPY" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ϵ�绰</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_TEL" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONTACT_MAIL" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>ԤԼ������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title">ԤԼʱ��<br>Date of appointment</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ORDER_DATE" defaultValue="" type="dateTime" dateFormat="yyyy-MM-dd HH:mm" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע<br>Remarks</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">�����<br>Reviewed by</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEEDBACK_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�������<br>Review date</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FEEDBACK_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��˽��<br></td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ORDER_STATE" defaultValue="" onlyValue="true" checkValue="0=δ�ύ;1=��ȷ��;2=ͨ��;3=��ͨ��;"/>
						</td>
						<td class="bz-edit-data-title">����ʱ��<br>Suggested date</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SUGGEST_DATE" defaultValue="" type="dateTime" dateFormat="yyyy-MM-dd HH:mm" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ʡ����ע</td>
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
			<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
