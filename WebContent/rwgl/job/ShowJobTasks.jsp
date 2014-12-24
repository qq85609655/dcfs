<%@ page contentType="text/html;charset=GBK"%>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="base.task.resource.task.vo.TaskVo"/>
<jsp:directive.page import="base.task.base.conf.SystemConfig"/>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<%
  	String contextPath= request.getContextPath();
  	String CATALOG = (String) request.getAttribute("CATALOG");
	String JOB_NAME = (String) request.getAttribute("JOB_NAME");
	String DESCRIPTION = (String) request.getAttribute("DESCRIPTION");
	ArrayList tasks = (ArrayList) request.getAttribute("tasks");
    if(tasks==  null) tasks= new ArrayList();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #F4F9FF;
}
-->
</style>
<title></title>
<!-- 内容区域 begin -->
<SCRIPT LANGUAGE="JavaScript">
function _return()
{
	window.location.href="<%= contextPath %>/base/task/resource/job/JobListServlet?CATALOG=<%=CATALOG%>";
}
</SCRIPT>
</head>
<body>
<form name="frmSub" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="text01" >

  
<tr>
        <td height="25" colspan="4">
			<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="9C9C9C" class="text01">
                <tr bgcolor="#EAEAEA" height="22"> 
                  
                <td align="left">&nbsp;■ 工作信息 </td>
                </tr>
                <tr align="center" bgcolor="#FFFFFF" height="30"> 
                	<td width="100%" align="center"> 
                  		<table border="0" width="100%" cellspacing="5" cellpadding="0" class="text01">
                    		<tr> 
                      <td width="17%"> 
                        <div align="right">工作名称：</div>
							        </td>
                      <td width="19%"> &nbsp;<%=StringUtil.escapeHTMLTags(JOB_NAME)%> </td>
                      <td width="12%"> 
                        <div align="right">工作描述：</div>
                      </td>
                      <td width="52%">&nbsp;<%=StringUtil.escapeHTMLTags(DESCRIPTION)%></td>
                    	</tr>
                  </table>
                  </td>
                 </tr>
              </table>		  
		</td>
</tr>	
 <tr>
        <td height="18" colspan="4">
			&nbsp;	 	  
		</td>
</tr>
<tr>
      <td colspan="4">
		<div id="primarydata" style="width:100%; overflow:hidden" >
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#9CC6F7" class="text01">
                <tr bgcolor="#EAEAEA" height="22"> 
                <td bgcolor="#EAEAEA" height="22" align="left">&nbsp;■ 使用该工作的任务信息</td>
                </tr>
                <tr align="center" bgcolor="#FFFFFF"> 
                <td width="100%" align="center" valign="top" >
                  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="9C9C9C" class="text01" style="vertical-align: top;">
                    <tr > 
                      <th width="83" align="center">序号</th>
                      <th width="274" align="center">任务名称</th>
                      <th width="151" align="center">任务状态</th>
                      <th width="353" align="center">任务描述</th>
                    </tr>
<%
				   if (tasks.size() == 0)
				   {
%>
					<tr bgcolor="#FFFFFF">
						<td colspan="4" align="center">该工作还没有被任何任务使用</td>
				    </tr>

<%
				   }
				   else
				   {
					   for(int i = 0 ; i < tasks.size(); i++) 
					   {					 
                          TaskVo task  = (TaskVo)tasks.get(i);  
						  String TASK_NAME = task.getTask_name();
						  String STATE = task.getStatus();
						  String TASK_DESCRIPTION = task.getDescription();

						  if (STATE.equals(SystemConfig.STATUS_DEVELOP))
						  {
							STATE = "开发";
						  }
						  else if (STATE.equals(SystemConfig.STATUS_PRODUCE))
						  {
							STATE = "生产";
						  }
						  
%>
							<tr bgcolor="#FFFFFF"> 
							  
                      <td align="center" width="83" height="26"> <%= i + 1 %> 
                      </td>
							  
                      <td width="274" height="26">&nbsp;<%=StringUtil.escapeHTMLTags(TASK_NAME)%></td>
							  
                      <td align="center" width="151" height="26"><%= STATE%></td>
							  
                      <td width="353" height="26">&nbsp;<%=StringUtil.escapeHTMLTags(TASK_DESCRIPTION)%></td>
							</tr>
<%
						}
					}
%>
                  </table>
 
  </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="text01">
   <tr align="center"> 
     <td height="20"> 
       &nbsp;
     </td>
   </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="text01">
    <tr align="center"> 
      <td> 
        <input type=button name="button2" value="返 回" class="input01" onClick="javascript: _return()" >
      </td>
    </tr>
</table>
</div>
</td>
</tr>
</table>
</form>
</body>
</html>