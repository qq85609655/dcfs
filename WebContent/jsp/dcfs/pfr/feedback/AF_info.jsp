<%
/**   
 * @Title: AF_info.jsp
 * @Description: ��������Ϣ
 * @author xugy
 * @date 2014-10-26����11:40:23
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

String MALE_NAME = data.getString("MALE_NAME","");
String FEMALE_NAME = data.getString("FEMALE_NAME","");

String MALE_PHOTO = data.getString("MALE_PHOTO","");
String FEMALE_PHOTO = data.getString("FEMALE_PHOTO","");

String LANG = (String)request.getAttribute("LANG");
%>
<BZ:html>
<BZ:head>
	<title>��������Ϣ</title>
	<BZ:webScript edit="true" tree="true"/>
	<up:uploadResource/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	setSigle();
	dyniframesize(['AFFrame','mainFrame']);//�������ܣ����Ԫ������Ӧ
	
});
</script>
<BZ:body property="data" codeNames="GJ;ADOPTER_HEALTH;">
	<table class="bz-edit-data-table" border="0">
		<%
		if("EN".equals(LANG)){
		%>
		<tr>
			<td class="bz-edit-data-title" width="15%">��������<br>Adoptive father</td>
			<td class="bz-edit-data-value" width="23%">
				<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" width="12%" rowspan="4">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<img style="width: 126px;height: 152px;" src='<up:attDownload attTypeCode="AF" packageId="<%=MALE_PHOTO%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>'></img>
				<%} %>
			</td>
			<td class="bz-edit-data-title" width="15%">Ů������<br>Adoptive mother</td>
			<td class="bz-edit-data-value" width="23%">
				<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" width="12%" rowspan="4">
			<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<img style="width: 126px;height: 152px;" src='<up:attDownload attTypeCode="AF" packageId="<%=FEMALE_PHOTO%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>'></img>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����<br>Nationality</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_NATION" defaultValue="" onlyValue="true" codeName="GJ" isShowEN="true"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">����<br>Nationality</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_NATION" defaultValue="" onlyValue="true" codeName="GJ" isShowEN="true"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��������<br>D.O.B</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">��������<br>D.O.B</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">ְҵ<br>Occupation</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_JOB_EN" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">ְҵ<br>Occupation</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_JOB_EN" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����״��<br>Health condition</td>
			<td class="bz-edit-data-value" colspan="2">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH" isShowEN="true"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">����״��<br>Health condition</td>
			<td class="bz-edit-data-value" colspan="2">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH" isShowEN="true"/>
				<%} %>
			</td>
		</tr>
		<%
		}else{
		%>
		<tr>
			<td class="bz-edit-data-title" width="15%">��������</td>
			<td class="bz-edit-data-value" width="23%">
				<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" width="12%" rowspan="4">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<img style="width: 126px;height: 152px;" src='<up:attDownload attTypeCode="AF" packageId="<%=MALE_PHOTO%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>'></img>
				<%} %>
			</td>
			<td class="bz-edit-data-title" width="15%">Ů������</td>
			<td class="bz-edit-data-value" width="23%">
				<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" width="12%" rowspan="4">
			<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<img style="width: 126px;height: 152px;" src='<up:attDownload attTypeCode="AF" packageId="<%=FEMALE_PHOTO%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>'></img>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">����</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��������</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">��������</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">ְҵ</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">ְҵ</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����״��</td>
			<td class="bz-edit-data-value" colspan="2">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">����״��</td>
			<td class="bz-edit-data-value" colspan="2">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
				<%} %>
			</td>
		</tr>
		<%} %>
	</table>
</BZ:body>
</BZ:html>
