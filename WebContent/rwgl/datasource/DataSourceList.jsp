<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html; charset=gb2312"%>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="base.task.resource.datasource.vo.DataSourceVO"/>
<jsp:directive.page import="base.task.resource.datasourcetype.vo.DataSourceTypeVO"/>
<jsp:directive.page import="java.util.Hashtable"/>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<jsp:directive.page import="base.resource.util.page.Pagination"/>
<jsp:directive.page import="java.util.ArrayList"/>
<%
	String contextpath = request.getContextPath();
	String DS_NAME= request.getParameter("DS_NAME");
	String DS_TYPE= request.getParameter("DS_TYPE");
	List dsList= (List)request.getAttribute("dsList");
	if(DS_NAME== null) DS_NAME="";
	if(DS_TYPE== null) DS_TYPE="";
	List dsTypeList2= (List)request.getAttribute("dsTypeList2");
	Hashtable inUsingHashtable= (Hashtable)request.getAttribute("inUsingHashtable");
	
	Pagination pagination= null;
	String pageNumber= request.getParameter("pageNumber");
	int showItemNumber=10;
	if(pageNumber==null){
		pageNumber="1";
	}
	String HTML="";
	List taskList= new ArrayList();
	if(dsList!=null&&dsList.size()>0){
		pagination= new Pagination();
		pagination.setPageNumber(Integer.parseInt(pageNumber));
		pagination.setShowItemNumber(showItemNumber);
		pagination.setVisitPageURL(contextpath+"/base/task/resource/datasource/DataSourceListServlet?DS_NAME="+DS_NAME+"&DS_TYPE="+DS_TYPE);
		taskList= pagination.interceptListByStartItemNumber(dsList);
		HTML= pagination.buildHTML("100%","left","text01");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextpath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<%=contextpath%>/rwgl/js/customString.js"></script>
        <script type="text/javascript" src="<%=contextpath%>/rwgl/js/formVerify.js"></script>
        <script type="text/javascript" src="<%=contextpath%>/rwgl/js/verify.js"></script>
        <script type="text/javascript" src="<%=contextpath%>/rwgl/js/jcommon.js"></script>
<title>无标题文档</title>
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
function _retrieve(){

      if(_check(frm)){
       document.frm.action="<%=contextpath%>/base/task/resource/datasource/DataSourceListServlet";
	   document.frm.submit();
      }else{
        return;
      }
	
}
function newGroup(){
	document.frm.action="<%=contextpath%>/base/task/resource/datasource/NewDataSourceServlet";
	document.frm.submit();
}
function _checkConn(dsID, dsType)
{
    this.alertbox.style.left = document.body.clientWidth / 2 - 100;
    this.alertbox.style.top = document.body.clientHeight / 2 - 12;
    this.alertbox.style.visibility = "visible";
    var _url = "<%= contextpath %>/base/task/resource/datasource/DataSourceTestServlet?ID=" + dsID + "&DS_TYPE=" + dsType;
    oDownload.startDownload(_url, alertResult);
}
function alertResult(s)
{
    this.alertbox.style.visibility = "hidden";
    var array = s.split("\n");
    if(array[array.length-1] == "result=true") {
      for(var i=0; i<array.length-1; i++) {
        var a = array[i].split(" - ");
        alert(a[1]);
      }
    }
    else
    {
        alert("测试数据源连接失败！");
    }
}
function delDSS(){
    
    var objIDS= document.getElementsByName("checkboxID");
	var isSelected=false;
	for(var i=0;i<objIDS.length;i++){
		if(objIDS[i].checked==true){
			isSelected=true;
			break;
		}
	}
	if(isSelected==true){
	   	var realdel = window.confirm("确认要删除这些信息吗？");
    	if(realdel==true){
			document.frm.action="<%=contextpath%>/base/task/resource/datasource/DeleteDataSourceServlet";
			document.frm.submit();
		}
	}else{
		alert("请选择您要删除的数据源！");
	}
}
</script>
<body>
<cool:DOWNLOAD ID="oDownload" STYLE="behavior:url(#default#download)" />
<div id="alertbox" style="position:absolute; width:200pt; height:40pt; z-index:1;visibility: hidden;">
  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#000000" class="text01">
    <tr bgcolor="#EEFFF7">
      <td height="40" align=center>正在尝试连接数据源,请稍候...</td>
    </tr>
  </table>
</div>
<form name="frm" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="text01" >
 
  
      <tr>
        <td height="25" colspan="4">
				  <div id="query">
					  数据源名称：&nbsp;
					  <input name="DS_NAME" type="text" fieldType="hasSpecialChar" fieldTitle="数据源名称" value="<%=DS_NAME%>" class="queryinput" size="20"/>
					  &nbsp;
					  数据源类型：&nbsp;
					  <select name="DS_TYPE" id="DS_TYPE">
                            <option value="" selected >【-全部-】</option>
                            
                             <%
            	for(int i=0;i<dsTypeList2.size();i++){
            		DataSourceTypeVO vo=(DataSourceTypeVO)dsTypeList2.get(i);
             %>
            <option value="<%=vo.getID() %>" ><%=vo.getDsTypeName() %></option>
            <%
            	}
             %>
                            			
                    </select>
					  <input type="button" name="queryb" value="查询(Q)" class="input01" accesskey="Q" onclick="_retrieve();"/ tabindex="100" Onkeydown="">
				  </div>		  
				</td>
</tr>	

 <tr>
      <td colspan="4">
		<div id="primarydata" style="width:100%; overflow:hidden" >
		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#9CC6F7" class="text01">
	    <tr height="22">
		  <th width="5%"><div align="center">&nbsp;</div></th>
	      <th width="5%"><div align="center">序号</div></th>
	      <th width="20%"><div align="center">数据源名称</div></th>
	      <th width="20%"><div align="center">数据源类型</div></th> 
		  <th width="20%"><div align="center">数据源描述</div></th>   
		  <th width="10%"><div align="center">连接测试</div></th>         	
      </tr>
      <%
        if(!taskList.isEmpty()){
	      	for(int i=0;i<taskList.size();i++){
	      		DataSourceVO dsvo= (DataSourceVO)taskList.get(i);
	      		String DsType= dsvo.getDS_TYPE();
	      		String DsName="";
	      		for(int j=0;j<dsTypeList2.size();j++){
            		DataSourceTypeVO vo=(DataSourceTypeVO)dsTypeList2.get(j);
            		if(DsType.equals(vo.getID())){
            			DsName= vo.getDsTypeName();
            		}
            	}
            	String ID= dsvo.getID();
       %>
      <tr height="22" >
        <td class="listdata"><div align="center">
        <%
        	if(inUsingHashtable.get(ID)!=null){
         %>
        <input disabled="disabled" type="checkbox" name="checkboxID" value="<%=dsvo.getID() %>" class="input">
        <%
        	}else{
         %>
         <input type="checkbox" name="checkboxID" value="<%=dsvo.getID() %>" class="input">
         <%
         	}
          %>
        </div></td>
        <td class="listdata"><div align="center"><%=i+1 %></div></td>
        <td class="listdata"><div align="left"><a href="<%=contextpath%>/base/task/resource/datasource/EditDataSourceServlet?ID=<%=dsvo.getID() %>&DS_TYPE=<%=DsType %>"><%=StringUtil.escapeHTMLTags(dsvo.getDS_NAME()) %></a></div></td>       
        <td class="listdata"><div align="left"><%=StringUtil.escapeHTMLTags(DsName) %></div></td>  
		<td class="listdata"><div align="left"><%=StringUtil.escapeHTMLTags(dsvo.getDESCRIPTION()) %></div></td> 
		<td class="listdata"><div align="center"><input type="button" name="test" value="测试" onClick="_checkConn('<%= dsvo.getID()%>', '<%=dsvo.getDS_TYPE()%>');" class="input01"></div></td>        				
      </tr>	 
      <%
      		}
      	}
       %> 		  		  		  
    </table>
		</div>
		</td>
    </tr>
    <tr>
      <td colspan="4" height="24" >
      <%=HTML %>
      </td>
    </tr>
  <tr><td align="center" colspan="4"><input type="button" name="addButton" value="新建" class="input01" onClick="newGroup();">&nbsp;<input type="button" name="delButton" value="删除" class="input01" onClick="delDSS();"></td></tr>
</table>

</form>
<script type="text/javascript">
 document.getElementById("DS_TYPE").value="<%=DS_TYPE%>";
</script>
</body>
</html>