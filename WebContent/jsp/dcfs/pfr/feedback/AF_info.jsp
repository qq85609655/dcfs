<%
/**   
 * @Title: AF_info.jsp
 * @Description: 收养人信息
 * @author xugy
 * @date 2014-10-26上午11:40:23
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
	<title>收养人信息</title>
	<BZ:webScript edit="true" tree="true"/>
	<up:uploadResource/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	setSigle();
	dyniframesize(['AFFrame','mainFrame']);//公共功能，框架元素自适应
	
});
</script>
<BZ:body property="data" codeNames="GJ;ADOPTER_HEALTH;">
	<table class="bz-edit-data-table" border="0">
		<%
		if("EN".equals(LANG)){
		%>
		<tr>
			<td class="bz-edit-data-title" width="15%">男收养人<br>Adoptive father</td>
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
			<td class="bz-edit-data-title" width="15%">女收养人<br>Adoptive mother</td>
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
			<td class="bz-edit-data-title">国籍<br>Nationality</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_NATION" defaultValue="" onlyValue="true" codeName="GJ" isShowEN="true"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">国籍<br>Nationality</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_NATION" defaultValue="" onlyValue="true" codeName="GJ" isShowEN="true"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">出生日期<br>D.O.B</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">出生日期<br>D.O.B</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">职业<br>Occupation</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_JOB_EN" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">职业<br>Occupation</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_JOB_EN" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">健康状况<br>Health condition</td>
			<td class="bz-edit-data-value" colspan="2">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH" isShowEN="true"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">健康状况<br>Health condition</td>
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
			<td class="bz-edit-data-title" width="15%">男收养人</td>
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
			<td class="bz-edit-data-title" width="15%">女收养人</td>
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
			<td class="bz-edit-data-title">国籍</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">国籍</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">出生日期</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">出生日期</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">职业</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">职业</td>
			<td class="bz-edit-data-value">
				<%
				if(!"".equals(FEMALE_NAME)){
				%>
				<BZ:dataValue field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">健康状况</td>
			<td class="bz-edit-data-value" colspan="2">
				<%
				if(!"".equals(MALE_NAME)){
				%>
				<BZ:dataValue field="MALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">健康状况</td>
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
