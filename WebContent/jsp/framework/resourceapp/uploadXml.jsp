<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!-- �����ǩ -->
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<html>
<BZ:head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>�����ϴ�</title>
	<!-- ������Դ -->
	<up:uploadResource/>
<script type="text/javascript" >
//����XML
function inXml(){//д��inputXml ʱ�����⣬������inXml ����inputXml
	document.srcForm.action=path+"app/inputXml.action";
	document.srcForm.submit();
}
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post" target="abc">
<iframe name="abc" style="display: none"></iframe>
		<!-- ���� -->
		<center>
		</center>
		<table>
			<tr>
				<td width="80%">
					<up:uploadBody 
							attTypeCode="ATT_XML" 
							id="PACKAGE_ID" 
							packageId="" 
							codeName="codeName" 
							name="ATT_INPUT_XML"/>
				</td>
				<td width="20%"><input type="button" value="����" class="button_add" onclick="inXml()"/></td>
			</tr>
		</table>
</BZ:form>
</BZ:body>
</html>