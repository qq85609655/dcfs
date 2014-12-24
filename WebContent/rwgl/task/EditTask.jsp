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
		disabledString = "����<font color='red'>����������״̬�������޸�</font>";
	}

	String taskJobCount = (String) request.getAttribute("taskJobCount");
	if (taskJobCount == null)
		taskJobCount = "";
	String isDisabled1 = "";
	String disabledString1 = "";
	if (taskJobCount == null || !taskJobCount.equals("1")) {
		isDisabled1 = " disabled='true' ";
		disabledString1 = "����<font color='red'>������û�й����������޸�״̬</font>";
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
		<title>�༭����</title>
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

//����
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
     alert("�������Ʋ���Ϊ�գ�");
     sForm.TASK_NAME.focus();
     return;
   }

  // var TIME_OUT	= sForm.TIME_OUT.value;
 //  var FORCAST_TIME	= sForm.FORCAST_TIME.value;

  // if(TIME_OUT!=""){
	//   if(!is_positiveInt(TIME_OUT)){
	//			alert("��������������������100000000");
	//			sForm.TIME_OUT.focus();
	//			return;
	//   }
  // }

  // if(FORCAST_TIME!=""){
	//   if(!is_positiveInt(FORCAST_TIME)){
	//			alert("��������������������100000000");
	//			sForm.FORCAST_TIME.focus();
	//			return;
	//   }
  // }

    if (sForm.START_DATE.value == "")
    {
        alert("�����뿪ʼ���ڣ�");
        sForm.START_DATE.focus();
        sForm.START_DATE.select();
        return false;
    }

    if (sForm.START_TIME.value == "")
    {
        alert("�����뿪ʼʱ�䣡");
        sForm.START_TIME.focus();
        sForm.START_TIME.select();
        return false;
    }
    if(!ratifyTime(sForm.START_TIME)){
		sForm.START_TIME.focus();
		alert("��������ȷ��ʱ���ʽ��");
		return false;
	}

	if((!(sForm.END_DATE.value == ""))&&(sForm.END_TIME.value == "")){
			alert("���������ʱ���ָ���������ڣ�");
			sForm.END_TIME.focus();
			sForm.END_TIME.select();
			return false;
	}
    if(!(sForm.END_TIME.value == "")){
		if(sForm.END_DATE.value == ""){
			alert("������������ڻ�ָ������ʱ�䣡");
			sForm.END_DATE.focus();
			sForm.END_DATE.select();
			return false;
		}

		if(!ratifyTime(sForm.END_TIME)){
			sForm.END_TIME.focus();
			alert("��������ȷ��ʱ���ʽ��");
			return false;
		}
	}
	
	var startTime= sForm.START_DATE.value.trim()+" "+sForm.START_TIME.value.trim();
	//var date=new Date();
	//var current=date.getYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds()
	var current="<%= DateUtils.getDate(null)%>";
	if(!startTime.trim().isAfterDateTime(current)){
	   alert("��ʼʱ��Ҫ�ڵ�ǰʱ��֮��");
			sForm.START_TIME.focus();
			sForm.START_TIME.select();
			return;
	}
	
	var endTime= sForm.END_DATE.value.trim()+" "+sForm.END_TIME.value.trim();
	if(startTime.trim()!="" && endTime.trim()!=""){
		if(!endTime.trim().isAfterDateTime(startTime)){
			alert("����ʱ��Ҫ�ڿ�ʼʱ��֮��");
			sForm.END_DATE.focus();
			sForm.END_DATE.select();
			return;
		}
	}
   // var MAX_TIME = sForm.MAX_TIME.value;
   // if(MAX_TIME!=""){
   //    if(!is_positiveInt(MAX_TIME)){
   //             alert("��������������������100000000");
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
			alert("��������Ϊ�գ�");
			sForm.SECOND.focus();
			return;
	   }
	   if(is_positiveInt(sForm.SECOND.value)== false){
			alert("��������������������100000000��");
			sForm.SECOND.focus();
			return;
	   }
	   detailstr =  sForm.SECOND.value ;
   }
   if(type=="mi"){
	   if(sForm.MINUTE.value == ""){
			alert("�ּ������Ϊ�գ�");
			sForm.MINUTE.focus();
			return;
	   }
	   if(is_positiveInt(sForm.MINUTE.value)== false){
			alert("�ּ������������������100000000��");
			sForm.MINUTE.focus();
			return;
	   }
	   detailstr =  sForm.MINUTE.value ;
   }
   if(type=="hh"){
	   if(sForm.HOUR.value == ""){
			alert("Сʱ�������Ϊ�գ�");
			sForm.HOUR.focus();
			return;
	   }
	   if(is_positiveInt(sForm.HOUR.value)== false){
			alert("Сʱ�������������������100000000��");
			sForm.HOUR.focus();
			return;
	   }
	   detailstr =  sForm.HOUR.value ;
   }
   if(type=="yy"){
	   if(sForm.YEAR.value == ""){
			alert("��������Ϊ�գ�");
			sForm.YEAR.focus();
			return;
	   }
	   if(is_positiveInt(sForm.YEAR.value)== false){
			alert("��������������������100000000��");
			sForm.YEAR.focus();
			return;
	   }
	   detailstr =  sForm.YEAR.value ;
   }
   if(type=="dd"){
	   if(sForm.DAY.value == ""){
			alert("��������Ϊ�գ�");
			sForm.DAY.focus();
			return;
	   }
	   if(is_positiveInt(sForm.DAY.value)== false){
			alert("��������������������100000000��");
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
			alert("�������ܵ��ȷ�ʽ��");
			sForm.WEEK[0].focus();
			return;
	   }
	   detailstr =  weekstr ;
   }

   if(type=="qq"){
		if((sForm.TEN1.value=="") && (sForm.TEN2.value=="") && (sForm.TEN3.value=="")){
			alert("������Ѯ���ȷ�ʽ��");
			sForm.TEN1.focus();
		}
		if(!(sForm.TEN1.value == "")){
			tendaystr =  sForm.TEN1.value;
			if(!is_positiveInt(tendaystr)){
				alert("������������");
				sForm.TEN1.focus();
				return;
			}
			if(parseInt(tendaystr) > 10){
				alert("�벻Ҫ�������10��������");
				sForm.TEN1.focus();
				return;
			}
		}

		if(!(sForm.TEN2.value =="")) {
			tempstr = sForm.TEN2.value;
			if(!is_positiveInt(tempstr)){
				alert("������������");
				sForm.TEN2.focus();
				return;
			}
			if((parseInt(tempstr) > 20) || (parseInt(tempstr) < 10)){
				alert("�벻Ҫ����10��20��������");
				sForm.TEN2.focus();
				return;
			}

			if(tendaystr== "")  tendaystr = tempstr;
			else				tendaystr = tendaystr + "," + tempstr;
		}

		if(!(sForm.TEN3.value =="")) {
			tempstr = sForm.TEN3.value;
			if(!is_positiveInt(tempstr)){
				alert("������������");
				sForm.TEN3.focus();
				return;
			}
			if((parseInt(tempstr) > 31) || (parseInt(tempstr) < 20)){
				alert("�벻Ҫ����20��31��������");
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
				alert("����������");
				sForm.MonthDays.focus();
				return;
	   }

	   if(sForm.LastDay.checked)   monthstr = "0";

	   var tempstr     = sForm.MonthDays.value;
	   var montharray  = tempstr.split(",");

	   for(var i=0; i< montharray.length;i++)
	   {
    	   if(!is_positiveInt(montharray[i])){
				alert("��������ȷ������");
				sForm.MonthDays.focus();
				return;
			}
			if((parseInt(montharray[i]) > 31) ){
				alert("��Ҫ������ȷ������");
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
            alert("�����Ѿ����˸ù����Ŀ�ʼʱ�䣬������Ϊ����״̬��");
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
                alert("�����Ѿ����˸ù����Ľ���ʱ�䣬������Ϊ����״̬��");
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
        cellobj.innerHTML = "���&nbsp;&nbsp;<input type=text name=SECOND class=inputtxt size=12 >&nbsp;&nbsp;��";
    }else if(type == "mi"){
        cellobj.innerHTML = "���&nbsp;&nbsp;<input type=text name=MINUTE class=inputtxt size=12 >&nbsp;&nbsp;����";

    }else if(type == "hh"){
        cellobj.innerHTML = "���&nbsp;&nbsp;<input type=text name=HOUR class=inputtxt size=12 >&nbsp;&nbsp;Сʱ";

    }else if(type == "dd"){
        cellobj.innerHTML = "���&nbsp;&nbsp;<input type=text name=DAY class=inputtxt size=12 >&nbsp;&nbsp;��";

    }else if(type == "yy"){
        cellobj.innerHTML = "���&nbsp;&nbsp;<input type=text name=YEAR class=inputtxt size=12 >&nbsp;&nbsp;��";

    }else if(type == "ww"){
        cellobj.innerHTML = "<input type=checkbox name=WEEK value=1 >����һ"   +
                            "<input type=checkbox name=WEEK value=2 >���ڶ�"       +
                            "<input type=checkbox name=WEEK value=3 >������"       +
                            "<input type=checkbox name=WEEK value=4 >������"       +
                            "<input type=checkbox name=WEEK value=5 >������"       +
                            "<input type=checkbox name=WEEK value=6 >������"       +
                            "<input type=checkbox name=WEEK value=7 >������"   ;

    }else if(type == "qq"){
        cellobj.innerHTML = "��Ѯ&nbsp;&nbsp;<input type=text name=TEN1 class=inputtxt size=4 >&nbsp;&nbsp;��&nbsp;&nbsp;" +
                            "��Ѯ&nbsp;&nbsp;<input type=text name=TEN2 class=inputtxt size=4 >&nbsp;&nbsp;��&nbsp;&nbsp;" +
                            "��Ѯ&nbsp;&nbsp;<input type=text name=TEN3 class=inputtxt size=4 >&nbsp;&nbsp;��" ;

    }else if(type == "mm"){
        cellobj.innerHTML = "ÿ��&nbsp;&nbsp;<input type=text name=MonthDays class=inputtxt size=12 >&nbsp;&nbsp;��(��,�ָ�)&nbsp;&nbsp;" +
                            "<input type=checkbox name=LastDay value=0  >&nbsp;&nbsp;���һ��";

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
										�������ƣ�
									</td>
									<td>
										<input type="text" <%=isDisabled%> name="TASK_NAME" size="20"
											value="<%=taskvo.getTask_name()%>" maxlength="100"><font color="red">*</font>
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										����״̬��
									</td>
									<td>
										<select name="STATUS" <%=isDisabled%> <%=isDisabled1%>>
											<option value="<%=SystemConfig.STATUS_DEVELOP%>"
												<%
												if(status.equals(SystemConfig.STATUS_DEVELOP)) 
   out.print("selected"); //System.out.println("aaaaaaaaaaaaaaaa");%>>
												����
											</option>
											<option value="<%=SystemConfig.STATUS_PRODUCE%>"
												<%  
												if(status.equals(SystemConfig.STATUS_PRODUCE)) 
   out.print("selected"); %>>
												����
											</option>
										</select>
										<%=disabledString%>
										<%=disabledString1%>
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										���з�ʽ��
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
												����
											</option>
											<option value="1" <%=bystr%>>
												����
											</option>
										</select>
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										����ǰ�᣺
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
												����ִ��ʧ��ֹͣ
											</option>
											<option value="1" <%=gostr%>>
												����ִ��ʧ�ܼ���
											</option>
										</select>
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										���ȼ���
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
										����ʱ���ã��룩��
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
										Ԥ������ʱ�䣨�룩��
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
										���ȷ�ʽ��
									</td>
									<td>
										<select name="SCHEDULE_TYPE" onchange="changeScheduleType()">
											<OPTION value="" <% if(type==null) out.print("selected"); %>>
												������
											</OPTION>
											<option value="00"
												<% if("00".equals(type)) out.print("selected"); %>>
												�̶�ʱ��
											</option>
											<!--												<option value="ss" <% if("ss".equals(type)) out.print("selected"); %>>����</option>
												<option value="mi" <% if("mi".equals(type)) out.print("selected"); %>>�ּ��</option>             -->
											<option value="mi"
												<% if("mi".equals(type)) out.print("selected"); %>>
												���Ӽ��
											</option>
											<option value="hh"
												<% if("hh".equals(type)) out.print("selected"); %>>
												Сʱ���
											</option>
											<option value="dd"
												<% if("dd".equals(type)) out.print("selected"); %>>
												����
											</option>
											<option value="yy"
												<% if("yy".equals(type)) out.print("selected"); %>>
												����
											</option>
											<option value="ww"
												<% if("ww".equals(type)) out.print("selected"); %>>
												ÿ��
											</option>
											<!--<option value="qq" <% if("qq".equals(type)) out.print("selected"); %>>ÿѮ</option>           -->
											<option value="mm"
												<% if("mm".equals(type)) out.print("selected"); %>>
												ÿ��
											</option>
										</select>
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										��ʼ���ڣ�
									</td>
									<td><input type="text" name="START_DATE" value="<%=DateUtil.formatDate(taskvo.getStart_time().getTime())%>" size="10" maxlength="15" readonly><img src="<%=contextPath%>/rwgl/image/datetime.gif" style="cursor:hand;" alt="�������������˵�" onClick="return showCalendar('START_DATE','%Y-%m-%d');">
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										��ʼʱ�䣺
									</td>
									<td>
										<input type="text" name="START_TIME" size="10" maxlength="15" value="<%=beginTime%>">
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										�������ڣ�
									</td>
									<td><input type="text" name="END_DATE" size="10" maxlength="15" value="<%=endDate%>"  ><img src="<%=contextPath%>/rwgl/image/datetime.gif" style="cursor:hand;" alt="�������������˵�" onClick="return showCalendar('END_DATE','%Y-%m-%d');">
									</td>
								</tr>
								<tr>
									<td align="left" nowrap>
										����ʱ�䣺
									</td>
									<td>
										<input type="text" name="END_TIME" size="10" maxlength="15"  value="<%=endTime%>">
									</td>
								</tr>
								<!--  
								<tr>
									<td align="left" nowrap>
										�������ʱ�䣺
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
										����˵����
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
															������ϸ��Ϣ
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
																���&nbsp;&nbsp;<input type=text <%=isDisabled%> name=SECOND class=inputtxt size=12 value="<%=value%>">&nbsp;&nbsp;��
														<%
																			}
																			if(type.equals("mi")){
														%>
																���&nbsp;&nbsp;<input type=text <%=isDisabled%> name=MINUTE class=inputtxt size=12  value="<%=value%>">&nbsp;&nbsp;��
														<%
																			}

																			if(type.equals("hh")){
														%>
																���&nbsp;&nbsp;<input type=text<%=isDisabled%>  name=HOUR class=inputtxt size=12 value="<%=value%>">&nbsp;&nbsp;Сʱ
														<%
																			}
																			if(type.equals("dd")){
														%>
																���&nbsp;&nbsp;<input type=text <%=isDisabled%> name=DAY class=inputtxt size=12 value="<%=value%>">&nbsp;&nbsp;��
														<%
																			}
																			if(type.equals("yy")){
														%>
																���&nbsp;&nbsp;<input type=text <%=isDisabled%> name=YEAR class=inputtxt size=12 value="<%=value%>">&nbsp;&nbsp;��
														<%
																			}
																			if(type.equals("ww")){
																				String[] dayarray   = StringUtil.convertToArray(value,",");
																				ArrayList list		= new ArrayList();
																				for(int i=0; i< dayarray.length;i++) list.add(dayarray[i]);
														%>
																<input type=checkbox<%=isDisabled%>  name=WEEK value=1 <% if(list.contains("1")) out.println("checked"); %>>��һ
																<input type=checkbox<%=isDisabled%>  name=WEEK value=2 <% if(list.contains("2")) out.println("checked"); %>>�ܶ�
																<input type=checkbox<%=isDisabled%>  name=WEEK value=3 <% if(list.contains("3")) out.println("checked"); %>>����
																<input type=checkbox<%=isDisabled%>  name=WEEK value=4 <% if(list.contains("4")) out.println("checked"); %>>����
																<input type=checkbox<%=isDisabled%>  name=WEEK value=5 <% if(list.contains("5")) out.println("checked"); %>>����
																<input type=checkbox<%=isDisabled%>  name=WEEK value=6 <% if(list.contains("6")) out.println("checked"); %>>����
																<input type=checkbox<%=isDisabled%>  name=WEEK value=7 <% if(list.contains("7")) out.println("checked"); %>>����
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
															��Ѯ&nbsp;&nbsp;	<input type=text name=TEN1 class=inputtxt size=4 value="<%=TEN1%>">&nbsp;&nbsp;��
															��Ѯ&nbsp;&nbsp;	<input type=text name=TEN2 class=inputtxt size=4 value="<%=TEN2%>">&nbsp;&nbsp;��
															��Ѯ&nbsp;&nbsp;	<input type=text name=TEN3 class=inputtxt size=4 value="<%=TEN3%>">&nbsp;&nbsp;��
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
																ÿ��&nbsp;&nbsp;<input type=text name=MonthDays class=inputtxt size=12 value="<%= monthstr %>">&nbsp;&nbsp;��(��,�ָ�)&nbsp;&nbsp;
																<input type=checkbox name=LastDay value=0  <%=checkstr %> >&nbsp;&nbsp;���һ��
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
						<input type="button" name="next" <%=isDisabled %>  value="����" onClick="_checkFrm()"
							class="input01">
						&nbsp;&nbsp;
						<input type="button" name="cancel" value="����" onClick="_return()"
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
<!-- �������� end -->
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
