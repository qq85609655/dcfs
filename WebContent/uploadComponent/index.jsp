<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>�����ϴ�</title>
	<!-- ������Դ -->
	<up:uploadResource isImage="true"/>
</head>
<body>
		<!-- ���� -->
		<center>
		<h1>�ϴ����</h1>
		</center>
		
		<table>
			<tr>
				<td>���������ļ�</td>
				<td>
					<up:uploadBody 
						attTypeCode="AR" 
						smallType="101"
						id="uf101" 
						packageId="1" 
						name="test"
						queueTableStyle="padding:2px" 
						diskStoreRuleParamValues="org_id=1212133;af_id=140724321"
						queueStyle="border: solid 1px blue;width:380px"
						selectAreaStyle="border: solid 1px blue;border-bottom:none;width:380px;"
						proContainerStyle="width:380px;"
						firstColWidth="15px"
						/>
				</td>
			</tr>
			<tr>
				<td>���Զ�ͯ����</td>
				<td>
					<up:uploadBody 
						attTypeCode="AR" 
						id="ci" 
						packageId="1" 
						name="test"
						queueTableStyle="padding:2px" 
						diskStoreRuleParamValues="org_id=1212133;af_id=3293932"
						smallType="102"
						queueStyle="border: solid 1px blue;width:380px"
						selectAreaStyle="border: solid 1px blue;border-bottom:none;width:380px;"
						proContainerStyle="width:380px;"
						firstColWidth="15px"
						/>
				</td>
			</tr>
			<tr>
				<td>���Ե����ļ�</td>
				<td>
					<up:uploadBody 
						attTypeCode="AR" 
						id="ar" 
						packageId="1" 
						name="test"
						queueTableStyle="padding:2px" 
						diskStoreRuleParamValues="org_id=1212133;af_id=3293932"
						smallType="103"
						queueStyle="border: solid 1px blue;width:380px"
						selectAreaStyle="border: solid 1px blue;border-bottom:none;width:380px;"
						proContainerStyle="width:380px;"
						firstColWidth="15px"
						/>
				</td>
			</tr>
			<tr>
				<td>���������ļ�</td>
				<td>
					<up:uploadBody 
						attTypeCode="AR" 
						id="other" 
						packageId="1" 
						name="test"
						queueTableStyle="padding:2px" 
						diskStoreRuleParamValues="org_id=1212133;af_id=3293932"
						smallType="104"
						queueStyle="border: solid 1px blue;width:380px"
						selectAreaStyle="border: solid 1px blue;border-bottom:none;width:380px;"
						proContainerStyle="width:380px;"
						firstColWidth="15px"
						/>
				</td>
			</tr>
			<tr>
				<td>����ͼƬ</td>
				<td>
					<up:uploadImage attTypeCode="OTHER" 
						id="imgs" packageId="101" name="" 
						diskStoreRuleParamValues="org_id=1212133;af_id=3293932" 
						imageStyle="width:100px;height:100px;"
						autoUpload="true"
						hiddenSelectTitle="true"
						hiddenProcess="false"
						hiddenList="true"
						selectAreaStyle="border:0;width:100px;"
						proContainerStyle="width:100px;line-height:0px;"
					/>
				</td>
			</tr>
		</table>
	</body>
</html>