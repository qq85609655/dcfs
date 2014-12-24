<%@ page contentType="text/html;charset=GBK"%>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="base.task.resource.application.vo.ApplicationVO"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<jsp:directive.page import="base.resource.util.page.Pagination"/>
<%
  	String contextPath= request.getContextPath();
    String SYSTEM_NAME = (String) request.getAttribute("SYSTEM_NAME");
    String DESCRIPTION = (String) request.getAttribute("DESCRIPTION");
    ArrayList usingApps = (ArrayList) request.getAttribute("usingApps");
    List appList= (List)request.getAttribute("appList");
    if(appList==  null) appList= new ArrayList();
	
	Pagination pagination= null;
	String pageNumber= request.getParameter("pageNumber");
	int showItemNumber=10;
	if(pageNumber==null){
		pageNumber="1";
	}
	String HTML="";
	List taskList= new ArrayList();
	if(appList!=null&&appList.size()>0){
		pagination= new Pagination();
		pagination.setPageNumber(Integer.parseInt(pageNumber));
		pagination.setShowItemNumber(showItemNumber);
		pagination.setVisitPageURL(contextPath+"/base/task/resource/application/AppListServlet?SYSTEM_NAME="+SYSTEM_NAME+"&DESCRIPTION="+DESCRIPTION);
		taskList= pagination.interceptListByStartItemNumber(appList);
		HTML= pagination.buildHTML("100%","left","text01");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/customString.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/formVerify2.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/verify.js"></script>
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
<title>ϵͳӦ��</title>
<!-- �������� begin -->
<SCRIPT LANGUAGE="JavaScript">
<!--

//�½�
function _new() 
{
  window.location.href = "<%= contextPath %>/base/task/resource/application/NewAppServlet";
}

//ɾ��
function _del() 
{   
    var checkboxObj= document.getElementsByName("ID");
    var isSelected=false;
    for(var i=0;i<checkboxObj.length;i++){
    	if(checkboxObj[i].checked==true){
    		isSelected=true;
    		break;
    	}
    }
    if(isSelected==true){
	    realdel = window.confirm("ȷ��Ҫɾ����Щ��Ϣ��");
	    if ( realdel == true ){
	        document.frmSub.action = "<%= contextPath %>/base/task/resource/application/DeleteAppServlet";
	        document.frmSub.submit();
	    }
    }else{
    	alert("����ѡ����Ҫɾ����Ӧ�ã�");
    }
}

function queryAppList(){
  if(_check(frmSub)){ 
	document.frmSub.action="<%= contextPath %>/base/task/resource/application/AppListServlet";
	document.frmSub.submit();
	}else{
	return}
}
//-->
</SCRIPT>
</head>
<body>
<form name="frmSub" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="text01" >
  
<tr>
        <td height="25" colspan="4">
				  <div id="query">
				 &nbsp;Ӧ��ϵͳ���ƣ�
                 <input type="text" name="SYSTEM_NAME" size="15" fieldTitle="Ӧ��ϵͳ����" fieldType ="hasSpecialChar" class="queryinput" value="<%=SYSTEM_NAME%>"> 
&nbsp;������
<input type="text" name="DESCRIPTION" size="15" fieldTitle="����" fieldType ="hasSpecialChar" class="queryinput" value="<%=DESCRIPTION%>">
&nbsp;<input type=button name="querybutton" onclick="queryAppList();" value="�� ѯ" class="input01">
				  </div>		  
		</td>
</tr>	

<tr>
      <td colspan="4">
		<div id="primarydata" style="width:100%; overflow:hidden" >
              <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#9CC6F7" class="text01">
                <tr> 
                  <th width="5%" align="center"></th>
                  <th width="10%" align="center">���</th>
                  <th width="35%" align="center">Ӧ��ϵͳ����</th>
                  <th width="50%" align="center">����</th>
                </tr>
               <%
               		for(int i=0;i< taskList.size();i++){
               		  ApplicationVO appvo= (ApplicationVO)taskList.get(i);
               		  String systemid= appvo.getId();
               		  String systemname= appvo.getSystem_name();
               		  String systemdes= appvo.getDescription();
                %>
                <tr bgcolor="#FFFFFF"> 
                  <td align="center"> 
				<%
				     if ( ! usingApps.contains(systemid))
				     {
				%>
                    <input name="ID" type="checkbox" value="<%=systemid%>" >
                 <%
                    }
                    else
                    {
				 %>
                    <input name="ID" type="checkbox" value=""  disabled>
                  <%
                    }
				 %>
                  </td>
                  <td align="center"> <%= i+1%> </td>
                  <td> &nbsp;<a href="<%= contextPath %>/base/task/resource/application/EditAppServlet?ID=<%=systemid%>"><%=StringUtil.escapeHTMLTags(systemname)%></a> 
                  </td>
                  <td>&nbsp;<%= StringUtil.escapeHTMLTags(systemdes)%></td>
                  
                </tr>
                <%
                	}
                 %>
              </table>
  </div>
  </td>
  </tr>

  <tr height="15"> 
    <td colspan="4">
    <%=HTML %>
    </td>
  </tr>
  <tr align="center"> 
    <td colspan="4"> 
      <input type=hidden name="currentPage" value="1">
      <INPUT type=button name="button" value="�� ��" class="input01" onclick="_new()" >
      &nbsp;&nbsp; 
      <input type=button name="button2" value="ɾ ��" class="input01" onClick="_del()" >
    </td>
  </tr>
      
</table>
</form>
</body>
</html>