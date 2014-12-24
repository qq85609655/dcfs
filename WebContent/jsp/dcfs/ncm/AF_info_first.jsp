<%
/**   
 * @Title: AF_info_first.jsp
 * @Description: 收养人信息
 * @author xugy
 * @date 2014-10-30下午1:05:23
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
//文件类型
String FILE_TYPE = data.getString("FILE_TYPE");
//收养类型
String FAMILY_TYPE = data.getString("FAMILY_TYPE");
//收养人性别
String ADOPTER_SEX = data.getString("ADOPTER_SEX");

String MALE_PHOTO = data.getString("MALE_PHOTO","");
String FEMALE_PHOTO = data.getString("FEMALE_PHOTO","");
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
<BZ:body property="data" codeNames="GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_MARRYCOND;">
<%-- <%=path%>/match/showAFInfoFirst.action?AF_ID=<%=AF_ID%> --%>
	<table class="bz-edit-data-table" border="0" id="tab">
		<%
		if("33".equals(FILE_TYPE) || (!"33".equals(FILE_TYPE) && "2".equals(FAMILY_TYPE))){//继子女收养或（非继子女收养和单亲收养）
		%>
		<tr>
			<td class="bz-edit-data-title" width="15%">收养人</td>
			<td class="bz-edit-data-value" width="35%">
				<%
				if("1".equals(ADOPTER_SEX)){//男收养人
				%>
				<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title" width="15%">性别</td>
			<td class="bz-edit-data-value" width="23%">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="" defaultValue="男"/>
				<%
				}else{
				%>
				<BZ:dataValue field="" defaultValue="女"/>
				<%} %>
			</td>
			<td class="bz-edit-data-value" width="12%" rowspan="4">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<img style="width: 130px;height: 152px;" src='<up:attDownload attTypeCode="AF" packageId="<%=MALE_PHOTO%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>'></img>
				<%
				}else{
				%>
				<img style="width: 130px;height: 152px;" src='<up:attDownload attTypeCode="AF" packageId="<%=FEMALE_PHOTO%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>'></img>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">出生日期</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">年龄</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_AGE" defaultValue="" onlyValue="true"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_AGE" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">国籍</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">护照号码</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
		</tr>
			<%
			if("33".equals(FILE_TYPE)){
			%>
		<tr>
			<td class="bz-edit-data-title">婚姻状况</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="" defaultValue="已婚"/>
			</td>
			<td class="bz-edit-data-title">结婚日期</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MARRY_DATE" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
			<%
			}
			if(!"33".equals(FILE_TYPE) && "2".equals(FAMILY_TYPE)){
			%>
		<tr>
			<td class="bz-edit-data-title">受教育情况</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">职业</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">健康状况</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">违法行为及刑事处罚</td>
			<td class="bz-edit-data-value" colspan="2">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=无;1=有;"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=无;1=有;"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">有无不良嗜好</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=无;1=有;"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=无;1=有;"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">婚姻状况</td>
			<td class="bz-edit-data-value" colspan="2">
				<%
				if("2".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MARRY_CONDITION" defaultValue="" onlyValue="true" codeName="ADOPTER_MARRYCOND"/>
				<%
				}
				%>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">同居伙伴</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CONABITA_PARTNERS" defaultValue="" onlyValue="true" checkValue="0=无;1=有;"/>
			</td>
			<td class="bz-edit-data-title">同居时长</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="CONABITA_PARTNERS_TIME" defaultValue="" onlyValue="true"/>年
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">非同性恋声明</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="GAY_STATEMENT" defaultValue="" onlyValue="true" checkValue="0=无;1=有;"/>
			</td>
			<td class="bz-edit-data-title">年收入</td>
			<td class="bz-edit-data-value" colspan="2">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">家庭总资产</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
			<td class="bz-edit-data-title">家庭总债务</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">家庭净资产</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="TOTAL_NET_ASSETS" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
			<td class="bz-edit-data-title">未成年子女数量</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">子女数量及其情况</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">家庭住址</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">收养要求</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
			}
		}
		if(!"33".equals(FILE_TYPE) && "1".equals(FAMILY_TYPE)){//非继子女收养and双亲收养
		%>
		<tr>
			<td class="bz-edit-data-title" width="20%"></td>
			<td class="bz-edit-data-title" width="40%" style="text-align: center;" colspan="2"><b>男收养人</b></td>
			<td class="bz-edit-data-title" width="40%" style="text-align: center;" colspan="2"><b>女收养人</b></td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">姓名</td>
			<td class="bz-edit-data-value" width="28%">
				<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" width="12%" rowspan="4">
				<img style="width: 130px;height: 152px;" src='<up:attDownload attTypeCode="AF" packageId="<%=MALE_PHOTO%>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>'></img>
			</td>
			<td class="bz-edit-data-value" width="28%">
				<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" width="12%" rowspan="4">
				<img style="width: 130px;height: 152px;" src='<up:attDownload attTypeCode="AF" packageId="<%=FEMALE_PHOTO%>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>'></img>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">出生日期</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">年龄</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_AGE" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_AGE" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">国籍</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">护照号码</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">受教育情况</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">职业</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">健康状况</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">违法行为及刑事处罚</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=无;1=有;"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=无;1=有;"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">有无不良嗜好</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=无;1=有;"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=无;1=有;"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">年收入</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">家庭总资产</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">家庭总债务 </td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">家庭净资产</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="TOTAL_NET_ASSETS" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">婚姻状况</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="" defaultValue="已婚"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">结婚日期</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="MARRY_DATE" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">未成年子女数量</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td class="bz-edit-data-title">子女数量及情况</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">家庭地址</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">收养要求</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
		}
		%>
	</table>
</BZ:body>
</BZ:html>
