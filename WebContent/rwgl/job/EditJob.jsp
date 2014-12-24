<%@ page contentType="text/html;charset=GBK"%>
<jsp:directive.page import="base.task.base.conf.SystemConfig" />
<jsp:directive.page import="java.util.ArrayList" />
<jsp:directive.page
	import="base.task.resource.datasource.vo.DataSourceVO" />
<jsp:directive.page
	import="base.task.resource.jobgroup.vo.JobGroupVo" />
<jsp:directive.page import="base.task.resource.job.vo.JobVo" />
<jsp:directive.page import="base.resource.util.StringUtil"/>
<%
	String contextPath = request.getContextPath();
	ArrayList subdatas = (ArrayList) request.getAttribute("subdatas");
	JobVo job = (JobVo) request.getAttribute("job");
	ArrayList tokens = (ArrayList) request.getAttribute("tokens");
	ArrayList resources = (ArrayList) request.getAttribute("resources");
	ArrayList groups = (ArrayList) request.getAttribute("groups");
	String CATALOG = (String) request.getAttribute("CATALOG");
	String taskStatus = (String) request.getAttribute("taskStatus");
     
	String message = (String) request.getAttribute("message");
	if (message == null)
		message = "";

	if (groups == null)
		groups = new ArrayList();
	if (resources == null)
		resources = new ArrayList();
	if (tokens == null)
		tokens = new ArrayList();
	if (subdatas == null)
		subdatas = new ArrayList();

	String isDisabled = "";
	String disabledString = "";
	String readonlyString = "";

	if (taskStatus.equals("PRODUCE")) {
		isDisabled = " disabled='true' ";
		readonlyString = " readonly ";
		disabledString = "<tr height='10'><td colspan='2'><font color='red'>某个包含本工作的任务处于生产状态，不许修改本工作的内容</font></td></tr>";
	}
	String jobType = "";
	if (CATALOG.equals("0")) {
		jobType = "任务管理";
	} else if (CATALOG.equals("1")) {
		jobType = "任务管理";
	}
	String navigation = jobType + " -&gt;  工作注册";

	if (!SystemConfig.getString("resource.job.Job").trim().equals("")) {
		if (CATALOG.equals("0")) {
			jobType = new String("代码发布触发工作注册".getBytes("GBK"),
			"iso8859-1");
		} else if (CATALOG.equals("1")) {
			jobType = new String("代码ETL服务工作注册".getBytes("GBK"),
			"iso8859-1");
		}
		navigation = new String(SystemConfig.getString(
		"resource.job.Job", new String[] { jobType }).getBytes(
		"iso8859-1"), "GBK");
	}
%>
<html>
	<head>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet"
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
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/customString.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/formVerify2.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/verify.js"></script>
<script LANGUAGE="javascript" SRC="<%=contextPath%>/rwgl/js/jcommon.js"></script>
<SCRIPT LANGUAGE="JavaScript">

var RowCount = 3

//检查表单
function _checkFrm()
{
   if("<%=taskStatus%>"=="PRODUCE"){
       window.location.href="<%=contextPath%>/base/task/etl/EditETLServlet?Job_ID=" + "<%=job.getId()%>" + "&CATALOG=" + "<%=CATALOG%>" + "&taskStatus=" + "<%=taskStatus%>"; 
       return;   
   }
   var sForm = document.frmSub;
   var JOB_NAME = sForm.JOB_NAME.value;

   //var TKN_MAX_USETIME  = sForm.TKN_MAX_USETIME.value;
   //var TKN_MAX_WAITTIME = sForm.TKN_MAX_WAITTIME.value;
   var FORCAST_TIME     = sForm.FORCAST_TIME.value;

   //if(TKN_MAX_USETIME!=""){
   //    if(!is_positiveInt(TKN_MAX_USETIME)){
   //             alert("请输入正整数");
   //             sForm.TKN_MAX_USETIME.focus();
   //             return;
   //    }
  // }

   //if(TKN_MAX_WAITTIME!=""){
   //    if(!is_positiveInt(TKN_MAX_WAITTIME)){
    //            alert("请输入正整数");
    //            sForm.TKN_MAX_WAITTIME.focus();
    //            return;
   //    }
   //}

   if(FORCAST_TIME!=""){
       if(!is_positiveInt(FORCAST_TIME)){
                alert("预测运行时间（秒），请输入正整数");
                sForm.FORCAST_TIME.focus();
                return;
       }
   }

   var sourceres = "";
   var destres   = "";
   var tokenlist = "";

   //for(var i = 1; i < sForm.TKN_ID.length; i++)
   //{
    //    if(sForm.TKN_ID.options[i].selected){
     //       if(tokenlist == "")
     //           tokenlist = sForm.TKN_ID.options[i].value;
      //      else
      //          tokenlist = tokenlist + "," + sForm.TKN_ID.options[i].value;
     //   }
  // }

   sForm.TKN_LIST.value = tokenlist;

   if(!checkJobDetail()) 
        return;
        
   //if(!_check(frmSub))
   //{
     //alert("工作名称不能为空！");
     //sForm.JOB_NAME.focus();
    // return;
   //}else{
     sForm.action="<%=contextPath%>/base/task/resource/job/SaveJobServlet";
      sForm.submit();
   //}
}

function checkJobDetail(){
    var sForm = document.frmSub;
    var typeobj = sForm.JOB_TYPE;
    var jobtype = typeobj.options[typeobj.selectedIndex].value;
    var invName = eval("sForm.INVOKE_NAME"+jobtype);
    var invMethod = eval("sForm.INVOKE_METHOD"+jobtype);
    var invTable = eval("sForm.DEST_TABLE"+jobtype);
    var sqlStmt = eval("sForm.SQL_STMT"+jobtype);
    
    if(jobtype == "01" || jobtype == "02" || jobtype == "03" || jobtype == "04" || jobtype == "06" ){
        
        if(invName.value==""){
                if(jobtype == "01") alert("存储过程名称不能为空！");
                if(jobtype == "02") alert("类名称不能为空！");
                if(jobtype == "03") alert("类名称不能为空！");
                if(jobtype == "04") alert("执行程序名称不能为空！");
                if(jobtype == "06") alert("URL路径不能为空！");
            invName.focus();
            return  false;
        }
    }

    if((jobtype == "01" || jobtype == "05" ) &&(sForm.PROCESS_RESID.selectedIndex < 1)){
            alert("请选择执行位置！");
            sForm.PROCESS_RESID.focus();
            return  false;
    }

    if((jobtype == "02") &&(invMethod.value=="")){
            alert("调用方法不能为空！");
            invMethod.focus();
            return  false;
    }

    if((jobtype == "07"||jobtype == "08") &&(sForm.SOURCE_RESID.value=="")){
            alert("请指定源数据源！");
            sForm.SOURCE_RESID.focus();
            return  false;
    }

    if((jobtype == "07"||jobtype == "08") &&(sForm.DEST_RESID.value=="")){
            alert("请指定目标数据源表！");
            sForm.DEST_RESID.focus();
            return  false;
    }

    if((jobtype == "07") &&(invTable.value=="")){
            alert("目标表不能为空！");
            invTable.focus();
            return  false;
    }
     if((jobtype == "06")){
   	 var urlreg=/[a-zA-z]+:\/\/[^\s]*/;
   	 var urlvalue=sForm.INVOKE_NAME06.value;
   	 if(!urlreg.test(urlvalue)){
   	        alert("URL路径不符合规范！");
			sForm.INVOKE_NAME06.focus();
			return	false;
   	 }
			
	}

    if(((jobtype == "05" || jobtype == "07"))&&(sqlStmt.value=="") ){
                alert("SQL语句不能为空！");
                sqlStmt.focus();
                return  false;
    }
    var sqlreg=/^(insert into)|(update)/i;
    if(jobtype == "05"&&!sqlreg.test(sqlStmt.value)){
           alert("SQL语句只能以insert或update开始！");
				sqlStmt.focus();
				return	false;
    }
    if(jobtype == "05"&&sqlStmt.value.length>=1000){
    alert("SQL语句最大长度为1000！");
				sForm.SQL_STMT.focus();
				return	false;
    }
    return true;
}

function clearTableCell()
{
    var _detail = document.all.detail;
  var _rows = _detail.rows;
    for (var i = _rows.length - 1; i > 0; i--)
    {
         _detail.deleteRow(i);
    }
}

function initResponseType(){
    var sForm = document.frmSub;
    var typeobj = sForm.JOB_TYPE;
    var jobtype = typeobj.options[typeobj.selectedIndex].value;
    if(jobtype=="04"){
        sForm.RESPONE_TYPE.length=0;
        sForm.RESPONE_TYPE.options[0] = new Option("没有","0")
        sForm.RESPONE_TYPE.options[1] = new Option("文件","2")
        sForm.RESPONE_TYPE.selectedIndex = 1;

    }else{
        sForm.RESPONE_TYPE.length=0;
        sForm.RESPONE_TYPE.options[0] = new Option("没有","0")
        sForm.RESPONE_TYPE.options[1] = new Option("字符串","1")
        sForm.RESPONE_TYPE.selectedIndex = 1;
    }
}

function changeJobType()
{
    var firstRow,secondRow,thirdRow;
    var typeobj = document.frmSub.JOB_TYPE;
    var name    = document.frmSub.INVOKE_NAME;
    var param   = document.frmSub.INVOKE_PARAM;
    var method  = document.frmSub.INVOKE_METHOD;
    var dest    = document.frmSub.DEST_TABLE;
    var sql     = document.frmSub.SQL_STMT;
    var resposeType = document.frmSub.RESPONE_TYPE;
    var checkType  = document.frmSub.CHECK_TYPE;
    var target = document.frmSub.PROCESS_RESID;

    var jobtype = typeobj.options[typeobj.selectedIndex].value;


    if(jobtype == "01"){
        document.getElementById("resType").style.display = "";
        document.getElementById("chkType").style.display = "none";
        document.getElementById("proRs").style.display = "";
        document.getElementById("detail").style.display = "";
        
        document.getElementById("011").style.display = "";
        document.getElementById("012").style.display = "";
        
        document.getElementById("021").style.display = "none";
        document.getElementById("022").style.display = "none";
        document.getElementById("023").style.display = "none";
        
        document.getElementById("031").style.display = "none";
        document.getElementById("032").style.display = "none";
        
        document.getElementById("041").style.display = "none";
        
        document.getElementById("051").style.display = "none";
        document.getElementById("052").style.display = "none";
        
        document.getElementById("061").style.display = "none";
        
        document.getElementById("071").style.display = "none";
        document.getElementById("072").style.display = "none";
        document.getElementById("073").style.display = "none";
        
    }else if(jobtype =="02"){
        document.getElementById("resType").style.display = "";
        document.getElementById("chkType").style.display = "";
        document.getElementById("proRs").style.display = "none";
        document.getElementById("detail").style.display = "";
        
        document.getElementById("011").style.display = "none";
        document.getElementById("012").style.display = "none";
        
        document.getElementById("021").style.display = "";
        document.getElementById("022").style.display = "";
        document.getElementById("023").style.display = "";
        
        document.getElementById("031").style.display = "none";
        document.getElementById("032").style.display = "none";
        
        document.getElementById("041").style.display = "none";
        
        document.getElementById("051").style.display = "none";
        document.getElementById("052").style.display = "none";
        
        document.getElementById("061").style.display = "none";
        
        document.getElementById("071").style.display = "none";
        document.getElementById("072").style.display = "none";
        document.getElementById("073").style.display = "none";
    }else if(jobtype =="03"){
        document.getElementById("resType").style.display = "";
        document.getElementById("chkType").style.display = "";
        document.getElementById("proRs").style.display = "none";
        document.getElementById("detail").style.display = "";
        
        document.getElementById("011").style.display = "none";
        document.getElementById("012").style.display = "none";
        
        document.getElementById("021").style.display = "none";
        document.getElementById("022").style.display = "none";
        document.getElementById("023").style.display = "none";
        
        document.getElementById("031").style.display = "";
        document.getElementById("032").style.display = "";
        
        document.getElementById("041").style.display = "none";
        
        document.getElementById("051").style.display = "none";
        document.getElementById("052").style.display = "none";
        
        document.getElementById("061").style.display = "none";
        
        document.getElementById("071").style.display = "none";
        document.getElementById("072").style.display = "none";
        document.getElementById("073").style.display = "none";
    }else if(jobtype =="04"){
        document.getElementById("resType").style.display = "";
        document.getElementById("chkType").style.display = "none";
        document.getElementById("proRs").style.display = "none";
        document.getElementById("detail").style.display = "";
        
        document.getElementById("011").style.display = "none";
        document.getElementById("012").style.display = "none";
        
        document.getElementById("021").style.display = "none";
        document.getElementById("022").style.display = "none";
        document.getElementById("023").style.display = "none";
        
        document.getElementById("031").style.display = "none";
        document.getElementById("032").style.display = "none";
        
        document.getElementById("041").style.display = "";
        
        document.getElementById("051").style.display = "none";
        document.getElementById("052").style.display = "none";
        
        document.getElementById("061").style.display = "none";
        
        document.getElementById("071").style.display = "none";
        document.getElementById("072").style.display = "none";
        document.getElementById("073").style.display = "none";
    }else if(jobtype =="05"){
        document.getElementById("resType").style.display = "none";
        document.getElementById("chkType").style.display = "none";
        document.getElementById("proRs").style.display = "";
        document.getElementById("detail").style.display = "";
    
        document.getElementById("011").style.display = "none";
        document.getElementById("012").style.display = "none";
        
        document.getElementById("021").style.display = "none";
        document.getElementById("022").style.display = "none";
        document.getElementById("023").style.display = "none";
        
        document.getElementById("031").style.display = "none";
        document.getElementById("032").style.display = "none";
        
        document.getElementById("041").style.display = "none";
        
        document.getElementById("051").style.display = "";
        document.getElementById("052").style.display = "";
        
        document.getElementById("061").style.display = "none";
        
        document.getElementById("071").style.display = "none";
        document.getElementById("072").style.display = "none";
        document.getElementById("073").style.display = "none";
    }else if(jobtype =="06"){
        document.getElementById("resType").style.display = "none";
        document.getElementById("chkType").style.display = "none";
        document.getElementById("proRs").style.display = "none";
        document.getElementById("detail").style.display = "";
        
        document.getElementById("011").style.display = "none";
        document.getElementById("012").style.display = "none";
        
        document.getElementById("021").style.display = "none";
        document.getElementById("022").style.display = "none";
        document.getElementById("023").style.display = "none";
        
        document.getElementById("031").style.display = "none";
        document.getElementById("032").style.display = "none";
        
        document.getElementById("041").style.display = "none";
        
        document.getElementById("051").style.display = "none";
        document.getElementById("052").style.display = "none";
        
        document.getElementById("061").style.display = "";
        
        document.getElementById("071").style.display = "none";
        document.getElementById("072").style.display = "none";
        document.getElementById("073").style.display = "none";
    }else if(jobtype =="07"){
        document.getElementById("resType").style.display = "none";
        document.getElementById("chkType").style.display = "none";
        document.getElementById("proRs").style.display = "none";
        document.getElementById("detail").style.display = "";
        
        document.getElementById("011").style.display = "none";
        document.getElementById("012").style.display = "none";
        
        document.getElementById("021").style.display = "none";
        document.getElementById("022").style.display = "none";
        document.getElementById("023").style.display = "none";
        
        document.getElementById("031").style.display = "none";
        document.getElementById("032").style.display = "none";
        
        document.getElementById("041").style.display = "none";
        
        document.getElementById("051").style.display = "none";
        document.getElementById("052").style.display = "none";
        
        document.getElementById("061").style.display = "none";
        
        document.getElementById("071").style.display = "";
        document.getElementById("072").style.display = "";
        document.getElementById("073").style.display = "";
        
        document.frmSub.button.value = "修 改";
    }else if(jobtype =="08"){
        document.getElementById("resType").style.display = "none";
        document.getElementById("chkType").style.display = "none";
        document.getElementById("proRs").style.display = "none";
        document.getElementById("detail").style.display = "none";
        document.frmSub.button.value = "下一步";
        if("<%=taskStatus%>"=="PRODUCE"){
            document.frmSub.button.disabled=false;
            
        }
    }
    //_changeSelect();
    //_changeSelect2();
}

function _return()
{
    window.location.href="<%=contextPath%>/base/task/resource/job/JobListServlet?CATALOG="+<%=CATALOG%>;
}
function _changeSelect(){
    var jt01 = new Array();
    var jt07 = new Array();
    var jt08 = new Array();
    jt01.push(new Option('--------源数据源列表--------', '')); 
    <%
        for(int i=0;i<resources.size();i++){
            DataSourceVO resource = (DataSourceVO)resources.get(i);
    %>
    jt01.push(new Option('<%=resource.getDS_NAME()%>','<%=resource.getID()%>'));
    <%
        }
    %>
    
    jt07.push(new Option('--------源数据源列表--------', ''));
    <%
        for(int i=0;i<resources.size();i++){
            DataSourceVO resource = (DataSourceVO)resources.get(i);
            if(resource.getDS_TYPE().equals("DS_TYPE_JDBC") || resource.getDS_TYPE().equals("DS_TYPE_JNDI")){
    %>
    jt07.push(new Option('<%=resource.getDS_NAME()%>','<%=resource.getID()%>'));
    <%
            }
        }
    %>
    
    jt08.push(new Option('--------源数据源列表--------', '')); 
    <%
        for(int i=0;i<resources.size();i++){
            DataSourceVO resource = (DataSourceVO)resources.get(i);
    %>
    jt08.push(new Option('<%=resource.getDS_NAME()%>','<%=resource.getID()%>'));
    <%
        }
    %>
    jt08.push(new Option('--------主题数据列表--------', '')); 
    <%
        for(int i=0;i<subdatas.size();i++){
            //SubdataVO subdata = (SubdataVO)subdatas.get(i);
    %>
    jt08.push(new Option('subdata.getSubdataName()','topic'+'subdata.getId()'));
    <%
        }
    %>
    var jobtype = document.frmSub.JOB_TYPE.options[document.frmSub.JOB_TYPE.selectedIndex].value;
    var sources =new Array();
    if(jobtype == "08"){
        sources = jt08;
    }else if(jobtype == "07"){
        sources = jt07;
    }else{
        sources = jt01;
    }
    
    document.frmSub.SOURCE_RESID.length = 0;
    for(var i=0;i<sources.length; i++){    
        document.frmSub.SOURCE_RESID.options[i] = sources[i];
    }
    var source      =   sForm.SOURCE_RESID;
    for(var i = 0; i < source.length; i++)
    {
       if(source.options[i].value == "<%=job.getSource_resid()%>")
       {
          source.options[i].selected = true;
          break;
       }
    }
}

function _changeSelect2(){
    var jt01 = new Array();
    var jt07 = new Array();
    jt01.push(new Option('--------目标数据源列表--------', ''));
    <%
        for(int i=0;i<resources.size();i++){
            DataSourceVO resource = (DataSourceVO)resources.get(i);
    %>
    jt01.push(new Option('<%=resource.getDS_NAME()%>','<%=resource.getID()%>'));
    <%
        }
    %>
    
    jt07.push(new Option('--------目标数据源列表--------', ''));
    <%
        for(int i=0;i<resources.size();i++){
            DataSourceVO resource = (DataSourceVO)resources.get(i);
            if(resource.getDS_TYPE().equals("DS_TYPE_JDBC") || resource.getDS_TYPE().equals("DS_TYPE_JNDI")){
    %>
    jt07.push(new Option('<%=resource.getDS_NAME()%>','<%=resource.getID()%>'));
    <%
            }
        }
    %>

    
    var jobtype = document.frmSub.JOB_TYPE.options[document.frmSub.JOB_TYPE.selectedIndex].value;
    var sources =new Array();
    if(jobtype == "07"){
        sources = jt07;
    }else{
        sources = jt01;
    }

    document.frmSub.DEST_RESID.length = 0;
    for(var i=0;i<sources.length; i++){
        document.frmSub.DEST_RESID.options[i] = sources[i];
    }
    
    var dest      =   sForm.DEST_RESID;
    for(var i = 0; i < dest.length; i++)
    {
       if(dest.options[i].value == "<%=job.getDest_resid()%>")
       {
          dest.options[i].selected = true;
          break;
       }
    }

}

</SCRIPT>
	</head>

	<body>
		<form name="frmSub" method="post">
			

			<font class="text01" color="red"><%=message%>
			</font>
			<table border="0" cellpadding="1" cellspacing="1" align="center" bgcolor="#9CC6F7" width="60%" class="text01">
				<%=disabledString%>
				<tr class="listdata">
					<td align="right" nowrap="true">
						工作名称：
					</td>
					<td align="left">
						<input type="text" name="JOB_NAME" <%=isDisabled%>
							class="inputtxt" size="30" maxlength="40"
							value="<%=job.getJob_name()%>" required=true fieldTitle="工作名称" fieldType ="hasSpecialChar">
						<font color="#FF0000"> *</font>
					</td>
				</tr>
				<tr class="listdata">
					<td align="right" nowrap="true">
						工作组名称：
					</td>
					<td align="left">
						<select name="GROUP_ID" <%=isDisabled%> required=true fieldTitle="工作组名称">
							<%
								JobGroupVo group = null;
								for (int i = 0; i < groups.size(); i++) {
									group = (JobGroupVo) groups.get(i);
							%>
							<option value="<%=group.getId()%>">
								<%=StringUtil.escapeHTMLTags(group.getGroup_name())%>
							</option>

							<%
							}
							%>
						</select>
					</td>
				</tr>
				<tr class="listdata">
					<td align="right" nowrap="true">
						工作类型：
					</td>
					<td align="left">
						<select name="JOB_TYPE" ONCHANGE="changeJobType()"
							<%=isDisabled %>>
							<%
							if (CATALOG.equals("0")) {
							%>
							<option value="01" >
								存储过程
							</option>
							<option value="02" >
								普通JAVA程序
							</option>
							<!--  
							<option value="03">
								通用扩展接口
							</option>
							
							<option value="04">
								执行程序
							</option>
							-->
							<option value="05" >
								SQL
							</option>
							<option value="06" >
								URL
							</option>
							<%
							} else {
							%>
							<option value="07">
								简单抽取
							</option>
							<option value="08">
								ETL
							</option>
							<%
							}
							%>
						</select>
					</td>
					<input type="hidden" name="type" value="<%=job.getJob_type()%>">
					<input type="hidden" name="ID" value="<%=job.getId()%>">
				</tr>
				<tr id="resType" class="listdata">
					<td align="right" nowrap="true">
						反馈方式：
					</td>
					<td align="left">
						<select name="RESPONE_TYPE" <%=isDisabled%>>
							<option value="0">
								没有
							</option>
							<option value="1">
								字符串
							</option>
							<option value="2">
								文本
							</option>
						</select>
					</td>
				</tr>
				<tr id="chkType" class="listdata">
					<td align="right" nowrap="true">
						是否检测成功：
					</td>
					<td align="left">
						<select name="CHECK_TYPE" <%=isDisabled%>>
							<option value="0" selected>
								是
							</option>
							<option value="1">
								否
							</option>
						</select>
					</td>
				</tr>
				<!-- 
				<tr class="listdata">
					<td align="right" nowrap="true">
						源数据源：
					</td>
					<td align="left">
						<select name="SOURCE_RESID" >


						</select>
					</td>
				</tr>
				<tr class="listdata">
					<td align="right" nowrap="true">
						目标数据源：
					</td>
					<td align="left">
						<select name="DEST_RESID">


						</select>
					</td>
				</tr>
				 -->
				<tr id="proRs" class="listdata">
					<td align="right" nowrap="true">
						工作执行位置：
					</td>
					<td align="left">
						<select name="PROCESS_RESID" <%=isDisabled%>>
							<option value=""></option>
							<%
									for (int i = 0; i < resources.size(); i++) {
									DataSourceVO datasource = (DataSourceVO) resources.get(i);
							%>
							<option value="<%=datasource.getID()%>">
								<%=StringUtil.escapeHTMLTags(datasource.getDS_NAME())%>
							</option>

							<%
							}
							%>
						</select>
					</td>
				</tr>
				
				<tr valign="top" class="listdata">
					<td align="right" nowrap="true">
						预测运行时间（秒）：
					</td>
					<td align="left">
						<input type="text" <%=isDisabled%> name="FORCAST_TIME"
							class="inputtxt" size="30"
							value='<%=job.getForcast_time()%>'>
					</td>
				</tr>

				<tr valign="top" class="listdata">
					<td align="right" nowrap="true">
						优先级：
					</td>
					<td align="left">
						<select name="JOB_PRIORITY" <%=isDisabled%>>
							<option value="0" selected>
								0
							</option>
							<option value="1">
								1
							</option>
							<option value="2">
								2
							</option>
							<option value="3">
								3
							</option>
							<option value="4">
								4
							</option>
							<option value="5">
								5
							</option>
							<option value="6">
								6
							</option>
							<option value="7">
								7
							</option>
							<option value="8">
								8
							</option>
							<option value="9">
								9
							</option>
							<option value="10">
								10
							</option>
						</select>
					</td>
				</tr>
				<tr valign="top" class="listdata">
					<td align="right" nowrap="true">
						工作说明：
					</td>
					<%
						String DESCRIPTION= job.getDescription() == null ? "" : job.getDescription();
					 %>
					<td align=left>
						<input type="text" <%=isDisabled%> name="DESCRIPTION" class="inputtxt" size="30" maxlength="100" value='<%=StringUtil.escapeHTMLTags(DESCRIPTION)%>'>
					</td>
				</tr>
				<input type="hidden" name="STATUS" value="<%=SystemConfig.STATUS_PRODUCE%>">

				<tr class="listdata">
					<td colspan="2">
						<table id="detail" width="100%" class="text01">
							<TBODY>
								<TR align=center bgColor="#E0E0E0" height=20>
									<TD height="24" colspan="2" class="css-01">
										<div align="center">
											工作详细信息
										</div>
									</TD>
								</TR>

								<tr valign="top" id="011">
									<td align="right" width="42%">
										存储过程名称：
									</td>
									<td width="58%" align="left">
										<input type="text" <%=isDisabled%> name="INVOKE_NAME01"
											value="<%=StringUtil.escapeHTMLTags(job.getInvoke_name())%>" class="inputtxt" size="30"
											maxlength="120">
										<font color="#FF0000"> *</font>
									</td>
								</tr>
								<tr valign="top" id="012">
									<td align="right" width="42%">
										调用参数：
									</td>
									<%
										String Invoke_param=job.getInvoke_param() == null ? "" : job.getInvoke_param();
									 %>
									<td width="58%" align="left">
										<input type="text" <%=isDisabled%> name="INVOKE_PARAM01" value="<%=StringUtil.escapeHTMLTags(Invoke_param)%>"
											class="inputtxt" size="30" maxlength="120">
										<font color="#FF0000">(输出参数用"?"代替)</font>
									</td>
								</tr>

								<tr valign="top" id="021">
									<td align="right" width="42%">
										类名称：
									</td>
									<td width="58%" align="left">
										<input type="text" <%=isDisabled%> name="INVOKE_NAME02"
											value="<%=StringUtil.escapeHTMLTags(job.getInvoke_name())%>" class="inputtxt" size="30"
											maxlength="120">
										<font color="#FF0000"> *</font>
									</td>
								</tr>
								<tr valign="top" id="022">
									<td align="right" width="42%">
										调用方法：
									</td>
									<%
										String Invoke_method=job.getInvoke_method() == null ? "" : job.getInvoke_method();
									 %>
									<td width="58%" align="left">
										<input type="text" <%=isDisabled%> name="INVOKE_METHOD02"
											value="<%=StringUtil.escapeHTMLTags(Invoke_method)%>"
											class="inputtxt" size="30" maxlength="120">
										<font color="#FF0000"> *</font>
									</td>
								</tr>
								<tr valign="top" id="023">
									<td align="right" width="42%">
										调用参数：
									</td>
									<%
										String Invoke_params= job.getInvoke_param() == null ? "" : job.getInvoke_param();
									 %>
									<td width="58%" align="left">
										<input type="text" <%=isDisabled%> name="INVOKE_PARAM02"
											value='<%=StringUtil.escapeHTMLTags(Invoke_params)%>'
											class="inputtxt" size="30" maxlength="120">
										<font color="#FF0000"></font>
									</td>
								</tr>

								<tr valign="top" id="031">
									<td align="right" width="42%">
										类名称：
									</td>
									<td width="58%" align="left">
										<input type="text" <%=isDisabled%> name="INVOKE_NAME03" 
											value="<%=StringUtil.escapeHTMLTags(job.getInvoke_name())%>" class="inputtxt" size="30"
											maxlength="120">
										<font color="#FF0000"> *</font>
									</td>
								</tr>
								<tr valign="top" id="032">
									<td align="right" width="42%">
										调用参数：
									</td>
									<%
										String Invoke_paramf= job.getInvoke_param() == null ? "" : job.getInvoke_param();
									 %>
									<td width="58%" align="left">
										<input type="text" <%=isDisabled%> name="INVOKE_PARAM03"
											value='<%=StringUtil.escapeHTMLTags(Invoke_paramf)%>'
											class="inputtxt" size="30" maxlength="120">
										<font color="#FF0000"> </font>
									</td>
								</tr>

								<tr valign="top" id="041">
									<td align="right" width="42%">
										执行程序名称：
									</td>
									<td width="58%" align="left">
										<input type="text" <%=isDisabled%> name="INVOKE_NAME04"
											value="<%=StringUtil.escapeHTMLTags(job.getInvoke_name())%>" class="inputtxt" size="30"
											maxlength="120">
										<font color="#FF0000"> *</font>
									</td>
								</tr>

								<tr valign="top" id="051">
									<td align="left" colspan="2">
										&nbsp;&nbsp;要执行的SQL语句(update或insert)：
									</td>
								</tr>
								<tr valign="top" id="052" align="left">
									<td colspan="2">
										<TEXTAREA name="SQL_STMT05" <%=isDisabled%> rows=10 cols=60 type="_moz"><%=job.getSql_stmt() == null ? "" : job.getSql_stmt().trim()%>
										</TEXTAREA>
									</td>
								</tr>

								<tr valign="top" id="061">
									<td align="right" width="42%">
										HTTP URL：
									</td>
									<td align="left">
										<input type="text" name="INVOKE_NAME06" <%=isDisabled%> value="<%=job.getInvoke_name()%>" class="inputtxt" size="30"
											maxlength="120">
										<font color="#FF0000"> *</font>
									</td>
								</tr>

								<tr valign="top" id="071">
									<td align="right" width="42%">
										目标表(大小写区分)：
									</td>
									<td align="left">
										<input type="text" name="DEST_TABLE07" <%=isDisabled%>
											value="<%=job.getDest_table()%>" class="inputtxt" size="30"
											maxlength="120">
										<font color="#FF0000"> *</font>
									</td>
								</tr>
								<tr valign="top" id="072">
									<td align="right" width="42%">
										源库查询的SQL语句(select)：
									</td>
									<td>
									</td>
								</tr>
								<tr valign="top" id="073">
									<td colspan="2" align="left">
										<TEXTAREA name="SQL_STMT07" <%=isDisabled%> rows=10 cols=60 type="_moz"><%=job.getSql_stmt() == null ? "" : job.getSql_stmt().trim()%></TEXTAREA>
									</td>
								</tr>

								
							</TBODY>
						</table>
					</td>
				</tr>

				<tr height="10" class="listdata">
					<td colspan="2">
						&nbsp;
					</td>
				</tr>
				<tr class="listdata">
					<td colspan="2">
						<div align="center">
							<input type="hidden" name="CATALOG" value="<%=CATALOG%>">
							<input type="button" name="button" value="修 改" <%=isDisabled%> class="input01" onClick="_checkFrm()" style="cursor:hand">
							&nbsp;&nbsp;
							<input type="button" name="button2" value="返 回" class="input01" onClick="_return()" style="cursor:hand">
							<input type="hidden" name="TKN_LIST">
						</div>
					</td>
				</tr>
			</table>
		</form>
<script>
    var sForm       =   document.frmSub;
    var priority    =   sForm.JOB_PRIORITY;
    var job_type    =   sForm.JOB_TYPE;
    var responetype =   sForm.RESPONE_TYPE;
    var checktype   =   sForm.CHECK_TYPE;
    var status      =   sForm.STATUS;
    var groupId     =   sForm.GROUP_ID;
    var source      =   sForm.SOURCE_RESID
    var dest        =   sForm.DEST_RESID
    var process     =   sForm.PROCESS_RESID
    
    for(var i = 0; i < groupId.length; i++)
    {
       if(groupId.options[i].value == "<%= job.getGroup_id()%>")
       {
          groupId.options[i].selected = true;
          break;
       }
    }
    //for(var i = 0; i < source.length; i++)
    //{
    //   if(source.options[i].value == "<%= job.getSource_resid() %>")
     //  {
     //     source.options[i].selected = true;
      //    break;
     //  }
    //}
   // for(var i = 0; i < dest.length; i++)
   // {
    //   if(dest.options[i].value == "<%= job.getDest_resid() %>")
     //  {
     //     dest.options[i].selected = true;
     //     break;
      // }
    //}
    for(var i = 0; i < process.length; i++)
    {
       if(process.options[i].value == "<%= job.getProcess_resid() %>")
       {
          process.options[i].selected = true;
          break;
       }
    }
    for(var i = 0; i < priority.length; i++)
    {
       if(priority.options[i].value == "<%= job.getJob_priority()%>")
       {
          priority.options[i].selected = true;
          break;
      }
    }
   for(var i = 0; i < status.length; i++)
   {
       if(status.options[i].value == "<%= job.getStatus() %>")
       {
          status.options[i].selected = true;
          break;
      }
   }

    for(var i = 0; i < job_type.length; i++)
    {
       if(job_type.options[i].value == "<%= job.getJob_type()%>")
       {
          job_type.options[i].selected = true;
          break;
      }
   }

    for(var i = 0; i < responetype.length; i++)
    {
       if(responetype.options[i].value == "<%= job.getRespone_type()%>")
       {
          responetype.options[i].selected = true;
          break;
      }
   }
    for(var i = 0; i < checktype.length; i++)
    {
       if(checktype.options[i].value == "<%= job.getCheck_type()%>")
       {
          checktype.options[i].selected = true;
          break;
      }
   }
changeJobType();
</script>
	</body>
</html>
