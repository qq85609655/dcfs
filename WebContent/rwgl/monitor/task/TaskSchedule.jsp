<%@ page contentType="text/html; charset=GBK" %>
<%
try
{ 
   String contextPath = request.getContextPath();
   String theYear = (String)request.getAttribute("year");
   String theMonth = (String)request.getAttribute("month");
   int[] taskCount = (int[])request.getAttribute("taskCount");
   String[] taskNames = (String[])request.getAttribute("taskNames");
%> 
<!-- Header begin -->
<%@ include file="/eii/include/jsp/stmadc_header.jsp" %>
<!-- Header end -->
<script>
   var theYear = <%=theYear%>;
   var theMonth = <%=theMonth%>;
</script>
<!-- 内容区域 begin -->
<table bgcolor="#FFFFFF" align=center width=100% height=100% border="0"><tr><td align=center width=100% height="3%"><font color=#003366 size=+2>今后的任务安排情况</font>
<select id="taskCountSelect" style="visibility:hidden;width:4" disabled>
<%   for(int index=0;index<taskCount.length ;index++){ %>
<option value="<%=taskCount[index]%>"><%=taskNames[index]%></option>
<%   }  %>
</select>
</td></tr><tr><td  width="100%" height="100%" >
<iframe marginwidth="0" id="dateIframe" name="dateIframe" marginheight="4" target="_self" src="<%= contextPath %>/eii/jsp/monitor/task/date.jsp" width="100%" height="380"  frameborder="0" scrolling="no"></iframe>
</td></tr>
</table>
<!-- 内容区域 end -->

<!-- Tail begin -->
<%@ include file="/eii/include/jsp/stmadc_tail.jsp" %>
<%
}
catch(Exception e)
{
	out.println(e);
}
%>