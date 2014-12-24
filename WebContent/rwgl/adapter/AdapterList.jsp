<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html; charset=gbk"%>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="base.task.resource.adapter.vo.AdapterVO"/>
<jsp:directive.page import="base.task.resource.datasourcetype.vo.DataSourceTypeVO"/>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<jsp:directive.page import="base.resource.util.page.Pagination"/>
<jsp:directive.page import="java.util.ArrayList"/>
<%
	String contextpath = request.getContextPath();
	String ADAPTER_NAME= request.getParameter("ADAPTER_NAME");
	String DS_TYPE= request.getParameter("DS_TYPE");
	List dsTypeList= (List)request.getAttribute("dsTypeList");
	if(ADAPTER_NAME== null) ADAPTER_NAME="";
	if(DS_TYPE== null) DS_TYPE="";
	List dsTypeList2= (List)request.getAttribute("dsTypeList2");
	List usingAdapter= (List)request.getAttribute("usingAdapter");
	
	Pagination pagination= null;
	String pageNumber= request.getParameter("pageNumber");
	int showItemNumber=10;
	if(pageNumber==null){
		pageNumber="1";
	}
	String HTML="";
	List taskList= new ArrayList();
	if(dsTypeList!=null&&dsTypeList.size()>0){
		pagination= new Pagination();
		pagination.setPageNumber(Integer.parseInt(pageNumber));
		pagination.setShowItemNumber(showItemNumber);
		pagination.setVisitPageURL(contextpath+"/base/task/resource/adapter/AdapterListServlet");
		taskList= pagination.interceptListByStartItemNumber(dsTypeList);
		HTML= pagination.buildHTML("100%","left","text01");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextpath%>/css/style.css" rel="stylesheet" type="text/css" />
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
	document.frm.action="<%=contextpath%>/base/task/resource/adapter/AdapterListServlet";
	document.frm.submit();
}
function newGroup(){
	document.frm.action="<%=contextpath%>/base/task/resource/adapter/NewAdapterServlet";
	document.frm.submit();
}
function delAdapter(){
	var checkedObj=document.getElementsByName("checkboxid");
	var isSelected=false;
	for(var i=0;i<checkedObj.length;i++){
		if(checkedObj[i].checked==true){
			isSelected=true;
		}
	}
	if(isSelected==true){
		document.frm.action="<%=contextpath%>/base/task/resource/adapter/DeleteAdapterServlet";
		document.frm.submit();
	}else{
		alert("请选择您要删除的适配器！");
	}
}
</script>
<body>
<form name="frm" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="text01" >
  <tr>
    <td height="18"  valign="middle"><img src="<%=contextpath%>/images/currentpositionbg.jpg" width="8" height="18" id="positionimg"/><div class="currentposition"><strong>&nbsp;当前位置-&gt; 任务管理-&gt; 适配器管理</strong></div></td>
    <td  class="currentposition" align="right"><strong></strong></td>
    <td width="4%" align="right"> 
    
    </td>
    <td width="9%"> 
      
    </td>
  </tr>
  
      <tr>
        <td height="25" colspan="4">
				  <div id="query">
					  适配器名称：&nbsp;
					  <input name="ADAPTER_NAME" type="text" value="<%=ADAPTER_NAME%>" class="queryinput" size="11" maxlength="9" />
					  &nbsp;
					  使用数据源类型：&nbsp;
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
        <td height="18" colspan="4">
			&nbsp;	 	  
		</td>
</tr>
 <tr>
      <td colspan="4">
		<div id="primarydata" style="width:100%; overflow:hidden" >
		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#9CC6F7" class="text01">
	    <tr height="22">
		  <th width="5%"><div align="center">&nbsp;</div></th>
	      <th width="5%"><div align="center">序号</div></th>
	      <th width="20%"><div align="center">适配器名称</div></th>
	      <th width="20%"><div align="center">使用数据源类型</div></th> 
		  <th width="20%"><div align="center">适配器描述</div></th>         	
      </tr>
      <%
        if(!taskList.isEmpty()){
	      	for(int i=0;i<taskList.size();i++){
	      		AdapterVO dsvo= (AdapterVO)taskList.get(i);
	      		String DsType= dsvo.getDsType();
	      		String DsName="";
	      		String adapterid= dsvo.getID();
	      		for(int j=0;j<dsTypeList2.size();j++){
            		DataSourceTypeVO vo=(DataSourceTypeVO)dsTypeList2.get(j);
            		if(DsType.equals(vo.getID())){
            			DsName= vo.getDsTypeName();
            		}
            	}
       %>
      <tr height="22" >
        <td class="listdata"><div align="center">
        <%
        	if(!usingAdapter.contains(adapterid)){
         %>
        <input type="checkbox" name="checkboxid" value="<%=dsvo.getID() %>" class="input">
        <%
        	}else{
         %>
         <input disabled="disabled" type="checkbox" name="checkboxid" value="<%=dsvo.getID() %>" class="input">
         <%
         	}
          %>
        </div></td>
        <td class="listdata"><div align="center"><%=i+1 %></div></td>
        <td class="listdata"><div align="left"><a href="<%=contextpath%>/base/task/resource/adapter/EditAdapterServlet?ID=<%=dsvo.getID() %>"><%=StringUtil.escapeHTMLTags(dsvo.getAdapterName()) %></a></div></td>       
        <td class="listdata"><div align="left"><%=StringUtil.escapeHTMLTags(DsName)%></div></td>  
		<td class="listdata"><div align="left"><%=StringUtil.escapeHTMLTags(dsvo.getDescription())%></div></td> 
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
  <tr><td align="center" colspan="4"><input type="button" name="addButton" value="新建" class="input01" onClick="newGroup();">&nbsp;<input type="button" name="delButton" value="删除" class="input01" onClick="delAdapter();"></td></tr>
</table>

</form>
<script type="text/javascript">
 document.getElementById("DS_TYPE").value="<%=DS_TYPE%>";
</script>
</body>
</html>