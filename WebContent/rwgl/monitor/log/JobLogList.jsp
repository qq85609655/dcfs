<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*,com.icss.pangu.db.PageDBBean,com.icss.pangu.db.DBResult,com.icss.pangu.util.string.StringUtil" %>


<%
try
{
  String contextPath = request.getContextPath();
  PageDBBean pageDBBean = (PageDBBean) request.getAttribute("pageDBBean");
  DBResult dbResult = pageDBBean.getSelectDBResult();
    //add by zhangzw :增加对运行结果的查询
    String run_state = ( String)request.getAttribute("RUN_STATE");
    
  int nPageRows = pageDBBean.getEachPageRows();		//此页显示的行数

	String jobName = (String) request.getAttribute("jobName");
	String jobType = (String) request.getAttribute("jobType");
	String TIME1 = (String)request.getAttribute("TIME1");
    if (TIME1.length() >= 10) {
      TIME1 = TIME1.substring(0, 10);
    }
    String TIME2 = (String)request.getAttribute("TIME2");
    if (TIME2.length() >= 10) {
      TIME2 = TIME2.substring(0, 10);
    }

%>

<!-- Header begin -->

<!-- Header end -->
<META HTTP-EQUIV=Content-Type CONTENT="text/html; charset=gb2312">
<!-- 内容区域 begin -->
<SCRIPT LANGUAGE="JavaScript" src="<%= contextPath %>/rwgl/js/jcommon.js"></SCRIPT>
<script LANGUAGE="javascript" SRC="<%= contextPath %>/rwgl/js/calendar.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function _submit()
{
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
   sForm.action = "<%= contextPath %>/base/task/monitor/log/JobLogListServlet";
   sForm.submit();
}


function _goPage(_page) {
     var sForm = document.frmSub;
     sForm.currentPage.value = _page;
     sForm.action = "<%= contextPath %>/base/task/monitor/log/JobLogListServlet";
     sForm.submit();
	 return;
}

function _jumpPage() {
     var totalPage = <%= pageDBBean.getPages() %>;
     var sForm = document.frmSub;
	 if ( !is_positiveInt(sForm.pageNum.value) ) {
	 	doCritCode(sForm.pageNum,1,MSG_ERROR_PAGE_NUM);
		return;
	 }
	 if ( (sForm.pageNum.value-1) > (totalPage-1) ) {
	 	doCritCode(sForm.pageNum,1,MSG_OVER_PAGE_NUM);
		return;
	 }
     sForm.currentPage.value = sForm.pageNum.value;
     sForm.action = "<%= contextPath %>/base/task/monitor/log/JobLogListServlet";
     sForm.submit();
	 return;
}

function _return()
{
  window.location.href = "<%= contextPath %>/eii/jsp/homepage.jsp";
}

//-->
</SCRIPT>
<form name="frmSub" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
  <tr height="450">
    <td align="center" valign="top">
      <table align="center" width="100%" border="0" cellpadding="3" cellspacing="1">
        <tr>
          <td align="center">
            
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr height="9">
                <td></td>
              </tr>
            </table>
              <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="9C9C9C">
              
                <tr bgcolor="#EAEAEA" height="22">
                  <td colspan="2"><font color="4A4A4A">&nbsp;■ 查询条件 </font></td>
                </tr>
                <tr align="center" bgcolor="#FFFFFF" height="30">
                  <td width="84%" align="center">
                    <table border="0" width="100%" cellspacing="5" cellpadding="0">
                      <tr>
                        <td  align="right">
                          <div>工作名称：</div>
                        </td>
                        <td width="10%">
                          <input type="text" name="jobName" size="25" class="inputtxt" value="<%=jobName%>">
                        </td>
                      
                        <td  align="right">加工类型：</td>
                        <td height="4" >
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
			           </td>
			           </tr>
			           <tr>
			          <td width="18%" align="right">
								运行结果：
							</td>
							<td width="26%">
								 <select name="RUN_STATE" class="inputtxt">
								 <option value=""  <% if(run_state.equals("")) out.print("selected"); %> >查询全部</option>
								   <option value="0"  <% if(run_state.equals("0")) out.print("selected"); %> >正在运行</option>
								   <option value="1"  <% if(run_state.equals("1")) out.print("selected"); %>>成   功</option>
								   <option value="2"  <% if(run_state.equals("2")) out.print("selected"); %> >失   败</option>
								   <option value="3" <% if(run_state.equals("3")) out.print("selected"); %>>异   常</option>
								</select>
							</td>
                        
                        <td width="10%" align="right"  align="right"> 日&nbsp;&nbsp;&nbsp;&nbsp;期： </td>
                        <td width="36%">
                          <input name="TIME1" type="text" class="inputtxt" size="10" value="<%= TIME1 %>" readonly>
                          <img src="<%= contextPath %>/eii/images/time12.gif" style="cursor:hand;" alt="弹出日历下拉菜单" onClick="document.frmSub.TIME1.value=showCalendar(document.frmSub.TIME1.value,650,200)">
                          到
							<input name="TIME2" type="text" class="inputtxt" size="10" value="<%= TIME2 %>" readonly>
                          <img src="<%= contextPath %>/eii/images/time12.gif" style="cursor:hand;" alt="弹出日历下拉菜单" onClick="document.frmSub.TIME2.value=showCalendar(document.frmSub.TIME2.value,650,200)">
                        </td>
                      </tr>
                    </table>
                  </td>
                  <td width="6%">
                    <input type=button name="button3" value="查 询" class="inputbutton" style="cursor:hand" onclick="_submit()">
                  </td>
                </tr>

              </table>
              
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr height="9">
                <td></td>
              </tr>
            </table>
          
            
                <DIV class="div" style="overflow-x:scroll; width:781; margin:0px; BORDER-BOTTOM: #9C9C9C 1px solid;">
			       <TABLE width="1622" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="9C9C9C">

                <TR bgcolor="EAEAEA">
                    <TD width="39" align="center">序号</TD>
                    <TD width="122" align="center"><B></B>工作名称</TD>
                    <TD width="122" align="center">加工类型</TD>  
                    <TD width="131" align="center">所属任务</TD>
                    <TD width="143" align="center">开始时间</TD>
                    <TD width="138" align="center">结束时间</TD>
                    <TD width="99" align="center">运行结果</TD>
                    <TD width="768" align="center">结果信息</TD></TR>
                <%
                    int baseCount = (pageDBBean.getCurrentPage()-1)*pageDBBean.getEachPageRows()+1;
                    int nCount = 0 ;
                    for(int i=0 ;i<dbResult.getRows(); i++)
                    {
                      String JOB_ID = dbResult.getString(i, 0);
                      String JOB_NAME = dbResult.getString(i, 1);
                      String JOB_TYPE = dbResult.getString(i, 2);
                      String TI_TASK_NAME = dbResult.getString(i, 3);
                      String START_TIME = dbResult.getString(i, 4);
                      String END_TIME = dbResult.getString(i, 5);
                      String RUN_STATE = dbResult.getString(i, 6);
                      String RUN_MSG = dbResult.getString(i, 7);
                      String LOG_ID = dbResult.getString(i,8);
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
                    <TD align="center" width="49"> <%= baseCount+i %></TD>
               <%
                    if(JOB_TYPE.equals("09")) {
                %>    
                    <TD width="122">&nbsp;<A href="<%= contextPath %>/base/task/monitor/log/SendLogListServlet?JOBLOG_ID=<%= LOG_ID%>&TIME1=<%=TIME1%>&TIME2=<%=TIME2%>"><%=JOB_NAME%></A></TD>  
               <%
                    }else{
                %>      
                    <TD width="122">&nbsp;<%=JOB_NAME%></TD>
                <%
                    }
                %>    
                    <TD width="122">&nbsp;<%=typeStr%></TD>
                    <TD width="131">&nbsp;<%=TI_TASK_NAME%></TD>
                    <TD align="center" width="143"><%= START_TIME.substring(0, 19)%></TD>
                    <TD width="138" align="center"><%= END_TIME.substring(0, 19)%></TD>
                    <TD align="center" width="99"><%= RUN_STATE%></TD>
				    <TD width="768">&nbsp;<%= StringUtil.HTMLEncode(RUN_MSG)%></TD></TR>
                <%
                        nCount ++;
                    }
                    if(nCount < nPageRows){	//如果数据行数比本页行数少，补空白行
                        for(int i=nCount; i<nPageRows; i++) {
                  %>
                <TR bgcolor="#FFFFFF">
                    <TD align="center" width="49">&nbsp;</TD>
                    <TD align="center" width="122">&nbsp;</TD>
                    <TD align="center" width="122">&nbsp;</TD>
                    <TD align="center" width="131">&nbsp;</TD>
                    <TD width="143">&nbsp;</TD>
                    <TD align="center" width="138">&nbsp;</TD>
                    <TD width="99">&nbsp;</TD>
                    <TD width="768">&nbsp;</TD></TR>
                <%    }
                     }
                  %></TABLE>
                  </DIV>                 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>
                  <table border="0" align="right" cellpadding="3" cellspacing="0">
                    <tr>
                      <%
                          if (pageDBBean.isFirstPage()) {
                      %>
                          <td width="53"><img src="<%= contextPath %>/eii/images/pageone2.gif" width="53" height="17" ></td>
                          <td width="53"><img src="<%= contextPath %>/eii/images/pageup2.gif" width="53" height="17"></td>
                      <%
                          } else {
                      %>
                          <td width="53"><img src="<%= contextPath %>/eii/images/pageone.gif" width="53" height="17" onClick="JavaScript:_goPage(1)" style="cursor:hand"></td>
                          <td width="53"><img src="<%= contextPath %>/eii/images/pageup.gif" width="53" height="17" onClick="JavaScript:_goPage(<%= pageDBBean.getCurrentPage() - 1 %>)" style="cursor:hand"></td>
                      <%
                          }
                          if (pageDBBean.isLastPage()) {
                      %>
                          <td width="53"><img src="<%= contextPath %>/eii/images/pagedown2.gif" width="53" height="17"></td>
                          <td width="53"><img src="<%= contextPath %>/eii/images/pageend2.gif" width="53" height="17"></td>
                      <% } else { %>
                          <td width="53"><img src="<%= contextPath %>/eii/images/pagedown.gif" width="53" height="17" onClick="JavaScript:_goPage(<%= pageDBBean.getCurrentPage() + 1 %>)" style="cursor:hand" ></td>
                          <td width="53"><img src="<%= contextPath %>/eii/images/pageend.gif" width="53" height="17" onClick="JavaScript:_goPage(<%= pageDBBean.getPages() %>)" style="cursor:hand" ></td>
                      <% } %>
                      <% if ( pageDBBean.getPages()==0 || pageDBBean.getPages()==1 ) { %>
                          <td width="36"> <input name="pageNum" type="text" class="inputtxt" size="6" readonly></td>
                          <td width="53"><img src="<%= contextPath %>/eii/images/pagejump2.gif" width="53" height="17" ></td>
                       <% } else { %>
                          <td width="36"> <input name="pageNum" type="text" class="inputtxt" size="6"></td>
                          <td width="53"><img src="<%= contextPath %>/eii/images/pagejump.gif" width="53" height="17" onclick="JavaScript:_jumpPage()" style="cursor:hand" ></td>
                       <% } %>
                          <td><%= pageDBBean.getCurrentPage() %>/<%= pageDBBean.getPages() %>页&nbsp;共<%= pageDBBean.getRows() %>条</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr height="15">
                <td></td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr align="center">
                <td><!-- <input type=button name="button2" value="返 回" class="inputbutton" onClick="_return()" style="cursor:hand"> -->
                  <INPUT type="hidden" name="currentPage" value="1">
                    &nbsp;
                  
                </td>
              </tr>
            </table>
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr height="15">
              <td></td>
            </tr>
          </table>
         </td>
       </tr>
     </table>
    </td>
  </tr>
</table>
</form>
<!-- 内容区域 end -->

<!-- Tail begin -->
<%@ include file="/eii/include/jsp/stmadc_tail.jsp" %>
<!-- Tail end -->
<%
}
catch(Exception e)
{
	out.println(e);
}
%>