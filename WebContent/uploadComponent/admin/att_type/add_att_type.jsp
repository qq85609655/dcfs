<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.upload.datasource.DatasourceManager"%>
<%
	String path = request.getContextPath();
%>
<html>
<head>
<base target="_self">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>�������͹���</title>
<link rel="stylesheet" type="text/css" href="<%=path %>/uploadComponent/admin/skin/css/base.css">
<script type="text/javascript" src="<%=path %>/uploadComponent/admin/js/jquery.js"></script>
<script type="text/javascript" src="<%=path %>/uploadComponent/admin/js/ajaxOperations.js"></script>
<script type="text/javascript" src="<%=path %>/uploadComponent/admin/js/public.js"></script>
</head>
<body onload="att_type_diskrule_init('<%=path%>','<%=DatasourceManager.getRequestPrefix() %>');att_type_format_init('<%=path%>','<%=DatasourceManager.getRequestPrefix() %>');initApplicationNames('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>');" leftmargin="8" topmargin="8" background='<%=path %>/uploadComponent/admin/skin/images/allbg.gif'>

<!--  �����б�   -->
<form name="addAttTypeForm" id="addAttTypeForm" method="post">
<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" align="center" colspan="12" background="<%=path %>/uploadComponent/admin/skin/images/tbg.gif">
		<h1>��Ӹ�������</h1>
	</td>
</tr>

<tr align="center" bgcolor="#FAFAF1" height="22">
	<td><table width="100%" border="1" bordercolor="#B5CFD9" style="border: 1px solid #B5CFD9;border-collapse:collapse;font-size:12px;height: 25px;text-align: left;">
      <tr>
        <td align="right" valign="middle">�������ƣ�</td>
        <td align="left" valign="middle"><label>
          <input type="text" name="ATT_TYPE_NAME" id="ATT_TYPE_NAME">
        </label></td>
        <td align="right" valign="middle">�������ʹ���(CODE)��</td>
        <td align="left" valign="middle"><label>
          <input type="text" name="CODE" id="CODE">
        </label></td>
      </tr>
      <tr>
        <td align="right" valign="middle">�洢���ͣ�</td>
        <td align="left" valign="middle"><label>
          <input type="radio" name="STORE_TYPE" id="STORE_TYPE_DISK" value="1" onclick="showSortWeek()">
        ���� 
        <input type="radio" name="STORE_TYPE" id="STORE_TYPE_DATABASE" value="2" checked="checked" onclick="hiddenSortWeek()">
        ���ݿ�</label></td>
        <td align="right" valign="middle">����ģʽ��</td>
        <td align="left" valign="middle"><label>
          <input type="radio" name="ATT_MORE" id="ATT_MORE_SINGLE" value="1">
        </label>
          ������ 
          <label>
          <input type="radio" name="ATT_MORE" id="ATT_MORE_MORE" value="2" checked="checked">
          </label>
          �฽��</td>
      </tr>
      <tr>
        <td align="right" valign="middle">������С��</td>
        <td align="left" valign="middle"><label>
          <input type="text" name="ATT_SIZE" id="ATT_SIZE" size="4">
        MB</label></td>
        <td align="right" valign="middle">������ʽ��</td>
        <td align="left" valign="middle">
        	<table id="att_type_format" width="100%"></table>
        </td>
      </tr>
      <!-- 
      <tr id="APPLICATION_TR">
        <td align="right" valign="middle">Ӧ������</td>
        <td align="left" valign="middle"><label>
          <select name="APP_NAME" id="APP_NAME" onchange="initModuleNames('<%=path %>',this,'<%=DatasourceManager.getRequestPrefix() %>')">
          	<option value="">ѡ��Ӧ�ó�������</option>
          </select>
          </label></td>
        <td align="right" valign="middle">ģ�����ƣ�</td>
        <td align="left" valign="middle"><label>
          <select name="MOD_NAME" id="MOD_NAME">
          	<option value="">ѡ��ģ������</option>
          </select>
          </label></td>
      </tr>
       -->
      <tr style="display: none;" id="hiddenWeek">
        <td align="right" valign="middle">�洢����</td>
        <td align="left" valign="middle" colspan="3"><label>
          <select name="FILE_SORT_WEEK" id="FILE_SORT_WEEK"></select>
        </label></td>
      </tr>
    </table></td>
</tr>

<tr bgcolor="#EEF4EA">
<td height="28" colspan="12" align="center" valign="middle"><label>
  <input type="button" name="save" value="����" onclick="addAttTypeFormSubmit('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>');window.close();">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="button" name="close" value="�ر�" onclick="window.close()">
</label></td>
</tr>
</table>
</form>
</body>
</html>