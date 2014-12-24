<%
/**   
 * @Title: AF_info_third.jsp
 * @Description: 收养人信息
 * @author xugy
 * @date 2014-11-15下午6:55:23
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
	//intoiframesize('AFFrame');
});
</script>
<BZ:body property="data" codeNames="GJ;ADOPTER_MARRYCOND;ADOPTER_EDU;ADOPTER_HEALTH;">
<%-- <%=path%>/match/showAFInfoThird.action?CI_ID=<%=CI_ID%> --%>
	<table class="bz-edit-data-table" border="0">
		<tr>
			<td class="bz-edit-data-title" width="15%">男收养人</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title" width="15%">女收养人</td>
			<td class="bz-edit-data-value" width="35%">
				<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">国籍</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
			</td>
			<td class="bz-edit-data-title">国籍</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">出生日期</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-title">出生日期</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">护照号</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title">护照号</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">职业</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_JOB_EN" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title">职业</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_JOB_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">婚姻状况</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MARRY_CONDITION" defaultValue="已婚" onlyValue="true" codeName="ADOPTER_MARRYCOND"/>
			</td>
			<td class="bz-edit-data-title">婚姻状况</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MARRY_CONDITION" defaultValue="已婚" onlyValue="true" codeName="ADOPTER_MARRYCOND"/>
			</td>
		</tr>
		
		<tr>
			<td class="bz-edit-data-title">受教育情况</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
			</td>
			<td class="bz-edit-data-title">受教育情况</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">健康状况</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
			</td>
			<td class="bz-edit-data-title">健康状况</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
			</td>
		</tr>
	</table>
</BZ:body>
</BZ:html>
