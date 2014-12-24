<%
/**   
 * @Title: CI_info_second.jsp
 * @Description: ��ͯ��Ϣ
 * @author xugy
 * @date 2014-11-3����9:24:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
Data data=(Data)request.getAttribute("data");

String LANG = (String)request.getAttribute("LANG");//����
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
<%-- <%=path%>/match/showCIInfoSecond.action?CI_ID=<%=CI_ID%> --%>
	<table class="bz-edit-data-table" border="0">
		<%
		if("EN".equals(LANG)){
		%>
		<tr>
			<td class="bz-edit-data-title" width="15%">ʡ��<br/>Province</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" isShowEN="true" codeName="PROVINCE"/>
			</td>
			<td class="bz-edit-data-title" width="15%">����Ժ<br/>SWI</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="WELFARE_NAME_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����<br/>Name(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title">�Ա�<br/>Sex</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" isShowEN="true" codeName="ETXB"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��������<br/>D.O.B</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-title">��ͯ����<br/>Type of children</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" isShowEN="true" codeName="CHILD_TYPE"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͯ���<br/></td>
			<td class="bz-edit-data-value" colspan="3">
				<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" onlyValue="true" isShowEN="true" codeName="ETSFLX"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">������<br/></td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SENDER_EN" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title">�����˵�ַ<br/></td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
		}else{
		%>
		<tr>
			<td class="bz-edit-data-title" width="15%">ʡ��</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE"/>
			</td>
			<td class="bz-edit-data-title" width="15%">����Ժ</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title">�Ա�</td>
			<td class="bz-edit-data-value">
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
		<%} %>
	</table>
</BZ:body>
</BZ:html>
