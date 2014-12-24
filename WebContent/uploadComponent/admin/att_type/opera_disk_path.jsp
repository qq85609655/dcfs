<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.upload.datasource.DatasourceManager"%>
<%
	String path = request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>附件类型管理</title>
<link rel="stylesheet" type="text/css" href="<%=path %>/uploadComponent/admin/skin/css/base.css">
<script type="text/javascript" src="<%=path %>/uploadComponent/admin/js/public.js"></script>
</head>
<body leftmargin="8" topmargin="8" background='<%=path %>/uploadComponent/admin/skin/images/allbg.gif'>

<!--  内容列表   -->
<form name="diskPathForm" id="diskPathForm" method="post">
<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" align="center" colspan="12" background="<%=path %>/uploadComponent/admin/skin/images/tbg.gif">
		<h1>磁盘路径管理</h1>
	</td>
</tr>

<tr align="center" bgcolor="#FAFAF1" height="22">
	<td><table width="100%" border="1" bordercolor="#B5CFD9" style="border: 1px solid #B5CFD9;border-collapse:collapse;font-size:12px;height: 25px;text-align: left;">
      <tr>
        <td width="10%" align="right" valign="middle">磁盘路径：</td>
        <td width="90%" align="left" valign="middle"><label>
          <input type="text" name="diskPath" value="${diskPath }" style="width:450px">
        </label>          <label>(只限英文字母、数字及特殊字符)</label></td>
        </tr>
    </table></td>
</tr>

<tr bgcolor="#EEF4EA">
<td height="28" colspan="12" align="center" valign="middle">
	<table width="100%">
		<tr>
			<td width="10%" align="right" valign="middle">&nbsp;</td>
			<td width="90%" align="left" valign="middle">
				<label>
  <input type="button" name="save" value="保存/修改" onclick="diskPathFormSubmit('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>');window.close();">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="button" name="close" value="关闭" onclick="window.close()">
</label></td>
		</tr>
	</table>
</td>
</tr>
</table>
</form>
</body>
</html>