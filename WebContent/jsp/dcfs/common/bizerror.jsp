<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>

<%
  /**   
 * @Description: ҵ���������ҳ��
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
		<title>ҵ���������ҳ��</title>
        <BZ:webScript edit="true"/>
	</BZ:head>	
<BZ:body>
<div class="bz-action-frame" style="text-align:center">
	<br>
	<font size="5"><%=bizerror%></font>
	<br>
	<!-- ��ť����:begin -->
	<div class="bz-action-edit" desc="��ť��">
		<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_back();"/>
	</div>
	<!-- ��ť����:end -->
</div>
</BZ:body>
</BZ:html>