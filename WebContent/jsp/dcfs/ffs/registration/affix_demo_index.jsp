<%@page import="com.hx.upload.vo.Att"%>
<%@page import="java.util.List"%>
<%@page import="com.hx.upload.sdk.AttHelper"%>
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
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="3" style="height: 100px;padding-top: 20px;" align="center"><h1>�ϴ����</h1></td>
			</tr>
			<!-- ͼƬ�ϴ���� -->
			<tr style="height: 100px;">
				<td colspan="3">
					packageId=0,attTypeCode=DB,smallType=small
					<br>
					<up:uploadImage 
						attTypeCode="AF"
						id="0" 
						packageId="0" 
						name="0" 
						imageStyle="width:100px;height:100px;"
						autoUpload="true"
						hiddenSelectTitle="true"
						hiddenProcess="false"
						hiddenList="true"
						selectAreaStyle="border:0;width:100px;"
						proContainerStyle="width:100px;line-height:0px;"
						smallType="small"
						/>
					<br>
					packageId=00,attTypeCode=DB,smallType=00
					<br>
					<up:uploadImage 
						attTypeCode="AF"
						id="001" 
						packageId="00" 
						name="00" 
						imageStyle="width:100px;height:100px;"
						autoUpload="true"
						hiddenSelectTitle="true"
						hiddenProcess="false"
						hiddenList="true"
						selectAreaStyle="border:0;width:100px;"
						proContainerStyle="width:100px;line-height:0px;"
						smallType="001"
						/>
					<br>
					packageId=00,attTypeCode=DB,smallType=000
					<br>
					<up:uploadImage 
						attTypeCode="AF"
						id="0001" 
						packageId="00" 
						name="000" 
						imageStyle="width:100px;height:100px;"
						autoUpload="true"
						hiddenSelectTitle="true"
						hiddenProcess="false"
						hiddenList="true"
						selectAreaStyle="border:0;width:100px;"
						proContainerStyle="width:100px;line-height:0px;"
						smallType="0001"
						/>
				</td>
			</tr>
			
			<tr style="height:50px;"><td></td></tr>
			
			<!-- �ϴ���� -->
			<tr style="height: 80px;">
				<td width="50%">���̣�<br>
					packageId=2,attTypeCode=DISK
					<up:uploadBody 
						attTypeCode="AF" 
						id="1" 
						packageId="1d9d2de2-4704-4378-9bb8-1494c78aba84" 
						name="1" 
						unit="M" 
						bigType="big"
						smallType="10"/>
						
					<br>
					packageId=2,attTypeCode=DISK,smallType=3
					<up:uploadBody 
						attTypeCode="AF" 
						id="2" 
						packageId="1d9d2de2-4704-4378-9bb8-1494c78aba84" 
						name="2" 
						unit="M" 
						smallType="2"
						bigType="big"/>
					<br>
					packageId=2,attTypeCode=DISK,smallType=2
					<up:uploadBody 
						attTypeCode="AF" 
						id="3" 
						packageId="2" 
						name="3" 
						unit="M" 
						smallType="2" 
						bigType="big"/>
				</td>
				<td width="10%"></td>
				<td>���ݿ⣺
					<up:uploadBody 
					attTypeCode="AF" 
					id="111" 
					packageId="2" 
					name="2" 
					unit="M"
					queueStyle="border: solid 1px blue;width:380px"
					selectAreaStyle="border: solid 1px blue;border-bottom:none;width:380px;"
					proContainerStyle="width:380px;"
					/>
				</td>
			</tr>
			
			<!-- �б�鿴��� -->
			<tr>
				<td colspan="3" style="height: 100px;padding-top: 20px;" align="center"><h1>�ϴ��б�</h1></td>
			</tr>
			<tr style="height: 100px;">
				<td width="50%">�����б�
					<up:uploadList attTypeCode="AF" id="9" packageId="1d9d2de2-4704-4378-9bb8-1494c78aba84" firstColWidth="5px"/>
				</td>
				<td width="10%"></td>
				<td>���ݿ��б�
					<up:uploadList attTypeCode="AF" id="10" packageId="2" />
				</td>
			</tr>
			<!-- �������� -->
			<tr>
				<td colspan="3" style="height: 50px;padding-top: 20px;" align="center"><h1>��������</h1></td>
			</tr>
		</table>
		<table>
			<tr>
				<td width="40%"><a href='<up:attDownload packageId="1" isDownloadList="true"/>'>���������һ������</a></td>
				<td width="40%"><a href='<up:attDownload attTypeCode="AF" packageId="1"/>'>����������и��������ZIP��</a></td>
				<td><a href='<up:attDownload attTypeCode="AF" packageId="1,2"/>'>����������������и��������ZIP��</a></td>
				<td>"<up:attDownload attTypeCode="AF" packageId="2"/>"</td>
			</tr>
		</table>
	</body>
	
	<script type="text/javascript">
		alert(document.getElementById("infoTable9").innerHTML);
	</script>
</html>