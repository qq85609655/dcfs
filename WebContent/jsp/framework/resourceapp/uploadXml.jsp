<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!-- 导入标签 -->
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<html>
<BZ:head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>附件上传</title>
	<!-- 导入资源 -->
	<up:uploadResource/>
<script type="text/javascript" >
//导入XML
function inXml(){//写成inputXml 时有问题，这里用inXml 代表inputXml
	document.srcForm.action=path+"app/inputXml.action";
	document.srcForm.submit();
}
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post" target="abc">
<iframe name="abc" style="display: none"></iframe>
		<!-- 内容 -->
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
				<td width="20%"><input type="button" value="导入" class="button_add" onclick="inXml()"/></td>
			</tr>
		</table>
</BZ:form>
</BZ:body>
</html>