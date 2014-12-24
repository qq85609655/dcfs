<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html; charset=gbk"%>
<jsp:directive.page import="base.task.resource.adapter.vo.AdapterVO"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="base.task.resource.datasourcetype.vo.DataSourceTypeVO"/>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<%
	String contextpath = request.getContextPath();
	String message=(String)request.getAttribute("message");
	AdapterVO avo= (AdapterVO)request.getAttribute("adapterVO");

	String ADAPTER_NAME=(String)request.getAttribute("ADAPTER_NAME");
	String paraStr= (String)request.getAttribute("paraStr");
	if(message==null) message=""; 
	if(ADAPTER_NAME==null) ADAPTER_NAME=""; 
	List dsTypeList= (List)request.getAttribute("dsTypeList");
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
<script LANGUAGE="javascript" SRC="<%=contextpath%>/js/extendString.js"></script>
<script>
function saveNewGroup(){
    if(document.frm.IMPL_CLASS.value.trim()!="" && document.frm.ADAPTER_NAME.value.trim()!=""){
		document.frm.action="<%=contextpath%>/base/task/resource/adapter/SaveAdapterServlet";
		document.frm.submit();
	}else{
		alert("适配器名称和适配器实现类必须都填写！");
	}
}
function returnHome(){
	document.location.href="<%=contextpath%>/base/task/resource/adapter/AdapterListServlet";
}
function openAddWindow(){
    
	var returnValue=window.showModalDialog('<%=contextpath%>/rwgl/adapter/addnewparams.html','','dialogTop=280px;dialogLeft=350px;dialogHeight:200px;dialogWidth:400px;status=no;scrollbars=no;resizable=no');
    if(returnValue!=null){
		var optionObj= document.createElement("OPTION");
		optionObj.setAttribute("value",returnValue[0]+";"+returnValue[1]+";"+returnValue[2]);
		optionObj.setAttribute("text",returnValue[0]+";"+returnValue[1]+";"+returnValue[2]);
		document.getElementById("options").add(optionObj);
		document.frm.paraStr.value +=returnValue[0]+";"+returnValue[1]+";"+returnValue[2]+"@@";
	}
}

function delOption(){
    var optionObj= document.getElementById("options");
    var pStr="";
    for(var i=0;i<optionObj.options.length;i++){
    	if(optionObj.options[i].selected== true){
    	    var opValue= optionObj.options[i].value;
    	    var paraStrtemp= document.frm.paraStr.value;
    	    var arrParas= paraStrtemp.split("@@");
    	    for(var j=0;j< arrParas.length;j++){
    	    	var per= arrParas[j];
    	    	if(per!="" && per!=opValue){
    	    		pStr += per+"@@";
    	    		document.frm.paraStr.value= pStr;
    	    	}
    	    }
    		optionObj.options.remove(i);
    		delOption();
    	}
    }
}
</script>
<body>
<form name="frm" method="post">
<input type="hidden" name="ID" value="<%=avo.getID() %>"> 
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="text01">
  <tr>
    <td height="18"  valign="middle"><img src="<%=contextpath%>/images/currentpositionbg.jpg" width="8" height="18" id="positionimg"/><div class="currentposition"><strong>&nbsp;当前位置-&gt; 任务管理-&gt;适配器管理-&gt;新建适配器</strong></div></td>
    <td  class="currentposition" align="right"><strong></strong></td>
    <td width="4%" align="right"> 
    
    </td>
    <td width="9%"> 
      
    </td>
  </tr>
</table>	
<br>
<br>
<br>
<br>
<br>
<font class="text01" color="red"><%=message %></font>
<table width="60%" border="0" cellpadding="1" cellspacing="1" align="center" class="text01">
<tr>
<td>
<table width="100%" border="0" cellpadding="1" cellspacing="1" align="center" bgcolor="#9CC6F7">
      <tr>
        <td width="18%" class="listdata"><div align="right">适配器名称：</div></td>
        <td class="listdata" colspan="2"><div align="left"><input type="text" name="ADAPTER_NAME" size="20" maxlength="30" value="<%=avo.getAdapterName() %>"><font  class="text01" color="#FF0000">*</font></div></td>
      </tr>
      <tr>
        <td class="listdata"><div align="right">适用数据源类型：</div></td>
        <td class="listdata" colspan="2"><div align="left">
          <select name="DS_TYPE" id="DS_TYPE">
            <%
            	for(int i=0;i<dsTypeList.size();i++){
            		DataSourceTypeVO vo=(DataSourceTypeVO)dsTypeList.get(i);
             %>
            <option value="<%=vo.getID() %>"><%=StringUtil.escapeHTMLTags(vo.getDsTypeName()) %></option>
            <%
            	}
             %>
          </select>
          <font  class="text01" color="#FF0000">*</font></div></td>
      </tr>		
	    <tr>
        <td class="listdata"><div align="right">适配器描述：</div></td>
        <td class="listdata" colspan="2"><div align="left">
          <input name="DESCRIPTION" type="text" size="50" maxlength="50" value="<%=avo.getDescription() %>">
        </div></td>
      </tr>	
	    <tr>
        <td class="listdata"><div align="right">实现类名：</div></td>
        <td class="listdata" colspan="2"><div align="left">
          <input name="IMPL_CLASS" type="text" size="50" maxlength="100" value="<%=avo.getImplCalss() %>">
          <font  class="text01" color="#FF0000">*</font></div></td>
      </tr>	
	    <tr>
        <td class="listdata"><div align="right">自定义参数：</div></td>
        <td width="58%" height="100"  bgcolor="#FFFFFF">
        <input type="hidden" name="paraStr" value="<%=paraStr %>">
		<select name="options" id="options" size="8"  style="width:100%; height:100% " class="text01" multiple>
		
        </select>
        </td>
		<td width="24%" class="listdata"><div align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="insert" value="添加" onClick="openAddWindow();" class="button"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="delelte" value="删除" class="button" onclick="delOption()"></div></td>
      </tr>	  		  		  		  		  
      <tr class="listdata"><td align="center" colspan="3"><input type="button" name="addNewButton" value="保存" class="input01" onClick="saveNewGroup();">&nbsp;<input type="button" name="returnButton" value="返回" class="input01" onClick="returnHome();"></td></tr>
</table>
</td>
</tr>
</table>
</form>
</body>
<script type="text/javascript">
	document.getElementById("DS_TYPE").value="<%=avo.getDsType()%>";
	<%
	   String[] arrParas= paraStr.split("@@");
	   for(int i=0;i<arrParas.length;i++ ){
	    if(!"".equals(arrParas[i])){
	%>
	    var optionObj= document.createElement("OPTION");
		optionObj.setAttribute("value","<%=arrParas[i]%>");
		optionObj.setAttribute("text","<%=arrParas[i]%>");
		document.getElementById("options").add(optionObj);
	<%
		}}
	%>
</script>
</html>
