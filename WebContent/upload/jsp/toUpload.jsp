<%@page import="hx.util.Base64Util"%>
<%@ page language="java" contentType="text/html; charset=GBK"   pageEncoding="GBK"%>

<%
String path  = request.getContextPath();
String st = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><datas page=\"0\" dataTotal=\"2\" pageNum=\"1\" pageTotal=\"1\"><data entityName=\"null\">
<ENAME pk=\"false\"><![CDATA[family]]></ENAME>
<ATT_MORE pk=\"false\"><![CDATA[2]]></ATT_MORE>
<ATT_FORMAT pk=\"false\"><![CDATA[*.jpg||*.doc||*.docx||*.mp4]]></ATT_FORMAT>
<CODE pk=\"false\"><![CDATA[ABCDE111]]></CODE>
<CNAME pk=\"false\"><![CDATA[家庭文件]]></CNAME>
<ATT_SIZE pk=\"false\"><![CDATA[1000]]></ATT_SIZE>
<IS_NAILS pk=\"false\"><![CDATA[1]]></IS_NAILS>
</data>

<data entityName=\"null\"><ENAME pk=\"false\"><![CDATA[child]]></ENAME><ATT_MORE pk=\"false\"><![CDATA[1]]></ATT_MORE><ATT_FORMAT pk=\"false\"><![CDATA[*.*]]></ATT_FORMAT><CODE pk=\"false\"><![CDATA[ABCDE]]></CODE><CNAME pk=\"false\"><![CDATA[儿童材料]]></CNAME><ATT_SIZE pk=\"false\"><![CDATA[50]]></ATT_SIZE><IS_NAILS pk=\"false\"><![CDATA[0]]></IS_NAILS></data></datas>";
st =Base64Util.encryptBASE64(st.getBytes());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script type="text/javascript"  src="/dcfs/resource/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/upload/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
<script type="text/javascript" src="<%=path%>/upload/js/Urlbm.js"></script>
<title>上传</title>

<script>
	//接受返回值
	function getIframeVal(val)  
	{
	 document.getElementById("textareaid").value=urlDecode(val);
	}

	function _toipload(){
		popWin.showWinIframe("1000","600","fileframe","附件管理","iframe","#");
		document.srcForm.action="<%=path%>/uploadManager";
		document.srcForm.submit();
	}

</script>
</head>
<body >
<form name="srcForm" method="post" action="/uploadManager" target="fileframe">
<input type="button" value="转到上传" onclick="_toipload()" />
<input type="hidden" id="PACKAGE_ID" name="PACKAGE_ID" value="1234567890"/>
<input type="hidden" id="SMALL_TYPE" name="SMALL_TYPE" value="<%=st%>"/>
<input type="hidden" id="ENTITY_NAME" name="ENTITY_NAME" value="ATT_AF"/>
<input type="hidden" id="BIG_TYPE" name="BIG_TYPE" value="AF"/>
<input type="hidden" id="IS_EN" name="IS_EN" value="false"/>
<input type="hidden" id="CREATE_USER" name="CREATE_USER" value="柏鹤云"/>
<input type="hidden" id="PATH_ARGS" name="PATH_ARGS" value="org_id=1212133,af_id=3293932"/>
<textarea rows="5" cols="" style="width:600px;" id="textareaid"></textarea>
</form>
</body>
</html>