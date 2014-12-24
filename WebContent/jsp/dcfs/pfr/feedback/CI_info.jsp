<%
/**   
 * @Title: CI_info.jsp
 * @Description: ��ͯ��Ϣ
 * @author xugy
 * @date 2014-10-24����7:00:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
Data data=(Data)request.getAttribute("data");

String CI_ID = data.getString("CI_ID");//

String LANG = (String)request.getAttribute("LANG");
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
});
</script>
<BZ:body property="data" codeNames="ETXB;PROVINCE;CHILD_TYPE;ETSFLX;">
	<table class="bz-edit-data-table" border="0">
		<%
		if("EN".equals(LANG)){
		%>
		<tr>
			<td class="bz-edit-data-title" width="15%">��������ͯ����<br>Name(CN)</td>
			<td class="bz-edit-data-value" width="23%">
				<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" width="12%" rowspan="4">
				<img style="width: 126px;height: 152px;" src='<up:attDownload attTypeCode="CI" packageId="<%=CI_ID%>" smallType="<%=AttConstants.CI_IMAGE %>"/>'></img>
			</td>
			<td class="bz-edit-data-title" width="15%">����ƴ��<br>Name(EN)</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">�Ա�<br>Sex</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB" isShowEN="true"/>
			</td>
			<td class="bz-edit-data-title">ʡ��<br>Province</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE" isShowEN="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��������<br>D.O.B</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-title">����Ժ<br>SWI</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="WELFARE_NAME_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����״��<br>Health condition</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" codeName="CHILD_TYPE" isShowEN="true"/>
			</td>
			<td class="bz-edit-data-title">��ͯ���</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" onlyValue="true" codeName="ETSFLX" isShowEN="true"/>
			</td>
		</tr>
		<%
		}else{
		%>
		<tr>
			<td class="bz-edit-data-title" width="15%">��������ͯ����</td>
			<td class="bz-edit-data-value" width="23%">
				<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" width="12%" rowspan="4">
				<img style="width: 126px;height: 152px;" src='<up:attDownload attTypeCode="CI" packageId="<%=CI_ID%>" smallType="<%=AttConstants.CI_IMAGE %>"/>'></img>
			</td>
			<td class="bz-edit-data-title" width="15%">����ƴ��</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">�Ա�</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
			</td>
			<td class="bz-edit-data-title">ʡ��</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��������</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-title">����Ժ</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����״��</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" codeName="CHILD_TYPE"/>
			</td>
			<td class="bz-edit-data-title">��ͯ���</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" onlyValue="true" codeName="ETSFLX"/>
			</td>
		</tr>
		<%} %>
	</table>
</BZ:body>
</BZ:html>
