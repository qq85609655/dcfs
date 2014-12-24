<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String path = request.getContextPath();
%>

<BZ:html>
 <BZ:head>
 	<BZ:script isEdit="true"/>
 	<title>导入内部人员数据</title>
 	<script type="text/javascript">
 		function _ok(){
 			var reValue = document.getElementById("innerPerson").value;
 			window.returnValue = reValue;
 			window.close();
 		}
 	</script>
 </BZ:head> 
  <BZ:body>
  <table style="width:100%;height:100%">
  <tr><td style="height:25px;">
  <div style="width: 100%;border: 1px a3bae0 solid;">
  		<span style="text-align: right;width: 100%"><input class="button_add" type="button" value="确定" onclick="_ok();"/>&nbsp;&nbsp;<input class="button_close" type="button" value="关闭" onclick="window.close();"/></span>
  	</div>
  </td></tr>
  <tr><td style="height:100%">
  <textarea style="width: 100%;height: 100%;" id="innerPerson"></textarea>
  </td></tr>
  </table>
  </BZ:body>
</BZ:html>
