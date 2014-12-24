<%@ page contentType="text/html;charset=GBK"%>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="base.task.util.StringUtil"/>

<jsp:directive.page import="java.util.Hashtable"/>
<jsp:directive.page import="base.task.monitor.log.vo.TaskLogVO"/>
<jsp:directive.page import="base.resource.util.page.Pagination"/>
<%
    String contextPath= request.getContextPath();
    List pageDBBean = (List) request.getAttribute("pageDBBean");
    if(pageDBBean== null) pageDBBean= new ArrayList();
    
    Hashtable taskHT= (Hashtable)request.getAttribute("taskHT"); 
    if(taskHT== null) taskHT= new Hashtable();

	String taskName = (String) request.getAttribute("taskName");
	String TIME1 = (String)request.getAttribute("TIME1");
    if (TIME1.length() >= 10) {
      TIME1 = TIME1.substring(0, 10);
    }
    String TIME2 = (String)request.getAttribute("TIME2");
    if (TIME2.length() >= 10) {
      TIME2 = TIME2.substring(0, 10);
    }
    
    String RUN_STATE= (String)request.getAttribute("RUN_STATE");
    if (RUN_STATE==null) {
      RUN_STATE="";
    }
  String navigation = "任务管理-&gt;任务历史日志查询";

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
		pagination.setVisitPageURL(contextPath+"/base/task/monitor/log/TaskLogListServlet?taskName="+taskName+"&RUN_STATE="+RUN_STATE+"&TIME1="+TIME1+"&TIME2="+TIME2);
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
	//if(sForm.TIME2.value != "")
	//{
	//   if (!_compareTwoDateForString(sForm.TIME2.value, _getCurrentDate(0)))
	//   {
	//	   alert("终止日期不能在当前日期之后！");
	//	   sForm.TIME2.focus();
	//	   return;
	//   }
	//}
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
	 sForm.action = "<%=contextPath%>/base/task/monitor/log/TaskLogListServlet";
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
				 &nbsp;任务名称：
                  <input type="text" name="taskName" fieldTitle="任务名称" fieldType ="hasSpecialChar" size="25" class="queryinput" value="<%=taskName%>">
                  &nbsp;运行结果：
                  <select name="RUN_STATE" id="RUN_STATE">
                     <option value="">【--全部--】</option>
                     <option value="0">正在运行</option>
                     <option value="1">成功</option>
                     <option value="2">失败</option>
                     <option value="3">异常</option>
                  </select>
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
                 <tr bgcolor="EAEAEA">
                    <th width="5%" align="center">序号</th>
                    <th width="20%" align="center">任务名称</th>
                    <th width="15%" align="center">开始时间</th>
                    <th width="15%" align="center">结束时间</th>
                    <th width="10%" align="center">运行结果</th>
                    <th width="35%" align="center">结果信息</th>
                </tr>
              <%
                                    for(int i=0 ;i<taskList.size(); i++){
                                    TaskLogVO tlvo= (TaskLogVO)taskList.get(i); 
                                    String TL_TASK_ID = tlvo.getTASK_ID();
                                    String TI_TASK_NAME = (String)taskHT.get(TL_TASK_ID);
                                    String TL_START_TIME = tlvo.getSTART_TIME();
                                    String TL_END_TIME = tlvo.getEND_TIME();
                                    TL_END_TIME="null".equals(TL_END_TIME)?"":TL_END_TIME;
                                    String TL_RUN_STATE = tlvo.getRUN_STATE();
                                    String TL_RUN_MSG = tlvo.getRUN_MSG();
                                    String TL_LOG_ID = tlvo.getID();
                                    if (TL_RUN_STATE.equals("0"))
                                    {
                                      TL_RUN_STATE = "正在运行";
                                    }
                                    else if (TL_RUN_STATE.equals("1"))
                                    {
                                      TL_RUN_STATE = "成功";
                                    }
                                    else if (TL_RUN_STATE.equals("2"))
                                    {
                                      TL_RUN_STATE = "失败";
                                    }
                                    else if (TL_RUN_STATE.equals("3"))
                                    {
                                      TL_RUN_STATE = "异常";
                                    }
              %>
                  <tr bgcolor="#FFFFFF">
                    <td align="center" width="39"> <%=i+1%> </td>
                    <td width="147">&nbsp;<a href="<%=contextPath%>/base/task/monitor/log/TaskLogDetailServlet?TL_LOG_ID=<%=TL_LOG_ID%>&TIME1=<%=TIME1%>&TIME2=<%=TIME2%>"><%=StringUtil.escapeHTMLTags(TI_TASK_NAME)%></a></td>
                    <td align="center" width="142"><%=TL_START_TIME%></td>
                    <td width="140" align="center"><%=TL_END_TIME%></td>
                    <td align="center" width="118"><%=TL_RUN_STATE%></td>
                    <td width="871">&nbsp;<%=StringUtil.HTMLEncode(TL_RUN_MSG)%> </td>
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
	document.getElementById("RUN_STATE").value="<%=RUN_STATE%>";
</script>
</body>
</html>