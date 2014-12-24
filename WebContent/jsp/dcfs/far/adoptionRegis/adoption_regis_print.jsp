<%
/**   
 * @Title: adoption_regis_print.jsp
 * @Description: �ǼǴ�ӡ�Ǽ�֤
 * @author xugy
 * @date 2014-11-14����11:15:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data = (Data)request.getAttribute("data");
String ADREG_NO = data.getString("ADREG_NO","");
String number = "";
if(!"".equals(ADREG_NO) && ADREG_NO.length()==12){
    number = ADREG_NO.substring(0, 2)+"-"+ADREG_NO.substring(2, 4)+"-"+ADREG_NO.substring(4, 8)+"-"+ADREG_NO.substring(8, 12);
}
String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT","");
String MALE_NAME = data.getString("MALE_NAME","");
String FEMALE_NAME = data.getString("FEMALE_NAME","");
%>
<BZ:html>
<BZ:head>
	<title>�������ӡԤ��</title>
	<BZ:webScript edit="true"/>
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/jquery.jqprint.js"></script>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});

//����
function _print(){
	$("#PrintArea").jqprint(); 
}
//����
function _goback(){
	document.srcForm.action=path+"adoptionRegis/adoptionRegisList.action";
	document.srcForm.submit();
}
</script>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<div id="PrintArea">
	<table style="width: 18cm;font-size: 10.5pt" align="center">
		<tr>
			<td style="font-size: 18pt;text-align: center;" colspan="2">
				�л����񹲺͹������Ǽ�֤
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;text-align: center;" colspan="2">
				�����������
			</td>
		</tr>
		<tr>
			<td style="font-size: 12pt;text-align: center;" colspan="2">
				CERTIFICATE OF INTERCOUNTRY ADOPTION <br/>OF THE PEOPLE'S REPUBLIC OF CHINA
			</td>
		</tr>
		<tr>
			<td style="text-align: right;" colspan="2">
				<%
				if("".equals(ADREG_NO)){
				%>
				X1X2-X3X4-X5X6X7X8-X9X10X11X12
				<%
				}else{
				%>
				<%=number %>
				<%} %>
			</td>
		</tr>
		<tr>
			<td style="width: 50%;padding-top: 0.5cm;">
				������������/Name of Adoptee :<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/><br/><br/>
				�����������Ϊ/Name After Adoption :<BZ:dataValue field="CHILD_NAME_EN" defaultValue="" onlyValue="true"/><br/><br/>
				�Ա�/Sex : <BZ:dataValue field="SEX_NAME" defaultValue="" onlyValue="true"/><br/><br/>
				��������/DOB(yyyy-mm-dd) :<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/><br/><br/>
			</td>
			<td style="width: 50%;text-align: right;padding-right: 0.2cm;vertical-align: top;padding-top: 0.5cm;">
				<table class="table-print-s5" style="width: 75%;border: 1px black solid;">
					<tr>
						<td style="border: 1px black solid;height: 3cm;text-align: center;">
							�������뱻������<br/><br/>��Ӱ��Ƭ<br/><br/>����Ƭ�ϼӸ������Ǽ�ר���µĸ�ӡ��
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				���/Identity :<BZ:dataValue field="CHILD_IDENTITY_NAME" defaultValue="" onlyValue="true"/><br/><br/>
				
			</td>
		</tr>
		<tr>
			<td colspan="2">
				���֤����/ID No :<BZ:dataValue field="ID_CARD" defaultValue="" onlyValue="true"/><br/><br/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				����������(����)/The Person (Institution) Placing the Child for Adoption : <BZ:dataValue field="SENDER" defaultValue="" onlyValue="true"/><br/><br/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				סַ/Residential address :<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true"/><br/><br/><br/>
			</td>
		</tr>
		<tr>
			<td>
				������������/Name of Adoptive Father :
			</td>
			<td>
				����ĸ������/Name of Adoptive Mother :
			</td>
		</tr>
		<tr>
			<td style="vertical-align: top;">
				<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td style="vertical-align: top;">
				<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td>
				����/Nationality :
			</td>
			<td>
				����/Nationality :
			</td>
		</tr>
		<tr>
			<td style="vertical-align: top;">
				<BZ:dataValue field="MALE_NATION_NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td style="vertical-align: top;">
				<BZ:dataValue field="FEMALE_NATION_NAME" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td>
				��������/DOB(yyyy-mm-dd) :
			</td>
			<td>
				��������/DOB(yyyy-mm-dd) :
			</td>
		</tr>
		<tr>
			<td style="vertical-align: top;">
				<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td style="vertical-align: top;">
				<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
		</tr>
		<tr>
			<td>
				���֤����/ID No :
			</td>
			<td>
				���֤����/ID No :
			</td>
		</tr>
		<tr>
			<td style="vertical-align: top;">
				<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/><br/><br/>
			</td>
			<td style="vertical-align: top;">
				<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/><br/><br/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				סַ/Residential address :<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/><br/><br/>
			</td>
		</tr>
		<tr>
			<td style="line-height: 25px;" colspan="2">
				&nbsp;&nbsp;&nbsp;&nbsp;����飬�����������ϡ��л����񹲺͹����������Ĺ涨��׼��Ǽǣ�������ϵ�ԵǼ�֮���������<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;The above adoption is approved in accordance with the requirements stipulated in Adoption Law of the People's Republic of China. Adoption registration is hereby permitted and the adoption relationship shall come into force on the date of its registration.<br/>
			</td>
		</tr>
		<tr>
			<td style="text-align: right;line-height: 25px;" colspan="2">
				���Ǽǻ��ع��� Registration Authority��<br/>
				��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��
			</td>
		</tr>
		<tr>
			<td colspan="2">
				�Ǽ�Ա Registrar��<br/>
				��עNote:<br/>
				��Ӣ�����в��죬������Ϊ׼��In case of any discrepancy between the Chinese and English version,the Chinese version shall prevail. 
			</td>
		</tr>
		<tr>
			<td style="text-align: right;padding-right: 3cm;" colspan="2">
				NO
			</td>
		</tr>
	</table>
	<%
	if("1".equals(IS_CONVENTION_ADOPT)){
	%>
	<h1>&nbsp;</h1>
	<table style="width: 18cm;font-size: 12pt" align="center">
		<tr>
			<td style="font-size: 15pt;text-align: center;">
				�л����񹲺͹���������ϸ�֤��
			</td>
		</tr>
		<tr>
			<td style="font-size: 9.5pt;text-align: center;">
				CERTIFICATE OF CONFORMITY OF INTERCOUNTRY ADOPTION<br/><br/>
			</td>
		</tr>
		<tr>
			<td style="line-height: 30px;">
				&nbsp;&nbsp;&nbsp;&nbsp;����ǩ�»����ڴ�֤���л����񹲺͹������Ǽ�֤�����������������֤�ֺţ�<BZ:dataValue field="ADREG_NO" defaultValue="&nbsp;&nbsp;&nbsp;&nbsp;" onlyValue="true"/>��
				��ȷ����
				<%
				if("".equals(MALE_NAME)){
				%>
				<span style="text-decoration: underline;"><BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/></span>
				<%
				}else if("".equals(FEMALE_NAME)){
				%>
				<span style="text-decoration: underline;"><BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/></span>
				<%
				}else{
				%>
				<span style="text-decoration: underline;"><BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/></span> & 
				<span style="text-decoration: underline;"><BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/></span> 
				<%} %>
				��<span style="text-decoration: underline;"><BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/></span>
				���������ϡ�����������汣����ͯ��������Լ����23���Ĺ涨��<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;The undersigned authority hereby certifies that the adoption of
				<span style="text-decoration: underline;"><BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/></span> by 
				<%
				if("".equals(MALE_NAME)){
				%>
				<span style="text-decoration: underline;"><BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/></span>
				<%
				}else if("".equals(FEMALE_NAME)){
				%>
				<span style="text-decoration: underline;"><BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/></span>
				<%
				}else{
				%>
				<span style="text-decoration: underline;"><BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/></span> & 
				<span style="text-decoration: underline;"><BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/></span> 
				<%} %>
				confirmed by the Certificate of Intercountry Adoption (No.<BZ:dataValue field="ADREG_NO" defaultValue="&nbsp;&nbsp;&nbsp;&nbsp;" onlyValue="true"/>) 
				is in accordance with the requirements of Article 23 of the Hague Convention on Protection of Children and Cooperation in Respect of Intercountry Adoption.<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;���ݡ�����������汣����ͯ��������Լ����17��C��й���ͯ�������������ģ���ַ���й������ж���������԰��ͬ16���й���ͯ�������ã���
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_NOTICE_DATE_YEAR" defaultValue="" onlyValue="true"/></span>��
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_NOTICE_DATE_MONTH" defaultValue="" onlyValue="true"/></span>��
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_NOTICE_DATE_DAY" defaultValue="" onlyValue="true"/></span>���������þ���������������������غ������������<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;In accordance with Article 17-C of the Hague Convention, China Centre for Children's Welfare and Adoption (Address: Chinese Child Welfare Plaza, No. 16, Wangjiayuan Lane, Dongcheng District, Beijing, China) gave its agreement and solicited the agreement of the Central Authority of the receiving State and adoptive parent(s) on 
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_NOTICE_DATE" defaultValue="" onlyValue="true"/></span>.<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_GOV_CN" defaultValue="" onlyValue="true"/></span>��
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_FEEDBACK_DATE_YEAR" defaultValue="" onlyValue="true"/></span>��
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_FEEDBACK_DATE_MONTH" defaultValue="" onlyValue="true"/></span>��
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_FEEDBACK_DATE_DAY" defaultValue="" onlyValue="true"/></span>��ǩ����ͬ�������������<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_GOV_EN" defaultValue="" onlyValue="true"/></span> 
				signed the agreement on <span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_FEEDBACK_DATE" defaultValue="" onlyValue="true"/></span>.<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;�й���ͯ���������������ڵõ�ͬ���������������
				<span style="text-decoration: underline;"><BZ:dataValue field="NOTICE_SIGN_DATE_YEAR" defaultValue="" onlyValue="true"/></span>��
				<span style="text-decoration: underline;"><BZ:dataValue field="NOTICE_SIGN_DATE_MONTH" defaultValue="" onlyValue="true"/></span>��
				<span style="text-decoration: underline;"><BZ:dataValue field="NOTICE_SIGN_DATE_DAY" defaultValue="" onlyValue="true"/></span>��ǩ���ˡ���������֪ͨ�顷��<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;On receiving the agreement, China Centre for Children's Welfare and Adoption issued the Notice of Travelling to China for Adoption on 
				<span style="text-decoration: underline;"><BZ:dataValue field="NOTICE_SIGN_DATE" defaultValue="" onlyValue="true"/></span>.<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-decoration: underline;"><BZ:dataValue field="ADREG_ORG_CN" defaultValue="" onlyValue="true"/></span>��
				<span style="text-decoration: underline;"><BZ:dataValue field="ADREG_DATE_YEAR" defaultValue="" onlyValue="true"/></span>��
				<span style="text-decoration: underline;"><BZ:dataValue field="ADREG_DATE_MONTH" defaultValue="" onlyValue="true"/></span>��
				<span style="text-decoration: underline;"><BZ:dataValue field="ADREG_DATE_DAY" defaultValue="" onlyValue="true"/></span>����
				<span style="text-decoration: underline;"><BZ:dataValue field="CITY_ADDRESS_CN" defaultValue="" onlyValue="true"/></span>Ϊ�������������˵Ǽǡ�<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-decoration: underline;"><BZ:dataValue field="ADREG_ORG_EN" defaultValue="" onlyValue="true"/></span> 
				performed adoption registration on <span style="text-decoration: underline;"><BZ:dataValue field="ADREG_DATE" defaultValue="" onlyValue="true"/></span> 
				in <span style="text-decoration: underline;"><BZ:dataValue field="CITY_ADDRESS_EN" defaultValue="" onlyValue="true"/></span>.
			</td>
		</tr>
		<tr>
			<td style="text-align: right;">
				�Ǽǻ��ع��� Registration Authority (seal)<br/><br/><br/>
			</td>
		</tr>
		<tr>
			<td>
				��עNote:��Ӣ�����в��죬������Ϊ׼��In case of any discrepancy between the Chinese and English version, the Chinese version shall prevail.
			</td>
		</tr>
	</table>
	<%} %>
</div>
<div class="bz-action-frame">
	<div class="bz-action-edit" desc="��ť��">
		<input type="button" value="��&nbsp;&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="_print()" />&nbsp;
		<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
	</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>
