<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*" %>
<%@ page import="base.task.monitor.task.JobStatusObject" %>
<%@ page import="base.task.base.conf.SystemConfig" %>
<%
try
{
	String contextPath = request.getContextPath();
	String TI_TASK_NAME = (String) request.getAttribute("TI_TASK_NAME");
	String TI_RUN_TYPE = (String) request.getAttribute("TI_RUN_TYPE");
	ArrayList jobStatusList = (ArrayList) request.getAttribute("jobStatusList");
	String navigation = "数据交换平台 -&gt; 任务控制台 -&gt; 任务运行情况明细";
	if(!SystemConfig.getString("monitor.task.TaskStatusDetail").trim().equals(""))
	  navigation = new String(SystemConfig.getString("monitor.task.TaskStatusDetail").getBytes("iso8859-1"),"GBK");
%>

<!-- Header begin -->
<%@ include file="/eii/include/jsp/stmadc_header.jsp" %>
<!-- Header end -->
<META HTTP-EQUIV=Content-Type CONTENT="text/html; charset=gb2312">
<!-- 内容区域 begin -->

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
  <tr height="450">
    <td align="center" valign="top">
      <table align="center" width="100%" border="0" cellpadding="3" cellspacing="1">
        <tr>
          <td align="center">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#EFEFEF">
              <tr height="20">
                <td width="87%"><img src="<%=contextPath%>/eii/images/niu-1.jpg" width="9" height="9">
                  当前位置： <%=navigation%></td>
                <td width="4%" align="right">
                  <div align="right"><img src="<%= contextPath %>/eii/images/wenhao.jpg" width="16" height="16"></div>
                </td>
                <td width="9%">
                  <div align="center"><font color="FF6D00"><a href="javascript:openHelp('<%= contextPath %>/eii/html/help/proc/monitor/task/ShowTaskStatusDetail.htm');" class="A_Help">使用帮助</a></font></div>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr height="9">
                <td></td>
              </tr>
            </table>
             <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="9C9C9C">
                <tr bgcolor="#EAEAEA" height="22">
                  <td><font color="4A4A4A">&nbsp;■ 任务信息 </font></td>
                </tr>
                <tr align="center" bgcolor="#FFFFFF" height="30">
                	<td width="100%" align="center">
                  		<table border="0" width="100%" cellspacing="5" cellpadding="0">
                    		<tr>
                      <td width="17%" align="right">任务名称：</td>
                      <td width="26%">
                        &nbsp;<%=TI_TASK_NAME%>
					            </td>
                      <td width="12%"  align="right">运行状态：</td>
                      <td width="45%" align="right">&nbsp;正在运行</td>
                    	</tr>
                  </table>
                  </td>
                 </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr height="9">
                <td></td>
                </tr>
              </table>
              <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="9C9C9C">
                <tr bgcolor="#EAEAEA" height="22">
                <td><font color="4A4A4A">&nbsp;■ 工作信息 </font></td>
                </tr>
                <tr align="center" bgcolor="#FFFFFF" height="30">

                <td width="100%" align="center"> 
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr height="9">
                    <td></td>
                  </tr>
                </table>
                  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="9C9C9C">
                    <tr bgcolor="EAEAEA">
                      <td width="40" align="center">序号</td>
                      <td width="139" align="center">工作名称</td>
                      <td width="153" align="center">开始时间</td>
                      <td width="154" align="center">结束时间</td>
                      <td width="77" align="center">运行状态</td>
                      <td width="284" align="center">详细信息</td>
                    </tr>
<%
                   int nCount = 0;
                   for(int i = 0 ; i < jobStatusList.size(); i++)
                   {
                      JobStatusObject jsObject = (JobStatusObject) jobStatusList.get(i);
					            String jobId = jsObject.getJobId();
                      String jobName = jsObject.getJobName();
                      String startTime = jsObject.getJobStartTime();
                      String endTime = jsObject.getJobEndTime();
                      String runningState = jsObject.getRunningState();
                      String detail = jsObject.getDetail();
                      String theStatus = "";
                      if (runningState.equals("0"))
                      {
                        theStatus = "正在运行";
                      }
                      else if (runningState.equals("1"))
                      {
                        theStatus = "成功";
                      }
                      else if (runningState.equals("2"))
                      {
                        theStatus = "失败";
                      }
                      else if (runningState.equals("3"))
                      {
                        theStatus = "异常";
                      }
                      else if (runningState.equals("4"))
                      {
                        theStatus = "等待中";
                      }
%>
                    <tr bgcolor="#FFFFFF">
                      <td align="center" width="40" height="26"> <%= i + 1 %>
                      </td>
                      <td width="139" height="26">&nbsp;<%=jobName%></td>
                      <td align="center" width="153" height="26"><%= startTime%></td>
                      <td align="center" width="154" height="26" ><%= endTime%></td>
                      <td align="center" width="77" height="26"><%= theStatus%></td>
                      <td width="284" height="26">&nbsp;<%=detail%></td>
                    </tr>
<%
                        nCount ++;
                    }
%>
                  </table>
				   <br>
                </td>
                 </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr height="15">
                <td></td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr align="center">
                <td>
                  <input type=button name="button2" value="返 回" class="inputbutton" onClick="javascript: history.back(1)" style="cursor:hand">
                </td>
              </tr>
            </table>
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr height="15">
              <td></td>
            </tr>
          </table>
         </td>
       </tr>
     </table>
    </td>
  </tr>
</table>
<!-- 内容区域 end -->
<!-- Tail begin -->
<%@ include file="/eii/include/jsp/stmadc_tail.jsp" %>
<!-- Tail end -->
<%
}
catch(Exception e)
{
	out.println(e);
}
%>
<p>&nbsp;</p>