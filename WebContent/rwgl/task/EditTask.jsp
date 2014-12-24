<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="base.task.resource.task.vo.TaskVo"%>
<%@ page import="base.task.base.conf.SystemConfig"%>
<%@ page import="base.task.util.DateUtil"%>
<%@ page import="base.task.util.StringUtil"%>
<jsp:directive.page import="base.common.util.DateUtils"/>
<%
	String contextPath = request.getContextPath();
	TaskVo taskvo = (TaskVo) request.getAttribute("task");
	
	String run_state= taskvo.getRun_state();
	String flag = taskvo.getSchedule_flag();
	String type = taskvo.getSchedule_type();
	String value = taskvo.getSchedule_detail();
	String endDate = "";
	String endTime = "";
	if (taskvo.getEnd_time() != null) {
	    endDate = DateUtil.formatDate(taskvo.getEnd_time().getTime());
		SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
        endTime = df.format(taskvo.getEnd_time().getTime());
	}

	String status = taskvo.getStatus()==null?SystemConfig.STATUS_PRODUCE:taskvo.getStatus();//modify by yinxk 2008-3-16
	String isDisabled = "";
	String disabledString = "";
	if (status != null
	&& status.trim().equals(SystemConfig.STATUS_PRODUCE)) {
		isDisabled = " disabled='true' ";
		disabledString = "＝》<font color='red'>任务处于生产状态，不许修改</font>";
	}

	String taskJobCount = (String) request.getAttribute("taskJobCount");
	if (taskJobCount == null)
		taskJobCount = "";
	String isDisabled1 = "";
	String disabledString1 = "";
	if (taskJobCount == null || !taskJobCount.equals("1")) {
		isDisabled1 = " disabled='true' ";
		disabledString1 = "＝》<font color='red'>任务中没有工作，不许修改状态</font>";
	}
	SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
    String beginTime = df.format(taskvo.getStart_time().getTime());
    
	//System.out.println("DateUtil.formatDate(taskvo.getStart_time().getTime())==="+DateUtil.formatDate(taskvo.getStart_time().getTime()));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet"
			type="text/css" />
		<link href="<%= contextPath %>/rwgl/css/calendar.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript" src="<%= contextPath %>/rwgl/js/calendar-setup.js"></script>
<script LANGUAGE="javascript" SRC="<%= contextPath %>/rwgl/js/calendar.js"></script>
<script language="JavaScript" type="text/javascript" src="<%= contextPath %>/rwgl/js/calendar-zh.js"></script>
		<script LANGUAGE="javascript" SRC="<%=contextPath%>/rwgl/js/jcommon.js"></script>
		<script LANGUAGE="javascript" SRC="<%= contextPath %>/rwgl/js/extendString.js"></script>
		<script LANGUAGE="javascript" SRC="<%= contextPath %>/rwgl/js/formVerify.js"></script>
		<script LANGUAGE="javascript" SRC="<%= contextPath %>/rwgl/js/runFormVerify.js"></script>
		<title>编辑任务</title>
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
	</head>
	<SCRIPT LANGUAGE="JavaScript">
<!--
	var RowCount = 1

//检查表单
function _checkFrm()
{
   var sForm = document.frmSub;
   var TASK_NAME = sForm.TASK_NAME.value;
   var weekstr   = "";
   var tendaystr = "";
   var tempstr   = "";
   var monthstr  = "";
   var detailstr = "";

   if(TASK_NAME == "")
   {
     alert("任务名称不能为空！");
     sForm.TASK_NAME.focus();
     return;
   }

  // var TIME_OUT	= sForm.TIME_OUT.value;
 //  var FORCAST_TIME	= sForm.FORCAST_TIME.value;

  // if(TIME_OUT!=""){
	//   if(!is_positiveInt(TIME_OUT)){
	//			alert("请输入正整数，且少于100000000");
	//			sForm.TIME_OUT.focus();
	//			return;
	//   }
  // }

  // if(FORCAST_TIME!=""){
	//   if(!is_positiveInt(FORCAST_TIME)){
	//			alert("请输入正整数，且少于100000000");
	//			sForm.FORCAST_TIME.focus();
	//			return;
	//   }
  // }

    if (sForm.START_DATE.value == "")
    {
        alert("请输入开始日期！");
        sForm.START_DATE.focus();
        sForm.START_DATE.select();
        return false;
    }

    if (sForm.START_TIME.value == "")
    {
        alert("请输入开始时间！");
        sForm.START_TIME.focus();
        sForm.START_TIME.select();
        return false;
    }
    if(!ratifyTime(sForm.START_TIME)){
		sForm.START_TIME.focus();
		alert("请输入正确的时间格式！");
		return false;
	}

	if((!(sForm.END_DATE.value == ""))&&(sForm.END_TIME.value == "")){
			alert("请输入结束时间或不指定结束日期！");
			sForm.END_TIME.focus();
			sForm.END_TIME.select();
			return false;
	}
    if(!(sForm.END_TIME.value == "")){
		if(sForm.END_DATE.value == ""){
			alert("请输入结束日期或不指定结束时间！");
			sForm.END_DATE.focus();
			sForm.END_DATE.select();
			return false;
		}

		if(!ratifyTime(sForm.END_TIME)){
			sForm.END_TIME.focus();
			alert("请输入正确的时间格式！");
			return false;
		}
	}
	
	var startTime= sForm.START_DATE.value.trim()+" "+sForm.START_TIME.value.trim();
	//var date=new Date();
	//var current=date.getYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds()
	var current="<%= DateUtils.getDate(null)%>";
	if(!startTime.trim().isAfterDateTime(current)){
	   alert("开始时间要在当前时间之后！");
			sForm.START_TIME.focus();
			sForm.START_TIME.select();
			return;
	}
	
	var endTime= sForm.END_DATE.value.trim()+" "+sForm.END_TIME.value.trim();
	if(startTime.trim()!="" && endTime.trim()!=""){
		if(!endTime.trim().isAfterDateTime(startTime)){
			alert("结束时间要在开始时间之后！");
			sForm.END_DATE.focus();
			sForm.END_DATE.select();
			return;
		}
	}
   // var MAX_TIME = sForm.MAX_TIME.value;
   // if(MAX_TIME!=""){
   //    if(!is_positiveInt(MAX_TIME)){
   //             alert("请输入正整数，且少于100000000");
   //             sForm.MAX_TIME.focus();
   //             return;
   //    }
   // }

   var type	=   sForm.SCHEDULE_TYPE.options[sForm.SCHEDULE_TYPE.selectedIndex].value;

   if(type=="ss" || type =="mi"	|| type =="hh" || type =="dd"){
		sForm.SCHEDULE_FLAG.value = "1";
   }else if(type=="ww" || type =="qq"	|| type =="mm"){
		sForm.SCHEDULE_FLAG.value = "2";
   }else{
	   sForm.SCHEDULE_FLAG.value = "0";
   }

   if(type=="00"){
		detailstr = sForm.START_DATE.value + " " + sForm.START_TIME.value;
   }

   if(type=="ss"){
	   if(sForm.SECOND.value == ""){
			alert("秒间隔不能为空！");
			sForm.SECOND.focus();
			return;
	   }
	   if(is_positiveInt(sForm.SECOND.value)== false){
			alert("秒间隔是正整数，且少于100000000！");
			sForm.SECOND.focus();
			return;
	   }
	   detailstr =  sForm.SECOND.value ;
   }
   if(type=="mi"){
	   if(sForm.MINUTE.value == ""){
			alert("分间隔不能为空！");
			sForm.MINUTE.focus();
			return;
	   }
	   if(is_positiveInt(sForm.MINUTE.value)== false){
			alert("分间隔是正整数，且少于100000000！");
			sForm.MINUTE.focus();
			return;
	   }
	   detailstr =  sForm.MINUTE.value ;
   }
   if(type=="hh"){
	   if(sForm.HOUR.value == ""){
			alert("小时间隔不能为空！");
			sForm.HOUR.focus();
			return;
	   }
	   if(is_positiveInt(sForm.HOUR.value)== false){
			alert("小时间隔是正整数，且少于100000000！");
			sForm.HOUR.focus();
			return;
	   }
	   detailstr =  sForm.HOUR.value ;
   }
   if(type=="yy"){
	   if(sForm.YEAR.value == ""){
			alert("年间隔不能为空！");
			sForm.YEAR.focus();
			return;
	   }
	   if(is_positiveInt(sForm.YEAR.value)== false){
			alert("年间隔是正整数，且少于100000000！");
			sForm.YEAR.focus();
			return;
	   }
	   detailstr =  sForm.YEAR.value ;
   }
   if(type=="dd"){
	   if(sForm.DAY.value == ""){
			alert("天间隔不能为空！");
			sForm.DAY.focus();
			return;
	   }
	   if(is_positiveInt(sForm.DAY.value)== false){
			alert("天间隔是正整数，且少于100000000！");
			sForm.DAY.focus();
			return;
	   }
	   detailstr =  sForm.DAY.value ;
   }
   if(type=="ww"){
	   for(var i=0; i< sForm.WEEK.length;i++){
		   if(sForm.WEEK[i].checked == true){
			   if(weekstr == "") weekstr = sForm.WEEK[i].value;
			  else				 weekstr = weekstr + "," + sForm.WEEK[i].value
		   }
	   }
	   if(weekstr == ""){
			alert("请设置周调度方式！");
			sForm.WEEK[0].focus();
			return;
	   }
	   detailstr =  weekstr ;
   }

   if(type=="qq"){
		if((sForm.TEN1.value=="") && (sForm.TEN2.value=="") && (sForm.TEN3.value=="")){
			alert("请设置旬调度方式！");
			sForm.TEN1.focus();
		}
		if(!(sForm.TEN1.value == "")){
			tendaystr =  sForm.TEN1.value;
			if(!is_positiveInt(tendaystr)){
				alert("请输入正整数");
				sForm.TEN1.focus();
				return;
			}
			if(parseInt(tendaystr) > 10){
				alert("请不要输入大于10的正整数");
				sForm.TEN1.focus();
				return;
			}
		}

		if(!(sForm.TEN2.value =="")) {
			tempstr = sForm.TEN2.value;
			if(!is_positiveInt(tempstr)){
				alert("请输入正整数");
				sForm.TEN2.focus();
				return;
			}
			if((parseInt(tempstr) > 20) || (parseInt(tempstr) < 10)){
				alert("请不要输入10到20的正整数");
				sForm.TEN2.focus();
				return;
			}

			if(tendaystr== "")  tendaystr = tempstr;
			else				tendaystr = tendaystr + "," + tempstr;
		}

		if(!(sForm.TEN3.value =="")) {
			tempstr = sForm.TEN3.value;
			if(!is_positiveInt(tempstr)){
				alert("请输入正整数");
				sForm.TEN3.focus();
				return;
			}
			if((parseInt(tempstr) > 31) || (parseInt(tempstr) < 20)){
				alert("请不要输入20到31的正整数");
				sForm.TEN3.focus();
				return;
			}

			if(tendaystr== "")  tendaystr = tempstr;
			else				tendaystr = tendaystr + "," + tempstr;
		}

		detailstr =  tendaystr ;
   }

   if(type=="mm"){
	   if((sForm.LastDay.checked==false)&&(sForm.MonthDays.value == "")){
				alert("请输入日期");
				sForm.MonthDays.focus();
				return;
	   }

	   if(sForm.LastDay.checked)   monthstr = "0";

	   var tempstr     = sForm.MonthDays.value;
	   var montharray  = tempstr.split(",");

	   for(var i=0; i< montharray.length;i++)
	   {
    	   if(!is_positiveInt(montharray[i])){
				alert("请输入正确的日期");
				sForm.MonthDays.focus();
				return;
			}
			if((parseInt(montharray[i]) > 31) ){
				alert("请要输入正确的日期");
				sForm.MonthDays.focus();
				return;
			}

			if(monthstr == "")  monthstr = montharray[i];
			else				monthstr = monthstr + "," + montharray[i];
       }

	   detailstr =  monthstr ;
   }

   sForm.SCHEDULE_DETAIL.value = detailstr;

   if (sForm.STATUS.value == "1")
   {
      var _currentDatetime = _getCurrentDate(3);
      if(type=="00")
      {
        detailstr = sForm.START_DATE.value + " " + sForm.START_TIME.value;

        if (_currentDatetime > detailstr)
        {
            alert("现在已经过了该工作的开始时间，不能置为生产状态！");
            return;
        }
      }
      else
      {
         if (sForm.END_DATE.value != "" && sForm.END_TIME.value != "")
         {
            detailstr = sForm.END_DATE.value + " " + sForm.END_TIME.value;
            //alert(detailstr);
            if (_currentDatetime > detailstr)
            {
                alert("现在已经过了该工作的结束时间，不能置为生产状态！");
                return;
            }
         }

      }
   }


   sForm.action="<%=contextPath%>/base/task/resource/task/SaveTaskServlet";
   sForm.submit();
}

function _return()
{
	window.location.href="<%=contextPath%>/base/task/resource/task/TaskListServlet";
}

function changeLastDay(){
	var sForm	=	document.frmSub;
	if(sForm.LastDay.checked){
		sForm.MonthDays.value = "";
		sForm.MonthDays.disabled = true;
	}else{
		sForm.MonthDays.disabled = false;
	}
}

function changeScheduleType()
{
    var sForm   =   document.frmSub;
    var type    =   sForm.SCHEDULE_TYPE.options[sForm.SCHEDULE_TYPE.selectedIndex].value;

    rowobj  = document.all.detail.rows[1];
    cellobj = rowobj.cells[0];
    document.getElementById("detail").style.display = "";
    if(type == "ss"){
        cellobj.innerHTML = "间隔&nbsp;&nbsp;<input type=text name=SECOND class=inputtxt size=12 >&nbsp;&nbsp;秒";
    }else if(type == "mi"){
        cellobj.innerHTML = "间隔&nbsp;&nbsp;<input type=text name=MINUTE class=inputtxt size=12 >&nbsp;&nbsp;分钟";

    }else if(type == "hh"){
        cellobj.innerHTML = "间隔&nbsp;&nbsp;<input type=text name=HOUR class=inputtxt size=12 >&nbsp;&nbsp;小时";

    }else if(type == "dd"){
        cellobj.innerHTML = "间隔&nbsp;&nbsp;<input type=text name=DAY class=inputtxt size=12 >&nbsp;&nbsp;天";

    }else if(type == "yy"){
        cellobj.innerHTML = "间隔&nbsp;&nbsp;<input type=text name=YEAR class=inputtxt size=12 >&nbsp;&nbsp;年";

    }else if(type == "ww"){
        cellobj.innerHTML = "<input type=checkbox name=WEEK value=1 >星期一"   +
                            "<input type=checkbox name=WEEK value=2 >星期二"       +
                            "<input type=checkbox name=WEEK value=3 >星期三"       +
                            "<input type=checkbox name=WEEK value=4 >星期四"       +
                            "<input type=checkbox name=WEEK value=5 >星期五"       +
                            "<input type=checkbox name=WEEK value=6 >星期六"       +
                            "<input type=checkbox name=WEEK value=7 >星期日"   ;

    }else if(type == "qq"){
        cellobj.innerHTML = "上旬&nbsp;&nbsp;<input type=text name=TEN1 class=inputtxt size=4 >&nbsp;&nbsp;号&nbsp;&nbsp;" +
                            "中旬&nbsp;&nbsp;<input type=text name=TEN2 class=inputtxt size=4 >&nbsp;&nbsp;号&nbsp;&nbsp;" +
                            "下旬&nbsp;&nbsp;<input type=text name=TEN3 class=inputtxt size=4 >&nbsp;&nbsp;号" ;

    }else if(type == "mm"){
        cellobj.innerHTML = "每月&nbsp;&nbsp;<input type=text name=MonthDays class=inputtxt size=12 >&nbsp;&nbsp;号(以,分隔)&nbsp;&nbsp;" +
                            "<input type=checkbox name=LastDay value=0  >&nbsp;&nbsp;最后一天";

    }else{
        cellobj.innerHTML = "&nbsp;";
        document.getElementById("detail").style.display = "none";
    }

}

//-->
</SCRIPT>
	<body>
		<form method="post" name="frmSub">
			
			<br>
			<br>
			<table width="60%" border="0" cellpadding="1" cellspacing="1"
				align="center" class="text01" bgcolor="#FFFFFF">
				<tr>
					<td>
						<fieldset>
							<table width="100%" border="0" cellpadding="1" cellspacing="1"
								align="center">
								<tr>
									<td align="left" nowrap>
										任务名称：
									</td>
									<td>
										<input type="text" <%=isDisabled%> name="TASK_NAME" size="20"
											value="<%=taskvo.getTask_name()%>" maxlength="100"><font color="red">*</font>
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										生产状态：
									</td>
									<td>
										<select name="STATUS" <%=isDisabled%> <%=isDisabled1%>>
											<option value="<%=SystemConfig.STATUS_DEVELOP%>"
												<%
												if(status.equals(SystemConfig.STATUS_DEVELOP)) 
   out.print("selected"); //System.out.println("aaaaaaaaaaaaaaaa");%>>
												开发
											</option>
											<option value="<%=SystemConfig.STATUS_PRODUCE%>"
												<%  
												if(status.equals(SystemConfig.STATUS_PRODUCE)) 
   out.print("selected"); %>>
												生产
											</option>
										</select>
										<%=disabledString%>
										<%=disabledString1%>
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										运行方式：
									</td>
									<td>
										<%
															String constr = "";
															String bystr = "";
															if (taskvo.getRun_type().equals("0"))
														constr = "selected";
															if (taskvo.getRun_type().equals("1"))
														bystr = "selected";
										%>
										<select name="RUN_TYPE" <%=isDisabled%>>
											<option value="0" <%=constr%>>
												串行
											</option>
											<option value="1" <%=bystr%>>
												并行
											</option>
										</select>
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										运行前提：
									</td>
									<td>
										<%
															String stopstr = "";
															String gostr = "";
															if (taskvo.getContinue_flag().equals("0"))
														stopstr = "selected";
															if (taskvo.getContinue_flag().equals("1"))
														gostr = "selected";
										%>

										<select name="CONTINUE_FLAG" <%=isDisabled%>>
											<option value="0" <%=stopstr%>>
												工作执行失败停止
											</option>
											<option value="1" <%=gostr%>>
												工作执行失败继续
											</option>
										</select>
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										优先级：
									</td>
									<td>
										<select name="PRIORITY" <%=isDisabled%>>
											<option value="0" selected>
												0
											</option>
											<option value="1">
												1
											</option>
											<option value="2">
												2
											</option>
											<option value="3">
												3
											</option>
											<option value="4">
												4
											</option>
											<option value="5">
												5
											</option>
											<option value="6">
												6
											</option>
											<option value="7">
												7
											</option>
											<option value="8">
												8
											</option>
											<option value="9">
												9
											</option>
											<option value="10">
												10
											</option>
										</select>
									</td>
								</tr>
								<!--  
								<tr>
									<td align="left" nowrap>
										任务超时设置（秒）：
									</td>
									<%
									   //String time_out_int="";
									   //if(taskvo.getTime_out()!=0){
									   	//time_out_int= new Integer(taskvo.getTime_out()).toString();
									   //}
									 %>
									<td>
										<input type="text" <%=isDisabled%> value="time_out_int"
											name="TIME_OUT" size="10" maxlength="15">
									</td>
								</tr>
								
								<tr>
									<td align="left" nowrap>
										预测运行时间（秒）：
									</td>
									<%
									   //String Forcast_time_int="";
									   //if(taskvo.getForcast_time()!=0){
									   	//Forcast_time_int= new Integer(taskvo.getForcast_time()).toString();
									  //}
									 %>
									<td>
										<input type="text" <%=isDisabled%> value="Forcast_time_int"
											name="FORCAST_TIME" size="10" maxlength="15">
									</td>
								</tr>
								-->
								<tr>
									<td align="left" nowrap>
										调度方式：
									</td>
									<td>
										<select name="SCHEDULE_TYPE" onchange="changeScheduleType()">
											<OPTION value="" <% if(type==null) out.print("selected"); %>>
												不调度
											</OPTION>
											<option value="00"
												<% if("00".equals(type)) out.print("selected"); %>>
												固定时间
											</option>
											<!--												<option value="ss" <% if("ss".equals(type)) out.print("selected"); %>>秒间隔</option>
												<option value="mi" <% if("mi".equals(type)) out.print("selected"); %>>分间隔</option>             -->
											<option value="mi"
												<% if("mi".equals(type)) out.print("selected"); %>>
												分钟间隔
											</option>
											<option value="hh"
												<% if("hh".equals(type)) out.print("selected"); %>>
												小时间隔
											</option>
											<option value="dd"
												<% if("dd".equals(type)) out.print("selected"); %>>
												天间隔
											</option>
											<option value="yy"
												<% if("yy".equals(type)) out.print("selected"); %>>
												年间隔
											</option>
											<option value="ww"
												<% if("ww".equals(type)) out.print("selected"); %>>
												每周
											</option>
											<!--<option value="qq" <% if("qq".equals(type)) out.print("selected"); %>>每旬</option>           -->
											<option value="mm"
												<% if("mm".equals(type)) out.print("selected"); %>>
												每月
											</option>
										</select>
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										开始日期：
									</td>
									<td><input type="text" name="START_DATE" value="<%=DateUtil.formatDate(taskvo.getStart_time().getTime())%>" size="10" maxlength="15" readonly><img src="<%=contextPath%>/rwgl/image/datetime.gif" style="cursor:hand;" alt="弹出日历下拉菜单" onClick="return showCalendar('START_DATE','%Y-%m-%d');">
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										开始时间：
									</td>
									<td>
										<input type="text" name="START_TIME" size="10" maxlength="15" value="<%=beginTime%>">
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										结束日期：
									</td>
									<td><input type="text" name="END_DATE" size="10" maxlength="15" value="<%=endDate%>"  ><img src="<%=contextPath%>/rwgl/image/datetime.gif" style="cursor:hand;" alt="弹出日历下拉菜单" onClick="return showCalendar('END_DATE','%Y-%m-%d');">
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										结束时间：
									</td>
									<td>
										<input type="text" name="END_TIME" size="10" maxlength="15"  value="<%=endTime%>">
									</td>
								</tr>
								<!--  
								<tr>
									<td align="left" nowrap>
										最大运行时间：
									</td>
									<%
										//String max_time_str="";
										//if(taskvo.getMax_time()!=0){
										//	max_time_str= String.valueOf(taskvo.getMax_time());
										//}
									 %>
									<td>
										<input type="text" name="MAX_TIME" size="10" maxlength="15" value="max_time_str%>">
									</td>
								</tr>
								-->
								<tr>
									<td align="left" nowrap>
										任务说明：
									</td>
									<td>
										<input type="text" <%=isDisabled%> name="DESCRIPTION" size="30" maxlength="100" value="<%=taskvo.getDescription()%>">
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<table id="detail" width="100%">
											<TBODY>
												<TR align=CENTER bgColor=#999999 height=20>
													<TD height="24" colspan="2" class="css-01">
														<div align="center">
															调度明细信息
														</div>
													</TD>
												</TR>
												<tr valign="top">
													<td>
														<%
																			if (type!=null && type.trim().length()!=0){
																			if(type.equals("00"))  out.print("&nbsp;");
																			if(type.equals("ss")){
														%>
																间隔&nbsp;&nbsp;<input type=text <%=isDisabled%> name=SECOND class=inputtxt size=12 value="<%=value%>">&nbsp;&nbsp;秒
														<%
																			}
																			if(type.equals("mi")){
														%>
																间隔&nbsp;&nbsp;<input type=text <%=isDisabled%> name=MINUTE class=inputtxt size=12  value="<%=value%>">&nbsp;&nbsp;分
														<%
																			}

																			if(type.equals("hh")){
														%>
																间隔&nbsp;&nbsp;<input type=text<%=isDisabled%>  name=HOUR class=inputtxt size=12 value="<%=value%>">&nbsp;&nbsp;小时
														<%
																			}
																			if(type.equals("dd")){
														%>
																间隔&nbsp;&nbsp;<input type=text <%=isDisabled%> name=DAY class=inputtxt size=12 value="<%=value%>">&nbsp;&nbsp;天
														<%
																			}
																			if(type.equals("yy")){
														%>
																间隔&nbsp;&nbsp;<input type=text <%=isDisabled%> name=YEAR class=inputtxt size=12 value="<%=value%>">&nbsp;&nbsp;年
														<%
																			}
																			if(type.equals("ww")){
																				String[] dayarray   = StringUtil.convertToArray(value,",");
																				ArrayList list		= new ArrayList();
																				for(int i=0; i< dayarray.length;i++) list.add(dayarray[i]);
														%>
																<input type=checkbox<%=isDisabled%>  name=WEEK value=1 <% if(list.contains("1")) out.println("checked"); %>>周一
																<input type=checkbox<%=isDisabled%>  name=WEEK value=2 <% if(list.contains("2")) out.println("checked"); %>>周二
																<input type=checkbox<%=isDisabled%>  name=WEEK value=3 <% if(list.contains("3")) out.println("checked"); %>>周三
																<input type=checkbox<%=isDisabled%>  name=WEEK value=4 <% if(list.contains("4")) out.println("checked"); %>>周四
																<input type=checkbox<%=isDisabled%>  name=WEEK value=5 <% if(list.contains("5")) out.println("checked"); %>>周五
																<input type=checkbox<%=isDisabled%>  name=WEEK value=6 <% if(list.contains("6")) out.println("checked"); %>>周六
																<input type=checkbox<%=isDisabled%>  name=WEEK value=7 <% if(list.contains("7")) out.println("checked"); %>>周日
														<%
																					}
																					if(type.equals("qq")){
																						String[] dayarray   = StringUtil.convertToArray(value,",");
																						String TEN1="";
																						String TEN2="";
																						String TEN3="";
																						for(int i=0; i< dayarray.length;i++){
																							if(Integer.parseInt(dayarray[i])< 11)      TEN1= dayarray[i];
																							else if(Integer.parseInt(dayarray[i])< 21) TEN2= dayarray[i];
																							else			   TEN3= dayarray[i];
																						}
																%>
															上旬&nbsp;&nbsp;	<input type=text name=TEN1 class=inputtxt size=4 value="<%=TEN1%>">&nbsp;&nbsp;号
															中旬&nbsp;&nbsp;	<input type=text name=TEN2 class=inputtxt size=4 value="<%=TEN2%>">&nbsp;&nbsp;号
															下旬&nbsp;&nbsp;	<input type=text name=TEN3 class=inputtxt size=4 value="<%=TEN3%>">&nbsp;&nbsp;号
														<%
						}
						if(type.equals("mm")){
							String checkstr = "";
							String monthstr = "";
							String[] days = StringUtil.convertToArray(value,",");
							for(int k=0; k< days.length;k++){
								if(days[k].equals("0")) checkstr = "checked";
								else{
							if(monthstr.equals("")) monthstr = days[k];
							else			monthstr = monthstr + "," + days[k];
								}
							}
	%>
																每月&nbsp;&nbsp;<input type=text name=MonthDays class=inputtxt size=12 value="<%= monthstr %>">&nbsp;&nbsp;号(以,分隔)&nbsp;&nbsp;
																<input type=checkbox name=LastDay value=0  <%=checkstr %> >&nbsp;&nbsp;最后一天
														<%
															}
														}
														%>
													</td>
												</tr>
											</TBODY>
										</table>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
			</table>
			<br>
			<table width="60%" border="0" cellpadding="1" cellspacing="1"
				align="center" class="text01">
				<tr>
					<td align="center">
						<input type="button" name="next" <%=isDisabled %>  value="保存" onClick="_checkFrm()"
							class="input01">
						&nbsp;&nbsp;
						<input type="button" name="cancel" value="返回" onClick="_return()"
							class="input01">
						<input type=hidden  name="SCHEDULE_DETAIL" value="<%= value %>">
						<input type=hidden  name="SCHEDULE_FLAG" value="<%= flag %>">
						<input type=hidden  name="ID" value="<%=taskvo.getId()%>">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
<!-- 内容区域 end -->
<script language = javascript>
	var sForm			=	document.frmSub;
    var priority		=	sForm.PRIORITY;

    for(var i = 0; i < priority.length; i++)
    {
       if(priority.options[i].value == "<%= taskvo.getPriority()%>")
       {
      	  priority.options[i].selected = true;
          break;
      }
   }
   var type = sForm.SCHEDULE_TYPE.options[sForm.SCHEDULE_TYPE.selectedIndex].value;
   if(type=="" || type=="00"){
        document.getElementById("detail").style.display = "none";
   }
</script>
<!-- Tail begin -->
