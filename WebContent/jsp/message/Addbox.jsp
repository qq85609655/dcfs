<%@page import="hx.message.OAConstants"%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.taglib.TagTools"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String path = request.getContextPath();
String resourcepath=TagTools.getResourcePath(request,"");
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
DataList dataMsg=(DataList)request.getAttribute("dataMsg")==null?new DataList():(DataList)request.getAttribute("dataMsg");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <BZ:head>  
    <base href="<%=basePath%>">
  	<style>
	body{
	font-size:13px;
	}
	#table1 tr{
	height:24px;
	background-color:#ECF3FB;
	}
	#table1 th{
	text-align:center;
	height:24px;
	background-color:#F1F4F9;
	border-top:1px solid white;
	border-bottom:1px solid #b7ddf0;
	}
	#table1 td{
	text-align:center;
	border-top:1px solid white;
	border-bottom:1px solid #b7ddf0;
	}
	.box{
	border:1px solid red;
	}
	.box2{
	border:1px solid #b5b8c8;
	}

	</style>  
    <title>管理文件夹</title>
    <BZ:script isList="true" isAjax="true"/>
    <script language="javascript">
	 function goDelete(obj)
	 {
	 var wdyj=document.getElementById(obj+'1').innerHTML;
	 var ydyj=document.getElementById(obj+'2').innerHTML;
	 var ljxwuyj=document.getElementById('<%=OAConstants.LJX+"1"%>').innerHTML;
	 var ljxydyj=document.getElementById('<%=OAConstants.LJX+"2"%>').innerHTML;
	 var jgwuyj=parseInt(wdyj)+parseInt(ljxwuyj);
	 var jgydyj=parseInt(ydyj)+parseInt(ljxydyj);
	 if(wdyj!=0&&confirm('此文件夹存在未读信息确认删除?'))
	 {
	 shanchu(obj);
	 document.getElementById('<%=OAConstants.LJX+"1"%>').innerHTML=jgwuyj;
	 document.getElementById('<%=OAConstants.LJX+"2"%>').innerHTML=jgydyj;
	 alert('文件夹清空成功!');
	 }
	 if(wdyj==0&&obj!="<%=OAConstants.LJX%>")
	 {
	 if(confirm('确认清空文件夹?'))
	 {
	 shanchu(obj);
	 document.getElementById('<%=OAConstants.LJX+"1"%>').innerHTML=jgwuyj;
	 document.getElementById('<%=OAConstants.LJX+"2"%>').innerHTML=jgydyj;
	 alert('文件夹清空成功!');
	 }
	 }
	 if(wdyj==0&&obj=="<%=OAConstants.LJX%>")
	 {
	 if(confirm('清空垃圾箱邮件将永久删除，确定清空?'))
	 {
	 shanchu(obj);
	 alert('文件夹清空成功!');
	 }
	 }
	 }
	 
	 function shanchu(obj)
	 {
	 var dm =getBoolean("hx.message.MessageAjax","boxuuid="+obj+"&method=qingkong");
	 if(dm)
	 {
	 document.getElementById(obj+'1').innerHTML="0";
	 document.getElementById(obj+'2').innerHTML="0";
	 window.parent.leftFrame.location.reload();
	 }
	 }
	 
	 
	 function rename(obj)
	 {
	 var name=document.getElementById(obj+'5').innerHTML;
	 document.getElementById(obj+'0').innerHTML='<input type="text" name="fileName1" value="'+name+'" style="width:100px;height:20px">&nbsp;<input type="button" name=""  value="修改" class="extButtonSmall" onclick="changboxname(\''+obj+'\',\''+name+'\');"/>';
	 }
	 
	 
	 
	 function goDeleteFile(obj)
	 {
	 var wdyj=document.getElementById(obj+'1').innerHTML;
	 var ydyj=document.getElementById(obj+'2').innerHTML;
	 var ljxwuyj=document.getElementById('<%=OAConstants.LJX+"1"%>').innerHTML;
	 var ljxydyj=document.getElementById('<%=OAConstants.LJX+"2"%>').innerHTML;
	 var jgwuyj=parseInt(wdyj)+parseInt(ljxwuyj);
	 var jgydyj=parseInt(ydyj)+parseInt(ljxydyj);
	 if(wdyj!=0&&confirm('此文件夹存在未读信息确认删除?'))
	 {
	 var dm =getBoolean("hx.message.MessageAjax","boxuuid="+obj+"&method=shanchubox");
	 if(dm)
	 {
	 document.getElementById('<%=OAConstants.LJX+"1"%>').innerHTML=jgwuyj;
	 document.getElementById('<%=OAConstants.LJX+"2"%>').innerHTML=jgydyj;
	 var tabobj=document.getElementById('table1');
	 var tdobj=document.getElementById(obj+'1');
	 var trIndex=tdobj.parentNode.rowIndex;
	 tabobj.deleteRow(trIndex);
	 alert('文件夹删除成功此文件夹中信件已转移到垃圾箱');
	 window.parent.leftFrame.location.reload();
	 }
	 else
	 {
	 alert('文件夹删除失败');
	 }
	 }
	 else
	 if(wdyj==0&&confirm('确定删除文件夹?'))
	 {
	 var dm =getBoolean("hx.message.MessageAjax","boxuuid="+obj+"&method=shanchubox");
	 if(dm)
	 {
	 document.getElementById('<%=OAConstants.LJX+"1"%>').innerHTML=jgwuyj;
	 document.getElementById('<%=OAConstants.LJX+"2"%>').innerHTML=jgydyj;
	 var tabobj=document.getElementById('table1');
	 var tdobj=document.getElementById(obj+'1');
	 var trIndex=tdobj.parentNode.rowIndex;
	 tabobj.deleteRow(trIndex);
	 alert('文件夹删除成功此文件夹中信件已转移到垃圾箱');
	 window.parent.leftFrame.location.reload();
	 }else
	 {
	 alert('文件夹删除失败');
	 }
	 }
	 }
	 
	 
    var msg = new Hint(false); 
    function changboxname(boxuuid,name)
    {
    var va=document.getElementById('fileName1').value;
    if(va==name)
    {
    document.getElementById(boxuuid+'0').innerHTML='<a id="'+boxuuid+'5" href="<%=path%>/MessageServlet?method=receivemessage&boxuuid='+boxuuid+'">'+va+'</a>';
    }else
    {
	if(va=="")
	{
	msg.show(document.getElementById("fileName"),"请输入文件名！",0)
	return false;
	}
	//收件箱发件箱 命名检测
	if(va=="收件箱" || va=="发件箱"){
	msg.show(document.getElementById("fileName"),"您输入名字已经存在！",0)
   	return false;
    }
	//特殊字符检测
	var patn=/^[a-zA-Z0-9\u4e00-\u9fa5]+$/;
    if(!patn.test(va)){
		msg.showpop(document.getElementById("fileName"),"文件名只能含中文数字字母",0)
    	return false;
    }else{
	var de=va;
	var dm =getBoolean("hx.message.MessageAjax","&boxuuid="+boxuuid+"&fileName1="+de+"&method=changeboxname");
	if(dm){
    document.getElementById(boxuuid+'0').innerHTML='<a id="'+boxuuid+'5" href="<%=path%>/MessageServlet?method=receivemessage&boxuuid='+boxuuid+'">'+va+'</a>';
	window.parent.leftFrame.location.reload();
	}else{
    msg.show(document.getElementById("fileName"),"添加失败或名字已存在",0)
	}
    }
    }
    }
    function loadbox(){
	var va=document.getElementById('fileName').value;
	if(va=="")
	{
	msg.show(document.getElementById("fileName"),"请输入文件名！",0)
	return false;
	}
	//收件箱发件箱 命名检测
	if(va=="收件箱" || va=="发件箱"){
	msg.show(document.getElementById("fileName"),"您输入名字已经存在！",0)
   	return false;
    }
	//特殊字符检测
	var patn=/^[a-zA-Z0-9\u4e00-\u9fa5]+$/;
    if(!patn.test(va)){
		msg.show(document.getElementById("fileName"),"文件名只能含中文数字字母",0)
    	return false;
    }else{
	var de=va;
	var dm =getData("hx.message.MessageAjax","fileName="+de+"&method=addbox");
	if(dm.getString("UUID")!=""&&dm.getString("UUID")!=null){
	var uuid=dm.getString("UUID");
    var addTb = document.getElementById("table1");
    var _tr = addTb.insertRow();
    var _td = _tr.insertCell();
    _td.id=uuid+'0';
    _td.innerHTML='<a id="'+dm.getString("UUID")+'5" href="<%=path%>/MessageServlet?method=receivemessage&boxuuid='+dm.getString("UUID")+'">'+dm.getString("NAME")+'</a>';
    var _td = _tr.insertCell();
    _td.id=uuid+'1';
    _td.innerHTML="0";
    var _td = _tr.insertCell();
    _td.id=uuid+'2';
    _td.innerHTML="0";
    var _td = _tr.insertCell();
    _td.innerHTML='<input type="button" onClick="goDelete(\''+uuid+'\');" value="清空" class="btn2"/>&nbsp;<input type="button" onclick="rename(\''+uuid+'\');" value="重命名" class="btn2"/>&nbsp;<input type="button" onClick="goDeleteFile(\''+uuid+'\');" value="删除" class="btn2"/>'; 
    document.getElementById("fileName").value="";
    window.parent.leftFrame.location.reload();
	}else{
    msg.show(document.getElementById("fileName"),"添加失败或名字已存在",0)
	}
    }
    }
    </script>
  </BZ:head>
  <body>
	<div  class="extPanel" style="clear:left; ">
	<table cellspacing="0" width="100%"  id="table1"  align="center" style="font-size:12px; ">
	 <thead>
   <tr id="TR">
                <th width="40%">文件夹名称</th>
                <th width="10%">未读信息数</th>
				<th width="10%">总信息数</th>
				<th style="text-align:center;" width="40%">操作</th>
      </tr>
    </thead>
		   <tbody>
		  <%for(int i=0;i<dataMsg.size();i++)
		  {
		    String name="";
			Data data=dataMsg.getData(i);
			if(data.getString("NAME","").equals(OAConstants.SJX_CN))
			{
			name="收件箱";
			}else if(data.getString("NAME","").equals(OAConstants.FJX_CN)){
			name="发件箱";
			}else if(data.getString("NAME","").equals(OAConstants.LJX_CN))
			{
			name="垃圾箱";
			}else{
			name=data.getString("NAME","");
			}
		   %>
		   <tr>
           <td id="<%=data.getString("UUID","0")+0 %>"><a id="<%=data.getString("UUID","0")+5 %>" href="<%=path%>/MessageServlet?method=receivemessage&boxuuid=<%=data.getString("UUID","0")%>"><%=name%></a></td>
           <td id="<%=data.getString("UUID","0")+1 %>"><%=data.getString("WYDNUM","0") %></td>
           <td id="<%=data.getString("UUID","0")+2 %>"><%=data.getInt("YYDNUM")+data.getInt("WYDNUM") %></td>
           <td><input type="button" onClick="goDelete('<%=data.getString("UUID") %>');" value="清空" class="btn2"/>&nbsp;<%if(data.getString("UUID","").equals(OAConstants.SJX)||data.getString("UUID","").equals(OAConstants.FJX)||data.getString("UUID","").equals(OAConstants.LJX)) {}else{ %><input type="button" onclick="rename('<%=data.getString("UUID") %>');" value="重命名" class="btn2"/>&nbsp;<input type="button" onClick="goDeleteFile('<%=data.getString("UUID") %>');" value="删除" class="btn2"/><%} %></td>
           </tr>
           <%} %>
            </tbody>
  </table>
		  <table width="100%" border="0" cellpadding="2" bgcolor="#dce8f6">
	        <tr>
			<td width="10%" style="font-size:12px;padding-left:18px;">创建文件夹</td>
			<td width="20%" ><input type="text" name="fileName" check  message="请输入文件名"   maxlength="250" ></td>
			<td width="65%"><input type="button" name=""  value="创建" class="btn2" onclick="loadbox();"/></td>
			</tr>
            </table> 
            </div>
  </body>
</html>
