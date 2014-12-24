<%@ page contentType="text/html;charset=GBK"%>
<jsp:directive.page import="base.task.base.conf.SystemConfig"/>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="base.task.resource.datasource.vo.DataSourceVO"/>
<jsp:directive.page import="base.task.resource.jobgroup.vo.JobGroupVo"/>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<%
    String contextPath= request.getContextPath();
    String message= (String)request.getAttribute("message");
    if(message==null) message="";
	ArrayList subdatas = (ArrayList)request.getAttribute("subdatas");
    ArrayList tokens = (ArrayList)request.getAttribute("tokens");
    ArrayList resources = (ArrayList)request.getAttribute("resources");
    ArrayList groups  = (ArrayList)request.getAttribute("groups");
    if(groups==null) groups=new ArrayList(); 
    if(resources==null) resources=new ArrayList(); 
    if(tokens==null) tokens=new ArrayList(); 
    if(subdatas==null) subdatas=new ArrayList();
     
    String CATALOG = (String)request.getAttribute("CATALOG");

    String jobType = "";
   if(CATALOG.equals("0")){
     jobType = "�������";
   }else if(CATALOG.equals("1")){
     jobType = "�������";
   }
   String navigation = jobType + " -&gt;  ����ע��";
   
	 if(!SystemConfig.getString("resource.job.Job").trim().equals("")){
	   if(CATALOG.equals("0")){
       jobType = new String ("���뷢����������ע��".getBytes("GBK"), "iso8859-1");
     }else if(CATALOG.equals("1")){
       jobType = new String ("����ETL������ע��".getBytes("GBK"), "iso8859-1");
     }
	   navigation = new String(SystemConfig.getString("resource.job.Job", new String[]{jobType}).getBytes("iso8859-1"),"GBK");
	 }
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
         <script type="text/javascript" src="<%=contextPath%>/rwgl/js/customString.js"></script>
        <script type="text/javascript" src="<%=contextPath%>/rwgl/js/formVerify2.js"></script>
        <script type="text/javascript" src="<%=contextPath%>/rwgl/js/verify.js"></script>
        <script type="text/javascript" src="<%=contextPath%>/rwgl/js/jcommon.js"></script>
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

<script LANGUAGE="javascript" SRC="<%=contextPath%>/js/jcommon.js"></script>
<SCRIPT LANGUAGE="JavaScript">

	var RowCount = 3

//����
function _checkFrm()
{
   var sForm = document.frmSub;
   var JOB_NAME = sForm.JOB_NAME.value;
   var jobgroup=sForm.GROUP_ID.value.trim;
  

   //var TKN_MAX_USETIME	= sForm.TKN_MAX_USETIME.value;
   //var TKN_MAX_WAITTIME	= sForm.TKN_MAX_WAITTIME.value;
   var FORCAST_TIME		= sForm.FORCAST_TIME.value;

   //if(TKN_MAX_USETIME!=""){
	//   if(!is_positiveInt(TKN_MAX_USETIME)){
	//			alert("������������");
	//			sForm.TKN_MAX_USETIME.focus();
	//			return;
	//   }
  // }

   //if(TKN_MAX_WAITTIME!=""){
	//   if(!is_positiveInt(TKN_MAX_WAITTIME)){
	//			alert("������������");
	//			sForm.TKN_MAX_WAITTIME.focus();
	//			return;
	//   }
   //}

   //if(FORCAST_TIME!=""){
	//   if(!is_positiveInt(FORCAST_TIME)){
	//			alert("������������");
	//			sForm.FORCAST_TIME.focus();
	//			return;
	//   }
   //}

   var sourceres = "";
   var destres	 = "";
   var tokenlist = "";

   //for(var i = 1; i < sForm.TKN_ID.length; i++)
   //{
   // 	if(sForm.TKN_ID.options[i].selected){
	//		if(tokenlist == "")
    //            tokenlist = sForm.TKN_ID.options[i].value;
	//		else
    //        	tokenlist = tokenlist + "," + sForm.TKN_ID.options[i].value;
	//	}
   //}

   sForm.TKN_LIST.value = tokenlist;

   if(!checkJobDetail())
        return;

   // if(!_check(frmSub))
  // {
     //alert("�������Ʋ���Ϊ�գ�");
   //  sForm.JOB_NAME.focus();
    // return;
  // }else{
      sForm.action="<%= contextPath %>/base/task/resource/job/AddJobServlet";
     sForm.submit();
  // }
    
    
  
}

function checkJobDetail(){
	var sForm = document.frmSub;
	var typeobj = sForm.JOB_TYPE;
	var jobtype = typeobj.options[typeobj.selectedIndex].value;

	if(jobtype == "01" || jobtype == "02" || jobtype == "03" || jobtype == "04" || jobtype == "06" ){

		if(sForm.INVOKE_NAME.value==""){
				if(jobtype == "01") alert("�洢�������Ʋ���Ϊ�գ�");
				if(jobtype == "02") alert("�����Ʋ���Ϊ�գ�");
				if(jobtype == "03") alert("�����Ʋ���Ϊ�գ�");
				if(jobtype == "04") alert("ִ�г������Ʋ���Ϊ�գ�");
				if(jobtype == "06") alert("URL·������Ϊ�գ�");
			sForm.JOB_NAME.focus();
			return	false;
		}
	}

	if((jobtype == "01" || jobtype == "05" ) &&(sForm.PROCESS_RESID.selectedIndex < 1)){
			alert("��ѡ��ִ��λ�ã�");
			sForm.PROCESS_RESID.focus();
			return	false;
	}

	if((jobtype == "02") &&(sForm.INVOKE_METHOD.value=="")){
			alert("���÷�������Ϊ�գ�");
			sForm.INVOKE_METHOD.focus();
			return	false;
	}

	if((jobtype == "07"||jobtype == "08") &&(sForm.SOURCE_RESID.value=="")){
			alert("��ָ��Դ����Դ��");
			sForm.SOURCE_RESID.focus();
			return	false;
	}

	if((jobtype == "07"||jobtype == "08") &&(sForm.DEST_RESID.value=="")){
			alert("��ָ��Ŀ������Դ��");
			sForm.DEST_RESID.focus();
			return	false;
	}

	if((jobtype == "07") &&(sForm.DEST_TABLE.value=="")){
			alert("Ŀ�����Ϊ�գ�");
			sForm.DEST_TABLE.focus();
			return	false;
	}
    if((jobtype == "06")){
   	 var urlreg=/[a-zA-z]+:\/\/[^\s]*/;
   	 var urlvalue=sForm.INVOKE_NAME.value;
   	 if(!urlreg.test(urlvalue)){
   	        alert("URL·�������Ϲ淶��");
			sForm.INVOKE_NAME.focus();
			return	false;
   	 }
			
	}
     
	if(((jobtype == "05" || jobtype == "07"))&&(sForm.SQL_STMT.value=="") ){
				alert("SQL��䲻��Ϊ�գ�");
				sForm.SQL_STMT.focus();
				return	false;
	}
    var sqlreg=/^(insert into)|(update)/i;
    if(jobtype == "05"&&!sqlreg.test(sForm.SQL_STMT.value)){
           alert("SQL���ֻ����insert��update��ʼ��");
				sForm.SQL_STMT.focus();
				return	false;
    }
    if(jobtype == "05"&&sForm.SQL_STMT.value.length>=1000){
    alert("SQL�����󳤶�Ϊ1000��");
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
		sForm.RESPONE_TYPE.options[0] = new Option("û��","0")
		sForm.RESPONE_TYPE.options[1] = new Option("�ļ�","2")
		sForm.RESPONE_TYPE.selectedIndex = 1;

	}else{
		sForm.RESPONE_TYPE.length=0;
		sForm.RESPONE_TYPE.options[0] = new Option("û��","0")
		sForm.RESPONE_TYPE.options[1] = new Option("�ַ���","1")
        sForm.RESPONE_TYPE.selectedIndex = 1;
	}
}

function changeJobType()
{
	var firstRow,secondRow,thirdRow;
	var typeobj = document.frmSub.JOB_TYPE;
	var name	= document.frmSub.INVOKE_NAME;
	var param	= document.frmSub.INVOKE_PARAM;
	var method	= document.frmSub.INVOKE_METHOD;
	var dest	= document.frmSub.DEST_TABLE;
	var sql		= document.frmSub.SQL_STMT;
	var resposeType = document.frmSub.RESPONE_TYPE;
	var checkType  = document.frmSub.CHECK_TYPE;
    var target = document.frmSub.PROCESS_RESID;

	var jobtype = typeobj.options[typeobj.selectedIndex].value;
/*
	firstRow  = document.all.detail.rows[1];
	secondRow = document.all.detail.rows[2];
	thirdRow  = document.all.detail.rows[3];
*/
	initResponseType();

	clearTableCell();
	firstRow = document.all.detail.insertRow();
	firstRow.insertCell();
	firstRow.insertCell();

/*
01-�洢����
02-��ͨJAVA����
03-ͨ����չ�ӿ�
04-EXE/BAT
05-SQL
06-URL
07-�򵥳�ȡ
08-ETL
*/

	if(jobtype=="01" || jobtype=="02" || jobtype=="03" || jobtype=="05"  || jobtype=="07" ){
		secondRow= document.all.detail.insertRow();
		if(jobtype=="05")	secondRow.insertCell();
		else{
			secondRow.insertCell();
			secondRow.insertCell();
		}
	}

	if(jobtype == "01"){
        document.getElementById("resType").style.display = "";
        document.getElementById("chkType").style.display = "none";
        document.getElementById("proRs").style.display = "";
        document.getElementById("detail").style.display = "";

		RowCount = 3;
		firstRow.cells[0].innerText  ="�洢�������ƣ�";
		firstRow.cells[1].innerHTML  ="<input type=\"text\" name=\"INVOKE_NAME\" class=\"inputtxt\" size=\"30\" maxlength=\"120\"><font color=#FF0000> *</font>";
		secondRow.cells[0].innerText ="���ò�����";
		secondRow.cells[1].innerHTML ="<input type=\"text\" name=\"INVOKE_PARAM\" class=\"inputtxt\" size=\"30\" maxlength=\"120\">(���������\"?\"����)";
		firstRow.cells[0].align="right";
		firstRow.cells[0].width="42%";
		secondRow.cells[0].align="right";
		secondRow.cells[0].width="42%";
	}else if(jobtype =="02"){
        document.getElementById("resType").style.display = "";
        document.getElementById("chkType").style.display = "";
        document.getElementById("proRs").style.display = "none";
        document.getElementById("detail").style.display = "";


		thirdRow= document.all.detail.insertRow();
		thirdRow.insertCell();
		thirdRow.insertCell();
		RowCount = 4;

		firstRow.cells[0].innerText  ="�����ƣ�";
		firstRow.cells[1].innerHTML  ="<input type=\"text\" name=\"INVOKE_NAME\" fieldTitle=\"������\" fieldType =\"hasSpecialChar\" class=\"inputtxt\" size=\"30\" maxlength=\"120\"><font color=#FF0000> *</font>";
		secondRow.cells[0].innerText ="���÷�����";
		secondRow.cells[1].innerHTML ="<input type=\"text\" name=\"INVOKE_METHOD\" fieldTitle=\"���÷���\" fieldType =\"hasSpecialChar\" class=\"inputtxt\" size=\"30\" maxlength=\"120\"><font color=#FF0000> *</font>";
		thirdRow.cells[0].innerText  ="���ò�����";
		thirdRow.cells[1].innerHTML  ="<input type=\"text\" name=\"INVOKE_PARAM\" fieldTitle=\"���ò���\"  class=\"inputtxt\" size=\"30\" maxlength=\"120\">";
		firstRow.cells[0].align="right";
		firstRow.cells[0].width="42%";
		secondRow.cells[0].align="right";
		secondRow.cells[0].width="42%";
		thirdRow.cells[0].align="right";
		thirdRow.cells[0].width="42%";
	}else if(jobtype =="03"){
        document.getElementById("resType").style.display = "";
        document.getElementById("chkType").style.display = "";
        document.getElementById("proRs").style.display = "none";
        document.getElementById("detail").style.display = "";


		RowCount = 2;
		firstRow.cells[0].innerText  ="�����ƣ�";
		firstRow.cells[1].innerHTML  ="<input type=\"text\" name=\"INVOKE_NAME\" class=\"inputtxt\" size=\"30\" maxlength=\"120\"><font color=#FF0000> *</font>";
		firstRow.cells[0].align="right";
		firstRow.cells[0].width="42%";
	}else if(jobtype =="04"){
        document.getElementById("resType").style.display = "";
        document.getElementById("chkType").style.display = "none";
        document.getElementById("proRs").style.display = "none";
        document.getElementById("detail").style.display = "";

		RowCount = 2;
		firstRow.cells[0].innerText  ="ִ�г������ƣ�";
		firstRow.cells[1].innerHTML  ="<input type=\"text\" name=\"INVOKE_NAME\" class=\"inputtxt\" size=\"30\" maxlength=\"120\"><font color=#FF0000> *</font>";
		firstRow.cells[0].align="right";
		firstRow.cells[0].width="42%";
	}else if(jobtype =="05"){
        document.getElementById("resType").style.display = "none";
        document.getElementById("chkType").style.display = "none";
        document.getElementById("proRs").style.display = "";
        document.getElementById("detail").style.display = "";

		RowCount = 3;
		firstRow.cells[0].innerText  ="  Ҫִ�е�SQL���(update��insert)��";
		firstRow.cells[1].innerHTML  =" ";
		secondRow.cells[0].colSpan ='2';
		secondRow.cells[0].innerHTML  ="<TEXTAREA name=\"SQL_STMT\"  rows=10 cols=60></TEXTAREA> ";

		firstRow.cells[0].align="left";
		firstRow.cells[0].width="42%";
		secondRow.cells[0].align="right";
		secondRow.cells[0].width="42%";
	}else if(jobtype =="06"){
        document.getElementById("resType").style.display = "none";
        document.getElementById("chkType").style.display = "none";
        document.getElementById("proRs").style.display = "none";
        document.getElementById("detail").style.display = "";

		RowCount = 2;
		firstRow.cells[0].innerText  ="HTTP URL·��:";
		firstRow.cells[1].innerHTML  ="<input type=\"text\" name=\"INVOKE_NAME\" class=\"inputtxt\" size=\"30\" maxlength=\"120\"><font color=#FF0000> *</font>";
		firstRow.cells[0].align="right";
		firstRow.cells[0].width="42%";
	}else if(jobtype =="07"){
        document.getElementById("resType").style.display = "none";
        document.getElementById("chkType").style.display = "none";
        document.getElementById("proRs").style.display = "none";
        document.getElementById("detail").style.display = "";

		thirdRow = document.all.detail.insertRow();
		thirdRow.insertCell();
		RowCount = 4;

		firstRow.cells[0].innerHTML  ="Ŀ���(��Сд����)��";
		firstRow.cells[0].align="right";
		firstRow.cells[0].width="42%";
		firstRow.cells[1].innerHTML  ="<input type=\"text\" name=\"DEST_TABLE\" class=\"inputtxt\" size=\"30\" maxlength=\"100\"><font color=#FF0000> *</font>";
		secondRow.cells[0].innerText ="Դ���ѯ��SQL��䣺";
		secondRow.cells[0].align="right";
		secondRow.cells[0].width="42%";
		secondRow.cells[1].innerHTML =" ";
		thirdRow.cells[0].colSpan ='2';
		thirdRow.cells[0].innerHTML ="<TEXTAREA name=\"SQL_STMT\"  rows=10 cols=60></TEXTAREA> ";
        document.frmSub.button.value = "�� ��";
	}else if(jobtype =="08"){
        document.getElementById("resType").style.display = "none";
        document.getElementById("chkType").style.display = "none";
        document.getElementById("proRs").style.display = "none";
        document.getElementById("detail").style.display = "none";
        document.frmSub.button.value = "��һ��";
    }
    //_changeSelect();
    //_changeSelect2();
}

function _return()
{
	window.location.href="<%= contextPath %>/base/task/resource/job/JobListServlet?CATALOG=<%=CATALOG%>";
}

function _changeSelect(){
    var jt01 = new Array();
    var jt07 = new Array();
    var jt08 = new Array();
    jt01.push(new Option('--------Դ����Դ�б�--------', ''));
    <%
        for(int i=0;i<resources.size();i++){
            DataSourceVO resource = (DataSourceVO)resources.get(i);
    %>
    jt01.push(new Option('<%= resource.getDS_NAME() %>','<%= resource.getID()%>'));
    <%
        }
    %>
    
    jt07.push(new Option('--------Դ����Դ�б�--------', ''));
    <%
        for(int i=0;i<resources.size();i++){
            DataSourceVO resource = (DataSourceVO)resources.get(i);
            if(resource.getDS_TYPE().equals("DS_TYPE_JDBC") || resource.getDS_TYPE().equals("DS_TYPE_JNDI")){
    %>
    jt07.push(new Option('<%= resource.getDS_NAME() %>','<%= resource.getID()%>'));
    <%
            }
        }
    %>

    jt08.push(new Option('--------Դ����Դ�б�--------', ''));
    <%
        for(int i=0;i<resources.size();i++){
            DataSourceVO resource = (DataSourceVO)resources.get(i);
    %>
    jt08.push(new Option('<%= resource.getDS_NAME() %>','<%= resource.getID()%>'));
    <%
        }
    %>
    jt08.push(new Option('--------���������б�--------', ''));
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

}

function _changeSelect2(){
    var jt01 = new Array();
    var jt07 = new Array();
    jt01.push(new Option('--------Ŀ������Դ�б�--------', ''));
    <%
        for(int i=0;i<resources.size();i++){
            DataSourceVO resource = (DataSourceVO)resources.get(i);
    %>
    jt01.push(new Option('<%= resource.getDS_NAME()%>','<%= resource.getID() %>'));
    <%
        }
    %>
    
    jt07.push(new Option('--------Ŀ������Դ�б�--------', ''));
    <%
        for(int i=0;i<resources.size();i++){
            DataSourceVO resource = (DataSourceVO)resources.get(i);
            if(resource.getDS_TYPE().equals("DS_TYPE_JDBC") || resource.getDS_TYPE().equals("DS_TYPE_JNDI")){
    %>
    jt07.push(new Option('<%= resource.getDS_NAME()%>','<%= resource.getID()%>'));
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

}

</SCRIPT>
</head>

<body>
<form name="frmSub" method="post">


<font class="text01" color="red"><%=message %></font>
<table border="0" cellpadding="1" cellspacing="1" align="center" bgcolor="#9CC6F7" width="60%" class="text01">
<tr class="listdata">
  <td  align="right" nowrap="true" >�������ƣ�</td>
  <td  align="left">
    <input type="text" name="JOB_NAME" required=true fieldTitle="��������" fieldType ="hasSpecialChar" class="inputtxt" size="30" maxlength="40">
    <font color="#FF0000"> *</font>
  </td>
</tr>
                                          
<tr class="listdata">
  <td  align="right" nowrap="true">���������ƣ�</td>
  <td align="left">
    <select name="GROUP_ID" required=true fieldTitle="����������">
      <%
        JobGroupVo group = null;
        for(int i=0;i<groups.size();i++){
           group = (JobGroupVo)groups.get(i);
      %>
      <option value="<%=group.getId()%>" ><%=StringUtil.escapeHTMLTags(group.getGroup_name())%></option>
	  <%
	   }
	  %>
   </select>
  </td>
</tr>
                                          
<tr class="listdata">
  <td  align="right" nowrap="true">�������ͣ�</td>
  <td align="left">
    <select name="JOB_TYPE" ONCHANGE="changeJobType()">
   
      <option value="01" selected>�洢����</option>
      <option value="02">��ͨJAVA����</option>
      <!--  
      <option value="03">ͨ����չ�ӿ�</option>
      <option value="04">ִ�г���</option>
      -->
      <option value="05">SQL</option>
      <option value="06">URL</option>
    
    </select>
  </td>
</tr>
                                          
<tr id="resType" class="listdata">
  <td  align="right" nowrap="true"> ������ʽ��</td>
  <td align="left">
    <select name="RESPONE_TYPE" >
      <option value="0" >û��</option>
      <option value="1" selected>�ַ���</option>
      <option value="2">�ı�</option>
    </select> </td>
</tr>

<tr id="chkType" class="listdata">
  <td   align="right"> �Ƿ���ɹ���</td>
  <td align="left">
    <select name="CHECK_TYPE" >
      <option value="0" selected>��</option>
      <option value="1" >��</option>
    </select> </td>
</tr>
<!--  
<tr class="listdata">
  <td  align="right" nowrap="true"> ����Դ��</td>
  <td align="left">
    <select name="SOURCE_RESID">

    </select>
    </td>
</tr>

<tr class="listdata">
  <td  align="right" nowrap="true"> Ŀ������Դ��</td>
  <td align="left">
    <select name="DEST_RESID">

    </select> </td>
</tr>
-->                                          
<tr id = "proRs" class="listdata">
  <td  align="right" nowrap="true"> ����ִ��λ�ã�</td>
  <td align="left">
    <select name="PROCESS_RESID" >
	  <option value="" >-------����λ���б�-------</option>
	   <%
          for(int i=0;i<resources.size();i++){
              DataSourceVO datasource = (DataSourceVO)resources.get(i);
        %>
        <option value="<%= datasource.getID()%>" ><%= StringUtil.escapeHTMLTags(datasource.getDS_NAME())%></option>
         <%
               }
         %>
    </select>
   </td>
</tr>
<!--                                            
<tr class="listdata">
   <td  align="right" nowrap="true"> ������Դ��</td>
   <td align="left">
     <select name="TKN_ID" multiple size="5" style="height: 50px">
	  <option value="" >--------������Դ�б�--------</option>
	  <%
		//for(int i=0;i<tokens.size();i++){
           //TokenVO token = (TokenVO)tokens.get(i);
	  %>
		<option value="token.getId()" >test</option>
	  <%
		//}
	  %>
    </select> 
   </td>
</tr>

<tr valign="top" class="listdata">
  <td  align="right" nowrap="true">�������ʹ��ʱ�䣨�룩��</td>
  <td align="left">
    <input type="text" name="TKN_MAX_USETIME" class="inputtxt" size="30"></td>
</tr>
                                          
<tr valign="top" class="listdata">
  <td  align="right" nowrap="true">�������ȴ�ʱ�䣨�룩��</td>
  <td align="left">
    <input type="text" name="TKN_MAX_WAITTIME" class="inputtxt" size="30"></td>
</tr>
-->
<tr valign="top" class="listdata">
  <td align="right" nowrap="true">Ԥ������ʱ�䣨�룩��</td>
  <td align="left"><input type="text" name="FORCAST_TIME"��fieldTitle="Ԥ������ʱ�䣨�룩" fieldType ="number" class="inputtxt" size="30"></td>
</tr>

<tr valign="top" class="listdata">
  <td  align="right" nowrap="true">���ȼ���</td>
  <td align="left">
   <select name="JOB_PRIORITY" >
	<option value="0" selected>0</option>
	<option value="1" >1</option>
	<option value="2" >2</option>
	<option value="3" >3</option>
	<option value="4" >4</option>
	<option value="5" >5</option>
	<option value="6" >6</option>
	<option value="7" >7</option>
	<option value="8" >8</option>
	<option value="9" >9</option>
	<option value="10" >10</option>
	</select> </td>
</tr>

<tr valign="top" class="listdata">
	<td  align="right" nowrap="true">����˵����</td>
	<td align= "left" ><input type="text" name="DESCRIPTION" fieldTitle="����˵��" fieldType ="hasSpecialChar" class="inputtxt" size="30" maxlength="100"></td>
</tr>

<input type="hidden" name="STATUS"  value="<%=SystemConfig.STATUS_PRODUCE%>" >

<tr class="listdata">
<td colspan="2" >
	<table id="detail" width="100%" class="text01">
		<TBODY>
			<TR align=center bgColor="#E0E0E0" height=20>
			  <TD height="24" colspan="2" class="css-01">
				<div align="center">������ϸ��Ϣ</div>
                    </TD>
			</TR>
			<tr valign="top" class="listdata">
				<td align="right" width="26%">�洢��������:</td>
				<td width="72%" align="left"><input type="text" name="INVOKE_NAME" fieldTitle="�洢��������" fieldType ="hasSpecialChar" class="inputtxt" size="30" maxlength="120"><font color="#FF0000"> *</font></td>
			</tr>
			<tr valign="top" class="listdata">
				<td align="right" width="26%">���ò�����</td>
				<td align="left" width="72%"><input type="text" name="INVOKE_PARAM" fieldTitle="���ò���" fieldType ="hasSpecialChar" class="inputtxt" size="30" maxlength="120">(���������"?"����)</td>
			</tr>
		</TBODY>
	</table>
</td>
</tr>

<tr height="10" class="listdata">
  <td colspan="2">&nbsp; </td>
</tr>

<tr class="listdata">
    <td colspan="2"> <div align="center">
        <input type="hidden" name="CATALOG" value="<%=CATALOG%>">
        <input type="button" name="button" value="�� ��" class="input01" onClick="_checkFrm()" style="cursor:hand">
        &nbsp;&nbsp;
        <input type="button" name="button2" value="�� ��" class="input01" onClick="_return()" style="cursor:hand">
        <input type="hidden" name="TKN_LIST" >
     </div></td>
 </tr>
 
</table>
</form>
<script>
changeJobType();
</script>
</body>
</html>