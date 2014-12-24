<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>

<%
  /**   
 * @Description: 业务错误提醒页面
 * @author wangzheng   
 * @date 2014-9-10
 * @version V1.0   
 */
String path = request.getContextPath();
String bizerror = (String)request.getAttribute("error");
String url = (String)request.getAttribute("url");

if(url==null || "".equals(url)){
	url = "/";
}
url = path + url;
%>
<script type="text/javascript">
<!--
	function _back(){
		window.location.href = "<%=url%>";
	}
//-->
</script>
<BZ:html>
	<BZ:head>
		<title>业务错误提醒页面</title>
        <BZ:webScript edit="true"/>
	</BZ:head>	
<BZ:body>
<div class="bz-action-frame" style="text-align:center">
	<br>
	<font size="5"><%=bizerror%></font>
	<br>
	<!-- 按钮区域:begin -->
	<div class="bz-action-edit" desc="按钮区">
		<input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_back();"/>
	</div>
	<!-- 按钮区域:end -->
</div>
</BZ:body>
</BZ:html>