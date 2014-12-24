<%
/**   
 * @Title: Application.jsp
 * @Description: 申请书
 * @author xugy
 * @date 2014-12-2下午3:43:34
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
<BZ:head>
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
	<table style="text-align: center;margin-top: 2cm;width: 21cm;" align="center">
		<tr>
			<td style="font-size: 36pt;">
				收 养 登 记 表
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;padding-top: 0.3cm;">
				APPLICATION  FOR  ADOPTION  REGISTRATION
			</td>
		</tr>
		<tr>
			<td style="padding-top: 1.2cm;">
				<table style="width: 5.54cm;height: 3.76cm;text-align: center;">
					<tr>
						<td style="border: 1px black solid;font-size: 14pt;">
						收养人与被收养人的合影照片<br/>(Photo of the adoptive parents with adoptee)
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td style="font-size: 14pt;padding-top: 3.4cm;">
				收养证字号：
				<span style="text-decoration: underline;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</span>
			</td>
		</tr>
		<tr>
			<td style="padding-top: 4.6cm;text-align: left;">
				<table style="margin-left: 6cm;">
					<tr>
						<td style="font-size: 14pt;">
							被收养人姓名
						</td>
					</tr>
					<tr>
						<td style="padding-top: 0.6cm;font-size: 14pt;">
							Child's Name
							<span style="text-decoration: underline;">
								&nbsp;&nbsp;<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
							</span>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 1.7cm;font-size: 14pt;">
							登&nbsp;记&nbsp;日&nbsp;期：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<h1>&nbsp;</h1>
	<table style="margin-top: 2cm;width: 15cm;" align="center">
		<tr>
			<td style="font-size: 18pt;text-align: center;">
				说&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;明
			</td>
		</tr>
		<tr>
			<td style="font-size: 12pt;line-height: 25pt;padding-top: 1cm;">
				&nbsp;&nbsp;&nbsp;&nbsp;收养登记申请书中收养人情况表、送养人情况表、被收养人情况表及收养登记审批表中部分内容可以通过信息系统打印带出，若要手工填写，请参照以下填写说明：<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;一、填写收养人情况表的说明<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;1、“身份证件号”栏填写申请收养人护照号或其他有效身份证件号。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;2、“健康状况”栏填写“健康”、“患病”、“残障”。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;3、“婚姻状况”栏填写“已婚”、“未婚”、 “离异”、“丧偶”。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;4、“经济状况”栏填写申请收养人全年收入总和。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;5、“子女情况”栏填写子女数量，包括继子女、养子女、现已不在一起共同生活的子女。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;二、填写送养人情况表的说明<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;1、送养人情况由送养人如实填写。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;2、送养人是福利机构的，由法人代表在“送养人或福利机构意见”栏内签署意见。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;三、填写被收养人情况表的说明<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;1、被收养人情况表由送养人或福利机构如实填写。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;2、“身体状况”栏填写“正常”、“特需”。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;四、填写收养登记审批表的说明<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;1、收养登记审批表由收养登记受理单位如实填写。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;2、被收养人情况栏中的“身体状况”填写“正常”、“特需”。<br/>
			</td>
		</tr>
	</table>
	<h1>&nbsp;</h1>
	<table style="margin-top: 1.5cm;width: 18cm;" align="center">
		<tr>
			<td style="font-size: 18pt;text-align: center;">
				收&nbsp;&nbsp;&nbsp;养&nbsp;&nbsp;&nbsp;登&nbsp;&nbsp;&nbsp;记&nbsp;&nbsp;&nbsp;申&nbsp;&nbsp;&nbsp;请
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;text-align: center;padding-top: 0.4cm;">
				APPLICATION  LETTER
			</td>
		</tr>
		<tr>
			<td style="padding-top: 0.2cm;">
				<table style="border: 1px black solid;font-size: 12pt;">
					<tr>
						<td style="line-height: 25px;" colspan="4">
							&nbsp;&nbsp;&nbsp;&nbsp;内容包括：收养目的、不遗弃不虐待被收养人和抚育被收养人健康成长的保证及其他有关事项。（Including: purpose of adoption, promise to never abandon or abuse the child and commitment to provide the child with a healthy growth environment, etc.）<br/>
							<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
							<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
							<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;本人申请内容完全真实，如有虚假，愿承担法律责任。（I hereby certify that all details in this application are truthfully presented and in case of any falsehood, I commit to undertake the corresponding legal responsibilities.）
						</td>
					</tr>
					<tr style="height: 4cm;">
						<td>
							<table style="border: 1px black solid;height: 3cm;width: 2.5cm;margin-left: 0.3cm;">
								<tr>
									<td style="text-align: center;">
										贴相片处<br/>Photo(father)
									</td>
								</tr>
							</table>
						</td>
						<td>
							申请收养人签名（男）：<br/>
							Signature（father）<br/><br/><br/><br/><br/>
							<span style="text-decoration: underline;">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</span>
						</td>
						<td>
							<table style="border: 1px black solid;height: 3cm;width: 2.5cm;margin-left: 0.3cm;">
								<tr>
									<td style="text-align: center;">
										贴相片处<br/>Photo(mother)
									</td>
								</tr>
							</table>
						</td>
						<td>
							申请收养人签名（女）：<br/>
							Signature（mother）<br/><br/><br/><br/><br/>
							<span style="text-decoration: underline;">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</span>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="padding-left: 1cm;padding-top: 2cm;padding-bottom: 0.6cm;">
							日期(Date)：
						</td>
						<td colspan="2" style="padding-left: 1cm;padding-top: 2cm;padding-bottom: 0.6cm;">
							日期(Date)：
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<h1>&nbsp;</h1>
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
	<h1>&nbsp;</h1>
	<table style="margin-top: 1.5cm;width: 18cm;" align="center">
		<tr>
			<td style="font-size: 18pt;text-align: center;">
				送&nbsp;&nbsp;&nbsp;养&nbsp;&nbsp;&nbsp;人&nbsp;&nbsp;&nbsp;情&nbsp;&nbsp;&nbsp;况
			</td>
		</tr>
		<tr>
			<td style="padding-top: 0.6cm;">
				<table class="table-print-s4" style="font-size: 12pt;">
					<tr style="height: 2cm;">
						<td style="text-align: center;width: 18%;border: 1px black solid;">
							送养人姓名/福利机构名称
						</td>
						<td style="width: 82%;border: 1px black solid;" colspan="5">
							<BZ:dataValue field="SENDER" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 2cm;">
						<td style="text-align: center;border: 1px black solid;">
							送养人/福利机构地址
						</td>
						<td style="border: 1px black solid;" colspan="5">
							<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 2cm;">
						<td style="text-align: center;border: 1px black solid;">
							被送养人姓名
						</td>
						<td style="border: 1px black solid;width: 15%;">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;width: 20%;border: 1px black solid;">
							被送养人性别
						</td>
						<td style="border: 1px black solid;width: 9%;">
							<BZ:dataValue field="SEX_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;width: 16%;border: 1px black solid;">
							被送养人出生日期
						</td>
						<td style="border: 1px black solid;width: 22%;">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr style="height: 2cm;">
						<td style="text-align: center;border: 1px black solid;">
							经办人姓名
						</td>
						<td style="border: 1px black solid;" colspan="3">
							<BZ:dataValue field="CONTACT_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;border: 1px black solid;">
							经办人职务
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="CONTACT_JOB" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 2cm;">
						<td style="text-align: center;border: 1px black solid;">
							经办人身份证件号
						</td>
						<td style="border: 1px black solid;" colspan="3">
							<BZ:dataValue field="CONTACT_CARD" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;border: 1px black solid;">
							经办人联系电话
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="CONTACT_TEL" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: center;border: 1px black solid;">
							送养人或福利机构意见
						</td>
						<td style="border: 1px black solid;" colspan="5">
							<br/>(包括送养原因和是否同意由申请收养人收养的意见)<br/><br/><br/><br/><br/><br/><br/><br/>
							<br/><br/><br/><br/><br/><br/><br/><br/><br/>
							签字（按指印）：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							盖章：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							年&nbsp;&nbsp;&nbsp;&nbsp;
							月&nbsp;&nbsp;&nbsp;&nbsp;
							日<br/>&nbsp;
						</td>
					</tr>
					<tr>
						<td style="text-align: center;border: 1px black solid;">
							社会福利机构业务主管机关 签字、盖章
						</td>
						<td style="border: 1px black solid;" colspan="5">
							<br/><br/><br/><br/><br/><br/><br/><br/><br/>
							<br/><br/><br/><br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							年&nbsp;&nbsp;&nbsp;&nbsp;
							月&nbsp;&nbsp;&nbsp;&nbsp;
							日<br/>&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<h1>&nbsp;</h1>
	<table style="margin-top: 1.5cm;width: 18cm;" align="center">
		<tr>
			<td style="font-size: 18pt;text-align: center;">
				被&nbsp;&nbsp;&nbsp;收&nbsp;&nbsp;&nbsp;养&nbsp;&nbsp;&nbsp;人&nbsp;&nbsp;&nbsp;情&nbsp;&nbsp;&nbsp;况
			</td>
		</tr>
		<tr>
			<td style="padding-top: 0.6cm;">
				<table class="table-print-s4" style="font-size: 12pt;">
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 10%;border: 1px black solid;">
							姓 名
						</td>
						<td style="width: 30%;border: 1px black solid;">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;width: 10%;border: 1px black solid;">
							性 别
						</td>
						<td style="width: 30%;border: 1px black solid;">
							<BZ:dataValue field="SEX_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;width: 20%;border: 1px black solid;" rowspan="3">
							贴 相 片
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;" colspan="2">
							出 生 日 期
						</td>
						<td style="border: 1px black solid;" colspan="2">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;" colspan="2">
							身 体 状 况
						</td>
						<td style="border: 1px black solid;" colspan="2">
							<BZ:dataValue field="SN_TYPE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: center;border: 1px black solid;">
							类别
						</td>
						<td style="border: 1px black solid;" colspan="4">
							<br/>
							<input type="checkbox" <%if("10".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>查找不到生父母的弃婴和儿童<br/>
							<input type="checkbox" <%if("201".equals(CHILD_IDENTITY) || "202".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>丧失父母的孤儿<br/>
							<input type="checkbox" <%if("301".equals(CHILD_IDENTITY) || "302".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>生父母有特殊困难无力抚养的子女<br/>
							<input type="checkbox" <%if("40".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>三代以内同辈旁系血亲的子女<br/>
							<input type="checkbox" <%if("50".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>继子女<br/>
							<input type="checkbox" <%if("60".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>依法撤销生父母监护资格的儿童<br/>
							<br/>（划√表示）<br/>&nbsp;
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;" colspan="3">
							年满十周岁的被收养人意见
						</td>
						<td style="text-align: center;border: 1px black solid;" colspan="2">
							未满十周岁的被收养人按手（足）印
						</td>
					</tr>
					<tr>
						<td style="border: 1px black solid;" colspan="3">
							<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
							<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
							&nbsp;签&nbsp;&nbsp;名：<br/><br/>
							&nbsp;按指印：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日
							<br/><br/>&nbsp;
						</td>
						<td style="border: 1px black solid;" colspan="2">
							
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;">
							备注
						</td>
						<td style="border: 1px black solid;" colspan="4">
							年满10周岁的被收养人询问内容包括：在明确收养后果的前提下，是否自愿同意被收养人收养的明确意思表示。
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<h1>&nbsp;</h1>
	<table style="margin-top: 1.5cm;width: 18cm;" align="center">
		<tr>
			<td style="font-size: 18pt;text-align: center;">
				询&nbsp;&nbsp;问&nbsp;&nbsp;收&nbsp;&nbsp;养&nbsp;&nbsp;人&nbsp;&nbsp;笔&nbsp;&nbsp;录
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;text-align: center;padding-top: 0.4cm;">
				INTERVIEW RECORD OF ADOPTIVE PARENTS
			</td>
		</tr>
		<tr>
			<td style="padding-top: 0.6cm;">
				<table class="table-print-s4" style="font-size: 12pt;">
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 16%;border: 1px black solid;">
							询 问 时 间
						</td>
						<td style="width: 26%;border: 1px black solid;">
						
						</td>
						<td style="text-align: center;width: 16%;border: 1px black solid;">
							询 问 地 点
						</td>
						<td style="width: 42%;border: 1px black solid;">
						
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;">
							询问人姓名
						</td>
						<td style="border: 1px black solid;">
						
						</td>
						<td style="text-align: center;border: 1px black solid;">
							询问人单位
						</td>
						<td style="border: 1px black solid;">
						
						</td>
					</tr>
					<tr>
						<td style="border: 1px black solid;padding-left: 0.2cm;line-height: 30px;" colspan="4" >
							<br/>
							询问收养人内容：<br/>
							Questions:<br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;1.依照《中华人民共和国收养法》的有关规定，请问你们是否自愿收养&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;为养子、女？是否经过慎重考虑？<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;Do you wish to adopt xxxx as your daughter/son out of free will according to the regulations of the Adoption Law of People's Republic of China? Have you given the adoption a serious deliberation?<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;答：Yes<input type="checkbox"/> &nbsp;&nbsp;&nbsp;&nbsp;No<input type="checkbox"/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;2.为什么来中国收养孩子？<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;Why do you want to adopt from China?<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;答：<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;3.你们收养后能否提供良好的教育并保证不遗弃、不虐待该孩子？<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;Do you promise to provide the child with a good education after adoption and never to abandon or abuse the child?<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;答：Yes<input type="checkbox"/> &nbsp;&nbsp;&nbsp;&nbsp;No<input type="checkbox"/><br/><br/>&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<h1>&nbsp;</h1>
	<table class="table-print-s4" style="margin-top: 1.5cm;width: 18cm;font-size: 12pt;" align="center">
		<tr>
			<td style="border: 1px black solid;padding-left: 0.2cm;line-height: 30px;">
				<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;4.经过融合，你们认为孩子的情况与福利机构所介绍的情况是否一致？<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;Do you think the situation of the adoptee is consistent with that introduced by the welfare institution?<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;答：Yes<input type="checkbox"/> &nbsp;&nbsp;&nbsp;&nbsp;No<input type="checkbox"/><br/><br/>
				&nbsp;&nbsp;&nbsp;&nbsp;5.其他 Others<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
				<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
				本人已阅读询问笔录，与本人所表示的意思一致。<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;(I understand the interview written notes, the contents is consistent with what I meant to say or with my interpretation.)<br/><br/>
				被询问人签名：Male&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				记录人：<br/>
				(Signature) Female
				
			</td>
		</tr>
	</table>
	<h1>&nbsp;</h1>
	<table style="margin-top: 1.5cm;width: 18cm;" align="center">
		<tr>
			<td style="font-size: 18pt;text-align: center;">
				询&nbsp;&nbsp;问&nbsp;&nbsp;送&nbsp;&nbsp;养&nbsp;&nbsp;人&nbsp;&nbsp;笔&nbsp;&nbsp;录
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;text-align: center;padding-top: 0.4cm;">
				（非福利机构送养填写）
			</td>
		</tr>
		<tr>
			<td style="padding-top: 0.6cm;">
				<table class="table-print-s4" style="font-size: 12pt;">
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 16%;border: 1px black solid;">
							询 问 时 间
						</td>
						<td style="width: 26%;border: 1px black solid;">
						
						</td>
						<td style="text-align: center;width: 16%;border: 1px black solid;">
							询 问 地 点
						</td>
						<td style="width: 42%;border: 1px black solid;">
						
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;">
							询问人姓名
						</td>
						<td style="border: 1px black solid;">
						
						</td>
						<td style="text-align: center;border: 1px black solid;">
							询问人单位
						</td>
						<td style="border: 1px black solid;">
						
						</td>
					</tr>
					<tr>
						<td style="border: 1px black solid;padding-left: 0.2cm;line-height: 30px;" colspan="4" >
							<br/>
							询问送养人内容：<br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;1.姓名？<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;答：<br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;2.职业？<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;答：<br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;3.送养人与被送养人关系？<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;答：<br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;4.是否自愿送养?<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;答：<br/><br/><br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;本人已阅读询问笔录，与本人所表示的意思一致。<br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;被询问人签名：<br/><br/><br/>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<h1>&nbsp;</h1>
	<table style="margin-top: 1.5cm;width: 18cm;" align="center">
		<tr>
			<td style="font-size: 18pt;text-align: center;">
				收&nbsp;&nbsp;养&nbsp;&nbsp;登&nbsp;&nbsp;记&nbsp;&nbsp;审&nbsp;&nbsp;批&nbsp;&nbsp;表
			</td>
		</tr>
		<tr>
			<td style="padding-top: 0.6cm;">
				<table class="table-print-s4" style="font-size: 12pt;">
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 8%;border: 1px black solid;" rowspan="3">
							收 养 人 情 况
						</td>
						<td style="text-align: center;width: 15%;border: 1px black solid;" colspan="2">
							姓名
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="3">
							男：<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="2">
							女：<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 15%;border: 1px black solid;" colspan="2">
							出 生 日 期
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="3">
							<BZ:dataValue field="MALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="2">
							<BZ:dataValue field="FEMALE_BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 15%;border: 1px black solid;" colspan="2">
							国       籍
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="3">
							<BZ:dataValue field="MALE_NATION_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="2">
							<BZ:dataValue field="FEMALE_NATION_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 8%;border: 1px black solid;" rowspan="2">
							送 养 人 情 况
						</td>
						<td style="text-align: center;width: 15%;border: 1px black solid;" colspan="2">
							姓名/福利机构名称
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="5">
							<BZ:dataValue field="SENDER" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 15%;border: 1px black solid;" colspan="2">
							送养人/福利机构地址
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="5">
							<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 8%;border: 1px black solid;" rowspan="3">
							被 收 养 人 情 况
						</td>
						<td style="text-align: center;width: 15%;border: 1px black solid;" colspan="2">
							姓名
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;width: 15%;border: 1px black solid;">
							性别
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;">
							<BZ:dataValue field="SEX_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;width: 15%;border: 1px black solid;">
							出生日期
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 15%;border: 1px black solid;" colspan="2">
							身 体 状 况
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="5">
							<BZ:dataValue field="SN_TYPE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 8%;border: 1px black solid;">
							被 收 养 人 类 别
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="6">
							<br/>
							<input type="checkbox" <%if("10".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>查找不到生父母的弃婴和儿童<br/>
							<input type="checkbox" <%if("201".equals(CHILD_IDENTITY) || "202".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>丧失父母的孤儿<br/>
							<input type="checkbox" <%if("301".equals(CHILD_IDENTITY) || "302".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>生父母有特殊困难无力抚养的子女<br/>
							<input type="checkbox" <%if("40".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>三代以内同辈旁系血亲的子女<br/>
							<input type="checkbox" <%if("50".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>继子女<br/>
							<input type="checkbox" <%if("60".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>依法撤销生父母监护资格的儿童<br/>
							<br/>（划√表示）<br/>&nbsp;
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;" colspan="2">
							联系收养的收养组织名称
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="6">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: center;border: 1px black solid;" colspan="2">
							提 供 证 件 和 材 料 情 况
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;line-height: 30px;" colspan="6">
							<input type="checkbox" />1.来华收养子女通知书<br/>
							<input type="checkbox" />2.涉外送养通知书<br/>
							<input type="checkbox" />3.收养协议<br/>
							<input type="checkbox" />4.融合协议<br/>
							<input type="checkbox" />5.捐赠协议<br/>
							<input type="checkbox" />6.送养法人身份证件<br/>
							<input type="checkbox" />7.护照复印件<br/>
							<input type="checkbox" />8.委托书（夫妻双方共同收养，一方因故不能来华的，应当书面委托另一方，委托书应当经所在国公证和认证）<br/>
							<input type="checkbox" />9.其他
							<span style="text-decoration: underline;">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</span>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<h1>&nbsp;</h1>
	<table class="table-print-s4" style="margin-top: 1.5cm;width: 18cm;font-size: 12pt;" align="center">
		<tr>
			<td style="border: 1px black solid;width: 16%;text-align: center;">
				承 办 人 审 查 意 见
			</td>
			<td style="border: 1px black solid;">
				<br/><br/><br/><br/><br/><br/><br/><br/><br/>
				<br/><br/><br/><br/><br/><br/><br/><br/><br/>
				<br/><br/><br/><br/><br/><br/><br/><br/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;经办人：
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日<br/>&nbsp;
			</td>
		</tr>
		<tr>
			<td style="border: 1px black solid;text-align: center;">
				承 办 单 位 签 字 或 盖 章
			</td>
			<td style="border: 1px black solid;">
				<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
			</td>
		</tr>
		<tr>
			<td style="border: 1px black solid;text-align: center;">
				领 导 审 批 意 见
			</td>
			<td style="border: 1px black solid;">
				<br/><br/><br/><br/><br/><br/><br/><br/><br/>
				<br/><br/><br/><br/><br/><br/><br/><br/><br/>
				<br/><br/><br/><br/><br/><br/><br/><br/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;签 &nbsp;&nbsp;字：
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日<br/>&nbsp;
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
