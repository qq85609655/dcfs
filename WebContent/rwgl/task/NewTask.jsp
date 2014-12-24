<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<jsp:directive.page import="base.common.util.DateUtils"/>
<%
	String contextPath = request.getContextPath();
	SimpleDateFormat formater1 = new java.text.SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat formater2 = new java.text.SimpleDateFormat("HH:mm:ss");
	 
	String currentDate = formater1.format(new Date());
	String currentTime = formater2.format(new Date());
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="<%=contextPath %>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath %>/rwgl/css/calendar.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%= contextPath %>/rwgl/js/calendar-setup.js"></script>
<script LANGUAGE="javascript" SRC="<%= contextPath %>/rwgl/js/calendar.js"></script>
<script language="JavaScript" src="<%= contextPath %>/rwgl/js/calendar-zh.js"></script>
<script LANGUAGE="javascript" SRC="<%= contextPath %>/rwgl/js/jcommon.js"></script>
<script LANGUAGE="javascript" SRC="<%= contextPath %>/rwgl/js/extendString.js"></script>
<script LANGUAGE="javascript" SRC="<%= contextPath %>/rwgl/js/formVerify.js"></script>
<script LANGUAGE="javascript" SRC="<%= contextPath %>/rwgl/js/runFormVerify.js"></script>

<title>新建任务</title>
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

   //var TIME_OUT	= sForm.TIME_OUT.value;
   //var FORCAST_TIME	= sForm.FORCAST_TIME.value;

   //if(TIME_OUT!=""){
	//   if(!is_positiveInt(TIME_OUT)){
	//			alert("请输入正整数,且少于100000000！");
	//			sForm.TIME_OUT.focus();
	//			return;
	//   }
   //}

   //if(FORCAST_TIME!=""){
	//   if(!is_positiveInt(FORCAST_TIME)){
	//			alert("请输入正整数,且少于100000000！");
	//			sForm.FORCAST_TIME.focus();
	//			return;
	 //  }
 //  }

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
	//if(!startTime.trim().isAfterDateTime(current)){
	//   alert("开始时间要在当前时间之后！");
	//		sForm.START_TIME.focus();
	//		sForm.START_TIME.select();
	//		return;
	//}
	var endTime= sForm.END_DATE.value.trim()+" "+sForm.END_TIME.value.trim();
	
	//if(startTime.trim()!="" && endTime.trim()!=""){
	//	if(!endTime.trim().isAfterDateTime(startTime)){
	//		alert("结束时间要在开始时间之后！");
	//		sForm.END_DATE.focus();
	//		sForm.END_DATE.select();
	//		return;
	//	}
	//}
	
    //var MAX_TIME = sForm.MAX_TIME.value;
    //if(MAX_TIME!=""){
    //   if(!is_positiveInt(MAX_TIME)){
     //           alert("请输入正整数,且少于100000000！");
     //           sForm.MAX_TIME.focus();
     //           return;
     //  }
    //}

   var type	=   sForm.SCHEDULE_TYPE.options[sForm.SCHEDULE_TYPE.selectedIndex].value;
    
    
	
   if(type=="ss" || type =="mi"	|| type =="hh" || type =="dd" || type=="yy"){
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

	   var tempstr	   = sForm.MonthDays.value;
	   var montharray  = tempstr.split(",");

	   for(var i=0; i< montharray.length;i++)
	   {
    	   if(!is_positiveInt(montharray[i])){
				alert("请输入正确的日期");
				sForm.MonthDays.focus();
				return;
			}
			if((parseInt(montharray[i]) > 31) ){
				alert("请输入小于等于31的正整数");
				sForm.MonthDays.focus();
				return;
			}

			if(monthstr == "")  monthstr = montharray[i];
			else				monthstr = monthstr + "," + montharray[i];
       }

	   detailstr =  monthstr ;
   }

   sForm.SCHEDULE_DETAIL.value = detailstr;

   sForm.action="<%= contextPath %>/base/task/resource/task/AddTaskServlet";
   sForm.submit();
}

function _return()
{
	window.location.href="<%= contextPath %>/base/task/resource/task/TaskListServlet";
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
	var sForm	=	document.frmSub;
	var type	=   sForm.SCHEDULE_TYPE.options[sForm.SCHEDULE_TYPE.selectedIndex].value;

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

	}else if(type == "ww"){
		cellobj.innerHTML = "<input type=checkbox name=WEEK value=1 >周一 "	+
							"<input type=checkbox name=WEEK value=2 >周二 "	+
							"<input type=checkbox name=WEEK value=3 >周三 "	+
							"<input type=checkbox name=WEEK value=4 >周四 "	+
							"<input type=checkbox name=WEEK value=5 >周五 "	+
							"<input type=checkbox name=WEEK value=6 >周六 "	+
							"<input type=checkbox name=WEEK value=7 >周日 "	;

	}else if(type == "qq"){
		cellobj.innerHTML = "上旬&nbsp;&nbsp;<input type=text name=TEN1 class=inputtxt size=4 >&nbsp;&nbsp;号&nbsp;&nbsp;" +
							"中旬&nbsp;&nbsp;<input type=text name=TEN2 class=inputtxt size=4 >&nbsp;&nbsp;号&nbsp;&nbsp;" +
							"下旬&nbsp;&nbsp;<input type=text name=TEN3 class=inputtxt size=4 >&nbsp;&nbsp;号" ;

	}else if(type == "mm"){
		cellobj.innerHTML = "每月&nbsp;&nbsp;<input type=text name=MonthDays class=inputtxt size=12 >&nbsp;&nbsp;号(以,分隔)&nbsp;&nbsp;" +
							"<input type=checkbox name=LastDay value=0  >&nbsp;&nbsp;最后一天";
	
	}else if(type == "yy"){
		cellobj.innerHTML = "间隔&nbsp;&nbsp;<input type=text name=YEAR class=inputtxt size=12 >&nbsp;&nbsp;年";
	
	}else{
		cellobj.innerHTML = "&nbsp;";
        document.getElementById("detail").style.display = "none";
	}

}

//-->
</SCRIPT>
<body>
<form method="post" name="frmSub">
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="text01">
  <tr>
    <td height="18"  valign="middle"><img src="<%=contextPath %>/images/currentpositionbg.jpg" width="8" height="18" id="positionimg"/><div class="currentposition"><strong>&nbsp;当前位置-&gt; 任务管理-&gt;任务注册-&gt;新建任务</strong></div></td>
    <td  class="currentposition" align="right"><strong></strong></td>
    <td width="4%" align="right"> 
     </td>
    <td width="9%"> 
       </td>
  </tr>
</table>
<br>
<br>	
<table width="60%" border="0" cellpadding="1" cellspacing="1" align="center" class="text01" bgcolor="#FFFFFF">
<tr>
<td>
<fieldset>
<table width="100%" border="0" cellpadding="1" cellspacing="1" align="center" >
<tr><td align="left" nowrap> 任务名称：</td>
<td><input type="text" name="TASK_NAME" size="20" maxlength="100"><font color="red">*</font></td></tr>
<tr><td align="left" nowrap>运行方式：</td><td><select name="RUN_TYPE">
  <option value="0" selected>串行</option>
  <option value="1">并行</option>
</select></td></tr>
<tr><td align="left" nowrap>运行前提：</td><td><select name="CONTINUE_FLAG">
  <option value="0" selected>工作执行失败停止</option>
  <option value="1">工作执行失败继续</option>
</select></td></tr>
<tr><td align="left" nowrap>优先级：</td><td><select name="PRIORITY">
  <option value="0" selected>0</option>
  <option value="1">1</option>
  <option value="2">2</option>
  <option value="3">3</option>
  <option value="4">4</option>
  <option value="5">5</option>
  <option value="6">6</option>
  <option value="7">7</option>
  <option value="8">8</option>
  <option value="9">9</option>
  <option value="10">10</option>
</select></td></tr>
<!--  
<tr>
<td align="left" nowrap>任务超时设置（秒）：</td>
<td><input  type="text" name="TIME_OUT" size="10" maxlength="8"></td>
</tr>

<tr>
<td align="left" nowrap>预测运行时间（秒）：</td>
<td><input  type="text" name="FORCAST_TIME" size="10" maxlength="8">
</td>
</tr>
-->
<tr><td align="left" nowrap>调度方式：</td><td><select name="SCHEDULE_TYPE" onchange="changeScheduleType()">
  	<option value="">不调度</option>
	<option value="00">固定时间</option>
	<option value="mi" >分钟间隔</option>
	<option value="hh" >小时间隔</option>
	<option value="dd" selected>天间隔</option>
	<option value="yy">年间隔</option>
	<option value="ww" >每周</option>
	<option value="mm" >每月</option>
</select></td></tr>
<tr><td align="left" nowrap>开始日期：</td><td><input  type="text" name="START_DATE" value="<%=currentDate %>" size="10" maxlength="15" readonly><img src="<%= contextPath %>/images/datetime.gif" style="cursor:hand;" alt="弹出日历下拉菜单" onClick="return showCalendar('START_DATE','%Y-%m-%d');">
</td></tr>
<tr><td align="left" nowrap>开始时间(hh:mm:ss)：</td><td><input  type="text" name="START_TIME" size="10" value="<%=currentTime %>" maxlength="15"></td></tr>
<tr><td align="left" nowrap>结束日期：</td><td><input  type="text" name="END_DATE" size="10" maxlength="15" ><img src="<%= contextPath %>/images/datetime.gif" style="cursor:hand;" alt="弹出日历下拉菜单" onClick="return showCalendar('END_DATE','%Y-%m-%d');">
</td></tr>
<tr><td align="left" nowrap>结束时间(hh:mm:ss)：</td><td><input  type="text" name="END_TIME" size="10" maxlength="15"></td></tr>
<!--  
<tr><td align="left" nowrap>最大运行时间：</td><td><input  type="text" name="MAX_TIME" size="10" maxlength="8"></td></tr>
-->
<tr><td align="left" nowrap>任务说明：</td><td><input  type="text" name="DESCRIPTION" size="30" maxlength="100"></td></tr>
 <tr>
	<td colspan="2">
		<table id="detail" width="100%">
			<TBODY>
				<TR align=CENTER bgColor=#999999 height=20>
				  <TD height="24" colspan="2" class="css-01">
					<div align="center">调度明细信息</div>
                     </TD>
				</TR>
				<tr valign="top">
					<td >间隔&nbsp;&nbsp;<input type=text name=DAY class=inputtxt value="1" size=12>&nbsp;&nbsp;天</td>
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
<table width="60%" border="0" cellpadding="1" cellspacing="1" align="center" class="text01">
<tr><td align="center"><input type="button" name="next" value="保存" onClick="_checkFrm()" class="input01">&nbsp;&nbsp; <input type="button" name="cancel" value="返回" onClick="_return()"  class="input01">
<input type=hidden  name="SCHEDULE_DETAIL">
<input type=hidden  name="SCHEDULE_FLAG">
</td></tr>
</table>
</form>
</body>
</html>

