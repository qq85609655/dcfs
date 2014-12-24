<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>附件上传</title>
	<!-- 导入资源 -->
	<up:uploadResource isImage="true"/>
</head>
<body>
		<!-- 内容 -->
		<center>
		<h1>上传组件</h1>
		</center>
		
		<table>
			<tr>
				<td>测试收养文件</td>
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
				<td>测试儿童材料</td>
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
				<td>测试档案文件</td>
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
				<td>测试其他文件</td>
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
				<td>测试图片</td>
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