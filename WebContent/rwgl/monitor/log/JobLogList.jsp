<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*,com.icss.pangu.db.PageDBBean,com.icss.pangu.db.DBResult,com.icss.pangu.util.string.StringUtil" %>


<%
try
{
  String contextPath = request.getContextPath();
  PageDBBean pageDBBean = (PageDBBean) request.getAttribute("pageDBBean");
  DBResult dbResult = pageDBBean.getSelectDBResult();
    //add by zhangzw :���Ӷ����н���Ĳ�ѯ
    String run_state = ( String)request.getAttribute("RUN_STATE");
    
  int nPageRows = pageDBBean.getEachPageRows();		//��ҳ��ʾ������

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
<!-- �������� begin -->
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
		   alert("��ʼ���ڲ����ڵ�ǰ����֮��");
		   sForm.TIME1.focus();
		   return;
	   }
	}
	if(sForm.TIME2.value != "")
	{
	   if (!_compareTwoDateForString(sForm.TIME2.value, _getCurrentDate(0)))
	   {
		   alert("��ֹ���ڲ����ڵ�ǰ����֮��");
		   sForm.TIME2.focus();
		   return;
	   }
	}
    if (sForm.TIME1.value != "" && sForm.TIME2.value != "")
    {
		if (!_compareTwoDateForString(sForm.TIME1.value, sForm.TIME2.value))
		{
			alert("���ڷ�Χѡ��Ӧ�ð����Ⱥ�˳����д��");
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
                  <td colspan="2"><font color="4A4A4A">&nbsp;�� ��ѯ���� </font></td>
                </tr>
                <tr align="center" bgcolor="#FFFFFF" height="30">
                  <td width="84%" align="center">
                    <table border="0" width="100%" cellspacing="5" cellpadding="0">
                      <tr>
                        <td  align="right">
                          <div>�������ƣ�</div>
                        </td>
                        <td width="10%">
                          <input type="text" name="jobName" size="25" class="inputtxt" value="<%=jobName%>">
                        </td>
                      
                        <td  align="right">�ӹ����ͣ�</td>
                        <td height="4" >
                          <select name="jobType" >
				             <option value="" <% if(jobType.equals("")) out.print("selected"); %>>ȫ��</option>
                             <option value="01" <% if(jobType.equals("01")) out.print("selected"); %>>�洢����</option>
                             <option value="02" <% if(jobType.equals("02")) out.print("selected"); %>>��ͨJAVA����</option>
                             <option value="03" <% if(jobType.equals("03")) out.print("selected"); %>>ͨ����չ�ӿ�</option>
                             <option value="04" <% if(jobType.equals("04")) out.print("selected"); %>>ִ�г���</option>
                             <option value="05" <% if(jobType.equals("05")) out.print("selected"); %>>SQL</option>
                             <option value="06" <% if(jobType.equals("06")) out.print("selected"); %>>URL</option>
                             <option value="07" <% if(jobType.equals("07")) out.print("selected"); %>>�򵥳�ȡ</option>
                             <option value="08" <% if(jobType.equals("08")) out.print("selected"); %>>ETL</option>
                             <option value="09" <% if(jobType.equals("09")) out.print("selected"); %>>Զ��</option>                 
                         </select>
			           </td>
			           </tr>
			           <tr>
			          <td width="18%" align="right">
								���н����
							</td>
							<td width="26%">
								 <select name="RUN_STATE" class="inputtxt">
								 <option value=""  <% if(run_state.equals("")) out.print("selected"); %> >��ѯȫ��</option>
								   <option value="0"  <% if(run_state.equals("0")) out.print("selected"); %> >��������</option>
								   <option value="1"  <% if(run_state.equals("1")) out.print("selected"); %>>��   ��</option>
								   <option value="2"  <% if(run_state.equals("2")) out.print("selected"); %> >ʧ   ��</option>
								   <option value="3" <% if(run_state.equals("3")) out.print("selected"); %>>��   ��</option>
								</select>
							</td>
                        
                        <td width="10%" align="right"  align="right"> ��&nbsp;&nbsp;&nbsp;&nbsp;�ڣ� </td>
                        <td width="36%">
                          <input name="TIME1" type="text" class="inputtxt" size="10" value="<%= TIME1 %>" readonly>
                          <img src="<%= contextPath %>/eii/images/time12.gif" style="cursor:hand;" alt="�������������˵�" onClick="document.frmSub.TIME1.value=showCalendar(document.frmSub.TIME1.value,650,200)">
                          ��
							<input name="TIME2" type="text" class="inputtxt" size="10" value="<%= TIME2 %>" readonly>
                          <img src="<%= contextPath %>/eii/images/time12.gif" style="cursor:hand;" alt="�������������˵�" onClick="document.frmSub.TIME2.value=showCalendar(document.frmSub.TIME2.value,650,200)">
                        </td>
                      </tr>
                    </table>
                  </td>
                  <td width="6%">
                    <input type=button name="button3" value="�� ѯ" class="inputbutton" style="cursor:hand" onclick="_submit()">
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
                    <TD width="39" align="center">���</TD>
                    <TD width="122" align="center"><B></B>��������</TD>
                    <TD width="122" align="center">�ӹ�����</TD>  
                    <TD width="131" align="center">��������</TD>
                    <TD width="143" align="center">��ʼʱ��</TD>
                    <TD width="138" align="center">����ʱ��</TD>
                    <TD width="99" align="center">���н��</TD>
                    <TD width="768" align="center">�����Ϣ</TD></TR>
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
                        RUN_STATE = "��������";
                      }
                      else if (RUN_STATE.equals("1"))
                      {
                        RUN_STATE = "�ɹ�";
                      }
                      else if (RUN_STATE.equals("2"))
                      {
                        RUN_STATE = "ʧ��";
                      }
                      else if (RUN_STATE.equals("3"))
                      {
                        RUN_STATE = "�쳣";
                      }
                      String typeStr = "";
                      if(JOB_TYPE.equals("01")){
                        typeStr = "�洢����";
                      }else if (JOB_TYPE.equals("02")){
                        typeStr = "��ͨJAVA����";
                      }else if (JOB_TYPE.equals("03")){
                        typeStr = "ͨ����չ�ӿ�";
                      }else if (JOB_TYPE.equals("04")){
                        typeStr = "ִ�г���";
                      }else if (JOB_TYPE.equals("05")){
                        typeStr = "SQL";
                      }else if (JOB_TYPE.equals("06")){
                        typeStr = "URL";
                      }else if (JOB_TYPE.equals("07")){
                        typeStr = "�򵥳�ȡ";
                      }else if (JOB_TYPE.equals("08")){
                        typeStr = "ETL";
                      }else if (JOB_TYPE.equals("09")){
                        typeStr = "Զ��";
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
                    if(nCount < nPageRows){	//������������ȱ�ҳ�����٣����հ���
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
                          <td><%= pageDBBean.getCurrentPage() %>/<%= pageDBBean.getPages() %>ҳ&nbsp;��<%= pageDBBean.getRows() %>��</td>
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
                <td><!-- <input type=button name="button2" value="�� ��" class="inputbutton" onClick="_return()" style="cursor:hand"> -->
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
<!-- �������� end -->

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