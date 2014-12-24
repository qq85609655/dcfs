<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*,com.icss.pangu.db.PageDBBean,com.icss.pangu.db.DBResult,com.icss.pangu.util.string.StringUtil" %>
<%@ page import="base.task.base.conf.SystemConfig"%>
<%
try
{
  String contextPath = request.getContextPath();
  PageDBBean pageDBBean = (PageDBBean) request.getAttribute("pageDBBean");
  DBResult dbResult = pageDBBean.getSelectDBResult();
  int nPageRows = pageDBBean.getEachPageRows();		//��ҳ��ʾ������

	String taskName = (String) request.getAttribute("taskName");
	String TIME1 = (String)request.getAttribute("TIME1");
    if (TIME1.length() >= 10) {
      TIME1 = TIME1.substring(0, 10);
    }
    String TIME2 = (String)request.getAttribute("TIME2");
    if (TIME2.length() >= 10) {
      TIME2 = TIME2.substring(0, 10);
    }
     //add by zhangzw :���Ӷ����н���Ĳ�ѯ
    String RUN_STATE = ( String)request.getAttribute("RUN_STATE");
    
  String navigation = "���ݽ���ƽ̨ -&gt; ��־��ѯͳ�� -&gt; ������ʷ��־��ѯ";
	if(!SystemConfig.getString("monitor.log.TaskLog").trim().equals(""))
	  navigation = new String(SystemConfig.getString("monitor.log.TaskLog").getBytes("iso8859-1"),"GBK");
%>

<!-- Header begin -->
<%@ include file="/eii/include/jsp/stmadc_header.jsp" %>
<!-- Header end -->
<META HTTP-EQUIV=Content-Type CONTENT="text/html; charset=gb2312">
<!-- �������� begin -->
<SCRIPT LANGUAGE="JavaScript" src="<%= contextPath %>/eii/include/js/jcommon.js"></SCRIPT>
<script LANGUAGE="javascript" SRC="<%= contextPath %>/eii/include/js/calendar.js"></script>
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
   sForm.action = "<%= contextPath %>/base/task/monitor/log/TaskLogListServlet";
   sForm.submit();
}


function _goPage(_page) {
     var sForm = document.frmSub;
     sForm.currentPage.value = _page;
     sForm.action = "<%= contextPath %>/base/task/monitor/log/TaskLogListServlet";
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
     sForm.action = "<%= contextPath %>/com/icss/eii/monitor/log/TaskLogListServlet";
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
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#EFEFEF">
              <tr height="20">
                <td width="87%"><img src="<%=contextPath%>/eii/images/niu-1.jpg" width="9" height="9">
                  ��ǰλ�ã� <%=navigation%></td>
                <td width="4%" align="right">
                    </td>
                <td width="9%">
                      </td>
              </tr>
            </table>
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
							<td width="18%" align="right">
								�������ƣ�
							</td>
							<td width="26%">
								<input type="text" name="taskName" size="25" class="inputtxt"
									value="
								<%=taskName%>">
							</td>
							<td width="18%" align="right">
								���н����
							</td>
							<td width="26%">
								 <select name="RUN_STATE" class="inputtxt">
								 <option value=""  <% if(RUN_STATE.equals("")) out.print("selected"); %> >��ѯȫ��</option>
								   <option value="0"  <% if(RUN_STATE.equals("0")) out.print("selected"); %> >��������</option>
								   <option value="1"  <% if(RUN_STATE.equals("1")) out.print("selected"); %>>��   ��</option>
								   <option value="2"  <% if(RUN_STATE.equals("2")) out.print("selected"); %> >ʧ   ��</option>
								   <option value="3" <% if(RUN_STATE.equals("3")) out.print("selected"); %>>��   ��</option>
								</select>
							</td>
							</tr>
							<tr>
							<td width="20%" align="right">
								��&nbsp;&nbsp;&nbsp;&nbsp;�ڣ�
							</td>
							<td width="43%">
								<input name="TIME1" type="text" class="inputtxt" size="10"
									value="
								<%= TIME1 %>" readonly>
								<img src="
								<%= contextPath %>/eii/images/time12.gif" style="cursor:hand;"
								alt="�������������˵�"
								onClick="document.frmSub.TIME1.value=showCalendar(document.frmSub.TIME1.value,650,200)">
								��
								<input name="TIME2" type="text" class="inputtxt" size="10"
									value="
								<%= TIME2 %>" readonly>
								<img src="
								<%= contextPath %>/eii/images/time12.gif" style="cursor:hand;"
								alt="�������������˵�"
								onClick="document.frmSub.TIME2.value=showCalendar(document.frmSub.TIME2.value,650,200)">
							</td>
						</tr>
					</table>
                  </td>
                  <td width="16%">
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
              <table width="1500" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="9C9C9C">

                <tr bgcolor="EAEAEA">
                    <td width="39" align="center">���</td>
                    <td width="147" align="center">��������</td>
                    <td width="142" align="center">��ʼʱ��</td>
                    <td width="140" align="center">����ʱ��</td>
                    <td width="118" align="center">���н��</td>
                    <td width="871" align="center">�����Ϣ</td>
                </tr>
                <%
                    int baseCount = (pageDBBean.getCurrentPage()-1)*pageDBBean.getEachPageRows()+1;
                    int nCount = 0 ;
                    for(int i=0 ;i<dbResult.getRows(); i++)
                    {
                      String TL_TASK_ID = dbResult.getString(i, 0);
                      String TI_TASK_NAME = dbResult.getString(i, 1);
                      String TL_START_TIME = dbResult.getString(i, 2);
                      String TL_END_TIME = dbResult.getString(i, 3);
                      String TL_RUN_STATE = dbResult.getString(i, 4);
                      String TL_RUN_MSG = dbResult.getString(i, 5);
                      String TL_LOG_ID = dbResult.getString(i, 6);
                      if (TL_RUN_STATE.equals("0"))
                      {
                        TL_RUN_STATE = "��������";
                      }
                      else if (TL_RUN_STATE.equals("1"))
                      {
                        TL_RUN_STATE = "�ɹ�";
                      }
                      else if (TL_RUN_STATE.equals("2"))
                      {
                        TL_RUN_STATE = "ʧ��";
                      }
                      else if (TL_RUN_STATE.equals("3"))
                      {
                        TL_RUN_STATE = "�쳣";
                      }
%>
                  <tr bgcolor="#FFFFFF">
                    <td align="center" width="39"> <%= baseCount+i %> </td>
                    <td width="147">&nbsp;<a href="<%= contextPath%>/com/icss/eii/monitor/log/TaskLogDetailServlet?TL_LOG_ID=<%=TL_LOG_ID%>&TIME1=<%=TIME1%>&TIME2=<%=TIME2%>"><%=TI_TASK_NAME%></a></td>
                    <td align="center" width="142"><%= TL_START_TIME.substring(0, 19)%></td>
                    <td width="140" align="center"><%= TL_END_TIME.substring(0, 19)%></td>
                    <td align="center" width="118"><%= TL_RUN_STATE%></td>
                    <td width="871">&nbsp;<%= StringUtil.HTMLEncode(TL_RUN_MSG) %> </td>
                </tr>
                <%
                        nCount ++;
                    }
                    if(nCount < nPageRows){	//������������ȱ�ҳ�����٣����հ���
                        for(int i=nCount; i<nPageRows; i++) {
                  %>
                <tr bgcolor="#FFFFFF">
                    <td align="center" width="39">&nbsp;</td>
                    <td align="center" width="147">&nbsp;</td>
                    <td width="142">&nbsp;</td>
                    <td align="center" width="140">&nbsp;</td>
                    <td width="118">&nbsp;</td>
                    <td width="871">&nbsp;</td>
                </tr>
                <%    }
                     }
                  %>
              </table>
             </div>
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
                <td>
                    <input type=hidden name="currentPage" value="1">
                    &nbsp;
                    <!-- <input type=button name="button2" value="�� ��" class="inputbutton" onClick="_return()" style="cursor:hand"> -->
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
