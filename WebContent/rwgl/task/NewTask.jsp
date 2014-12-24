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

<title>�½�����</title>
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

   //var TIME_OUT	= sForm.TIME_OUT.value;
   //var FORCAST_TIME	= sForm.FORCAST_TIME.value;

   //if(TIME_OUT!=""){
	//   if(!is_positiveInt(TIME_OUT)){
	//			alert("������������,������100000000��");
	//			sForm.TIME_OUT.focus();
	//			return;
	//   }
   //}

   //if(FORCAST_TIME!=""){
	//   if(!is_positiveInt(FORCAST_TIME)){
	//			alert("������������,������100000000��");
	//			sForm.FORCAST_TIME.focus();
	//			return;
	 //  }
 //  }

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
	//if(!startTime.trim().isAfterDateTime(current)){
	//   alert("��ʼʱ��Ҫ�ڵ�ǰʱ��֮��");
	//		sForm.START_TIME.focus();
	//		sForm.START_TIME.select();
	//		return;
	//}
	var endTime= sForm.END_DATE.value.trim()+" "+sForm.END_TIME.value.trim();
	
	//if(startTime.trim()!="" && endTime.trim()!=""){
	//	if(!endTime.trim().isAfterDateTime(startTime)){
	//		alert("����ʱ��Ҫ�ڿ�ʼʱ��֮��");
	//		sForm.END_DATE.focus();
	//		sForm.END_DATE.select();
	//		return;
	//	}
	//}
	
    //var MAX_TIME = sForm.MAX_TIME.value;
    //if(MAX_TIME!=""){
    //   if(!is_positiveInt(MAX_TIME)){
     //           alert("������������,������100000000��");
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

	   var tempstr	   = sForm.MonthDays.value;
	   var montharray  = tempstr.split(",");

	   for(var i=0; i< montharray.length;i++)
	   {
    	   if(!is_positiveInt(montharray[i])){
				alert("��������ȷ������");
				sForm.MonthDays.focus();
				return;
			}
			if((parseInt(montharray[i]) > 31) ){
				alert("������С�ڵ���31��������");
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
		cellobj.innerHTML = "���&nbsp;&nbsp;<input type=text name=SECOND class=inputtxt size=12 >&nbsp;&nbsp;��";
	}else if(type == "mi"){
		cellobj.innerHTML = "���&nbsp;&nbsp;<input type=text name=MINUTE class=inputtxt size=12 >&nbsp;&nbsp;����";

	}else if(type == "hh"){
		cellobj.innerHTML = "���&nbsp;&nbsp;<input type=text name=HOUR class=inputtxt size=12 >&nbsp;&nbsp;Сʱ";

	}else if(type == "dd"){
		cellobj.innerHTML = "���&nbsp;&nbsp;<input type=text name=DAY class=inputtxt size=12 >&nbsp;&nbsp;��";

	}else if(type == "ww"){
		cellobj.innerHTML = "<input type=checkbox name=WEEK value=1 >��һ "	+
							"<input type=checkbox name=WEEK value=2 >�ܶ� "	+
							"<input type=checkbox name=WEEK value=3 >���� "	+
							"<input type=checkbox name=WEEK value=4 >���� "	+
							"<input type=checkbox name=WEEK value=5 >���� "	+
							"<input type=checkbox name=WEEK value=6 >���� "	+
							"<input type=checkbox name=WEEK value=7 >���� "	;

	}else if(type == "qq"){
		cellobj.innerHTML = "��Ѯ&nbsp;&nbsp;<input type=text name=TEN1 class=inputtxt size=4 >&nbsp;&nbsp;��&nbsp;&nbsp;" +
							"��Ѯ&nbsp;&nbsp;<input type=text name=TEN2 class=inputtxt size=4 >&nbsp;&nbsp;��&nbsp;&nbsp;" +
							"��Ѯ&nbsp;&nbsp;<input type=text name=TEN3 class=inputtxt size=4 >&nbsp;&nbsp;��" ;

	}else if(type == "mm"){
		cellobj.innerHTML = "ÿ��&nbsp;&nbsp;<input type=text name=MonthDays class=inputtxt size=12 >&nbsp;&nbsp;��(��,�ָ�)&nbsp;&nbsp;" +
							"<input type=checkbox name=LastDay value=0  >&nbsp;&nbsp;���һ��";
	
	}else if(type == "yy"){
		cellobj.innerHTML = "���&nbsp;&nbsp;<input type=text name=YEAR class=inputtxt size=12 >&nbsp;&nbsp;��";
	
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
    <td height="18"  valign="middle"><img src="<%=contextPath %>/images/currentpositionbg.jpg" width="8" height="18" id="positionimg"/><div class="currentposition"><strong>&nbsp;��ǰλ��-&gt; �������-&gt;����ע��-&gt;�½�����</strong></div></td>
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
<tr><td align="left" nowrap> �������ƣ�</td>
<td><input type="text" name="TASK_NAME" size="20" maxlength="100"><font color="red">*</font></td></tr>
<tr><td align="left" nowrap>���з�ʽ��</td><td><select name="RUN_TYPE">
  <option value="0" selected>����</option>
  <option value="1">����</option>
</select></td></tr>
<tr><td align="left" nowrap>����ǰ�᣺</td><td><select name="CONTINUE_FLAG">
  <option value="0" selected>����ִ��ʧ��ֹͣ</option>
  <option value="1">����ִ��ʧ�ܼ���</option>
</select></td></tr>
<tr><td align="left" nowrap>���ȼ���</td><td><select name="PRIORITY">
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
<td align="left" nowrap>����ʱ���ã��룩��</td>
<td><input  type="text" name="TIME_OUT" size="10" maxlength="8"></td>
</tr>

<tr>
<td align="left" nowrap>Ԥ������ʱ�䣨�룩��</td>
<td><input  type="text" name="FORCAST_TIME" size="10" maxlength="8">
</td>
</tr>
-->
<tr><td align="left" nowrap>���ȷ�ʽ��</td><td><select name="SCHEDULE_TYPE" onchange="changeScheduleType()">
  	<option value="">������</option>
	<option value="00">�̶�ʱ��</option>
	<option value="mi" >���Ӽ��</option>
	<option value="hh" >Сʱ���</option>
	<option value="dd" selected>����</option>
	<option value="yy">����</option>
	<option value="ww" >ÿ��</option>
	<option value="mm" >ÿ��</option>
</select></td></tr>
<tr><td align="left" nowrap>��ʼ���ڣ�</td><td><input  type="text" name="START_DATE" value="<%=currentDate %>" size="10" maxlength="15" readonly><img src="<%= contextPath %>/images/datetime.gif" style="cursor:hand;" alt="�������������˵�" onClick="return showCalendar('START_DATE','%Y-%m-%d');">
</td></tr>
<tr><td align="left" nowrap>��ʼʱ��(hh:mm:ss)��</td><td><input  type="text" name="START_TIME" size="10" value="<%=currentTime %>" maxlength="15"></td></tr>
<tr><td align="left" nowrap>�������ڣ�</td><td><input  type="text" name="END_DATE" size="10" maxlength="15" ><img src="<%= contextPath %>/images/datetime.gif" style="cursor:hand;" alt="�������������˵�" onClick="return showCalendar('END_DATE','%Y-%m-%d');">
</td></tr>
<tr><td align="left" nowrap>����ʱ��(hh:mm:ss)��</td><td><input  type="text" name="END_TIME" size="10" maxlength="15"></td></tr>
<!--  
<tr><td align="left" nowrap>�������ʱ�䣺</td><td><input  type="text" name="MAX_TIME" size="10" maxlength="8"></td></tr>
-->
<tr><td align="left" nowrap>����˵����</td><td><input  type="text" name="DESCRIPTION" size="30" maxlength="100"></td></tr>
 <tr>
	<td colspan="2">
		<table id="detail" width="100%">
			<TBODY>
				<TR align=CENTER bgColor=#999999 height=20>
				  <TD height="24" colspan="2" class="css-01">
					<div align="center">������ϸ��Ϣ</div>
                     </TD>
				</TR>
				<tr valign="top">
					<td >���&nbsp;&nbsp;<input type=text name=DAY class=inputtxt value="1" size=12>&nbsp;&nbsp;��</td>
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
<tr><td align="center"><input type="button" name="next" value="����" onClick="_checkFrm()" class="input01">&nbsp;&nbsp; <input type="button" name="cancel" value="����" onClick="_return()"  class="input01">
<input type=hidden  name="SCHEDULE_DETAIL">
<input type=hidden  name="SCHEDULE_FLAG">
</td></tr>
</table>
</form>
</body>
</html>

