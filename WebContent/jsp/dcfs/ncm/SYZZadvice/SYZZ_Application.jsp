<%
/**   
 * @Title: SYZZ_Application.jsp
 * @Description: ������
 * @author xugy
 * @date 2014-12-15����8:18:34
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
	<title>�����Ǽ�������</title>
	<BZ:webScript edit="true"/>
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/jquery.jqprint.js"></script>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	//dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
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
				��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��
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
							����<br/>Name
						</td>
						<td style="border: 1px black solid;width: 39%">
							�У�<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/><br/>
							Father��<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="border: 1px black solid;width: 39%">
							Ů��<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/><br/>
							Mother��<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							��  ��  ��  ��<br/>Date of Birth
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
							���֤����<br/>Passport No.
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
							���� <br/>Nationality
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
							ְҵ<br/>Occupation
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
							�Ļ��̶�<br/>Educational Level
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
							����״��<br/>Health State
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
							����״��<br/>Martial Status
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
							������λ<br/>Employer
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
							��Ů���<br/>Off Spring Info.
						</td>
						<td style="border: 1px black solid;" colspan="2">
							<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							����״��<br/>Annual Income
						</td>
						<td style="border: 1px black solid;" colspan="2">
							���ʲ�:<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
							��ծ��:<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
							���ʲ�:<BZ:dataValue field="TOTAL_RESULT" defaultValue="" onlyValue="true"/><BZ:dataValue field="CURRENCY" defaultValue="" onlyValue="true" codeName="HBBZ"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							��סַ<br/>Current Address
						</td>
						<td style="border: 1px black solid;" colspan="2">
							<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="border: 1px black solid;text-align: center;">
							��ϵ������������֯����<br/>Adoption Agency
						</td>
						<td style="border: 1px black solid;" colspan="2">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 2cm;">
						<td style="border: 1px black solid;text-align: center;">
							ǩ��<br/>Signature
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
	<div class="bz-action-edit" desc="��ť��">
		<input type="button" value="��&nbsp;&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="_print()" />
	</div>
</div>
</BZ:body>
</BZ:html>
