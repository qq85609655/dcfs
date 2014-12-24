<%@ page contentType="text/html;charset=GBK"%>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="java.util.Hashtable"/>
<jsp:directive.page import="base.task.base.conf.SystemConfig"/>
<jsp:directive.page import="java.util.Iterator"/>
<jsp:directive.page import="base.task.resource.job.vo.JobVo"/>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<jsp:directive.page import="base.resource.util.page.Pagination"/>
<%
  	String contextPath= request.getContextPath();
    String JOB_NAME     = (String) request.getAttribute("JOB_NAME");
	String GROUP_ID = (String) request.getAttribute("GROUP_ID");
	String JOB_TYPE = (String) request.getAttribute("JOB_TYPE");
    String CATALOG = (String) request.getAttribute("CATALOG");

    Hashtable resources    = (Hashtable) request.getAttribute("resources");
	Hashtable workgroups   = (Hashtable) request.getAttribute("workgroups");
	Hashtable selectedJobsHT= (Hashtable)request.getAttribute("selectedJobsHT");
	//System.out.println("selectedJobsHT:= "+selectedJobsHT);
	if(resources==null) resources= new Hashtable();
	if(workgroups==null) workgroups= new Hashtable();
	
	List pageDBBean = (List) request.getAttribute("pageDBBean");
	if(pageDBBean==null) pageDBBean= new ArrayList();
	//System.out.println("pageDBBean.size():= "+pageDBBean.size());
	
	ArrayList selectedJobs = (ArrayList) request.getAttribute("selectedJobs");
	if(selectedJobs==null) selectedJobs= new ArrayList();
	
	String jobType = "";
   if(CATALOG.equals("0")){
     jobType = "任务管理";
   }else if(CATALOG.equals("1")){
     jobType = "任务管理";
   }
   String navigation = jobType + " -&gt;  工作注册";
   
	 if(!SystemConfig.getString("resource.job.Job").trim().equals("")){
	   if(CATALOG.equals("0")){
       jobType = new String ("代码发布触发工作注册".getBytes("GBK"), "iso8859-1");
     }else if(CATALOG.equals("1")){
       jobType = new String ("代码ETL服务工作注册".getBytes("GBK"), "iso8859-1");
     }
	   navigation = new String(SystemConfig.getString("resource.job.Job", new String[]{jobType}).getBytes("iso8859-1"),"GBK");
	 }
	 
	Pagination pagination= null;
	String pageNumber= request.getParameter("pageNumber");
	int showItemNumber=10;
	if(pageNumber==null){
		pageNumber="1";
	}
	String HTML="";
	List taskList= new ArrayList();
	if(pageDBBean!=null&&pageDBBean.size()>0){
		pagination= new Pagination();
		pagination.setPageNumber(Integer.parseInt(pageNumber));
		pagination.setShowItemNumber(showItemNumber);
		pagination.setVisitPageURL(contextPath+"/base/task/resource/job/JobListServlet?JOB_NAME="+JOB_NAME+"&GROUP_ID="+GROUP_ID+"&JOB_TYPE="+JOB_TYPE);
		taskList= pagination.interceptListByStartItemNumber(pageDBBean);
		HTML= pagination.buildHTML("100%","left","text01");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/customString.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/formVerify.js"></script>
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
<title></title>
<!-- 内容区域 begin -->
<SCRIPT LANGUAGE="JavaScript">
<!--

//新建
function _new(){
  //window.location.href = "<%= contextPath %>/rwgl/job/NewJob.jsp";
  window.location.href = "<%= contextPath %>/base/task/resource/job/NewJobServlet?CATALOG=<%=CATALOG%>";
}

//删除
function _del(){
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
        sForm.action = "<%= contextPath %>/base/task/resource/job/DeleteJobServlet?CATALOG=<%=CATALOG%>";
        sForm.submit();
    }
}
function queryAppList(){

   if(_check(frmSub)){ 
	 document.frmSub.action = "<%= contextPath %>/base/task/resource/job/JobListServlet?CATALOG=<%=CATALOG%>";
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
				 &nbsp;工作名称：
                 <input type="text" name="JOB_NAME" size="30" class="queryinput" value="<%= JOB_NAME %>"> 
                 &nbsp;工作组：
                 <select name="GROUP_ID">
						  		<option value="">【-全部-】</option>
<%
								Iterator workgroupIterator = workgroups.keySet().iterator();
								while (workgroupIterator.hasNext())
								{
									String  workgroupCode = (String) workgroupIterator.next();
									String  workgroupName = (String) workgroups.get(workgroupCode);
%>
										<option value="<%=workgroupCode%>"><%=workgroupName%></option>
<%
								}
%>
                          </select>
                 &nbsp;
                 工作类型：
                 <select name="JOB_TYPE">
						  		<option value="">【-全部-】</option>
                               
                                <option value="01">存储过程</option>
                                <option value="02">普通JAVA程序</option>
                                <!--  
                                <option value="03">通用扩展接口</option>
                                
                                <option value="04">EXE/BAT</option>
                                -->
                                <option value="05">SQL </option>
                                <option value="06">URL </option>
                              
                          </select>
                 <input type="button" name="querybutton" onclick="queryAppList();" value="查 询" class="input01">
				  </div>		  
		</td>
</tr>	
 
<tr>
      <td colspan="4">
		<div id="primarydata" style="width:100%; overflow:hidden" >
              <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#9CC6F7" class="text01">
                 <tr>
                  <th width="3%" align="center"></th>
                  <th width="5%" align="center">序号</th>
                  <th width="24%" align="center">工作名称</th>
				  <th width="12%" align="center">工作组名称</th>
                  <th width="12%" align="center">工作类型</th>
                  <%
                  if(CATALOG.equals("0")){
                  %>
                  <th width="17%" align="center">工作执行位置</th>
                  <%
                  }else if(CATALOG.equals("1")){%>
                  <%
                  }%>
                  <th width="7%" align="center">优先级</th>
				  <th width="11%" align="center">预测运行时间</th>
                  <th width="9%" align="center">使用情况</th>
                </tr>
                <%
					for(int i=0 ;i<taskList.size(); i++)
					{
					    JobVo vo= (JobVo) taskList.get(i);
					    String id= vo.getId();
					    //System.out.println("id:= "+id);
						String JOB_TYPENAME		= "";
						String GROUPID= vo.getGroup_id();
						String PROCESS_RESID= vo.getProcess_resid();
						if(PROCESS_RESID== null) PROCESS_RESID="";

						String GROUP_NAME= "";
						String PROCESS_RES	= "";
						int typeid=1;
						try{typeid = Integer.parseInt(vo.getJob_type());}catch(Exception e){ }
						switch(typeid){
							case 1: JOB_TYPENAME	= "存储过程";break;
							case 2: JOB_TYPENAME	= "普通JAVA程序";break;
							case 3: JOB_TYPENAME	= "通用扩展接口";break;
							case 4: JOB_TYPENAME	= "执行程序";break;
							case 5: JOB_TYPENAME	= "SQL";break;
							case 6: JOB_TYPENAME	= "URL";break;
							case 7: JOB_TYPENAME	= "简单抽取";break;
                            case 8: JOB_TYPENAME    = "ETL";break;
						}

						if(!("".equals(GROUPID))){
							GROUP_NAME = (String)workgroups.get(GROUPID);
						}

                        if(!("".equals(PROCESS_RESID))){
							PROCESS_RES = (String)resources.get(PROCESS_RESID);
						}
                     %>
                <tr bgcolor="#FFFFFF">
                  <td align="center">
                    <%
					if ( selectedJobsHT.get(id)==null)
					{
                   %>
                    <input name="ID" type="checkbox" value="<%= vo.getId()%>" >
                    <%
					}else
					{
                    %>
                    <input name="ID" type="checkbox" value=""  disabled>
                    <%
					}
                   %>
                  </td>
                  <td align="center"> <%= i+1%> </td>
                  <td> &nbsp;<a href="<%= contextPath %>/base/task/resource/job/EditJobServlet?ID=<%=vo.getId()%>&CATALOG=<%=CATALOG%>"><%= StringUtil.escapeHTMLTags(vo.getJob_name().trim())%></a>
                  </td>
                  <td align="center"><%=StringUtil.escapeHTMLTags(GROUP_NAME)%>&nbsp;</td>
				  <td align="center"><%=StringUtil.escapeHTMLTags(JOB_TYPENAME)%>&nbsp;</td>
                  <%
                  if(CATALOG.equals("0")){
                  %>
                  <td align="center"><%=StringUtil.escapeHTMLTags(PROCESS_RES)%>&nbsp;</td>
                  <%
                  }else if(CATALOG.equals("1")){
                  }
                  %>
                  <td align="center">&nbsp;<%= vo.getJob_priority()%></td>
				  <td align="center">&nbsp;<%= vo.getForcast_time() %></td>
                  <td align="center"><a href="<%= contextPath %>/base/task/resource/job/ShowJobTasksServlet?ID=<%=vo.getId()%>&CATALOG=<%=CATALOG%>">查看明细</a></td>
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
      <INPUT type=button name="button" value="新 建" class="input01" onclick="_new()" >
      &nbsp;&nbsp; 
      <input type=button name="button2" value="删 除" class="input01" onClick="_del()" >
    </td>
  </tr>
      
</table>
</form>
<script language = javascript>

  for(var i = 0; i < document.frmSub.GROUP_ID.length; i++)
  {
    if(document.frmSub.GROUP_ID[i].value == "<%=GROUP_ID%>")
    {
      	document.frmSub.GROUP_ID[i].selected = true;
        break;
    }
  }

   for(var i = 0; i < document.frmSub.JOB_TYPE.length; i++)
  {
    if(document.frmSub.JOB_TYPE[i].value == "<%=JOB_TYPE%>")
    {
      	document.frmSub.JOB_TYPE[i].selected = true;
        break;
    }
  }

</script>
</body>
</html>