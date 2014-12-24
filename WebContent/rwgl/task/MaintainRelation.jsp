<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="base.task.resource.task.vo.TaskJobVo"%>
<%@ page import="base.task.resource.job.vo.JobVo"%>
<%@ page import="base.task.base.conf.SystemConfig"%>
<%@ page import="java.util.Hashtable"%>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<%
	String contextPath = request.getContextPath();
	String TASK_ID = (String) request.getAttribute("TASK_ID");
	String sTJ_JOB_ID = (String) request.getAttribute("TJ_JOB_ID");
	if (sTJ_JOB_ID == null)
		sTJ_JOB_ID = "";
	String TASK_NAME = (String) request.getAttribute("TASK_NAME");
	ArrayList jobs = (ArrayList) request.getAttribute("jobs");
	ArrayList relationResult = (ArrayList) request
			.getAttribute("relationResult");
	if(relationResult==null){
		relationResult = new ArrayList();
	}
	Hashtable jobsHashTable= (Hashtable)request.getAttribute("jobsHashTable");
	if(jobsHashTable== null){
		jobsHashTable= new Hashtable();
	}
	String taskState = (String) request.getAttribute("taskState");
	String isDisabled = "";
	String disabledString = "";
	
	String disableStr="";
    if(taskState  != null  && taskState.equals(SystemConfig.STATUS_PRODUCE) ) disableStr="disabled";
%>

<html>
	<head>
		<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet"
			type="text/css" />
		<script LANGUAGE="javascript" SRC="<%=contextPath%>/rwgl/js/calendar.js"></script>
		<script LANGUAGE="javascript" SRC="<%=contextPath%>/rwgl/js/jcommon.js"></script>
		<title>编辑任务</title>
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
	<SCRIPT LANGUAGE="JavaScript">
<!--
var relationarray = new Array();
var isAllDisabled = false;
var tag=0;
<%
    if(taskState  != null  && taskState.equals(SystemConfig.STATUS_PRODUCE) ){
       isDisabled = " disabled='true'";
       disabledString = "<font color='red'>任务处于生产状态，不许修改本任务的内容</font>";
%>
            isAllDisabled = true;
<%

    }
%>
  
//检查表单
function _checkFrm(way){

   var sForm = document.frmSub;
   var selectedIndex = sForm.TJ_JOB_ID.selectedIndex;
   
   var objCheck= document.getElementsByName("JOB_ID");
   var isSelected= false;
   for(var i=0;i< objCheck.length;i++){
       if(objCheck[i].checked==true){
       		isSelected=true;
       		break;
       }
   }
   if(way=="Delete"){
	   if(isSelected==false)
	   {
	     alert("请选择工作！");
     	 sForm.TJ_JOB_ID.focus();
     	 return false;
	   }
   }else if(way=="Add"){
   	   if(selectedIndex <= -1)
	   {
	    alert("请选择工作！");
        sForm.TJ_JOB_ID.focus();
        return false;
	   }
   }else{
   	   if(isSelected==false)
	   {
	     alert("请选择工作！");
         sForm.TJ_JOB_ID.focus();
         return false;
	   }
   }

   return true;

}

function submitJob(way){
	var sForm = document.frmSub;
	if(_checkFrm(way) ){
		document.frmSub.way.value = way;
		sForm.action="<%=contextPath%>/base/task/resource/task/MaintainRelationServlet";
		sForm.submit();
	}
}

function _addJob(){
	var sForm = document.frmSub;
	sForm.TJ_SEQ_NUM.value = parseInt(sForm.MAX_SEQ_NUM.value) + 1;
	submitJob("Add");
}

function _modifyJob(){
	submitJob("Modify");
}

function _deleteJob(){
	submitJob("Delete");
}

function _upJobSeq(){
	var sForm = document.frmSub;
	if(sForm.TJ_SEQ_NUM.value=="1"){
     alert("不能上移！");
     return false;
	}
	submitJob("UpJobSeq");
}

function _downJobSeq(){
	var sForm = document.frmSub;
	if(sForm.TJ_SEQ_NUM.value==sForm.MAX_SEQ_NUM.value){
     alert("不能下移！");
     return false;
	}
	submitJob("DownJobSeq");
}

function _return()
{
	window.location.href="<%=contextPath%>/base/task/resource/task/TaskListServlet";
}

function Relation(jobid,seqnum,continueflag)
{
	this.jobid			= jobid;
	this.seqnum			= seqnum;
	this.continueflag	= continueflag;
}

function editRelation(jobid,seqnum,continueflag,jobname){//尹小凯重构 2008-6-11
   
	var sForm		=	document.frmSub;
	var jobobj		=	sForm.TJ_JOB_ID;
    for(var i = 0; i < jobobj.length; i++)
    {
       if(jobobj.options[i].value == jobid)
       {
      	  jobobj.options[i].selected = true;
          break;
      }
   }
   
   sForm.TJ_SEQ_NUM.value = seqnum;

   if(continueflag =="0")
		sForm.TJ_CONTINUE_FLAG.options[0].selected = true;
   else
		sForm.TJ_CONTINUE_FLAG.options[1].selected = true;
   if(isAllDisabled){
      sForm.AddJob.disabled	= true;
      sForm.ModifyJob.disabled	= true;
      sForm.DeleteJob.disabled	= true;
      sForm.UpSeq.disabled	= true;
      sForm.DownSeq.disabled	= true;
   }else{
      sForm.AddJob.disabled	= true;
      sForm.ModifyJob.disabled	= false;
      sForm.DeleteJob.disabled	= false;
      sForm.UpSeq.disabled	= false;
      sForm.DownSeq.disabled	= false;

   }
   
    for(var i=0;i<jobobj.length;i++){//每次过滤掉”假数据“
   	   if(jobobj.options[i].value=="#"){
	       jobobj.remove(i)
	   }
    }
   
   
   var temp=document.createElement("option");
   temp.text=jobname;
   temp.value="#"
   temp.selected="selected"
   jobobj.add(temp);
   
   jobobj.disabled=true;
}

function changeJob(){
	var sForm	=	document.frmSub;
	var flag	=   false;
	if( sForm.TJ_JOB_ID == null || sForm.TJ_JOB_ID.selectedIndex < 0) return;

	var jobid   =   sForm.TJ_JOB_ID.options[sForm.TJ_JOB_ID.selectedIndex].value;
	for(var i=0; i< relationarray.length;i++){
		if(relationarray[i].jobid == jobid){
			sForm.TJ_SEQ_NUM.value = relationarray[i].seqnum;

			if(parseInt(document.frmSub.MAX_SEQ_NUM.value)==1)
				sForm.JOB_ID.checked = true;
			else
				sForm.JOB_ID[i].checked = true;

			if(relationarray[i].continueflag == "0")
				sForm.TJ_CONTINUE_FLAG.options[0].selected = true;
			else
				sForm.TJ_CONTINUE_FLAG.options[1].selected = true;
			flag = true;
		}
	}
	if(flag){
		sForm.AddJob.disabled		= true;
		sForm.ModifyJob.disabled	= false;
		sForm.DeleteJob.disabled	= false;
		sForm.UpSeq.disabled		= false;
		sForm.DownSeq.disabled		= false;
	}else{
		sForm.AddJob.disabled		= false;
		sForm.ModifyJob.disabled	= true;
		sForm.DeleteJob.disabled	= true;
		sForm.UpSeq.disabled		= true;
		sForm.DownSeq.disabled		= true;

		if(parseInt(document.frmSub.MAX_SEQ_NUM.value)==1)
			sForm.JOB_ID.checked = false;
		else if( sForm.JOB_ID != null){
			for(var i=0; i<sForm.JOB_ID.length;i++){
				if(sForm.JOB_ID[i].checked){
					sForm.JOB_ID[i].checked= false;
					break;
				}
			}
		}
	}
        if(isAllDisabled){
           sForm.AddJob.disabled	= true;
           sForm.ModifyJob.disabled	= true;
           sForm.DeleteJob.disabled	= true;
           sForm.UpSeq.disabled	= true;
           sForm.DownSeq.disabled	= true;
        }
        
}


<%
	for (int i = 0; i < relationResult.size(); i++)
	{
        TaskJobVo taskJobVo = (TaskJobVo)relationResult.get(i);
		String jobid  = taskJobVo.getJob_id();
		String seqnum = String.valueOf(taskJobVo.getSeq_num());
		String flag   = taskJobVo.getContinue_flag();
%>
		var relationobj = new Relation("<%=jobid%>","<%=seqnum%>","<%=flag%>");
		relationarray[relationarray.length] = relationobj;
<%
	}
%>
//-->


</SCRIPT>
	<body>
		<form method="post" name="frmSub">
			<table width="100%" border="0" cellspacing="0" cellpadding="1"
				class="text01">
				<tr>
					<td height="18" valign="middle">
						<img src="<%=contextPath%>/images/currentpositionbg.jpg" width="8"
							height="18" id="positionimg" />
						<div class="currentposition">
							<strong>&nbsp;当前位置-&gt;任务管理-&gt;任务注册-&gt;包含工作管理</strong>
						</div>
					</td>
					<td class="currentposition" align="right">
						<strong></strong>
					</td>
					<td width="4%" align="right">
						
					</td>
					<td width="9%">
						
					</td>
				</tr>
			</table>
			<br>
			<table width="80%" border="0" cellpadding="1" cellspacing="1"
				align="center" class="text01" bgcolor="#FFFFFF">
				<tr>
					<td>
						<fieldset>
							<table width="100%" border="0" cellpadding="1" cellspacing="1"
								align="center">
								<tr>
									<td  width="40%" align="left" nowrap>
										任务名称：
									</td>
									<td  width="60%" align="left">
										<%=TASK_NAME%>
									</td>
								</tr>
								<tr>
									<td  width="40%" align="left" nowrap>
										工作名称：
									</td>
									<td  width="60%" align="left">
										<input type=hidden name="TASK_ID" value="<%=TASK_ID%>">
										<input type=hidden name="TASK_NAME" value="<%=TASK_NAME%>">
										<input type=hidden name="TJ_SEQ_NUM">
										<input type=hidden name="way">

										<input type=hidden name="MAX_SEQ_NUM"
											value="<%=relationResult.size()%>">
										<select name="TJ_JOB_ID" <%=isDisabled%>
											onchange='changeJob()'>
											<%
											if(jobs==null){
												jobs = new ArrayList();
											}
													for (int i = 0; i < jobs.size(); i++) {
													JobVo job = (JobVo) jobs.get(i);
													String selectedOrNot = "";
													if (job.getId().trim().equals(sTJ_JOB_ID))
														selectedOrNot = " selected ";
											%>
											<option value="<%=job.getId()%>" <%=selectedOrNot%>>
												<%=StringUtil.escapeHTMLTags(job.getJob_name())%>
											</option>

											<%
											}
											%>
										</select>
									</td>
								</tr>
								<tr>
									<td  width="40%" align="left" nowrap>
										失败是否继续:
									</td>
									<td  width="60%" align="left">
										<select name="TJ_CONTINUE_FLAG" <%=isDisabled%>>
											<option value="0" selected>
												失败结束&nbsp;&nbsp;&nbsp;&nbsp;
											</option>
											<option value="1">
												失败继续&nbsp;&nbsp;&nbsp;&nbsp;
											</option>
										</select>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<%=disabledString%>
									</td>
								</tr>
								<tr>
									<td colspan="4" width="700">
										<table width="100%" border="0" cellpadding="1" cellspacing="1"
											bgcolor="#9CC6F7" class="text01" id="detail">
											<tr height="22">
												<th width="5%">
													<div align="center">
														&nbsp;
													</div>
												</th>
												<th width="7%">
													<div align="center">
														序号
													</div>
												</th>
												<th width="68%">
													<div align="center">
														工作名称
													</div>
												</th>
												<th width="15%">
													<div align="center">
														生产状态
													</div>
												</th>
											</tr>
											<%
												int recordcount = relationResult.size();
												for (int i = 0; i < recordcount; i++) {
													TaskJobVo jobVo=(TaskJobVo)relationResult.get(i);
													String flag = jobVo.getContinue_flag();
													String jobid = jobVo.getJob_id();
													String seqnum = String
													.valueOf(jobVo.getSeq_num());
													String checkedOrNot = "";//暂不使用，radio是否选择
													if (jobid != null && jobid.equals(sTJ_JOB_ID))
														checkedOrNot = " checked ";
													String showflag = "";
													if (flag.equals("0"))
														showflag = "失败结束";
													else
														showflag = "失败继续";
													
													String jobName= (String)jobsHashTable.get(jobid);
											%>
											<tr>
												<td class="listdata">
													<div align="center">
														<input <%=disableStr %> value="<%=jobid %>" type="radio" name="JOB_ID" 
															onClick='editRelation("<%=jobid%>","<%=seqnum%>","<%=flag%>","<%=jobName %>") '>
													</div>
												</td>

												<td class="listdata">
													<div align="center">
														<%=i + 1%>
													</div>

												</td>
												<td class="listdata">
													<div align="center">
														<%=StringUtil.escapeHTMLTags(jobName)%>
													</div>

												</td>
												<td class="listdata">
													<div align="center">
														<%=showflag%>
													</div>
												</td>
											</tr>
											<%
												}
												for (int k = 10; k > recordcount; k--) {
											%>
											<tr>
												<td class="listdata">
													<div align="center">
													
													</div>
												</td>

												<td class="listdata">
													<div align="center">
														
													</div>

												</td>
												<td class="listdata">
													<div align="center">
														
													</div>

												</td>
												<td class="listdata">
													<div align="center">
														
													</div>
												</td>
											</tr>

											<%
											}
											%>
										</table>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<div align="center">
											<input type="button" name="AddJob" value="添 加"
												class="input01" onClick="_addJob()">
											<input type="button" name="ModifyJob" value="修改工作前提"
												class="input01" onClick="_modifyJob()" disabled>
											<input type="button" name="DeleteJob" value="删 除"
												class="input01" onClick="_deleteJob()" disabled>
											<input type="button" name="UpSeq" value="上 移" class="input01"
												onClick="_upJobSeq()" disabled>
											<input type="button" name="DownSeq" value="下 移"
												class="input01" onClick="_downJobSeq()" style="cursor:hand"
												disabled>
												<input type="button" name="refresh" value="撤销选择"
												class="input01" onClick="javascript:self.location.href='<%= contextPath%>/base/task/resource/task/MaintainRelationServlet?TASK_ID=<%=TASK_ID %>&way=Show'">
											<input type="button" name="button2" value="返 回"
												class="input01" onClick="_return()">
										</div>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
			</table>
		</form>
	</body>
	<script type="text/javascript">
	if(isAllDisabled){
       document.frmSub.AddJob.disabled=true;//modify by yinxk 2008-3-17
     }
	</script>
</html>
