<%@ page contentType="text/html;charset=GBK"%>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="base.task.util.StringUtil"/>
<jsp:directive.page import="java.util.Hashtable"/>
<jsp:directive.page import="base.task.monitor.log.vo.JobLogVO"/>
<jsp:directive.page import="base.resource.util.page.Pagination"/>
<%
    String contextPath= request.getContextPath();
    List pageDBBean = (List) request.getAttribute("pageDBBean");
    if(pageDBBean== null) pageDBBean= new ArrayList();

    Hashtable taskLogListHT= (Hashtable)request.getAttribute("taskLogListHT");
	Hashtable JobListHT= (Hashtable)request.getAttribute("JobListHT");
	Hashtable TaskListHT= (Hashtable)request.getAttribute("TaskListHT");
	Hashtable JobListTHT= (Hashtable)request.getAttribute("JobListTHT");
	
	if(taskLogListHT==null) taskLogListHT= new Hashtable();
	if(JobListHT==null) JobListHT= new Hashtable();
	if(TaskListHT==null) TaskListHT= new Hashtable();
	
    
	String jobName = (String) request.getAttribute("jobName");
	String jobType = (String) request.getAttribute("jobType");
	if(jobName==null){
		jobName="";
	}
	if(jobType==null){
		jobType="";
	}
	String TIME1 = (String)request.getAttribute("TIME1");
    if (TIME1.length() >= 10) {
      TIME1 = TIME1.substring(0, 10);
    }
    String TIME2 = (String)request.getAttribute("TIME2");
    if (TIME2.length() >= 10) {
      TIME2 = TIME2.substring(0, 10);
    }
	String RUN_STATE1 = (String) request.getAttribute("RUN_STATE");
	
	Pagination pagination= null;
	String pageNumber= request.getParameter("pageNumber");
	int showItemNumber=10;
	if(pageNumber==null){
		pageNumber="1";
	}
	String HTML="";
	List taskList= new ArrayList();
	if(pageDBBean!=null&&pageDBBean.size()>0){
		pagination= new Pagination();
		pagination.setPageNumber(Integer.parseInt(pageNumber));
		pagination.setShowItemNumber(showItemNumber);
		pagination.setVisitPageURL(contextPath+"/base/task/monitor/log/JobLogListServlet?jobName="+jobName+"&jobType="+jobType+"&RUN_STATE1="+RUN_STATE1+"&TIME1="+TIME1+"&TIME2="+TIME2);
		taskList= pagination.interceptListByStartItemNumber(pageDBBean);
		HTML= pagination.buildHTML("100%","left","text01");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />

<script LANGUAGE="javascript" SRC="<%=contextPath%>/rwgl/js/jcommon.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/customString.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/formVerify2.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/verify.js"></script>
<link href="<%= contextPath %>/rwgl/css/calendar.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript" src="<%= contextPath %>/rwgl/js/calendar-setup.js"></script>
<script language="JavaScript" type="text/javascript" src="<%= contextPath %>/rwgl/js/calendar.js"></script>
<script language="JavaScript" type="text/javascript" src="<%= contextPath %>/rwgl/js/calendar-zh.js"></script>
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
<!--
function _submit()
{    

    var date= document.getElementById("TIME1");
    var edate= document.getElementById("TIME2");
    if(date.value.atrim() !=""){
       if(!date.value.isDate()){
	       alert("[开始时间]不符合日期格式标准！例如：2007-09-25");
	       date.select();
	       date.focus();
	       return;
       }
    }
    if(edate.value.atrim() !=""){
       if(!edate.value.isDate()){
	       alert("[结束时间]不符合日期格式标准！例如：2007-09-25");
	       edate.select();
	       edate.focus();
	       return;
       }
    }
	var sForm = document.frmSub;
	if(sForm.TIME1.value != "")
	{
	   if (!_compareTwoDateForString(sForm.TIME1.value, _getCurrentDate(0)))
	   {
		   alert("起始日期不能在当前日期之后！");
		   sForm.TIME1.focus();
		   return;
	   }
	}
	if(sForm.TIME2.value != "")
	{
	   if (!_compareTwoDateForString(sForm.TIME2.value, _getCurrentDate(0)))
	   {
		   alert("终止日期不能在当前日期之后！");
		   sForm.TIME2.focus();
		   return;
	   }
	}
    if (sForm.TIME1.value != "" && sForm.TIME2.value != "")
    {
		if (!_compareTwoDateForString(sForm.TIME1.value, sForm.TIME2.value))
		{
			alert("日期范围选择应该按照先后顺序填写！");
			sForm.TIME1.focus();
			return;
	     }
   }
   if(_check(frmSub)){ 
	 sForm.action = "<%=contextPath%>/base/task/monitor/log/JobLogListServlet";
       sForm.submit();
	}else{
	return}
   
}

//-->
</SCRIPT>
</head>
<body>
<form name="frmSub" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="text01" >
  
<tr>
        <td height="25" colspan="4">
				 <div id="query">
				 &nbsp;工作名称：
                 <input type="text" name="jobName" fieldTitle="工作名称" fieldType ="hasSpecialChar" size="25" class="queryinput" value="<%=jobName%>">
                 &nbsp;加工类型：
                 <select name="jobType" >
                      <option value="" <% if(jobType.equals("")) out.print("selected"); %>>全部</option>
                      <option value="01" <% if(jobType.equals("01")) out.print("selected"); %>>存储过程</option>
                      <option value="02" <% if(jobType.equals("02")) out.print("selected"); %>>普通JAVA程序</option>
                      <option value="03" <% if(jobType.equals("03")) out.print("selected"); %>>通用扩展接口</option>
                      <option value="04" <% if(jobType.equals("04")) out.print("selected"); %>>执行程序</option>
                      <option value="05" <% if(jobType.equals("05")) out.print("selected"); %>>SQL</option>
                      <option value="06" <% if(jobType.equals("06")) out.print("selected"); %>>URL</option>
                      <option value="07" <% if(jobType.equals("07")) out.print("selected"); %>>简单抽取</option>
                      <option value="08" <% if(jobType.equals("08")) out.print("selected"); %>>ETL</option>
                      <option value="09" <% if(jobType.equals("09")) out.print("selected"); %>>远程</option>                 
                  </select>
                  &nbsp;运行结果：
                  <select name="RUN_STATE" id="RUN_STATE">
                     <option value="">【--全部--】</option>
                     <option value="0">正在运行</option>
                     <option value="1">成功</option>
                     <option value="2">失败</option>
                     <option value="3">异常</option>
                     <option value="4">等待回执</option>
                  </select>
                 &nbsp;<br>
                   &nbsp;日&nbsp;&nbsp;期：
                 <input id="TIME1" name="TIME1" type="text" class="queryinput" size="10" value="<%=TIME1%>" ><img src="<%=contextPath%>/rwgl/image/datetime.gif" style="cursor:hand;" alt="弹出日历下拉菜单" width="16" height="16" onclick="return showCalendar('TIME1', '%Y-%m-%d');"/>

                    到
				<input id="TIME2" name="TIME2" type="text" class="queryinput" size="10" value="<%=TIME2%>" ><img src="<%=contextPath%>/rwgl/image/datetime.gif" style="cursor:hand;" alt="弹出日历下拉菜单" onClick="return showCalendar('TIME2', '%Y-%m-%d');">
                 &nbsp;<input type=button name="button3" value="查 询" class="input01"  onclick="_submit()">
				</div>		  
		</td>
</tr>	
 
<tr>
      <td colspan="4">
		<div id="primarydata" style="width:100%; overflow:hidden" >
              <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#9CC6F7" class="text01">
                <tr> 
                   <th width="5%" align="center" nowrap="nowrap">序号</th>
                    <th width="20%" align="center" nowrap="nowrap">工作名称</th>
                    <th width="10%" align="center" nowrap="nowrap">工作类型</th>  
                    <th width="10%" align="center" nowrap="nowrap">所属任务</th>
                    <th width="15%" align="center" nowrap="nowrap">开始时间</th>
                    <th width="15%" align="center" nowrap="nowrap">结束时间</th>
                    <th width="10%" align="center" nowrap="nowrap">运行结果</th>
                    
                </tr>
               <%
                                     for(int i=0;i<taskList.size(); i++){
                                     JobLogVO jlvo= (JobLogVO)taskList.get(i);
                                     String JOB_ID =jlvo.getJOB_ID();
                                    
                                     String JOB_NAME =(String)JobListHT.get(JOB_ID);
                                     String JOB_TYPE =(String)JobListTHT.get(JOB_ID);
                                     String TASK_LOG = jlvo.getTASK_LOG();
                                     
                                     String TI_TASK_NAME =(String)TaskListHT.get(taskLogListHT.get(TASK_LOG));
                                     String START_TIME =jlvo.getSTART_TIME();
                                     String END_TIME =jlvo.getEND_TIME();
                                     String RUN_STATE =jlvo.getRUN_STATE();
                                     String RUN_MSG =jlvo.getRUN_MSG();
                                     String LOG_ID =jlvo.getID();
                                     if (RUN_STATE.equals("0"))
                                     {
                                       RUN_STATE = "正在运行";
                                     }
                                     else if (RUN_STATE.equals("1"))
                                     {
                                       RUN_STATE = "成功";
                                     }
                                     else if (RUN_STATE.equals("2"))
                                     {
                                       RUN_STATE = "失败";
                                     }
                                     else if (RUN_STATE.equals("3"))
                                     {
                                       RUN_STATE = "异常";
                                     }
                                     String typeStr = "";
                                     if(JOB_TYPE.equals("01")){
                                       typeStr = "存储过程";
                                     }else if (JOB_TYPE.equals("02")){
                                       typeStr = "普通JAVA程序";
                                     }else if (JOB_TYPE.equals("03")){
                                       typeStr = "通用扩展接口";
                                     }else if (JOB_TYPE.equals("04")){
                                       typeStr = "执行程序";
                                     }else if (JOB_TYPE.equals("05")){
                                       typeStr = "SQL";
                                     }else if (JOB_TYPE.equals("06")){
                                       typeStr = "URL";
                                     }else if (JOB_TYPE.equals("07")){
                                       typeStr = "简单抽取";
                                     }else if (JOB_TYPE.equals("08")){
                                       typeStr = "ETL";
                                     }else if (JOB_TYPE.equals("09")){
                                       typeStr = "远程";
                                     }
               %>
                <TR bgcolor="#FFFFFF">
                    <TD align="center" width="49"> <%=i+1%></TD>
               <%
               if(JOB_TYPE.equals("09")) {
               %>    
                    <TD >&nbsp;<A href="<%=contextPath%>/base/task/monitor/log/SendLogListServlet?JOBLOG_ID=<%=LOG_ID%>&TIME1=<%=TIME1%>&TIME2=<%=TIME2%>"><%=StringUtil.escapeHTMLTags(JOB_NAME)%></A></TD>  
               <%
                 }else{
                 %>      
                    <TD >&nbsp;<%=StringUtil.escapeHTMLTags(JOB_NAME)%></TD>
                <%
                }
                %>    
                    <TD >&nbsp;<%=typeStr%></TD>
                    <TD >&nbsp;<%=StringUtil.escapeHTMLTags(TI_TASK_NAME)%></TD>
                    <TD ><%=START_TIME%></TD>
                    <TD ><%=END_TIME%></TD>
                    <TD ><%=RUN_STATE%></TD>
				    
				</TR>
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
  <!--  
  <tr align="center"> 
    <td colspan="4"> 
      <input type=hidden name="currentPage" value="1">
      <input type=button name="button2" value="删 除" class="input01" onClick="_del()" >
    </td>
  </tr>
  -->    
</table>
</form>
<script type="text/javascript">
	document.getElementById("RUN_STATE").value="<%=RUN_STATE1%>";
</script>
</body>
</html>