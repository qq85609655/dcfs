<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" isErrorPage="true" %>
<%@ page import="hx.common.Constants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<BZ:html>
<%
	Object msg=request.getAttribute(Constants.ERROR_MSG_TITLE);
	Exception ex=(Exception)request.getAttribute(Constants.ERROR_MSG);
	if(msg==null){
	    msg="";
	}
	//response.setCharacterEncoding("GBK");
	//response.setStatus(200); 

%>
<BZ:head>
	<title>´íÎóÒ³Ãæ</title>
</BZ:head> 
<BZ:body>
	<table align="center" width="100%" class="chaxuntj" >
		<caption><h3>´íÎó</h3></caption>
		<tr>
			<td><%=msg %></td>
		</tr>
		<tr>
			<td><%=ex.getMessage()%></td>
		</tr>
		<%-- <tr>
			<td>
				<%
				    Throwable t=ex;
				    while(t!=null){
					    StackTraceElement[] trace = t.getStackTrace();
					    for (int i=0; i<trace.length;i++){
					    	%>
					    	<%= trace[i]%>
					    	<br/>
					    	<%
					    }
					    t=t.getCause();
				    }
				
				%>
			</td>
		</tr> --%>
	</table>
</BZ:body>
</BZ:html>