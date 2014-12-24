<%@ page contentType="text/html;charset=GBK"%>
<jsp:directive.page import="base.task.base.conf.SystemConfig" />
<jsp:directive.page import="java.util.ArrayList" />
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="java.util.Hashtable"/>
<jsp:directive.page import="base.task.util.StringUtil"/>
<jsp:directive.page import="base.task.monitor.log.vo.JobLogVO"/>
<%
	String contextPath = request.getContextPath();
	String TI_TASK_NAME = (String) request.getAttribute("TI_TASK_NAME");
	String TIME1 = (String) request.getAttribute("TIME1");
	String TIME2 = (String) request.getAttribute("TIME2");
	String TL_RUN_STATE = (String) request.getAttribute("TL_RUN_STATE");
	List JobLogList = (List)request.getAttribute("JobLogList");
	Hashtable jobHT= (Hashtable)request.getAttribute("jobHT");
	
	if(JobLogList== null) JobLogList= new ArrayList(); 
	if(jobHT== null) jobHT= new Hashtable(); 
	
	
	
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
  String navigation = "������� -&gt; ������ʷ��־��ѯ -&gt; ������ʷ����������־��ϸ";
%>
<html>
	<head>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="<%=contextPath%>/css/style.css" rel="stylesheet"
			type="text/css" />
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
		<script LANGUAGE="javascript"
			SRC="<%=contextPath%>/js/extendString.js"></script>
		<script LANGUAGE="javascript" SRC="<%=contextPath%>/js/jcommon.js"></script>
<script language="javascript">
function _return() 
{
  window.location.href = "<%=contextPath%>/base/task/monitor/log/TaskLogListServlet?TIME1=<%=TIME1%>&TIME2=<%=TIME2%>";
}
 

</script>
</head>
<body>
<form name="frmSub" method="post">			
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="text01" >
  <tr>
    <td height="18"  valign="middle"><img src="<%=contextPath%>/images/currentpositionbg.jpg" width="8" height="18" id="positionimg"/><div class="currentposition"><strong>&nbsp; ��ǰλ��-&gt;<%=navigation%></div></td>
    <td  class="currentposition" align="right"><strong></strong></td>
    <td width="4%" align="right"> 
     </td>
    <td width="9%"> 
     </td>
  </tr>
  
<tr>
        <td height="25" colspan="4">
			<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="9C9C9C" class="text01">
                <tr bgcolor="#EAEAEA" height="22"> 
                  
                <td align="left">&nbsp;�� ������Ϣ </td>
                </tr>
                <tr align="center" bgcolor="#FFFFFF" height="30"> 
                	<td width="100%" align="center"> 
                  		<table border="0" width="100%" cellspacing="5" cellpadding="0" class="text01">
                    		<tr> 
                       <td width="17%" align="right">�������ƣ�</td>
                      <td width="26%">
                        &nbsp;<%=StringUtil.escapeHTMLTags(TI_TASK_NAME)%>
					            </td>
                      <td width="12%"  align="right">����״̬��</td>
                      <td width="45%">&nbsp;<%=TL_RUN_STATE%></td>
                    	</tr>
                  </table>
                  </td>
                 </tr>
              </table>		  
		</td>
</tr>	

 <tr>
        <td height="18" colspan="4">
			&nbsp;	 	  
		</td>
</tr>

<tr>
      <td colspan="4">
		<div id="primarydata" style="width:100%; overflow:hidden" >
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#9CC6F7" class="text01">
                <tr bgcolor="#EAEAEA" height="22"> 
                <td bgcolor="#EAEAEA" height="22" align="left">&nbsp;�� ������Ϣ</td>
                </tr>
                <tr align="center" bgcolor="#FFFFFF"> 
                <td width="100%" align="center" valign="top" >
                  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="9C9C9C" class="text01" style="vertical-align: top;">
                    <tr bgcolor="EAEAEA">
                      <th width="40" align="center">���</th>
                      <th width="139" align="center">��������</th>
                      <th width="153" align="center">��ʼʱ��</th>
                      <th width="154" align="center">����ʱ��</th>
                      <th width="77" align="center">����״̬</th>
                      <th width="284" align="center">��ϸ��Ϣ</th>
                    </tr>
<%
                   for(int i = 0 ; i < JobLogList.size(); i++)
                   {
                      JobLogVO jvo= (JobLogVO)JobLogList.get(i);
			  String jobId = jvo.getJOB_ID();
                      String jobName = (String)jobHT.get(jobId);
                      String startTime = jvo.getSTART_TIME();
                      String endTime = jvo.getEND_TIME();
                      String runningState = jvo.getRUN_STATE();
                      String detail = jvo.getRUN_MSG();
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
                      <td align="center" width="40" height="26"> <%=i + 1%>
                      </td>
                      <td width="139" height="26">&nbsp;<%=StringUtil.escapeHTMLTags(jobName)%></td>
                      <td align="center" width="153" height="26"><%=startTime%></td>
                      <td align="center" width="154" height="26" ><%=endTime%></td>
                      <td align="center" width="77" height="26"><%=theStatus%></td>
                      <td width="284" height="26">&nbsp;<%=StringUtil.HTMLEncode(detail)%></td>
                    </tr>
<%
                    }
%>
                  </table>
  </td>
  </tr>
</table>
</div>
</td>
</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="text01">
   <tr align="center"> 
     <td height="20"> 
       &nbsp;
     </td>
   </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="text01">
    <tr align="center"> 
      <td> 
        <input type=button name="button2" value="�� ��" class="input01" onClick="javascript: _return()" >
      </td>
    </tr>
</table>

</html>
