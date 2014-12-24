<%@ page contentType="text/html; charset=GBK" %>
<HTML><HEAD><TITLE></TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content="MSHTML 5.00.2920.0" name=GENERATOR></HEAD>
<link href="<%=request.getContextPath() %>/eii/css/stmadc.css" rel="stylesheet" type="text/css">
<BODY bgcolor="#FFFFFF" onload="fload()">
<INPUT id=txt1 style="DISPLAY: none">
<SCRIPT>
var gdCtrl = new Object();
var goSelectTag = new Array();
var gcGray = "#AAAAAA";
var gcToggle = "#C0C0C0";
var gcBG = "#EEEEEE";
var gcBG1="#000000";
var gcWhite="#FFFFFF";
var previousObject = null;
var gdCurDate = new Date();
var currYear = gdCurDate.getFullYear();
var currMonth = gdCurDate.getMonth() + 1;
var currDay = gdCurDate.getDate();

var giYear = parent.theYear;
var giMonth = parent.theMonth;

var gCalMode = "";
var gCalDefDate = "";

var CAL_MODE_NOBLANK = "2";

function fSetDate(iYear, iMonth, iDay){
  //VicPopCal.style.visibility = "hidden";
  if ((iYear == 0) && (iMonth == 0) && (iDay == 0)){
  	gdCtrl.value = "";
  }else{
  	iMonth = iMonth + 100 + "";
  	iMonth = iMonth.substring(1);
  	iDay   = iDay + 100 + "";
  	iDay   = iDay.substring(1);
  	gdCtrl.value = iYear+"-"+iMonth+"-"+iDay;
  }

  for (i in goSelectTag)
  	goSelectTag[i].style.visibility = "visible";
  goSelectTag.length = 0;
  window.returnValue=gdCtrl.value;
  //window.close();
}

function HiddenDiv()
{
	var i;
  VicPopCal.style.visibility = "hidden";
  for (i in goSelectTag)
  	goSelectTag[i].style.visibility = "visible";
  goSelectTag.length = 0;

}
function fSetSelected(aCell){
  var iMon = tbSelMonth.value;
  var isBeforeMonth = false;
  var isCurrentMonth = false;
  if(iMon <=9) iMon = "0" + iMon;
  if(currMonth<=9) currMonth = "0" + currMonth;
  else currMonth = "" + currMonth;
   currMonth = currMonth.replace("00","0");
  var iYear = tbSelYear.value;
  var sYearMonthString = "" + iYear+iMon;
  var cYearMonthString = "" + currYear+currMonth;
//  alert("sYearMonthString = " + sYearMonthString + "\ncYearMonthString = " + cYearMonthString );
  if(sYearMonthString  < cYearMonthString || sYearMonthString.length < cYearMonthString.length){
     isBeforeMonth = true;
     return;
  }else if (sYearMonthString==cYearMonthString){
     isCurrentMonth = true;
  }
  aCell.bgColor = gcBG;
  with (aCell.children["cellText"]){
    var huanhang = innerText.indexOf("\n") ;
//    alert("换行位置＝" + huanhang );
    if(huanhang < 1) { return;}
    var thisDateString = innerText.substring(0,huanhang-2);
//    alert("当前日期str＝" + thisDateString );
  	var iDay = parseInt(thisDateString);
//    alert("当前日期int＝" + thisDateString );
  	if(isCurrentMonth && iDay < currDay){	return; }
  	var origSelectText = parent.document.all.taskCountSelect.options[iDay].text.replace("1、","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、");
  	while(origSelectText.indexOf("，") >= 0){
  	    origSelectText = origSelectText.replace("，","<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
  	}
  	var taskCountAt = parent.document.all.taskCountSelect.options[iDay].value;
	if(taskCountAt < 1){
	  document.all.resultTextCell.innerHTML= "<font color='#4F4F4F'>根据当前任务安排，"+iYear+"年 "+iMon+"月 "+iDay+" 日 没有任务需要运行</font>";
	}else{
	  document.all.resultTextCell.innerHTML= "<font color='#4F4F4F'>根据当前任务安排，"+iYear+"年 "+iMon+"月 "+iDay+" 日 有如下任务需要运行：<br>" + origSelectText  + "</font>";
	}
  }
}

function Point(iX, iY){
	this.x = iX;
	this.y = iY;
}

function fBuildCal(iYear, iMonth) {
  var aMonth=new Array();
  for(i=1;i<7;i++)
  	aMonth[i]=new Array(i);

  var dCalDate=new Date(iYear, iMonth-1, 1);
  var iDayOfFirst=dCalDate.getDay();
  var iDaysInMonth=new Date(iYear, iMonth, 0).getDate();
  var iOffsetLast=new Date(iYear, iMonth-1, 0).getDate()-iDayOfFirst+1;
  var iDate = 1;
  var iNext = 1;

  for (d = 0; d < 7; d++)
	aMonth[1][d] = (d<iDayOfFirst)?-(iOffsetLast+d):iDate++;
  for (w = 2; w < 7; w++)
  	for (d = 0; d < 7; d++)
		aMonth[w][d] = (iDate<=iDaysInMonth)?iDate++:-(iNext++);
  return aMonth;
}

function fDrawCal(iYear, iMonth, iCellHeight, sDateTextSize) {
  var WeekDay = new Array("日","一","二","三","四","五","六");
  var styleTH = " bgcolor='#8080C0' bordercolor='"+gcBG1+"' valign='middle' align='center' height='5%' style='font-size:24px;font-weight:bold;";
  var styleTD = " bgcolor='"+gcWhite+"' bordercolor='"+gcBG1+"' valign='middle' align='center' height='"+iCellHeight+"' style='font-size:16px;font-weight:bold;";
  with (document) {
	write("<tr>");
	for(i=0; i<7; i++)
		write("<th "+styleTH+" color:white' >" + WeekDay[i] + "</th>");
	write("</tr>");

  	for (w = 1; w < 7; w++) {
		write("<tr>");
		for (d = 0; d < 7; d++) {
			write("<td id=calCell "+styleTD+"cursor:hand;' onMouseOver='this.bgColor=gcToggle' onMouseOut='this.bgColor=gcWhite' onclick='fSetSelected(this)'>");
			write("<font id=cellText ><b> </b></font>");
			write("</td>")
		}
		write("</tr>");
	}
  }
}

function fUpdateCal(iYear, iMonth) {
  myMonth = fBuildCal(iYear, iMonth);
  var taskCountAt = 0;
  var iMon = tbSelMonth.value;
  var isBeforeMonth = false;
  var isCurrentMonth = false;
  if(iMon <=9) iMon = "0" + iMon;
  if(currMonth<=9) currMonth = "0" + currMonth;
  else currMonth = "" + currMonth;
   currMonth = currMonth.replace("00","0");
  var iYear = tbSelYear.value;
  var sYearMonthString = "" + iYear+iMon;
  var cYearMonthString = "" + currYear+currMonth;
//  alert("sYearMonthString = " + sYearMonthString + "\ncYearMonthString = " + cYearMonthString );
  if(sYearMonthString  < cYearMonthString || sYearMonthString.length < cYearMonthString.length){
     isBeforeMonth = true;
  }else if (sYearMonthString==cYearMonthString){
     isCurrentMonth = true;
  }
  var i = 0;
  for (w = 0; w < 6; w++){
	for (d = 0; d < 7; d++){
		with (cellText[(7*w)+d]) {
			Victor = i++;
			if (myMonth[w+1][d]< 0) {
				color = "#6AB5B5";
				innerText = (-myMonth[w+1][d]) + "日";
			}else{
			    if(isBeforeMonth || (isCurrentMonth  && myMonth[w+1][d] < currDay) ){
				  color = gcGray;
				  innerText = myMonth[w+1][d] + "日";
			    }else{
	               taskCountAt = parent.document.all.taskCountSelect.options[myMonth[w+1][d]].value;
			       if(taskCountAt < 1){
			         color = gcGray;
			         innerText = myMonth[w+1][d] + "日\n没有任务";
			       }else if(taskCountAt > 10){
			         color = "#FF5B5B";
			         innerText = myMonth[w+1][d] + "日\n"+ taskCountAt  +"个任务";
			       }else{
				     color = gcGray;
				     innerText = myMonth[w+1][d] + "日\n"+ taskCountAt  +"个任务";
				   }//else
				}//else
			}//else
		 }//with
	  }	//for
   }//for
}

function fSetYearMon(iYear, iMon){
//  alert(iMon-1);
  tbSelMonth.options[iMon-1].selected = true;
  for (i = 0; i < tbSelYear.length; i++)
	if (tbSelYear.options[i].value == iYear)
		tbSelYear.options[i].selected = true;
  fUpdateCal(iYear, iMon);
}

function fSetYearMon1(iYear, iMon){
  tbSelMonth.options[iMon-1].selected = true;
  for (i = 0; i < tbSelYear.length; i++)
	if (tbSelYear.options[i].value == iYear)
		tbSelYear.options[i].selected = true;
//  fUpdateCal(iYear, iMon);
}

function fPrevMonth(){
  var iMon = tbSelMonth.value;
  var iYear = tbSelYear.value;

  if (--iMon<1) {
	  iMon = 12;
	  iYear--;
  }
	if(iYear < currYear){
	alert("不能选择当前月份以前的月份，请重新选择");
	 return;
	}
  fSetYearMon1(iYear, iMon);
}

function fNextMonth(){
  var iMon = tbSelMonth.value;
  var iYear = tbSelYear.value;

  if (++iMon>12) {
	  iMon = 1;
	  iYear++;
  }

  fSetYearMon1(iYear, iMon);
}

function submitThis(){
  var iMon = tbSelMonth.value;
  if(iMon <=9) iMon = "0" + iMon;
//  if(currMonth<=9) currMonth = "0" + currMonth;
  var iYear = tbSelYear.value;
  var sYearMonthString = "" + iYear+iMon;
  var cYearMonthString = "" + currYear+currMonth;
//  alert("sYearMonthString = " + sYearMonthString + "\ncYearMonthString = " + cYearMonthString );
  if(sYearMonthString  < cYearMonthString  || sYearMonthString.length < cYearMonthString.length){
     alert("只能选择当前月和以后的月份");
     return false;
  }
  parent.location.replace("<%=request.getContextPath()%>/base/task/monitor/task/TaskScheduleServlet?year="+iYear+"&month=" + iMon);
}

function fToggleTags(){
  with (document.all.tags("SELECT")){
 	for (i=0; i<length; i++)
 		if ((item(i).Victor!="Won")&&fTagInBound(item(i))){
 			item(i).style.visibility = "hidden";
 			goSelectTag[goSelectTag.length] = item(i);
 		}
  }
}

function fTagInBound(aTag){
  with (VicPopCal.style){
  	var l = parseInt(left);
  	var t = parseInt(top);
  	var r = l+parseInt(width);
  	var b = t+parseInt(height);
	var ptLT = fGetXY(aTag);
	return !((ptLT.x>r)||(ptLT.x+aTag.offsetWidth<l)||(ptLT.y>b)||(ptLT.y+aTag.offsetHeight<t));
  }
}

function fGetXY(aTag){
  var oTmp = aTag;
  var pt = new Point(0,0);
  do {
  	pt.x += oTmp.offsetLeft;
  	pt.y += oTmp.offsetTop;
  	oTmp = oTmp.offsetParent;
  } while(oTmp.tagName!="BODY");
  return pt;
}

// Main: popCtrl is the widget beyond which you want this calendar to appear;
//       dateCtrl is the widget into which you want to put the selected date.
// i.e.: <input type="text" name="dc" style="text-align:center" readonly><INPUT type="button" value="V" onclick="fPopCalendar(dc,dc);return false">
function fPopCalendar(popCtrl, dateCtrl, mode, defDate){
	gCalMode = mode;
	gCalDefDate = defDate;

  if (popCtrl == previousObject){
	  	if (VicPopCal.style.visibility == "visible"){
  		//HiddenDiv();
  		return true;
  	}

  }
  previousObject = popCtrl;
  gdCtrl = dateCtrl;
  fSetYearMon(giYear, giMonth);
  var point = fGetXY(popCtrl);

  with (VicPopCal.style) {
  	left = point.x;
	top  = point.y+popCtrl.offsetHeight;
	width = VicPopCal.offsetWidth;
	height = VicPopCal.offsetHeight;
	fToggleTags(point);
	visibility = 'visible';
  }
}

var gMonths = new Array("1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月");
var isThisYear = false;
var monthBeginInt = 0;
if(giYear == currYear){
  isThisYear = true;
  monthBeginInt = currMonth - 1;
}
with (document) {
write("<Div id='VicPopCal' style='OVERFLOW:hidden;POSITION:absolute;VISIBILITY:hidden;border:0px ridge;width:100%;height:100%;top:0;left:0;z-index:100;overflow:hidden'>");
write("<table border='0' width='100%' height='80%'>");
write("<TR>");
write("<td valign='middle' align='center'><input type='button' id='prevMonthBtn' name='PrevMonth' value='上个月' class='inputbutton' style='cursor:hand' onClick='fPrevMonth()'>");
write("&nbsp;<SELECT name='tbSelYear' Victor='Won'>");
for(i=currYear;i<(currYear+20);i++)
	write("<OPTION value='"+i+"'" + (giYear==i?" selected ":"") + ">"+i+"年</OPTION>");
write("</SELECT>");
write("&nbsp;<select name='tbSelMonth'  Victor='Won'>");
for (i=0; i<12; i++){
	write("<option value='"+(i+1)+"'" + (giMonth==i+1 && isThisYear?" selected ":"") + ">"+gMonths[i]+"</option>");
	}
write("</SELECT>");
write("&nbsp;<input type='button' name='PrevMonth' value='下个月' class='inputbutton' style='cursor:hand' onclick='fNextMonth()'>");
write("&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' name='submitButton' value='确 定' class='inputbutton' style='cursor:hand' onclick='submitThis()'>");
write("</td>");
write("</TR><TR>");
write("<td align='center'  width='100%' height='100%'  bgcolor='#C8C8E3'>");
write("<DIV ><table width='100%' border='0'height='100%' bordercolor='gray'>");
fDrawCal(giYear, giMonth, 4, '12');
write("</table></DIV>");
write("</td>");
write("</TR><tr>");
			write("<td id='resultCell' height='120'>");
			write("<div id='resultTextCell' style='POSITION:relative;border:0px ridge;width:100%;height:100%;top:0;left:0;z-index:100;overflow:auto'><br></br></div>");
			write("</td></tr>")
write("</TABLE></Div>");
}
</SCRIPT>

<SCRIPT>
function fload()
{
	fPopCalendar(document.all.txt1, document.all.txt1);
}

function fkeydown()
{
	if(event.keyCode==27){
		event.returnValue = null;
		window.returnValue = null;
		//window.close();
	}
}
document.onkeydown=fkeydown;
parent.window.document.all.dateIframe.height = document.body.scrollHeight + 60;
</SCRIPT>

</BODY></HTML>
