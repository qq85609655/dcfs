<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*,com.icss.pangu.db.DBResult,com.icss.pangu.util.string.StringUtil" %>
<%@ page import="base.task.base.conf.SystemConfig"%>
<%
try
{
    String contextPath = request.getContextPath();
	String TI_TASK_NAME = (String) request.getAttribute("TI_TASK_NAME");
	String TIME1 = (String) request.getAttribute("TIME1");
	String TIME2 = (String) request.getAttribute("TIME2");
	String TL_RUN_STATE = (String) request.getAttribute("TL_RUN_STATE");
	DBResult dbResult = (DBResult) request.getAttribute("dbResult");
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
  String navigation = "���ݽ���ƽ̨ -&gt; ��־��ѯͳ�� -&gt; ������ʷ��־��ѯ -&gt; ������ʷ����������־��ϸ";
	if(!SystemConfig.getString("monitor.log.TaskLogDetail").trim().equals(""))
	  navigation = new String(SystemConfig.getString("monitor.log.TaskLogDetail").getBytes("iso8859-1"),"GBK");
%>

<script language="javascript">
 function _return() 
{
  window.location.href = "/eii/base/task/monitor/log/TaskLogListServlet?TIME1=<%=TIME1%>&TIME2=<%=TIME2%>";
}
 

</script>

<!-- Header begin -->
<%@ include file="/eii/include/jsp/stmadc_header.jsp" %>
<!-- Header end -->
<META HTTP-EQUIV=Content-Type CONTENT="text/html; charset=gb2312">
<!-- �������� begin -->

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
                  <td><font color="4A4A4A">&nbsp;�� ������Ϣ </font></td>
                </tr>
                <tr align="center" bgcolor="#FFFFFF" height="30">
                	<td width="100%" align="center">
                  		<table border="0" width="100%" cellspacing="5" cellpadding="0">
                    		<tr>
                      <td width="17%" align="right">�������ƣ�</td>
                      <td width="26%">
                        &nbsp;<%=TI_TASK_NAME%>
					            </td>
                      <td width="12%"  align="right">����״̬��</td>
                      <td width="45%">&nbsp;<%=TL_RUN_STATE%></td>
                    	</tr>
                  </table>
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
                <td><font color="4A4A4A">&nbsp;�� ������Ϣ </font></td>
                </tr>
                <tr align="center" bgcolor="#FFFFFF" height="30">

                <td width="100%" align="center">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr height="5">
                        <td></td>
                    </tr>
                   </table>
                
                  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="9C9C9C">
                    <tr bgcolor="EAEAEA">
                      <td width="40" align="center">���</td>
                      <td width="139" align="center">��������</td>
                      <td width="153" align="center">��ʼʱ��</td>
                      <td width="154" align="center">����ʱ��</td>
                      <td width="77" align="center">����״̬</td>
                      <td width="284" align="center">��ϸ��Ϣ</td>
                    </tr>
<%
                   int nCount = 0;
                   for(int i = 0 ; i < dbResult.getRows(); i++)
                   {
					            String jobId = dbResult.getString(i, "JOB_ID");
                      String jobName =dbResult.getString(i, "JOB_NAME");
                      String startTime = dbResult.getString(i, "START_TIME").substring(0, 19);
                      String endTime =dbResult.getString(i, "END_TIME").substring(0, 19);
                      String runningState =dbResult.getString(i, "RUN_STATE");
                      String detail = dbResult.getString(i, "RUN_MSG");
                      String theStatus = "";
                      if (runningState.equals("0"))
                      {
                        theStatus = "��������";
                      }
                      else if (runningState.equals("1"))
                      {
                        theStatus = "�ɹ�";
                      }
                      else if (runningState.equals("2"))
                      {
                        theStatus = "ʧ��";
                      }
                      else if (runningState.equals("3"))
                      {
                        theStatus = "�쳣";
                      }
                      else if (runningState.equals("4"))
                      {
                        theStatus = "�ȴ���";
                      }
%>
                    <tr bgcolor="#FFFFFF">
                      <td align="center" width="40" height="26"> <%= i + 1 %>
                      </td>
                      <td width="139" height="26">&nbsp;<%=jobName%></td>
                      <td align="center" width="153" height="26"><%= startTime%></td>
                      <td align="center" width="154" height="26" ><%= endTime%></td>
                      <td align="center" width="77" height="26"><%= theStatus%></td>
                      <td width="284" height="26">&nbsp;<%=StringUtil.HTMLEncode(detail)%></td>
                    </tr>
<%
                        nCount ++;
                    }
%>
                  </table>
				   <br>
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
                  <input type=button name="button2" value="�� ��" class="inputbutton" onClick="_return();" style="cursor:hand">
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
<p>&nbsp;</p>