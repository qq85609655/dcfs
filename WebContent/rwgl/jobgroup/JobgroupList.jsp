<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*" %>
<%@ page import="base.task.resource.jobgroup.vo.JobGroupVo" %>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<jsp:directive.page import="base.resource.util.page.Pagination"/>
<%
	String contextPath = request.getContextPath();
	String GROUP_NAME = (String) request.getAttribute("GROUP_NAME");
	String DESCRIPTION = (String) request.getAttribute("DESCRIPTION");
	ArrayList usingGroups = (ArrayList) request
			.getAttribute("usingGroups");
	Hashtable inUsing = (Hashtable) request.getAttribute("inUsing");
	
	Pagination pagination= null;
	String pageNumber= request.getParameter("pageNumber");
	int showItemNumber=10;
	if(pageNumber==null){
		pageNumber="1";
	}
	String HTML="";
	List taskList= new ArrayList();
	if(usingGroups!=null&&usingGroups.size()>0){
		pagination= new Pagination();
		pagination.setPageNumber(Integer.parseInt(pageNumber));
		pagination.setShowItemNumber(showItemNumber);
		pagination.setVisitPageURL(contextPath+"/base/task/resource/jobgroup/JobgroupListServlet?GROUP_NAME="+GROUP_NAME);
		taskList= pagination.interceptListByStartItemNumber(usingGroups);
		HTML= pagination.buildHTML("100%","left","text01");
	}

%>
<html>
	<head>
		<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=contextPath%>/rwgl/js/customString.js"></script>
        <script type="text/javascript" src="<%=contextPath%>/rwgl/js/formVerify2.js"></script>
        <script type="text/javascript" src="<%=contextPath%>/rwgl/js/verify.js"></script>
		<title>工作组管理</title>
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
	</head>
	<script>
//新建
function _new() 
{
  window.location.href = "<%=contextPath%>/base/task/resource/jobgroup/NewJobgroupServlet";
}

//删除
function _del() 
{
    var sForm = document.frmSub;
    var checkIDs = "";
    var checkedLength = 0;
    for (var i=0;i<sForm.elements.length;i++) 
    {
        if ((sForm.elements[i].type == "checkbox") && (sForm.elements[i].checked == true))
        {
            checkIDs += sForm.elements[i].value + ",";
            checkedLength++;
        }
    }
    if (checkedLength == 0) 
    {
        alert("至少要选中一项进行删除");
        return;
    }
    checkIDs = checkIDs.substr(0, checkIDs.length - 1);
    realdel = window.confirm("确认要删除这些信息吗？");
    if ( realdel == true )
    {
        sForm.action = "<%=contextPath%>/base/task/resource/jobgroup/DeleteJobgroupServlet";
        sForm.submit();
    }
} 
   function _query(){
   var sForm = document.frmSub;
      if(_check(frmSub)){
       sForm.action="<%=contextPath%>/base/task/resource/jobgroup/JobgroupListServlet";
        sForm.submit();
      }else{
        return;
      }
   
   }
</script>
	<body>
		<form name="frmSub" method="post" >
			<table width="100%" border="0" cellspacing="0" cellpadding="1"
				class="text01">
					<td height="25" colspan="4">
						<div id="query">
							工作组名称：&nbsp;
							<input name="GROUP_NAME" type="text" class="queryinput" fieldType="hasSpecialChar" fieldTitle="工作组名称" value="<%=GROUP_NAME==null?"":GROUP_NAME %>" />
							&nbsp;

							<input type="button" name="search" value="查询(Q)" onclick="_query()" class="input01" accesskey="Q"  >
						</div>
					</td>
				</tr>
				
				<tr>
					<td colspan="4">
						<div id="primarydata" style="width:100%; overflow:hidden">
							<table width="100%" border="0" cellpadding="1" cellspacing="1"
								bgcolor="#9CC6F7" class="text01">
								<tr height="22">
									<th width="5%">
										<div align="center">
											&nbsp;
										</div>
									</th>
									<th width="5%">
										<div align="center">
											序号
										</div>
									</th>
									<th width="30%">
										<div align="center">
											工作组名称
										</div>
									</th>
									<th width="60%">
										<div align="center">
											描述
										</div>
									</th>
								</tr>
								<%for (int i=0;i<taskList.size();i++){ 
									JobGroupVo vo = (JobGroupVo)taskList.get(i);
									String group_id= vo.getId();
									
								%>
								<tr height="22">
									<td class="listdata">
										<div align="center">
										    <%
										    	if(inUsing.get(group_id)!=null){
										     %>
											<input disabled="disabled" type="checkbox" name="ID" value="<%=vo.getId() %>"
												class="input">
											<%
												}else{
											 %>
											 <input  type="checkbox" name="ID" value="<%=vo.getId() %>"
												class="input">
											<%
												}
											 %>
										</div>
									</td>
									<td class="listdata">
										<div align="center">
											<%=i+1 %>
										</div>
									</td>
									<td class="listdata">
										<div align="left">
										<a href="<%= contextPath %>/base/task/resource/jobgroup/EditJobgroupServlet?ID=<%=vo.getId()%>"><%=StringUtil.escapeHTMLTags(vo.getGroup_name())%></a>
										</div>
									</td>
									<td class="listdata">
										<div align="left">
											<%=StringUtil.escapeHTMLTags(vo.getDescription())%>
										</div>
									</td>
								</tr>
								<%} %>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<td>
					 <%=HTML %>
					</td>
				</tr>
				<tr class="text01">
					<td align="center">
						<input type="button" name="addButton" value="新建" class="input01"
							onClick="_new();">
						&nbsp;
						<input type="button" name="delButton" value="删除" onClick="_del();"
							class="input01">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
