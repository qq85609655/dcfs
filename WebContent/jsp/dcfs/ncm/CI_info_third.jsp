<%
/**   
 * @Title: CI_info_third.jsp
 * @Description: ��ͯ��Ϣ
 * @author xugy
 * @date 2014-11-15����6:52:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
Data data=(Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
	<title>��ͯ��Ϣ</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	setSigle();
	dyniframesize(['CIFrame','mainFrame']);//�������ܣ����Ԫ������Ӧ
	//intoiframesize('CIFrame');
});
</script>
<BZ:body property="data" codeNames="ETXB;PROVINCE;CHILD_TYPE;ETSFLX;">
<%-- <%=path%>/match/showCIInfoThird.action?CI_ID=<%=CI_ID%> --%>
	<table class="bz-edit-data-table" border="0">
		<tr>
			<td class="bz-edit-data-title" width="15%">����</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title" width="15%">�Ա�</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��������</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-title">��ͯ����</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" codeName="CHILD_TYPE"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͯ���</td>
			<td class="bz-edit-data-value" colspan="3">
				<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" onlyValue="true" codeName="ETSFLX"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">������</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SENDER" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title">�����˵�ַ</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
	</table>
</BZ:body>
</BZ:html>
