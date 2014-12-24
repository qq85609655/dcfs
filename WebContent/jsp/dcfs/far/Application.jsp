<%
/**   
 * @Title: Application.jsp
 * @Description: ������
 * @author xugy
 * @date 2014-12-2����3:43:34
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
	<table style="text-align: center;margin-top: 2cm;width: 21cm;" align="center">
		<tr>
			<td style="font-size: 36pt;">
				�� �� �� �� ��
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
						�������뱻�����˵ĺ�Ӱ��Ƭ<br/>(Photo of the adoptive parents with adoptee)
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td style="font-size: 14pt;padding-top: 3.4cm;">
				����֤�ֺţ�
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
							������������
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
							��&nbsp;��&nbsp;��&nbsp;�ڣ�&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��
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
				˵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��
			</td>
		</tr>
		<tr>
			<td style="font-size: 12pt;line-height: 25pt;padding-top: 1cm;">
				&nbsp;&nbsp;&nbsp;&nbsp;�����Ǽ�������������������������������������������������Ǽ��������в������ݿ���ͨ����Ϣϵͳ��ӡ��������Ҫ�ֹ���д�������������д˵����<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;һ����д������������˵��<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;1�������֤���š�����д���������˻��պŻ�������Ч���֤���š�<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;2��������״��������д�������������������������ϡ���<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;3��������״��������д���ѻ顱����δ�顱�� �����족����ɥż����<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;4��������״��������д����������ȫ�������ܺ͡�<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;5������Ů���������д��Ů��������������Ů������Ů�����Ѳ���һ��ͬ�������Ů��<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;������д������������˵��<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;1���������������������ʵ��д��<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;2���������Ǹ��������ģ��ɷ��˴����ڡ������˻����������������ǩ�������<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;������д��������������˵��<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;1����������������������˻���������ʵ��д��<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;2��������״��������д���������������衱��<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;�ġ���д�����Ǽ��������˵��<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;1�������Ǽ��������������Ǽ�����λ��ʵ��д��<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;2����������������еġ�����״������д���������������衱��<br/>
			</td>
		</tr>
	</table>
	<h1>&nbsp;</h1>
	<table style="margin-top: 1.5cm;width: 18cm;" align="center">
		<tr>
			<td style="font-size: 18pt;text-align: center;">
				��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��
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
							&nbsp;&nbsp;&nbsp;&nbsp;���ݰ���������Ŀ�ġ���������Ű���������˺͸����������˽����ɳ��ı�֤�������й������Including: purpose of adoption, promise to never abandon or abuse the child and commitment to provide the child with a healthy growth environment, etc.��<br/>
							<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
							<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
							<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;��������������ȫ��ʵ��������٣�Ը�е��������Ρ���I hereby certify that all details in this application are truthfully presented and in case of any falsehood, I commit to undertake the corresponding legal responsibilities.��
						</td>
					</tr>
					<tr style="height: 4cm;">
						<td>
							<table style="border: 1px black solid;height: 3cm;width: 2.5cm;margin-left: 0.3cm;">
								<tr>
									<td style="text-align: center;">
										����Ƭ��<br/>Photo(father)
									</td>
								</tr>
							</table>
						</td>
						<td>
							����������ǩ�����У���<br/>
							Signature��father��<br/><br/><br/><br/><br/>
							<span style="text-decoration: underline;">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</span>
						</td>
						<td>
							<table style="border: 1px black solid;height: 3cm;width: 2.5cm;margin-left: 0.3cm;">
								<tr>
									<td style="text-align: center;">
										����Ƭ��<br/>Photo(mother)
									</td>
								</tr>
							</table>
						</td>
						<td>
							����������ǩ����Ů����<br/>
							Signature��mother��<br/><br/><br/><br/><br/>
							<span style="text-decoration: underline;">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</span>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="padding-left: 1cm;padding-top: 2cm;padding-bottom: 0.6cm;">
							����(Date)��
						</td>
						<td colspan="2" style="padding-left: 1cm;padding-top: 2cm;padding-bottom: 0.6cm;">
							����(Date)��
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
	<h1>&nbsp;</h1>
	<table style="margin-top: 1.5cm;width: 18cm;" align="center">
		<tr>
			<td style="font-size: 18pt;text-align: center;">
				��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��
			</td>
		</tr>
		<tr>
			<td style="padding-top: 0.6cm;">
				<table class="table-print-s4" style="font-size: 12pt;">
					<tr style="height: 2cm;">
						<td style="text-align: center;width: 18%;border: 1px black solid;">
							����������/������������
						</td>
						<td style="width: 82%;border: 1px black solid;" colspan="5">
							<BZ:dataValue field="SENDER" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 2cm;">
						<td style="text-align: center;border: 1px black solid;">
							������/����������ַ
						</td>
						<td style="border: 1px black solid;" colspan="5">
							<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 2cm;">
						<td style="text-align: center;border: 1px black solid;">
							������������
						</td>
						<td style="border: 1px black solid;width: 15%;">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;width: 20%;border: 1px black solid;">
							���������Ա�
						</td>
						<td style="border: 1px black solid;width: 9%;">
							<BZ:dataValue field="SEX_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;width: 16%;border: 1px black solid;">
							�������˳�������
						</td>
						<td style="border: 1px black solid;width: 22%;">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr style="height: 2cm;">
						<td style="text-align: center;border: 1px black solid;">
							����������
						</td>
						<td style="border: 1px black solid;" colspan="3">
							<BZ:dataValue field="CONTACT_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;border: 1px black solid;">
							������ְ��
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="CONTACT_JOB" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 2cm;">
						<td style="text-align: center;border: 1px black solid;">
							���������֤����
						</td>
						<td style="border: 1px black solid;" colspan="3">
							<BZ:dataValue field="CONTACT_CARD" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;border: 1px black solid;">
							��������ϵ�绰
						</td>
						<td style="border: 1px black solid;">
							<BZ:dataValue field="CONTACT_TEL" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: center;border: 1px black solid;">
							�����˻����������
						</td>
						<td style="border: 1px black solid;" colspan="5">
							<br/>(��������ԭ����Ƿ�ͬ�����������������������)<br/><br/><br/><br/><br/><br/><br/><br/>
							<br/><br/><br/><br/><br/><br/><br/><br/><br/>
							ǩ�֣���ָӡ����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							���£�&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							��&nbsp;&nbsp;&nbsp;&nbsp;
							��&nbsp;&nbsp;&nbsp;&nbsp;
							��<br/>&nbsp;
						</td>
					</tr>
					<tr>
						<td style="text-align: center;border: 1px black solid;">
							��ḣ������ҵ�����ܻ��� ǩ�֡�����
						</td>
						<td style="border: 1px black solid;" colspan="5">
							<br/><br/><br/><br/><br/><br/><br/><br/><br/>
							<br/><br/><br/><br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							��&nbsp;&nbsp;&nbsp;&nbsp;
							��&nbsp;&nbsp;&nbsp;&nbsp;
							��<br/>&nbsp;
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
				��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��
			</td>
		</tr>
		<tr>
			<td style="padding-top: 0.6cm;">
				<table class="table-print-s4" style="font-size: 12pt;">
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 10%;border: 1px black solid;">
							�� ��
						</td>
						<td style="width: 30%;border: 1px black solid;">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;width: 10%;border: 1px black solid;">
							�� ��
						</td>
						<td style="width: 30%;border: 1px black solid;">
							<BZ:dataValue field="SEX_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;width: 20%;border: 1px black solid;" rowspan="3">
							�� �� Ƭ
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;" colspan="2">
							�� �� �� ��
						</td>
						<td style="border: 1px black solid;" colspan="2">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;" colspan="2">
							�� �� ״ ��
						</td>
						<td style="border: 1px black solid;" colspan="2">
							<BZ:dataValue field="SN_TYPE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: center;border: 1px black solid;">
							���
						</td>
						<td style="border: 1px black solid;" colspan="4">
							<br/>
							<input type="checkbox" <%if("10".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>���Ҳ�������ĸ����Ӥ�Ͷ�ͯ<br/>
							<input type="checkbox" <%if("201".equals(CHILD_IDENTITY) || "202".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>ɥʧ��ĸ�Ĺ¶�<br/>
							<input type="checkbox" <%if("301".equals(CHILD_IDENTITY) || "302".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>����ĸ����������������������Ů<br/>
							<input type="checkbox" <%if("40".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>��������ͬ����ϵѪ�׵���Ů<br/>
							<input type="checkbox" <%if("50".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>����Ů<br/>
							<input type="checkbox" <%if("60".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>������������ĸ�໤�ʸ�Ķ�ͯ<br/>
							<br/>�����̱�ʾ��<br/>&nbsp;
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;" colspan="3">
							����ʮ����ı����������
						</td>
						<td style="text-align: center;border: 1px black solid;" colspan="2">
							δ��ʮ����ı������˰��֣��㣩ӡ
						</td>
					</tr>
					<tr>
						<td style="border: 1px black solid;" colspan="3">
							<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
							<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
							&nbsp;ǩ&nbsp;&nbsp;����<br/><br/>
							&nbsp;��ָӡ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��
							<br/><br/>&nbsp;
						</td>
						<td style="border: 1px black solid;" colspan="2">
							
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;">
							��ע
						</td>
						<td style="border: 1px black solid;" colspan="4">
							����10����ı�������ѯ�����ݰ���������ȷ���������ǰ���£��Ƿ���Ըͬ�ⱻ��������������ȷ��˼��ʾ��
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
				ѯ&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;¼
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
							ѯ �� ʱ ��
						</td>
						<td style="width: 26%;border: 1px black solid;">
						
						</td>
						<td style="text-align: center;width: 16%;border: 1px black solid;">
							ѯ �� �� ��
						</td>
						<td style="width: 42%;border: 1px black solid;">
						
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;">
							ѯ��������
						</td>
						<td style="border: 1px black solid;">
						
						</td>
						<td style="text-align: center;border: 1px black solid;">
							ѯ���˵�λ
						</td>
						<td style="border: 1px black solid;">
						
						</td>
					</tr>
					<tr>
						<td style="border: 1px black solid;padding-left: 0.2cm;line-height: 30px;" colspan="4" >
							<br/>
							ѯ�����������ݣ�<br/>
							Questions:<br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;1.���ա��л����񹲺͹������������йع涨�����������Ƿ���Ը����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ϊ���ӡ�Ů���Ƿ񾭹����ؿ��ǣ�<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;Do you wish to adopt xxxx as your daughter/son out of free will according to the regulations of the Adoption Law of People's Republic of China? Have you given the adoption a serious deliberation?<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;��Yes<input type="checkbox"/> &nbsp;&nbsp;&nbsp;&nbsp;No<input type="checkbox"/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;2.Ϊʲô���й��������ӣ�<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;Why do you want to adopt from China?<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;��<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;3.�����������ܷ��ṩ���õĽ�������֤����������Ű���ú��ӣ�<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;Do you promise to provide the child with a good education after adoption and never to abandon or abuse the child?<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;��Yes<input type="checkbox"/> &nbsp;&nbsp;&nbsp;&nbsp;No<input type="checkbox"/><br/><br/>&nbsp;
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
				&nbsp;&nbsp;&nbsp;&nbsp;4.�����ںϣ�������Ϊ���ӵ�����븣�����������ܵ�����Ƿ�һ�£�<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;Do you think the situation of the adoptee is consistent with that introduced by the welfare institution?<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;��Yes<input type="checkbox"/> &nbsp;&nbsp;&nbsp;&nbsp;No<input type="checkbox"/><br/><br/>
				&nbsp;&nbsp;&nbsp;&nbsp;5.���� Others<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
				<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
				�������Ķ�ѯ�ʱ�¼���뱾������ʾ����˼һ�¡�<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;(I understand the interview written notes, the contents is consistent with what I meant to say or with my interpretation.)<br/><br/>
				��ѯ����ǩ����Male&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				��¼�ˣ�<br/>
				(Signature) Female
				
			</td>
		</tr>
	</table>
	<h1>&nbsp;</h1>
	<table style="margin-top: 1.5cm;width: 18cm;" align="center">
		<tr>
			<td style="font-size: 18pt;text-align: center;">
				ѯ&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;¼
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;text-align: center;padding-top: 0.4cm;">
				���Ǹ�������������д��
			</td>
		</tr>
		<tr>
			<td style="padding-top: 0.6cm;">
				<table class="table-print-s4" style="font-size: 12pt;">
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 16%;border: 1px black solid;">
							ѯ �� ʱ ��
						</td>
						<td style="width: 26%;border: 1px black solid;">
						
						</td>
						<td style="text-align: center;width: 16%;border: 1px black solid;">
							ѯ �� �� ��
						</td>
						<td style="width: 42%;border: 1px black solid;">
						
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;">
							ѯ��������
						</td>
						<td style="border: 1px black solid;">
						
						</td>
						<td style="text-align: center;border: 1px black solid;">
							ѯ���˵�λ
						</td>
						<td style="border: 1px black solid;">
						
						</td>
					</tr>
					<tr>
						<td style="border: 1px black solid;padding-left: 0.2cm;line-height: 30px;" colspan="4" >
							<br/>
							ѯ�����������ݣ�<br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;1.������<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;��<br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;2.ְҵ��<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;��<br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;3.�������뱻�����˹�ϵ��<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;��<br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;4.�Ƿ���Ը����?<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;��<br/><br/><br/><br/><br/><br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;�������Ķ�ѯ�ʱ�¼���뱾������ʾ����˼һ�¡�<br/><br/><br/>
							&nbsp;&nbsp;&nbsp;&nbsp;��ѯ����ǩ����<br/><br/><br/>
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
				��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��&nbsp;&nbsp;��
			</td>
		</tr>
		<tr>
			<td style="padding-top: 0.6cm;">
				<table class="table-print-s4" style="font-size: 12pt;">
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 8%;border: 1px black solid;" rowspan="3">
							�� �� �� �� ��
						</td>
						<td style="text-align: center;width: 15%;border: 1px black solid;" colspan="2">
							����
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="3">
							�У�<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="2">
							Ů��<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 15%;border: 1px black solid;" colspan="2">
							�� �� �� ��
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
							��       ��
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
							�� �� �� �� ��
						</td>
						<td style="text-align: center;width: 15%;border: 1px black solid;" colspan="2">
							����/������������
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="5">
							<BZ:dataValue field="SENDER" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 15%;border: 1px black solid;" colspan="2">
							������/����������ַ
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="5">
							<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 8%;border: 1px black solid;" rowspan="3">
							�� �� �� �� �� ��
						</td>
						<td style="text-align: center;width: 15%;border: 1px black solid;" colspan="2">
							����
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;width: 15%;border: 1px black solid;">
							�Ա�
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;">
							<BZ:dataValue field="SEX_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td style="text-align: center;width: 15%;border: 1px black solid;">
							��������
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 15%;border: 1px black solid;" colspan="2">
							�� �� ״ ��
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="5">
							<BZ:dataValue field="SN_TYPE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;width: 8%;border: 1px black solid;">
							�� �� �� �� �� ��
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="6">
							<br/>
							<input type="checkbox" <%if("10".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>���Ҳ�������ĸ����Ӥ�Ͷ�ͯ<br/>
							<input type="checkbox" <%if("201".equals(CHILD_IDENTITY) || "202".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>ɥʧ��ĸ�Ĺ¶�<br/>
							<input type="checkbox" <%if("301".equals(CHILD_IDENTITY) || "302".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>����ĸ����������������������Ů<br/>
							<input type="checkbox" <%if("40".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>��������ͬ����ϵѪ�׵���Ů<br/>
							<input type="checkbox" <%if("50".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>����Ů<br/>
							<input type="checkbox" <%if("60".equals(CHILD_IDENTITY)){ %> checked="checked" <%} %> disabled="disabled"/>������������ĸ�໤�ʸ�Ķ�ͯ<br/>
							<br/>�����̱�ʾ��<br/>&nbsp;
						</td>
					</tr>
					<tr style="height: 1.5cm;">
						<td style="text-align: center;border: 1px black solid;" colspan="2">
							��ϵ������������֯����
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;" colspan="6">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: center;border: 1px black solid;" colspan="2">
							�� �� ֤ �� �� �� �� �� ��
						</td>
						<td style="border: 1px black solid;padding-left: 0.2cm;line-height: 30px;" colspan="6">
							<input type="checkbox" />1.����������Ů֪ͨ��<br/>
							<input type="checkbox" />2.��������֪ͨ��<br/>
							<input type="checkbox" />3.����Э��<br/>
							<input type="checkbox" />4.�ں�Э��<br/>
							<input type="checkbox" />5.����Э��<br/>
							<input type="checkbox" />6.�����������֤��<br/>
							<input type="checkbox" />7.���ո�ӡ��<br/>
							<input type="checkbox" />8.ί���飨����˫����ͬ������һ����ʲ��������ģ�Ӧ������ί����һ����ί����Ӧ�������ڹ���֤����֤��<br/>
							<input type="checkbox" />9.����
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
				�� �� �� �� �� �� ��
			</td>
			<td style="border: 1px black solid;">
				<br/><br/><br/><br/><br/><br/><br/><br/><br/>
				<br/><br/><br/><br/><br/><br/><br/><br/><br/>
				<br/><br/><br/><br/><br/><br/><br/><br/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;�����ˣ�
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��<br/>&nbsp;
			</td>
		</tr>
		<tr>
			<td style="border: 1px black solid;text-align: center;">
				�� �� �� λ ǩ �� �� �� ��
			</td>
			<td style="border: 1px black solid;">
				<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
			</td>
		</tr>
		<tr>
			<td style="border: 1px black solid;text-align: center;">
				�� �� �� �� �� ��
			</td>
			<td style="border: 1px black solid;">
				<br/><br/><br/><br/><br/><br/><br/><br/><br/>
				<br/><br/><br/><br/><br/><br/><br/><br/><br/>
				<br/><br/><br/><br/><br/><br/><br/><br/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;ǩ &nbsp;&nbsp;�֣�
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��<br/>&nbsp;
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
