<%
/**   
 * @Title: CI_info_sign.jsp
 * @Description: ��ͯ��Ϣ��ǩ��ҳ�棩
 * @author xugy
 * @date 2014-11-27����2:40:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
//
Data data=(Data)request.getAttribute("data");

String CI_ID = data.getString("CI_ID");//
%>
<BZ:html>
<BZ:head>
	<title>��ͯ��Ϣ</title>
	<BZ:webScript edit="true" tree="true"/>
	<up:uploadResource/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	setSigle();
	dyniframesize(['CIFrame','mainFrame']);//�������ܣ����Ԫ������Ӧ
	//intoiframesize('CIFrame');
});
//
function _viewCI(CHILD_NOs){
	parent._viewEtcl(CHILD_NOs);
}
</script>
<BZ:body property="data" codeNames="ETXB;PROVINCE;CHILD_TYPE;ETSFLX;BCZL;">
<%-- <%=path%>/match/showCIInfoFirst.action?CI_ID=<%=CI_ID%> --%>
	<table class="bz-edit-data-table" border="0">
		<tr>
			<td class="bz-edit-data-title" width="15%">����</td>
			<td class="bz-edit-data-value" width="23%">
				<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" width="12%" rowspan="4">
				<img style="width: 130px;height: 152px;" src='<up:attDownload attTypeCode="CI" packageId="<%=CI_ID%>" smallType="<%=AttConstants.CI_IMAGE %>"/>'></img>
			</td>
			<td class="bz-edit-data-title" width="15%">ʡ��</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">�Ա�</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
			</td>
			<td class="bz-edit-data-title">����Ժ</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��������</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-title">��ʰ����</td>
			<td class="bz-edit-data-value" >
				<BZ:dataValue field="PICKUP_DATE" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͯ����</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" codeName="CHILD_TYPE"/>
			</td>
			<td class="bz-edit-data-title">��������</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SEND_DATE" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͯ���</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" onlyValue="true" codeName="ETSFLX"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��������</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="SN_TYPE" defaultValue="" onlyValue="true" codeName="BCZL"/>
			</td>
			<td class="bz-edit-data-title">�ر��ע</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
			</td>
		</tr>
	</table>
</BZ:body>
</BZ:html>
