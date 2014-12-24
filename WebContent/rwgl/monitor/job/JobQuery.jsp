<html>
<head>
<title>工作选择</title>
</head>

<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.List"%>
<%@ page import="base.task.monitor.job.JobBean"%>
<%@ page import="base.task.resource.job.vo.JobVo"%>

<%
		String JOB_TYPE = request.getParameter("JOB_TYPE");
		if(JOB_TYPE==null) JOB_TYPE ="01";
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
	if(form.JOB_ID.checked){
		values[0] = form.JOB_ID.value;
		count ++;
	}
  }

  for(var i=0; i<form.JOB_ID.length; i++) {

	var obj = form.JOB_ID[i];
	if(obj.checked ){
		values[count] = form.JOB_ID[i].value;
		count ++ ;
	}
  }
  if(count==0){
	if (!confirm ("你没有选择工作，是否继续进行？"))
    {
        return false;
    }

  }
  ret[0] = values;
  ret[1] = form.JOB_TYPE.value;

  window.returnValue = ret;

  window.close();

}
</script>


 <SCRIPT LANGUAGE="JavaScript">

<!--

	window.returnValue = null;

	window.document.title = "工作选择";

//-->
</SCRIPT>
<link href="<%=request.getContextPath() %>/eii/css/stmadc.css" rel="stylesheet" type="text/css">

 <body bgcolor="#EEF4FF">
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
 

 <form name="frm"  target="_self"  action="<%=request.getContextPath()%>/rwgl/monitor/job/JobQuery.jsp">

 <table width="100%" border="1" cellpadding="2" cellspacing="2" bgcolor="BAEBFB" bordercolordark="6ED1F7" bordercolorlight="6ED1F7">
     <tr height="7" bgcolor="#EAEAEA">
         <td align="center" colspan="2"><font color="4A4A4A">&nbsp;工作列表 </font></td>
     </tr>
  <tr>

    <td align="center" bgcolor="#FFFFFF">

      <table width="100%" border="0" cellspacing="0" cellpadding="6">
        <tr>
          <td height="4" align="center">
               <select name="JOB_TYPE" >
				   <option value="aa" <% if(JOB_TYPE.equals("aa")) out.print("selected"); %>>全部</option>
                   <option value="01" <% if(JOB_TYPE.equals("01")) out.print("selected"); %>>存储过程</option>
                   <option value="02" <% if(JOB_TYPE.equals("02")) out.print("selected"); %>>普通JAVA程序</option>
                   <option value="03" <% if(JOB_TYPE.equals("03")) out.print("selected"); %>>通用扩展接口</option>
                   <option value="04" <% if(JOB_TYPE.equals("04")) out.print("selected"); %>>执行程序</option>
                   <option value="05" <% if(JOB_TYPE.equals("05")) out.print("selected"); %>>SQL</option>
                   <option value="06" <% if(JOB_TYPE.equals("06")) out.print("selected"); %>>URL</option>
                   <option value="07" <% if(JOB_TYPE.equals("07")) out.print("selected"); %>>简单抽取</option>
                   <option value="08" <% if(JOB_TYPE.equals("08")) out.print("selected"); %>>ETL</option>
                   <option value="09" <% if(JOB_TYPE.equals("09")) out.print("selected"); %>>远程</option>
                   
                </select>
			</td>
          <td height="4" >
		     <input type=submit name="button3" value="查 询" class="inputbutton" style="cursor:hand">
  		  </td>

        </tr>
        <tr>
        </tr>
        <tr>

          <td colspan="2">

             <fieldset valign="top" align="center" id=listset>

              <legend><span color='#0C0C0C'> 选择工作 </span></legend>

              <div style="overflow:auto;width:360px;height:206px">
              <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="9C9C9C">
                <tr bgcolor="EAEAEA">
                  <td width="10%" align="center">选择</td>
                  <td width="10%" align="center">序号</td>
                  <td width="80%" align="center">工作名称</td>
                </tr>
                <%
					int nCount	  = 0;
					int nPageRows = 0;
					List jobList = JobBean.findJobByType(JOB_TYPE);
					for(int i=0; i< jobList.size();i++){
						JobVo jobinfo = (JobVo)jobList.get(i);

				%>
                <tr bgcolor="#FFFFFF">
                  <td align="center">
                    <input name="JOB_ID" type="checkbox" value="<%= jobinfo.getId() %>" >
                  </td>
                  <td align="center"> <%= i %>   </td>
                  <td><%= jobinfo.getJob_name() %></td>
                </tr>
                <%
                        nCount ++;
                    }
                    if(nCount < 10){	//如果数据行数比本页行数少，补空白行
                        for(int i=nCount; i<nPageRows; i++) {
                  %>
                <tr bgcolor="#FFFFFF">
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td align="center">&nbsp;</td>
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

      </table>
      <table width="378" border="1" cellpadding="6" cellspacing="0" bordercolorlight="A9A9A9" bordercolordark="#FFFFFF" >

        <tr>

          <td width="372" align="center">

            <input type=button value=' 确 定 ' class="inputbutton" style="cursor:hand" onclick="_ok();">
            <input type=hidden value="<%= nCount%>" name="recordcount">

          </td>

        </tr>

      </table>

    </td>

  </tr>

</table>
 </form>
 </table>
 </body>
</html>
