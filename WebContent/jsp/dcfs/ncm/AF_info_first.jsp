<%
/**   
 * @Title: AF_info_first.jsp
 * @Description: ��������Ϣ
 * @author xugy
 * @date 2014-10-30����1:05:23
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
//�ļ�����
String FILE_TYPE = data.getString("FILE_TYPE");
//��������
String FAMILY_TYPE = data.getString("FAMILY_TYPE");
//�������Ա�
String ADOPTER_SEX = data.getString("ADOPTER_SEX");

String MALE_PHOTO = data.getString("MALE_PHOTO","");
String FEMALE_PHOTO = data.getString("FEMALE_PHOTO","");
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
	//intoiframesize('AFFrame');
	
});
</script>
<BZ:body property="data" codeNames="GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;ADOPTER_MARRYCOND;">
<%-- <%=path%>/match/showAFInfoFirst.action?AF_ID=<%=AF_ID%> --%>
	<table class="bz-edit-data-table" border="0" id="tab">
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
			<td class="bz-edit-data-value" width="23%">
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
			<td class="bz-edit-data-value" colspan="2">
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
			<td class="bz-edit-data-title">ͬ�ӻ��</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="CONABITA_PARTNERS" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
			</td>
			<td class="bz-edit-data-title">ͬ��ʱ��</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="CONABITA_PARTNERS_TIME" defaultValue="" onlyValue="true"/>��
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͬ��������</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="GAY_STATEMENT" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
			</td>
			<td class="bz-edit-data-title">������</td>
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
			<td class="bz-edit-data-title">��ͥ���ʲ�</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
			<td class="bz-edit-data-title">��ͥ��ծ��</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ���ʲ�</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="TOTAL_NET_ASSETS" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
			<td class="bz-edit-data-title">δ������Ů����</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��Ů�����������</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥסַ</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����Ҫ��</td>
			<td class="bz-edit-data-value" colspan="4">
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
			<td class="bz-edit-data-title" width="40%" style="text-align: center;" colspan="2"><b>��������</b></td>
			<td class="bz-edit-data-title" width="40%" style="text-align: center;" colspan="2"><b>Ů������</b></td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����</td>
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
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">�ܽ������</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_EDUCATION" defaultValue="" onlyValue="true" codeName="ADOPTER_EDU"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">ְҵ</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����״��</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_HEALTH" defaultValue="" onlyValue="true" codeName="ADOPTER_HEALTH"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">Υ����Ϊ�����´���</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">���޲����Ⱥ�</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" defaultValue="" onlyValue="true" checkValue="0=��;1=��;"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">������</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
			<td class="bz-edit-data-value" colspan="2">
				<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ���ʲ�</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ��ծ�� </td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ���ʲ�</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="TOTAL_NET_ASSETS" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����״��</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="" defaultValue="�ѻ�"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">�������</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="MARRY_DATE" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">δ������Ů����</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��Ů���������</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">��ͥ��ַ</td>
			<td class="bz-edit-data-value" colspan="4">
				<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">����Ҫ��</td>
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
