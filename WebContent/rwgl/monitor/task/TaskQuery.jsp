<%@ page contentType="text/html;charset=gb2312" %>
<html>
<head>
<title>任务选择</title>
</head>

<%@ page import="java.util.List"%>
<%@ page import="base.task.monitor.task.TaskBean"%>
<%@ page import="base.task.resource.task.vo.TaskVo"%>


<%
		String contextPath = request.getContextPath();
		String TI_SCHEDULE_TYPE = request.getParameter("TI_SCHEDULE_TYPE");
		if(TI_SCHEDULE_TYPE==null) TI_SCHEDULE_TYPE="aa";
%>
<style>
   BODY {background-color: white}
   TD {font-size: 10pt; 
       font-family: verdana,helvetica; 
	   text-decoration: none;
	   white-space:nowrap;}
   A  {text-decoration: none;
       color: black}
</style>

<script>
function _ok() {

  var form = document.frm;
  var ret = new Array();

  var values = new Array();
  var record = parseInt(form.recordcount.value);
  var count = 0; 
  if(record==1){
	if(form.TI_TASK_ID.checked){
		values[0] = form.TI_TASK_ID.value;
		count ++;
	}
  }

  for(var i=0; i<form.TI_TASK_ID.length; i++) {

	var obj = form.TI_TASK_ID[i];
	if(obj.checked ){
		values[count] = form.TI_TASK_ID[i].value;
		count ++ ;
	}
  }
  if(count==0){
	if (!confirm ("你没有选择任务，是否继续进行？"))
    {    
        return false;
    }

  }
  ret[0] = values;
  ret[1] = form.TI_SCHEDULE_TYPE.value;

  window.returnValue = ret;

  window.close();

}
</script>


 <SCRIPT LANGUAGE="JavaScript">

//<!--

	window.returnValue = null;

	window.document.title = "任务选择";

//-->
</SCRIPT>
<link href="<%=request.getContextPath() %>/eii/css/stmadc.css" rel="stylesheet" type="text/css">

 <body bgcolor="#EEF4FF">
 <form name="frm" action="<%=request.getContextPath()%>/eii/jsp/monitor/task/TaskQuery.jsp">
 <input type=hidden name="type" value="assign">

 <table width="100%"  border="1" cellpadding="2" cellspacing="2" bgcolor="BAEBFB" bordercolordark="6ED1F7" bordercolorlight="6ED1F7">
     <tr height="7" bgcolor="#EAEAEA"> 
         <td align="center" colspan="2"><font color="4A4A4A">&nbsp;任务列表 </font></td>
     </tr>
  <tr>

    <td  align="center" bgcolor="#FFFFFF"> 

      <table  border="0" cellspacing="0" cellpadding="6" width="100%">
        <tr> 
          <td height="4" align="center">						     
              <select name="TI_SCHEDULE_TYPE">
				    <option value="aa" <% if(TI_SCHEDULE_TYPE.equals("aa")) out.print("selected"); %>>全部</option>
                    <option value="00" <% if(TI_SCHEDULE_TYPE.equals("00")) out.print("selected"); %>>固定时间</option>
<!--					<option value="mi" <% if(TI_SCHEDULE_TYPE.equals("mi")) out.print("selected"); %>>分间隔</option>    -->
					<option value="hh" <% if(TI_SCHEDULE_TYPE.equals("hh")) out.print("selected"); %>>小时间隔</option>
					<option value="dd" <% if(TI_SCHEDULE_TYPE.equals("dd")) out.print("selected"); %>>天间隔</option>
					<option value="ww" <% if(TI_SCHEDULE_TYPE.equals("ww")) out.print("selected"); %>>每周</option>
<!--	 onchange="this.form.submit()"					<option value="qq" <% if(TI_SCHEDULE_TYPE.equals("qq")) out.print("selected"); %>>每旬</option>   -->
					<option value="mm" <% if(TI_SCHEDULE_TYPE.equals("mm")) out.print("selected"); %>>每月</option>
              </select>
			</td>
          <td height="4" >	
		     <input type=submit name="button3" value="查 询" class="inputbutton" style="cursor:hand">	     
  		  </td>

        </tr>
        <tr> 

          <td colspan="2">

             <fieldset valign="top" align="center" id=listset> 

              <legend><span color='#0C0C0C'> 选择任务 </span></legend>

              <div style="overflow:auto">
            <form name="frmSub" method="post">
              <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="9C9C9C">
                <tr bgcolor="EAEAEA"> 
                  <td width="10%" align="center">选择</td>
                  <td width="10%" align="center">序号</td>
                  <td width="80%" align="center">工作名称</td>
                </tr>
                <%
					int nCount	  = 0;
					int nPageRows = 0;
					List taskList = TaskBean.findTaskByScheduleType(TI_SCHEDULE_TYPE);
					for(int i=0; i< taskList.size();i++){
						TaskVo taskinfo = (TaskVo)taskList.get(i);

				%>
                <tr bgcolor="#FFFFFF"> 
                  <td align="center"> 
                    <input name="TI_TASK_ID" type="checkbox" value="<%= taskinfo.getId() %>" > 
                  </td>
                  <td align="center"> <%= i %>   </td>
                  <td><%= taskinfo.getTask_name() %></td>
                </tr>
                <%
                        nCount ++;
                    }
                    if(nCount < 10){	//如果数据行数比本页行数少，补空白行
                        for(int i=nCount; i<nPageRows; i++) {
                  %>
                <tr bgcolor="#FFFFFF"> 
                  <td align="center">　</td>
                  <td align="center">　</td>
                  <td align="center">　</td>
                  <td align="center">　</td>
                  <td align="center">　</td>
                  <td align="center">　</td>
                  <td align="center">　</td>
                  <td align="center">　</td>
                  <td align="center">　</td>
                </tr>
                <%    } 
                     }
                  %>
              </table>
              </div>

            </fieldset>

          </td>

        </tr>

        <tr> 

          <td height="4" colspan="2"> </td>

        </tr>
        <tr> 

          <td height="4" colspan="2" align="center">
            <input type=button value=' 确 定 ' class="inputbutton" style="cursor:hand" onclick="_ok();">
            <input type=hidden value="<%= nCount%>" name="recordcount">
          
          </td>

        </tr>

      </table>

    </td>

  </tr>

</table>
 </form>
 </body>
</html>
