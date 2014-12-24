<%
/**   
 * @Title: AZB_adoption_registration.jsp
 * @Description: 收养登记证
 * @author xugy
 * @date 2014-12-7下午6:56:34
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
	<title>收养登记证</title>
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
	<table style="width: 18cm;font-size: 10.5pt" align="center">
		<tr>
			<td style="font-size: 18pt;text-align: center;" colspan="2">
				中华人民共和国收养登记证
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;text-align: center;" colspan="2">
				（跨国收养）
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
				被收养人姓名/Name of Adoptee :<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/><br/><br/>
				被收养后改名为/Name After Adoption :<BZ:dataValue field="CHILD_NAME_EN" defaultValue="" onlyValue="true"/><br/><br/>
				性别/Sex : <BZ:dataValue field="SEX_NAME" defaultValue="" onlyValue="true"/><br/><br/>
				出生日期/DOB(yyyy-mm-dd) :<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/><br/><br/>
			</td>
			<td style="width: 50%;text-align: right;padding-right: 0.2cm;vertical-align: top;padding-top: 0.5cm;">
				<table class="table-print-s5" style="width: 75%;border: 1px black solid;">
					<tr>
						<td style="border: 1px black solid;height: 3cm;text-align: center;">
							收养人与被收养人<br/><br/>合影照片<br/><br/>（照片上加盖收养登记专用章的钢印）
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				身份/Identity :<BZ:dataValue field="CHILD_IDENTITY_NAME" defaultValue="" onlyValue="true"/><br/><br/>
				
			</td>
		</tr>
		<tr>
			<td colspan="2">
				身份证件号/ID No :<BZ:dataValue field="ID_CARD" defaultValue="" onlyValue="true"/><br/><br/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				送养人姓名(名称)/The Person (Institution) Placing the Child for Adoption : <BZ:dataValue field="SENDER" defaultValue="" onlyValue="true"/><br/><br/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				住址/Residential address :<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true"/><br/><br/><br/>
			</td>
		</tr>
		<tr>
			<td>
				收养父亲姓名/Name of Adoptive Father :
			</td>
			<td>
				收养母亲姓名/Name of Adoptive Mother :
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
				国籍/Nationality :
			</td>
			<td>
				国籍/Nationality :
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
				出生日期/DOB(yyyy-mm-dd) :
			</td>
			<td>
				出生日期/DOB(yyyy-mm-dd) :
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
				身份证件号/ID No :
			</td>
			<td>
				身份证件号/ID No :
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
				住址/Residential address :<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/><br/><br/>
			</td>
		</tr>
		<tr>
			<td style="line-height: 25px;" colspan="2">
				&nbsp;&nbsp;&nbsp;&nbsp;经审查，以上收养符合《中华人民共和国收养法》的规定，准予登记，收养关系自登记之日起成立。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;The above adoption is approved in accordance with the requirements stipulated in Adoption Law of the People's Republic of China. Adoption registration is hereby permitted and the adoption relationship shall come into force on the date of its registration.<br/>
			</td>
		</tr>
		<tr>
			<td style="text-align: right;line-height: 25px;" colspan="2">
				（登记机关公章 Registration Authority）<br/>
				年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日
			</td>
		</tr>
		<tr>
			<td colspan="2">
				登记员 Registrar：<br/>
				备注Note:<br/>
				中英文如有差异，以中文为准。In case of any discrepancy between the Chinese and English version,the Chinese version shall prevail. 
			</td>
		</tr>
		<tr>
			<td style="text-align: right;padding-right: 3cm;" colspan="2">
				NO
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
