<%@ page contentType="text/html;charset=GBK"%>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="base.task.base.conf.SystemConfig"/>
<jsp:directive.page import="base.task.monitor.task.TaskStatusObject"/>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<jsp:directive.page import="base.resource.util.page.Pagination"/>
<jsp:directive.page import="java.util.List"/>
<html>
<%
    String contextPath= request.getContextPath();
	String taskName = (String) request.getAttribute("taskName");
	String taskStatus = (String) request.getAttribute("taskStatus");

	ArrayList taskStatusList = (ArrayList) request.getAttribute("taskStatusList");

    String CATALOG = (String)request.getAttribute("CATALOG");
    if(CATALOG== null || "".equals(CATALOG)) CATALOG="0";
    String jobType = "";
    
   if(CATALOG.equals("0")){
     jobType = "数据加工";
   }else if(CATALOG.equals("1")){
     jobType = "本地数据交换";
   }else if(CATALOG.equals("2")){
     jobType = "远程数据交换";
   }
   String navigation = "任务管理-&gt;任务监控";

	Pagination pagination= null;
	String pageNumber= request.getParameter("pageNumber");
	int showItemNumber=10;
	if(pageNumber==null){
		pageNumber="1";
	}
	String HTML="";
	List taskList= new ArrayList();
	if(taskStatusList!=null&&taskStatusList.size()>0){
		pagination= new Pagination();
		pagination.setPageNumber(Integer.parseInt(pageNumber));
		pagination.setShowItemNumber(showItemNumber);
		pagination.setVisitPageURL(contextPath+"/base/task/monitor/task/TaskStatusListServlet?taskName="+taskName+"&taskStatus="+taskStatus);
		taskList= pagination.interceptListByStartItemNumber(taskStatusList);
		HTML= pagination.buildHTML("100%","left","text01");
	}
%>

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

<style type="text/css">
<!--
.buttonStyle {
	width:70px;
	height:19px;
	font-family:arial;
	font-size:10px;
	border-width:1px;
	border-top-color:#FFFFFF;
	border-left-color:#FFFFFF;
	border-right-color:#000000;
	border-bottom-color:#000000;
	background-color:#E6EDFC;
}
-->
</style>

<!-- 内容区域 begin -->
<SCRIPT LANGUAGE="JavaScript">
<!--
//跳转动态监控
function _toMonitor()
{
  window.location.href = "<%= contextPath %>/task/jsp/monitor/task/TaskStatusMonitor.jsp";
}

// 开始任务
function _startTask(id, threadPoolRunnableId, status)
{
	var sForm = document.frmSub;
	/*if (status == "2")
		sForm.threadPoolRunnableId.value = id;
	else if (status == "3")*/
		sForm.taskId.value = id;
	sForm.status.value = status;
	sForm.threadPoolRunnableId.value = threadPoolRunnableId;
	sForm.action = "<%=contextPath%>/base/task/monitor/task/StartTaskServlet?CATALOG=<%=CATALOG%>";
	sForm.submit();
}

// 停止任务
function _stopRunning(taskID, threadPoolRunnableId)
{
	var result = confirm("终止正在运行的任务会造成不可预知的结果，是否继续？");
	if (! result)
		return;
	var sForm = document.frmSub;
	sForm.taskId.value = taskID;
	sForm.threadPoolRunnableId.value = threadPoolRunnableId;
	sForm.action = "<%=contextPath%>/base/task/monitor/task/StopRunningTaskServlet";
	sForm.submit();
}

// 停止等待
function _stopWaiting(taskID, threadPoolRunnableId)
{
	var result = confirm("终止等待的任务以后，您需要手工启动该任务才能让它再次运行，是否继续？");
	if (! result)
		return;
	var sForm = document.frmSub;
	sForm.taskId.value = taskID;
	sForm.threadPoolRunnableId.value = threadPoolRunnableId;
	sForm.action = "<%=contextPath%>/base/task/monitor/task/StopWaitingTaskServlet";
	sForm.submit();
}

// 重置开发状态
function _verifyState(taskId, threadPoolRunnableId)
{
	var result = confirm("将任务状态重置为“开发”状态以后，该任务将不能被执行，是否继续？");
	if (! result)
		return;
	var sForm = document.frmSub;
	sForm.taskId.value = taskId;
	sForm.threadPoolRunnableId.value = threadPoolRunnableId;
	sForm.action = "<%=contextPath%>/base/task/monitor/task/VerifyTaskStateServlet";
	sForm.submit();
}

//马上运行所有被选择的任务
function _runAtOnce(){
	var sForm = document.frmSub;
	var selectTask = sForm.selectTask;
	var runTasks = "";
	
	if (selectTask == null) {
		return;
	}
	
	for (i = 0; i < selectTask.length; i++) {
		if (selectTask[i].checked == true) {
			runTasks += selectTask[i].value + ";";
		}
	}
	
	if (runTasks == "") {
		alert("请至少选择一个任务！");
		return;
	}
	
	sForm.runTasks.value = runTasks;
	//alert(sForm.runTasks.value);
	sForm.action = "<%=contextPath%>/base/task/monitor/task/StartTaskServlet?runSelects=true";
	sForm.submit();
}

function _selectAll(srcObj) {
	var sForm = document.frmSub;
	var selectTask = sForm.selectTask;
	var checked = false;
	
	//alert(srcObj.checked);
	
	if (srcObj.checked == true) {
		checked = true;
	}

	//srcObj.checked = checked;
	for (i = 0; i < selectTask.length; i++) {
		selectTask[i].checked = checked;
	}
}

function queryTaskStatusList(){
	document.frmSub.action="<%= contextPath %>/base/task/monitor/task/TaskStatusListServlet";
	document.frmSub.submit();
}
//-->
</SCRIPT>
</head>
<body>
<form name="frmSub" method="post">
<input type="hidden" name="CATALOG"  value="<%=CATALOG%>">
<input type="hidden" name="status">
<input type="hidden" name="taskId">
<input type="hidden" name="threadPoolRunnableId">
<input type="hidden" name="runTasks">
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="text01" >

  
<tr>
        <td height="25" colspan="4">
				  <div id="query">
				 &nbsp;任务名称：
                 <input type="text" name="taskName" size="25" class="queryinput" value="<%=taskName%>">
                 &nbsp;运行状态：
                 <select name="taskStatus">
                   <option value="" >【-全部-】</option>
                   <option value="1" >正在运行</option>
                   <option value="2" >等待执行</option>
                   <option value="3" >停&nbsp;&nbsp;&nbsp;&nbsp;顿</option>
                 </select>
                 &nbsp;<input type=submit name="querybutton" onclick="queryTaskStatusList();" value="查 询" class="input01">
				  </div>		  
		</td>
</tr>	

<tr>
      <td colspan="4">
		<div id="primarydata" style="width:100%; overflow:hidden" >
              <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#9CC6F7" class="text01">
                                <tr>
                  <%
                  if(CATALOG.equals("2")) {
                  %>
                  <th width="5"><input name="selectAll" type="checkbox" onclick="_selectAll(this)" /></th>
                  <%
                  }
                  %>
                  <th width="9%" align="center" nowrap>序号</th>
                  <th width="22%" align="center" nowrap>任务名称</th>
                  <th width="10%" align="center" nowrap>运行方式</th>
                  <th width="10%" align="center" nowrap>运行状态</th>
                  <th width="11%" align="center" nowrap>已运行时间</th>
                  <th width="20%" align="center" nowrap>下一次运行时间</th>
                  <th width="13%" align="center" nowrap>可用操作</th>
                </tr>
<%
                   for(int i = 0 ; i < taskList.size(); i++)
                   {
                      TaskStatusObject tStatus = (TaskStatusObject) taskList.get(i);
                      String taskId = tStatus.getTaskId();
                      String threadPoolRunnableId = tStatus.getThreadPoolRunnableId();
                      String tName = tStatus.getTaskName();
                      String runType = tStatus.getRunType();
                      String status = tStatus.getStatus();
                      String usedTime = tStatus.getUsedTime();
                      String nextExecTime = tStatus.getNextExecTime();
                      String operation = tStatus.getOperation();
                      String theStatus = "";
  	 		          String theRunType = "";
  	 		          String checkBoxString = "";
                      if (status.equals("1"))
                      {
                        theStatus = "正在运行";
                      }
                      else if (status.equals("2"))
                      {
                    	checkBoxString = threadPoolRunnableId + "," + status;
                        theStatus = "等待执行";
                      }
                      else if (status.equals("3"))
                      {
                   	  	checkBoxString = taskId + "," + status;
                        theStatus = "停顿";
                      }
                      if (runType.equals("0"))
                      {
                          theRunType = "串行";
                      }
                      else if (runType.equals("1"))
                      {
                          theRunType = "并行";
                      }
%>
                <tr bgcolor="#FFFFFF">
                  <%
                  if(CATALOG.equals("2")) {
                  %>
                  <td align="center"><input name="selectTask" type="checkbox" value="<%= checkBoxString %>" /></td>
                  <%
                  }
                  %>
                  <td align="center"> <%= i + 1 %> </td>
                  <td>&nbsp;
                    <%
                     if (status.equals("1"))
                     {
%>
                    <a href="<%= contextPath %>/base/task/monitor/task/ShowTaskStatusDetailServlet?threadPoolRunnableId=<%= threadPoolRunnableId%>&&runType=<%=runType%>">
                    <%=StringUtil.escapeHTMLTags(tName)%></a>
                    <%
                     }
                     else
                     {
%>
                    <%=StringUtil.escapeHTMLTags(tName)%>
<%
                     }
%>
                  </td>
                  <td align="center" ><%=theRunType%></td>
                  <td align="center" nowrap><%= theStatus%>
                  <%if (!operation.equals("") && !operation.equals("0") || status.equals("1")) { %>
                  	  [<a href="<%=contextPath %>/base/task/monitor/task/TaskStatusListServlet">刷新</a>]
                  <%} %>
                  </td>
                  <td >&nbsp;<%=(usedTime==null)? "" : usedTime%></td>
                  <td align="center" ><%= nextExecTime%></td>
                  <td nowrap>&nbsp;

<%				if (status.equals("1"))
                {
%>					<input type="button" name="button4" value="停止运行" class="buttonStyle" onClick="_stopRunning('<%=taskId%>','<%=threadPoolRunnableId%>')">
<%				}
                else if (status.equals("2"))
                {
%>					<input type="button" name="button52" value="马上运行" class="buttonStyle" onClick="_startTask('<%=taskId%>','<%=threadPoolRunnableId%>','<%=status%>')">
	                &nbsp;
	                <input type="button" name="button5" value="终止等待" class="buttonStyle" onClick="_stopWaiting('<%=taskId%>','<%=threadPoolRunnableId%>')">
<%				}
                else if (status.equals("3"))
                {
%>					<%--<input type="button" name="button522" value="马上运行" class="buttonStyle" onClick="_startTask('<%=taskId%>','<%=threadPoolRunnableId%>','<%=status%>')">
                    &nbsp;--%>
                	<input type="button" name="button53" value="重置开发" class="buttonStyle" onClick="_verifyState('<%=taskId%>','<%=threadPoolRunnableId%>')">
<%				}
%>
                  </td>
                </tr>
                <%
                    }
                  %>
              </table>
  </div>
  </td>
  </tr>

  <tr height="15"> 
    <td colspan="4">
    <%=HTML %>
    </td>
  </tr>
  <tr align="center"> 
    <td colspan="4"> 
      <%
        if(CATALOG.equals("2")) {
        %>
        <input type="button" name="runAtOnce" value="马上运行" class="inputbutton" onClick="_runAtOnce()" style="cursor:hand">
        <%
        }
        %>
        <!-- <input type=button name="button2" value="返 回" class="inputbutton" onClick="_return()" style="cursor:hand"> -->
        &nbsp;&nbsp;
        <!-- <input type=button name="button2" value="实时监控" class="inputbutton" onClick="_toMonitor()" style="cursor:hand"> -->
    </td>
  </tr>    
</table>

</form>
<!-- 内容区域 end -->
<script language = javascript>
  for(var i = 0; i < document.frmSub.taskStatus.length; i++)
  {
    if(document.frmSub.taskStatus[i].value == "<%=taskStatus%>")
    {
      	document.frmSub.taskStatus[i].selected = true;
        break;
    }
  }
</script>
</body>
</html>