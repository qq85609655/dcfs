<%
/**   
 * @Title: AZB_intercountry_adoption.jsp
 * @Description: 登记证
 * @author xugy
 * @date 2014-12-7下午7:03:34
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
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
	<title>跨国收养合格证明</title>
	<BZ:webScript edit="true"/>
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/jquery.jqprint.js"></script>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
function _print(){
	$("#PrintArea").jqprint(); 
}
</script>
<BZ:body property="data">
<div id="PrintArea">
	<table style="width: 18cm;font-size: 12pt" align="center">
		<tr>
			<td style="font-size: 15pt;text-align: center;">
				中华人民共和国跨国收养合格证明
			</td>
		</tr>
		<tr>
			<td style="font-size: 9.5pt;text-align: center;">
				CERTIFICATE OF CONFORMITY OF INTERCOUNTRY ADOPTION<br/><br/>
			</td>
		</tr>
		<tr>
			<td style="line-height: 30px;">
				&nbsp;&nbsp;&nbsp;&nbsp;以下签章机关在此证明中华人民共和国收养登记证（跨国收养）（收养证字号：<BZ:dataValue field="ADREG_NO" defaultValue="&nbsp;&nbsp;&nbsp;&nbsp;" onlyValue="true"/>）
				所确立的
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
				对<span style="text-decoration: underline;"><BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/></span>
				的收养符合《跨国收养方面保护儿童及合作公约》第23条的规定。<br/>
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
				&nbsp;&nbsp;&nbsp;&nbsp;根据《跨国收养方面保护儿童及合作公约》第17条C款，中国儿童福利和收养中心（地址：中国北京市东城区王家园胡同16号中国儿童福利大厦）于
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_NOTICE_DATE_YEAR" defaultValue="" onlyValue="true"/></span>年
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_NOTICE_DATE_MONTH" defaultValue="" onlyValue="true"/></span>月
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_NOTICE_DATE_DAY" defaultValue="" onlyValue="true"/></span>日做出安置决定并征求收养国中央机关和收养人意见。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;In accordance with Article 17-C of the Hague Convention, China Centre for Children's Welfare and Adoption (Address: Chinese Child Welfare Plaza, No. 16, Wangjiayuan Lane, Dongcheng District, Beijing, China) gave its agreement and solicited the agreement of the Central Authority of the receiving State and adoptive parent(s) on 
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_NOTICE_DATE" defaultValue="" onlyValue="true"/></span>.<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_GOV_CN" defaultValue="" onlyValue="true"/></span>于
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_FEEDBACK_DATE_YEAR" defaultValue="" onlyValue="true"/></span>年
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_FEEDBACK_DATE_MONTH" defaultValue="" onlyValue="true"/></span>月
				<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_FEEDBACK_DATE_DAY" defaultValue="" onlyValue="true"/></span>日签署了同意收养的意见。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_GOV_EN" defaultValue="" onlyValue="true"/></span> 
				signed the agreement on <span style="text-decoration: underline;"><BZ:dataValue field="ADVICE_FEEDBACK_DATE" defaultValue="" onlyValue="true"/></span>.<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;中国儿童福利和收养中心在得到同意收养的意见后，于
				<span style="text-decoration: underline;"><BZ:dataValue field="NOTICE_SIGN_DATE_YEAR" defaultValue="" onlyValue="true"/></span>年
				<span style="text-decoration: underline;"><BZ:dataValue field="NOTICE_SIGN_DATE_MONTH" defaultValue="" onlyValue="true"/></span>月
				<span style="text-decoration: underline;"><BZ:dataValue field="NOTICE_SIGN_DATE_DAY" defaultValue="" onlyValue="true"/></span>日签发了《来华收养通知书》。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;On receiving the agreement, China Centre for Children's Welfare and Adoption issued the Notice of Travelling to China for Adoption on 
				<span style="text-decoration: underline;"><BZ:dataValue field="NOTICE_SIGN_DATE" defaultValue="" onlyValue="true"/></span>.<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-decoration: underline;"><BZ:dataValue field="ADREG_ORG_CN" defaultValue="" onlyValue="true"/></span>于
				<span style="text-decoration: underline;"><BZ:dataValue field="ADREG_DATE_YEAR" defaultValue="" onlyValue="true"/></span>年
				<span style="text-decoration: underline;"><BZ:dataValue field="ADREG_DATE_MONTH" defaultValue="" onlyValue="true"/></span>月
				<span style="text-decoration: underline;"><BZ:dataValue field="ADREG_DATE_DAY" defaultValue="" onlyValue="true"/></span>日在
				<span style="text-decoration: underline;"><BZ:dataValue field="CITY_ADDRESS_CN" defaultValue="" onlyValue="true"/></span>为该例收养办理了登记。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;<span style="text-decoration: underline;"><BZ:dataValue field="ADREG_ORG_EN" defaultValue="" onlyValue="true"/></span> 
				performed adoption registration on <span style="text-decoration: underline;"><BZ:dataValue field="ADREG_DATE" defaultValue="" onlyValue="true"/></span> 
				in <span style="text-decoration: underline;"><BZ:dataValue field="CITY_ADDRESS_EN" defaultValue="" onlyValue="true"/></span>.
			</td>
		</tr>
		<tr>
			<td style="text-align: right;">
				登记机关公章 Registration Authority (seal)<br/><br/><br/>
			</td>
		</tr>
		<tr>
			<td>
				备注Note:中英文如有差异，以中文为准。In case of any discrepancy between the Chinese and English version, the Chinese version shall prevail.
			</td>
		</tr>
	</table>
</div>
<div class="bz-action-frame">
	<div class="bz-action-edit" desc="按钮区">
		<input type="button" value="打&nbsp;&nbsp;&nbsp;印" class="btn btn-sm btn-primary" onclick="_print()" />
	</div>
</div>
</BZ:body>
</BZ:html>
