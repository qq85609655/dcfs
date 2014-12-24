<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="base.task.base.conf.SystemConfig"%>
<%@ page import="org.apache.commons.logging.Log"%>
<%@ page import="org.apache.commons.logging.LogFactory"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="base.task.resource.task.vo.TaskVo"%>
<%@ page import="base.task.resource.task.vo.TaskJobVo"%>
<jsp:directive.page import="base.resource.util.page.Pagination"/>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<jsp:directive.page import="base.common.util.DateUtils"/>
<%
	//Log log = LogFactory.getLog("TaskList.jsp");
    String contextPath = request.getContextPath();
	String qry_TI_TASK_NAME   = (String) request.getAttribute("TASK_NAME");
	String qry_TI_USE_TYPE   = (String) request.getAttribute("STATUS");
	String qry_TI_RUN_TYPE   = (String) request.getAttribute("RUN_TYPE");
	ArrayList selectedTasks = (ArrayList) request.getAttribute("selectedTasks");
	List taskListall = (List) request.getAttribute("taskList");	
	SimpleDateFormat formater = new java.text.SimpleDateFormat("yyyy-MM-dd");
	
	List jobList = new ArrayList();
	for(int i=0;i<selectedTasks.size();i++){
		TaskJobVo jobvo = (TaskJobVo)selectedTasks.get(i);
		jobList.add(jobvo.getTask_id());
	}
	
	Pagination pagination= null;
	String pageNumber= request.getParameter("pageNumber");
	int showItemNumber=10;
	if(pageNumber==null){
		pageNumber="1";
	}
	
	String HTML="";
	List taskList= new ArrayList();
	if(taskListall!=null&&taskListall.size()>0){
		pagination= new Pagination();
		pagination.setPageNumber(Integer.parseInt(pageNumber));
		pagination.setShowItemNumber(showItemNumber);
		pagination.setVisitPageURL(contextPath+"/base/task/resource/task/TaskListServlet?TASK_NAME="+qry_TI_TASK_NAME+"&STATUS="+qry_TI_USE_TYPE+"&RUN_TYPE="+qry_TI_RUN_TYPE);
		taskList= pagination.interceptListByStartItemNumber(taskListall);
		HTML= pagination.buildHTML("100%","left","text01");
	}
	
	
%>
<html>
  <head>
	<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet"
		type="text/css" />
	<title>�������</title>
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
	<!-- �������� begin -->
	<SCRIPT LANGUAGE="JavaScript">
<!--

//�½�
function _new() 
{
  window.location.href = "<%=contextPath%>/base/task/resource/task/NewTaskServlet";
}

//ɾ��
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
        alert("����Ҫѡ��һ�����ɾ��");
        return;
    }
    checkIDs = checkIDs.substr(0, checkIDs.length - 1);
    realdel = window.confirm("ȷ��Ҫɾ����Щ��Ϣ��");
    if ( realdel == true )
    {
        sForm.action = "<%=contextPath%>/base/task/resource/task/DeleteTaskServlet";
        sForm.submit();
    }
}

function _retrieve(){
	document.frmSub.action="<%= contextPath %>/base/task/resource/task/TaskListServlet";
	document.frmSub.submit();
}
//-->
</SCRIPT>
</head>	
<body>
<form name="frmSub" method="post"
	action="<%=contextPath%>/base/task/resource/task/TaskListServlet" >
	<table width="100%" border="0" cellspacing="0" cellpadding="1"
		class="text01">

		 <tr>
		   <td height="25" colspan="4">
			  <div id="query">
				  �������ƣ�&nbsp;
				  <input name="TASK_NAME" type="text" value="<%= qry_TI_TASK_NAME %>" class="queryinput"  />
				  &nbsp;
				  ����״̬��&nbsp;
				  <select name="STATUS">
				    <option value="" <%if("".equals(qry_TI_USE_TYPE)) {%>selected<%} %>>��-ȫ��-��</option>
				    <option value="<%= SystemConfig.STATUS_DEVELOP %>" <%if(SystemConfig.STATUS_DEVELOP.equals(qry_TI_USE_TYPE)) {%>selected<%} %>>����</option>
				    <option value="<%= SystemConfig.STATUS_PRODUCE %>" <%if(SystemConfig.STATUS_PRODUCE.equals(qry_TI_USE_TYPE)) {%>selected<%} %>>����</option>
				  </select>
				   &nbsp;
				   ���з�ʽ��&nbsp;
				   <select name="RUN_TYPE">
				    <option value="" <%if("".equals(qry_TI_RUN_TYPE)) {%>selected<%} %> >��-ȫ��-��</option>
				    <option value="0" <%if("0".equals(qry_TI_RUN_TYPE)) {%>selected<%} %>>����</option>
				    <option value="1" <%if("1".equals(qry_TI_RUN_TYPE)) {%>selected<%} %>>����</option>
				  </select>
				   &nbsp;
				  <input type="submit" name="button1" value="��ѯ(Q)" class="input01" accesskey="Q" onclick="_retrieve();"/ tabindex="100" Onkeydown="">
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
									���
								</div>
							</th>
							<th width="20%">
								<div align="center">
									��������
								</div>
							</th>
							<th width="10%">
								<div align="center">
									����״̬
								</div>
							</th>
							<th width="10%">
								<div align="center">
									���з�ʽ
								</div>
							</th>
							<th width="10%">
								<div align="center">
									���ȼ�
								</div>
							</th>
							<th width="10%">
								<div align="center">
									���ȷ�ʽ
								</div>
							</th>
							<th width="10%">
								<div align="center">
									����ʱ��
								</div>
							</th>
							<th width="10%">
								<div align="center">
									��������
								</div>
							</th>
							<th width="10%">
								<div align="center">
									��������
								</div>
							</th>
						</tr>
						<%
						for(int i=0;i<taskList.size();i++){ 
						    
							TaskVo taskvo = (TaskVo)taskList.get(i);
							String STATUS = taskvo.getStatus()==null?"":taskvo.getStatus().trim();//modify by yinxk
							String RUN_TYPE =taskvo.getRun_type()==null?"":taskvo.getRun_type().trim();//modify by yinxk
							String SCHEDULE_TYPE= taskvo.getSchedule_type()==null?"":taskvo.getSchedule_type().trim();//modify by yinxk
							int usertype=1;
							try{ usertype = Integer.parseInt(STATUS);}catch(Exception e){System.out.println(e);}
							switch(usertype){
								case 0 : STATUS	= "����";break;
								case 1 : STATUS	= "����";break;
							}
							int runtype = 1;
							try{ runtype = Integer.parseInt(RUN_TYPE);}catch(Exception e){System.out.println(e);}
	
							switch(runtype){
								case 0: RUN_TYPE	= "����";break;
								case 1: RUN_TYPE	= "����";break;
							}
							String type = SCHEDULE_TYPE;
							if(type.equals("ss"))		SCHEDULE_TYPE = "����" ;
							else if(type.equals("mi"))	SCHEDULE_TYPE = "����" ;
							else if(type.equals("hh"))	SCHEDULE_TYPE = "��Сʱ" ;
							else if(type.equals("dd"))	SCHEDULE_TYPE = "����" ;
							else if(type.equals("ww"))	SCHEDULE_TYPE = "����" ;
							else if(type.equals("qq"))	SCHEDULE_TYPE = "��Ѯ" ;
							else if(type.equals("mm"))	SCHEDULE_TYPE = "����" ;
	                        else if(type.equals("00"))  SCHEDULE_TYPE = "�̶�ʱ��" ;
	                        else if(type.equals("yy"))  SCHEDULE_TYPE = "����" ;
							else						SCHEDULE_TYPE = "������";
	                        
	                        int taskJobCount = 0;
	                        if(jobList.contains(taskvo.getId()))
	                            taskJobCount  = 1;
	                        String CREATETIME = taskvo.getCreatetime()==null?"":DateUtils.getDate(taskvo.getCreatetime());//modify by yinxk
	                        
	                        if (CREATETIME.length() > 10)
	                        CREATETIME = CREATETIME.substring(0, 10);
	                       
						%>
						<tr height="22">
							<td class="listdata">
								<div align="center">
									 <%
											if (usertype == 0  && taskJobCount == 0)
											{
						
									%>
						                    <input name="ID" type="checkbox" value="<%= taskvo.getId()%>" > 
						                    <%
											}
											else
											{
									%>
						                    <input name="ID" type="checkbox" value=""  disabled> 
						                    <%
											}%>
								</div>
							</td>
							<td class="listdata">
								<div align="center">
									<%=i+1 %>
								</div>
							</td>
							<td class="listdata">
								<div align="left">
									 &nbsp;<a href="<%= contextPath %>/base/task/resource/task/EditTaskServlet?ID=<%= taskvo.getId()%>&taskJobCount=<%=taskJobCount%>"><%= StringUtil.escapeHTMLTags(taskvo.getTask_name())%></a>
								</div>
							</td>
							<td class="listdata">
								<div align="center">
									<%=STATUS %>
								</div>
							</td>
							<td class="listdata">
								<div align="center">
									<%=RUN_TYPE %>
								</div>
							</td>
							<td class="listdata">
								<div align="center">
									<%=taskvo.getPriority() %>
								</div>
							</td>
							<td class="listdata">
								<div align="center">
									<%=SCHEDULE_TYPE %>
								</div>
							</td>
							<td class="listdata">
								<div align="center">
									<%=CREATETIME %>
								</div>
							</td>
							<td class="listdata">
								<div align="center">
									 <a href="<%= contextPath %>/base/task/resource/task/MaintainRelationServlet?TASK_ID=<%= taskvo.getId()%>&&way=Show">����</a>
								</div>
							</td>
							<td class="listdata">
								<div align="center">
									<a href="<%= contextPath %>/base/task/resource/task/TrigManageServlet?ID=<%= taskvo.getId()%>&&way=Show">����</a>
								</div>
							</td>
						</tr>
						<%}
						 %>
					</table>
				</div>
			</td>
		</tr>
<tr>
	<td align="left" colspan="4">
	<%=HTML %>
	</td>
</tr>
		<tr class="text01">
			<td align="center">
				<input type="button" name="addButton" value="�½�" class="input01"
					onClick="_new();">
				&nbsp;
				<input type="button" name="delButton" value="ɾ��" class="input01"
					onClick="_del();">
			</td>
		</tr>
	</table>

		</form>
	</body>
</html>
