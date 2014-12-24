<%
/**   
 * @Title: SYZZ_Application.jsp
 * @Description: 申请书
 * @author xugy
 * @date 2014-12-15下午8:18:34
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
Data data = (Data)request.getAttribute("data");

String CHILD_IDENTITY = data.getString("CHILD_IDENTITY");
%>
<BZ:html>
<BZ:head language="EN">
	<title>收养登记申请书</title>
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
<BZ:body property="data" codeNames="HBBZ;">
<div id="PrintArea">
	<table style="margin-top: 1.5cm;width: 18cm;" align="center">
		<tr>
			<td style="font-size: 18pt;text-align: center;">
				收&nbsp;&nbsp;&nbsp;养&nbsp;&nbsp;&nbsp;人&nbsp;&nbsp;&nbsp;情&nbsp;&nbsp;&nbsp;况
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;text-align: center;padding-top: 0.4cm;">
				BASIC INFORMATION OF ADOPTIVE PARENTS
			</td>
		</tr>
		<tr>
			<td style="padding-top: 0.2cm;">
				<table class="table-print-s4" style="font-size: 12pt;">
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;width: 22%">
							姓名<br/>Name
						</td>
						<td style="border: 1px black solid;width: 39%">
							男：<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/><br/>
							Father：<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="border: 1px black solid;width: 39%">
							女：<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/><br/>
							Mother：<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							出  生  日  期<br/>Date of Birth
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							身份证件号<br/>Passport No.
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							国籍 <br/>Nationality
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="MALE_NATION_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="FEMALE_NATION_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							职业<br/>Occupation
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							文化程度<br/>Educational Level
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="MALE_EDUCATION_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="FEMALE_EDUCATION_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							健康状况<br/>Health State
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="MALE_HEALTH_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="FEMALE_HEALTH_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							婚姻状况<br/>Martial Status
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="MALE_MARRY_CONDITION" defaultValue="" onlyValue="true"/>
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="FEMALE_MARRY_CONDITION" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							工作单位<br/>Employer
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="" defaultValue="" onlyValue="true"/>
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							子女情况<br/>Off Spring Info.
						</td>
						<td style="border: 1px black solid;" colspan="2">
							<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							经济状况<br/>Annual Income
						</td>
						<td style="border: 1px black solid;" colspan="2">
							总资产:<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
							总债务:<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
							净资产:<BZ:dataValue field="TOTAL_RESULT" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							现住址<br/>Current Address
						</td>
						<td style="border: 1px black solid;" colspan="2">
							<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							联系收养的收养组织名称<br/>Adoption Agency
						</td>
						<td style="border: 1px black solid;" colspan="2">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 2cm;">
						<td style="border: 1px black solid;text-align: center;">
							签字<br/>Signature
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="" defaultValue="" onlyValue="true"/>
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
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
