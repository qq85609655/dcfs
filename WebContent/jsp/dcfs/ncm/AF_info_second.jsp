<%
/**   
 * @Title: AF_info_second.jsp
 * @Description: ��������Ϣ
 * @author xugy
 * @date 2014-11-3����9:45:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
Data data=(Data)request.getAttribute("data");
//�ļ�����
String FILE_TYPE = data.getString("FILE_TYPE");
//��������
String FAMILY_TYPE = data.getString("FAMILY_TYPE");
//�������Ա�
String ADOPTER_SEX = data.getString("ADOPTER_SEX");

String LANG = (String)request.getAttribute("LANG");//����
%>
<BZ:html>
<BZ:head>
	<title>��������Ϣ</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	setSigle();
	dyniframesize(['AFFrame','mainFrame']);//�������ܣ����Ԫ������Ӧ
	//intoiframesize('AFFrame');
});
</script>
<BZ:body property="data" codeNames="GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_MARRYCOND;">
<%-- <%=path%>/match/showAFInfoSecond.action?AF_ID=<%=AF_ID%> --%>
	<table class="bz-edit-data-table" border="0" id="tab">
		<%
		if("EN".equals(LANG)){
		%>
		<%
		if("33".equals(FILE_TYPE) || (!"33".equals(FILE_TYPE) && "2".equals(FAMILY_TYPE))){//����Ů�����򣨷Ǽ���Ů�����͵���������
		%>
		<tr>
			<td class="bz-edit-data-title" width="15%">������<br/>(EN)</td>
			<td class="bz-edit-data-value" width="35%">
				<%
				if("1".equals(ADOPTER_SEX)){//��������
				%>
				<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title" width="15%">�Ա�<br/>(EN)</td>
			<td class="bz-edit-data-value" width="35%">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="" defaultValue="Male"/>
				<%
				}else{
				%>
				<BZ:dataValue field="" defaultValue="Female"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��������<br/>(EN)</td>
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
			<td class="bz-edit-data-title">����<br/>(EN)</td>
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
			<td class="bz-edit-data-title">����<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_NATION" defaultValue="" onlyValue="true" isShowEN="true" codeName="GJ"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_NATION" defaultValue="" onlyValue="true" isShowEN="true" codeName="GJ"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">���պ���<br/>(EN)</td>
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
			<td class="bz-edit-data-title">����״��<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="" defaultValue="Cohabitating"/>
			</td>
			<td class="bz-edit-data-title">�������<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MARRY_DATE" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
			<%
			}
			if(!"33".equals(FILE_TYPE) && "2".equals(FAMILY_TYPE)){
			%>
		<tr>
			<td class="bz-edit-data-title">�ܽ������<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_EDUCATION" defaultValue="" onlyValue="true" isShowEN="true" codeName="ADOPTER_EDU"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_EDUCATION" defaultValue="" onlyValue="true" isShowEN="true" codeName="ADOPTER_EDU"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">ְҵ<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_JOB_EN" defaultValue="" onlyValue="true"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_JOB_EN" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����״��<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_HEALTH" defaultValue="" onlyValue="true" isShowEN="true" codeName="ADOPTER_HEALTH"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_HEALTH" defaultValue="" onlyValue="true" isShowEN="true" codeName="ADOPTER_HEALTH"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">Υ����Ϊ�����´���<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=No;1=Yes;"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=No;1=Yes;"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">���޲����Ⱥ�<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=No;1=Yes;"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=No;1=Yes;"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">����״��<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<%
				if("2".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MARRY_CONDITION" defaultValue="" onlyValue="true" isShowEN="true" codeName="ADOPTER_MARRYCOND"/>
				<%
				}
				%>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">ͬ�ӻ��<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CONABITA_PARTNERS" defaultValue="" onlyValue="true" checkValue="0=No;1=Yes;"/>
			</td>
			<td class="bz-edit-data-title">ͬ��ʱ��<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CONABITA_PARTNERS_TIME" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͬ��������<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="GAY_STATEMENT" defaultValue="" onlyValue="true" checkValue="0=No;1=Yes;"/>
			</td>
			<td class="bz-edit-data-title">������<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" isShowEN="true" codeName="HBBZ"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" isShowEN="true" codeName="HBBZ"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ���ʲ�<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" isShowEN="true" codeName="HBBZ"/>
			</td>
			<td class="bz-edit-data-title">��ͥ��ծ��<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" isShowEN="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ���ʲ�<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="TOTAL_NET_ASSETS" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" isShowEN="true" codeName="HBBZ"/>
			</td>
			<td class="bz-edit-data-title">δ������Ů����<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��Ů�����������<br/>(EN)</td>
			<td class="bz-edit-data-value" colspan="3">
				<BZ:dataValue field="CHILD_CONDITION_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥסַ<br/>(EN)</td>
			<td class="bz-edit-data-value" colspan="3">
				<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����Ҫ��<br/>(EN)</td>
			<td class="bz-edit-data-value" colspan="3">
				<BZ:dataValue field="ADOPT_REQUEST_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
			}
		}
		if(!"33".equals(FILE_TYPE) && "1".equals(FAMILY_TYPE)){//�Ǽ���Ů����and˫������
		%>
		<tr>
			<td class="bz-edit-data-title" width="20%"></td>
			<td class="bz-edit-data-title" width="40%" style="text-align: center;" ><b>��������(EN)</b></td>
			<td class="bz-edit-data-title" width="40%" style="text-align: center;" ><b>Ů������(EN)</b></td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��������<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_AGE" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_AGE" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_NATION" defaultValue="" onlyValue="true" isShowEN="true" codeName="GJ"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_NATION" defaultValue="" onlyValue="true" isShowEN="true" codeName="GJ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">���պ���<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">�ܽ������<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_EDUCATION" defaultValue="" onlyValue="true" isShowEN="true" codeName="ADOPTER_EDU"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_EDUCATION" defaultValue="" onlyValue="true" isShowEN="true" codeName="ADOPTER_EDU"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">ְҵ<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_JOB_EN" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_JOB_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����״��<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_HEALTH" defaultValue="" onlyValue="true" isShowEN="true" codeName="ADOPTER_HEALTH"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_HEALTH" defaultValue="" onlyValue="true" isShowEN="true" codeName="ADOPTER_HEALTH"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">Υ����Ϊ�����´���<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=No;1=Yes;"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=No;1=Yes;"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">���޲����Ⱥ�<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=No;1=Yes;"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=No;1=Yes;"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">������<br/>(EN)</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/> <BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" isShowEN="true" codeName="HBBZ"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/> <BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" isShowEN="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ���ʲ�<br/>(EN)</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/> <BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" isShowEN="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ��ծ�� <br/>(EN)</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/> <BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" isShowEN="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ���ʲ�<br/>(EN)</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="TOTAL_NET_ASSETS" defaultValue="" onlyValue="true"/> <BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" isShowEN="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">δ������Ů����<br/>(EN)</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����״��<br/>(EN)</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="" defaultValue="Cohabitating"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">�������<br/>(EN)</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MARRY_DATE" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��Ů���������<br/>(EN)</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="CHILD_CONDITION_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ��ַ<br/>(EN)</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����Ҫ��<br/>(EN)</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="ADOPT_REQUEST_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
		}
		%>
		<%
		}else{
		%>
		<%
		if("33".equals(FILE_TYPE) || (!"33".equals(FILE_TYPE) && "2".equals(FAMILY_TYPE))){//����Ů�����򣨷Ǽ���Ů�����͵���������
		%>
		<tr>
			<td class="bz-edit-data-title" width="15%">������</td>
			<td class="bz-edit-data-value" width="35%">
				<%
				if("1".equals(ADOPTER_SEX)){//��������
				%>
				<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title" width="15%">�Ա�</td>
			<td class="bz-edit-data-value" width="35%">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="" defaultValue="��"/>
				<%
				}else{
				%>
				<BZ:dataValue field="" defaultValue="Ů"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��������</td>
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
			<td class="bz-edit-data-title">����</td>
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
			<td class="bz-edit-data-title">����</td>
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
			<td class="bz-edit-data-title">���պ���</td>
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
			<td class="bz-edit-data-title">����״��</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="" defaultValue="�ѻ�"/>
			</td>
			<td class="bz-edit-data-title">�������</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MARRY_DATE" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
			<%
			}
			if(!"33".equals(FILE_TYPE) && "2".equals(FAMILY_TYPE)){
			%>
		<tr>
			<td class="bz-edit-data-title">�ܽ������</td>
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
			<td class="bz-edit-data-title">ְҵ</td>
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
			<td class="bz-edit-data-title">����״��</td>
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
			<td class="bz-edit-data-title">Υ����Ϊ�����´���</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
				<%} %>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">���޲����Ⱥ�</td>
			<td class="bz-edit-data-value">
				<%
				if("1".equals(ADOPTER_SEX)){
				%>
				<BZ:dataValue field="MALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
				<%
				}else{
				%>
				<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
				<%} %>
			</td>
			<td class="bz-edit-data-title">����״��</td>
			<td class="bz-edit-data-value">
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
			<td class="bz-edit-data-title">ͬ�ӻ��</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CONABITA_PARTNERS" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
			</td>
			<td class="bz-edit-data-title">ͬ��ʱ��</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CONABITA_PARTNERS_TIME" defaultValue="" onlyValue="true"/>��
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͬ��������</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="GAY_STATEMENT" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
			</td>
			<td class="bz-edit-data-title">������</td>
			<td class="bz-edit-data-value">
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
			<td class="bz-edit-data-title">��ͥ���ʲ�</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
			<td class="bz-edit-data-title">��ͥ��ծ��</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ���ʲ�</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="TOTAL_NET_ASSETS" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
			<td class="bz-edit-data-title">δ������Ů����</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��Ů�����������</td>
			<td class="bz-edit-data-value" colspan="3">
				<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥסַ</td>
			<td class="bz-edit-data-value" colspan="3">
				<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����Ҫ��</td>
			<td class="bz-edit-data-value" colspan="3">
				<BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
			}
		}
		if(!"33".equals(FILE_TYPE) && "1".equals(FAMILY_TYPE)){//�Ǽ���Ů����and˫������
		%>
		<tr>
			<td class="bz-edit-data-title" width="20%"></td>
			<td class="bz-edit-data-title" width="40%" style="text-align: center;" ><b>��������</b></td>
			<td class="bz-edit-data-title" width="40%" style="text-align: center;" ><b>Ů������</b></td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��������</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_AGE" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_AGE" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_NATION" defaultValue="" onlyValue="true" codeName="GJ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">���պ���</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">�ܽ������</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">ְҵ</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����״��</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">Υ����Ϊ�����´���</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">���޲����Ⱥ�</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">������</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ���ʲ�</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ��ծ�� </td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ���ʲ�</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="TOTAL_NET_ASSETS" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">δ������Ů����</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����״��</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="" defaultValue="�ѻ�"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">�������</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MARRY_DATE" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��Ů���������</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ��ַ</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����Ҫ��</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
		}
		%>
		<%} %>
	</table>
</BZ:body>
</BZ:html>
