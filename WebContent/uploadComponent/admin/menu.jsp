<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.upload.datasource.DatasourceManager"%>
<%
	String path = request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>menu</title>
<link rel="stylesheet" href="<%=path %>/uploadComponent/admin/skin/css/base.css" type="text/css" />
<link rel="stylesheet" href="<%=path %>/uploadComponent/admin/skin/css/menu.css" type="text/css" />
<!-- 
<script type="text/javascript" src="<%=path %>/uploadComponent/admin/js/public.js"></script>
 -->
<script language="javascript" type="text/javascript" src="<%=path %>/uploadComponent/admin/skin/js/frame/menu.js"></script>
<script language='javascript'>
	var curopenItem = '1';
</script>
</head>
<body target="main">
<table width='99%' height="100%" border='0' cellspacing='0' cellpadding='0'>
  <tr>
    <td style='padding-left:3px;padding-top:8px' valign="top">
	<!-- Item 1 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items1_1")'><b>常用操作</b></dt>
        	<dd style='display:block' class='sitem' id='items1_1'>
          		<ul class='sitemu'>
            		<li>
              			<div class='items'>
                			<div class='fllct'>
                				<a href='<%=path %>/att_type/AttType.<%=DatasourceManager.getRequestPrefix() %>?param=queryAttType' target='main'>附件类型管理</a>
                			</div>
                			<!-- 
                			<div class='flrct'>
                				<a href='javascript:add_att_type_dialog()' target='main'>
                					<img src='<%=path %>/uploadComponent/admin/skin/images/frame/gtk-sadd.png' alt='添加附件类型' title='添加附件类型'/>
                				</a>
                			</div>
                			 -->
              			</div>
            		</li>
            		<li>
            			<a href='<%=path %>/att/Att.<%=DatasourceManager.getRequestPrefix() %>?param=queryAtts' target='main'>附件管理</a>
            		</li>
          		</ul>
        	</dd>
      	</dl>
      <!-- Item 1 End -->
      <!-- Item 2 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items2_1")'><b>系统帮助</b></dt>
        <dd style='display:block' class='sitem' id='items2_1'>
          <ul class='sitemu'>
            <li><a href='javascript:void(0)' target='main' onclick="alert('权限不足');">其他功能</a></li>
          </ul>
        </dd>
      </dl>
      <!-- Item 2 End -->
	  </td>
  </tr>
</table>
</body>
</html>