<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.upload.datasource.DatasourceManager"%>
<%
	String path = request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>�������͹���</title>
<link rel="stylesheet" type="text/css" href="<%=path %>/uploadComponent/admin/skin/css/base.css">
<script type="text/javascript" src="<%=path %>/uploadComponent/admin/js/jquery.js"></script>
<script type="text/javascript" src="<%=path %>/uploadComponent/admin/js/ajaxOperations.js"></script>
<script type="text/javascript" src="<%=path %>/uploadComponent/admin/js/public.js"></script>
</head>
<body leftmargin="8" topmargin="8" background='<%=path %>/uploadComponent/admin/skin/images/allbg.gif'>

<!--  �����б�   -->
<form name="opera_datasource_form" id="opera_datasource_form" method="post">
<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" align="center" colspan="12" background="<%=path %>/uploadComponent/admin/skin/images/tbg.gif">
		<h1>����Դ����</h1>
	</td>
</tr>

<tr align="center" bgcolor="#FAFAF1" height="22">
	<td><table width="100%" border="1" bordercolor="#B5CFD9" style="border: 1px solid #B5CFD9;border-collapse:collapse;font-size:12px;height: 25px;text-align: left;">
      <!-- 
      <tr>
        <td align="right" valign="middle">���ݿ����ƣ�</td>
        <td align="left" valign="middle"><label>
       		<input type="text" name="databaseName" value="${datasouceBean.databaseName }">
       		<%-- ֮��ĳ�������ʽ
       		<select name="databaseName">
       			<option value="mysql" <%="mysql".equalsIgnoreCase(bean.getDatabaseName())?"selected='selected'":"" %>>mysql</option>
       		</select>
       		 --%>
        </label></td>
        <td align="right" valign="middle">���ݿ�������</td>
        <td align="left" valign="middle"><label>
          <input type="text" name="driver" value="${datasouceBean.driver }" style="width: 250px">
        </label></td>
      </tr>
       -->
      <tr>
        <td align="right" valign="middle">���ݿ�������</td>
        <td align="left" valign="middle"><label>
          <input type="text" name="driver" value="${datasouceBean.driver }" style="width: 250px">
        </label></td>
        <td align="right" valign="middle"></td>
        <td align="left" valign="middle"></td>
      </tr>
      <tr>
        <td align="right" valign="middle">���ݿ�����url��</td>
        <td colspan="3" align="left" valign="middle"><label>
          <input type="text" name="url" value="${datasouceBean.url }" style="width: 432px">
        </label></td>
        </tr>
      <tr>
        <td align="right" valign="middle">�û�����</td>
        <td align="left" valign="middle"><label>
          <input type="text" name="username" value="${datasouceBean.username }">
        </label></td>
        <td align="right" valign="middle">���룺</td>
        <td align="left" valign="middle"><label>
          <input type="text" name="password" value="${datasouceBean.password }">
        </label></td>
      </tr>
      <tr>
        <td align="right" valign="middle">Ĭ����������</td>
        <td align="left" valign="middle"><label>
          <input type="text" name="initialSize" value="${datasouceBean.initialSize }">
        </label></td>
        <td align="right" valign="middle">�����������</td>
        <td align="left" valign="middle"><label>
          <input type="text" name="maxActive" value="${datasouceBean.maxActive }">
        </label></td>
      </tr>
      <tr>
        <td align="right" valign="middle">����������</td>
        <td align="left" valign="middle"><label>
          <input type="text" name="maxIdle" value="${datasouceBean.maxIdle }">
        </label></td>
        <td align="right" valign="middle">��С��������</td>
        <td align="left" valign="middle"><label>
          <input type="text" name="minIdle" value="${datasouceBean.minIdle }">
        </label></td>
      </tr>
      <tr>
        <td align="right" valign="middle">��ʱ�趨��</td>
        <td align="left" valign="middle"><label>
          <input type="text" name="removeAbandonedTimeout" value="${datasouceBean.removeAbandonedTimeout }" style="width:100px">
        ��</label></td>
        <td align="right" valign="middle">��ʱ�ȴ����ã�</td>
        <td align="left" valign="middle"><label>
          <input type="text" name="maxWait" value="${datasouceBean.maxWait }" style="width:100px">
        ����</label></td>
      </tr>
    </table></td>
</tr>

<tr bgcolor="#EEF4EA">
<td height="28" colspan="12" align="center" valign="middle"><label>
  <input type="button" name="save" value="����" onclick="opera_datasource_submit('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>');window.close();">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="button" name="close" value="�ر�" onClick="window.close()">
</label></td>
</tr>
</table>
</form>
</body>
</html>