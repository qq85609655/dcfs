<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="base.task.base.conf.SystemConfig"%>
<%@ page import="base.task.resource.task.vo.TaskVo"%>
<jsp:directive.page import="base.task.resource.task.vo.TaskTrigVo"/>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<%
	String contextPath = request.getContextPath();
	String ID = (String) request.getAttribute("ID");
	String sTRIG_TASK_ID = (String) request
			.getAttribute("TRIG_TASK_ID");
	if (sTRIG_TASK_ID == null) {
		sTRIG_TASK_ID = "";
	}
	String TASK_NAME = (String) request.getAttribute("TASK_NAME");
	ArrayList tasks = (ArrayList) request.getAttribute("tasks");

	ArrayList trigTasks = (ArrayList) request.getAttribute("trigTasks");

	String taskState = (String) request.getAttribute("taskState");
	String isDisabled = "";
	String disabledString = "";
	Hashtable taskListHashTable= (Hashtable)request.getAttribute("taskListHashTable");
	
	String disableStr="";
    if(taskState  != null  && taskState.equals(SystemConfig.STATUS_PRODUCE) ) disableStr="disabled";

%>
<html>
	<head>
		<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet"
			type="text/css" />
		<title>任务管理</title>
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
		<SCRIPT LANGUAGE="JavaScript">
<!--
//if(<%=tasks.size()%>==0){
//   alert("没有可以触发的任务");
//   window.location = "<%=contextPath%>/base/task/resource/task/TaskListServlet";
//}
var relationarray = new Array();
var isAllDisabled = false;
<%
    if(taskState  != null  && taskState.equals(SystemConfig.STATUS_PRODUCE) ){
       isDisabled = " disabled='true'";
       disabledString = "<font color='red'>任务处于生产状态，不许修改本任务的内容</font>";
%>
            isAllDisabled = true;
<%

    }
%>

var tag=0;
//检查表单
function _checkFrm(way)
{
   var sForm = document.frmSub;
   var selectedIndex = sForm.TRIG_TASK_ID.selectedIndex;
   var objCheck= document.getElementsByName("TRIG_ID");
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
	     alert("请选择任务！");
	     sForm.TRIG_TASK_ID.focus();
	     return false;
	   }
   }else if(way=="Add"){
   	   if(selectedIndex <= -1)
	   {
	     alert("请选择任务！");
	     sForm.TRIG_TASK_ID.focus();
	     return false;
	   }
   }else{
   	   if(isSelected==false)
	   {
	     alert("请选择任务！");
	     sForm.TRIG_TASK_ID.focus();
	     return false;
	   }
   }
   return true;

}

function submitJob(way){
    var sForm = document.frmSub;
    if(_checkFrm(way) ){
        document.frmSub.way.value = way;
        sForm.action="<%=contextPath%>/base/task/resource/task/TrigManageServlet";
        sForm.submit();
    }
}

function _addJob(){
    var sForm = document.frmSub;
    sForm.SEQ_NUM.value = parseInt(sForm.MAX_SEQ_NUM.value) + 1;
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
    if(sForm.SEQ_NUM.value=="1"){
     alert("不能上移！");
     return false;
    }
    submitJob("UpJobSeq");
}

function _downJobSeq(){
    var sForm = document.frmSub;
    if(sForm.SEQ_NUM.value==sForm.MAX_SEQ_NUM.value){
     alert("不能下移！");
     return false;
    }
    submitJob("DownJobSeq");
}

function _return()
{
    window.location.href="<%=contextPath%>/base/task/resource/task/TaskListServlet";
}

function Relation(trigid,seqnum,constraint,trigtime)
{
    this.trigid         = trigid;
    this.seqnum         = seqnum;
    this.constraint     = constraint;
    this.trigtime       = trigtime;
}

function editRelation(trigid,seqnum,constraint,trigtime,trigtype,taskname){//尹小凯重构 2008-6-11
    var sForm       =   document.frmSub;
    var trigobj      =   sForm.TRIG_TASK_ID;
    for(var i = 0; i < trigobj.length; i++)
    {
       if(trigobj.options[i].value == trigid)
       {
          trigobj.options[i].selected = true;
          break;
      }
   }
   sForm.SEQ_NUM.value = seqnum;

   if(constraint =="0")
        sForm.CONSTRAINT.options[0].selected = true;
   else
        sForm.CONSTRAINT.options[1].selected = true;

   if(trigtime =="0"){
        sForm.TRIG_TIME.options[0].selected = true;
   }else{
        sForm.TRIG_TIME.options[1].selected = true;
   }
   if(trigtype=="0"){
      sForm.TRIG_TYPE.options[0].selected = true;
   }else{
       sForm.TRIG_TYPE.options[1].selected = true;
   }

   if(isAllDisabled){
      sForm.AddJob.disabled = true;
      sForm.ModifyJob.disabled  = true;
      sForm.DeleteJob.disabled  = true;
      sForm.UpSeq.disabled  = true;
      sForm.DownSeq.disabled    = true;
   }else{
      sForm.AddJob.disabled = true;
      sForm.ModifyJob.disabled  = false;
      sForm.DeleteJob.disabled  = false;
      sForm.UpSeq.disabled  = false;
      sForm.DownSeq.disabled    = false;

   }
   
    for(var i=0;i<trigobj.length;i++){//每次过滤掉”假数据“
   	   if(trigobj.options[i].value=="#"){
	       trigobj.remove(i)
	   }
    }
   
   
   var temp=document.createElement("option");
   temp.text=taskname;
   temp.value="#"
   temp.selected="selected"
   trigobj.add(temp);
    
   trigobj.disabled=true;
   
   
}

function changeJob(){
    var sForm   =   document.frmSub;
    var flag    =   false;
    if( sForm.TRIG_TASK_ID == null || sForm.TRIG_TASK_ID.selectedIndex < 0) return;

    var trigid  =   sForm.TRIG_TASK_ID.options[sForm.TRIG_TASK_ID.selectedIndex].value;
    for(var i=0; i< relationarray.length;i++){
        if(relationarray[i].trigid == trigid){
            sForm.SEQ_NUM.value = relationarray[i].seqnum;

            if(parseInt(document.frmSub.MAX_SEQ_NUM.value)==1)
                sForm.TRIG_ID.checked = true;
            else
                sForm.TRIG_ID[i].checked = true;

            if(relationarray[i].constraint == "0")
                sForm.CONSTRAINT.options[0].selected = true;
            else
                sForm.CONSTRAINT.options[1].selected = true;

            if(relationarray[i].trigtime == "0")
                sForm.TRIG_TIME.options[0].selected = true;
            else
                sForm.TRIG_TIME.options[1].selected = true;


            flag = true;
        }
    }
    if(flag){
        sForm.AddJob.disabled       = true;
        sForm.ModifyJob.disabled    = false;
        sForm.DeleteJob.disabled    = false;
        sForm.UpSeq.disabled        = false;
        sForm.DownSeq.disabled      = false;
    }else{
        sForm.AddJob.disabled       = false;
        sForm.ModifyJob.disabled    = true;
        sForm.DeleteJob.disabled    = true;
        sForm.UpSeq.disabled        = true;
        sForm.DownSeq.disabled      = true;

        if(parseInt(document.frmSub.MAX_SEQ_NUM.value)==1)
            sForm.TRIG_ID.checked = false;
        else if( sForm.TRIG_ID != null){
            for(var i=0; i<sForm.TRIG_ID.length;i++){
                if(sForm.TRIG_ID[i].checked){
                    sForm.TRIG_ID[i].checked= false;
                    break;
                }
            }
        }
    }
        if(isAllDisabled){
           sForm.AddJob.disabled    = true;
           sForm.ModifyJob.disabled = true;
           sForm.DeleteJob.disabled = true;
           sForm.UpSeq.disabled = true;
           sForm.DownSeq.disabled   = true;
        }
}


<%
    for (int i = 0; i < trigTasks.size(); i++)
    {
        TaskTrigVo obj = (TaskTrigVo)trigTasks.get(i);
        String trigid = (String)obj.getTrig_task_id();
        String seqnum = String.valueOf(obj.getSeq_num());
        String constraint = (String)obj.getTrig_constraint();
        String trigtime   = (String)obj.getTrig_time();
%>
        var relationobj = new Relation("<%=trigid%>","<%=seqnum%>","<%=constraint%>","<%=trigtime%>");
        relationarray[relationarray.length] = relationobj;
<%
    }
%>
//-->


</SCRIPT>
	</head>
	<body>
	<form name="frmSub" method="post">
	
		<table width="100%" border="0" cellspacing="0" cellpadding="1"
				class="text01">
				<tr>
					<td height="18" valign="middle">
						<img src="<%=contextPath%>/images/currentpositionbg.jpg" width="8"
							height="18" id="positionimg" />
						<div class="currentposition">
							<strong>&nbsp;当前位置-&gt;任务管理-&gt;任务注册-&gt;任务触发</strong>
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

			<table width="80%" border="0" cellpadding="1" cellspacing="1"
				align="center" class="text01"  bgcolor="#FFFFFF">
				<tr>
					<td>
						<fieldset>
							<table width="100%" border="0" cellpadding="1" cellspacing="1"
								align="center">
								<tr>
									<td width="40%" align="left"  nowrap>
										任务名称：
									</td>
									<td width="60%" align="left">
										<%=StringUtil.escapeHTMLTags(TASK_NAME)%>
									</td>
								</tr>
								<tr>
									<td width="40%" align="left" nowrap>
										触发任务名称：
									</td>
									<td width="60%" align="left">
										<input type=hidden name="ID" value="<%= ID %>">
                                        <input type=hidden name="TASK_NAME" value="<%= TASK_NAME%>">
                                        <input type=hidden name="SEQ_NUM" >
                                        <input type=hidden name="way">

                                        <input type=hidden name="MAX_SEQ_NUM" value="<%= trigTasks.size() %>">
                                         <select name="TRIG_TASK_ID" <%=isDisabled%> onchange='changeJob()'>
                                         <%
                                               for(int i=0; i < tasks.size(); i++){
                                                   TaskVo taskvo = (TaskVo)tasks.get(i);
                                                   String selectedOrNot = "";
                                                   if(taskvo.getId().trim().equals(sTRIG_TASK_ID)) selectedOrNot = " selected ";
                                         %>
                                                   <option value="<%= taskvo.getId() %>"  <%=selectedOrNot%> ><%= StringUtil.escapeHTMLTags(taskvo.getTask_name()) %></option>

                                         <%
                                               }
                                         %>
                                         </select>
									</td>
								</tr>
								<tr>
									<td width="40%" align="left"  nowrap>
										触发方式：
									</td>
									<td width="60%" align="left">
										 <select name="TRIG_TYPE" <%=isDisabled%>>
                                                <option value="0" selected>串行触发&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                                <option value="1" >并行触发&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                         </select>
									</td>
								</tr>
								<tr>
									<td width="40%" align="left" nowrap>
										触发任务执行前提：
									</td>
									<td width="60%" align="left">
										<select name="CONSTRAINT" <%=isDisabled%>>
                                                <option value="0" selected>可以独立调度执行</option>
                                                <option value="1" >主任务结束才能执行</option>
                                        </select>
									</td>
								</tr>
								<tr>
									<td width="40%" align="left"  nowrap>
										触发任务执行时间：
									</td>
									<td width="60%" align="left">
										<select name="TRIG_TIME" <%=isDisabled%>>
                                                <option value="0" selected>立即执行&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                                <option value="1" >按调度执行&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                                        </select>
									</td>
								</tr>
								<tr height="10">
                                            <td colspan="2"><%= disabledString %></td>
                                </tr>
								<tr>
                                   <td colspan="4" width="700">
                                       <table width="100%" border="0" cellpadding="1" cellspacing="1"
											bgcolor="#9CC6F7"  class="text01" id="detail">
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
											<th width="25%">
												<div align="center">
													任务名称
												</div>
											</th>
											<th width="25%">
												<div align="center">
													触发任务执行前提
												</div>
											</th>
											<th width="15%">
												<div align="center">
													执行时间
												</div>
											</th>
											<th width="15%">
												<div align="center">
													触发方式
												</div>
											</th>
                                 		</tr>
                             <%
                                        int recordcount = trigTasks.size();
                                        for(int i=0 ;i<recordcount; i++)
                                        {
                                            TaskTrigVo object = (TaskTrigVo)trigTasks.get(i);
                                            String constraint    = (String)object.getTrig_constraint();
                                            String trigid    = (String)object.getTrig_task_id();
                                            String seqnum   = String.valueOf(object.getSeq_num());
                                            String trigtime = object.getTrig_time();
                                            String trigtype = object.getTrig_type();
                                            String checkedOrNot = "";//暂不使用，radio是否选择
                                            if(trigid != null && trigid.equals(sTRIG_TASK_ID)) checkedOrNot = " checked ";
                                            String showconstraint = "";
                                            if(constraint.equals("0")) showconstraint = "可以独立调度执行";
                                            else                 showconstraint = "主任务结束才能执行";

                                            String showtrigtime = "";
                                            if(trigtime.equals("0")) showtrigtime = "立即执行";
                                            else                 showtrigtime = "按调度执行";

                                            String showtrigtype = "";
                                            if(trigtype.equals("1")) showtrigtype = "并行触发";
                                            else                 showtrigtype = "串行触发";
                                            
                                          
                             %>
                                            <tr>
                                            	<td class="listdata">
													<div align="center">
														<input <%=disableStr %> type="radio" name="TRIG_ID" value="<%=trigid %>"   onClick='editRelation("<%=  trigid %>","<%= seqnum %>","<%=  constraint %>","<%= trigtime %>","<%=trigtype %>","<%= StringUtil.escapeHTMLTags((String)taskListHashTable.get(trigid))%> ") ' >
													</div>
												</td>
												<td class="listdata">
													<div align="center">
														<%=i + 1%>
													</div>
												</td>
												<td class="listdata">
													<div align="center">
														<%= StringUtil.escapeHTMLTags((String)taskListHashTable.get(trigid))%>
													</div>
												</td>
												<td class="listdata">
													<div align="center">
														<%= showconstraint %>
													</div>
												</td>
												<td class="listdata">
													<div align="center">
														<%= showtrigtime %>
													</div>
												</td>
												<td class="listdata">
													<div align="center">
														<%= showtrigtype %>
													</div>
												</td>
                                            </tr>
<%
                                        }
                                        for(int k=10; k> recordcount; k--){
%>
                                             <tr bgcolor="#FFFFFF">
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
	                        				<input type="button" name="AddJob" value="添 加" class="input01" onClick="_addJob()"  <%=isDisabled%>>
	                                        <input type="button" name="ModifyJob" value="修 改" class="input01" onClick="_modifyJob()"  disabled>
	                                        <input type="button" name="DeleteJob" value="删 除" class="input01" onClick="_deleteJob()"  disabled>
	                        				<input type="button" name="UpSeq" value="上 移" class="input01" onClick="_upJobSeq()"  disabled>
	                                        <input type="button" name="DownSeq" value="下 移" class="input01" onClick="_downJobSeq()" disabled>
	                                        <input type="button" name="refresh" value="撤销选择"
												class="input01" onClick="javascript:self.location.href='<%= contextPath%>/base/task/resource/task/TrigManageServlet?ID=<%=ID %>&&way=Show'"">
	                                        <input type="button" name="button2" value="返 回" class="input01" onClick="_return()" >
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
</html>
<!-- 内容区域 end -->
<script>
    if(parseInt(document.frmSub.MAX_SEQ_NUM.value)>0){
        changeJob();
    }
</script>
