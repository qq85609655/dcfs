<%@page import="hx.util.DateUtility"%>
<%@page import="hx.message.OAConstants"%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="java.util.Map"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.taglib.TagTools"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@ taglib uri="/WEB-INF/taglib/oa" prefix="OA" %>
<%
String resourcepath=TagTools.getResourcePath(request,"");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
DataList dataMsg=(DataList)request.getAttribute("dataMsg")==null?new DataList():(DataList)request.getAttribute("dataMsg");
DataList yddataMsg=(DataList)request.getAttribute("yddataMsg")==null?new DataList():(DataList)request.getAttribute("yddataMsg");
String language=(String)session.getAttribute("language");
  if(language == null){ 
  language="zh-CN";
  }
String boxname=(String)request.getAttribute("boxname");
if(boxname.equals(OAConstants.SJX_CN))
{
boxname="�ռ���";
}else if(boxname.equals(OAConstants.FJX_CN)){
boxname="������";
}else if(boxname.equals(OAConstants.LJX_CN))
{
boxname="������";
}
String boxuuid=(String)request.getAttribute("boxuuid");
String type=(String)request.getParameter("type")==null?"":(String)request.getParameter("type");
%>
<% 
DataList dataList=(DataList)request.getAttribute("dataList")==null?new DataList():(DataList)request.getAttribute("dataList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<BZ:html>
  <BZ:head>  
    <title>����Ϣ</title>
   <link rel="stylesheet" type="text/css" href="<%=resourcepath %>/message/css/newStyle.css"/>
  <BZ:script isList="true" /> 
  </BZ:head>
  <style>
  	#popdiv{
	font-size:12px;
	position:absolute;
	z-index:100;
	width:200px;
	height:80px;
	}
  </style>
<script type="text/javascript" >
window.onload = function()
{    
  <% if(dataList.size()==0){%>  
     window.top._closepagemsg();
  <%}else{}%> 
}
function _loadlist(){
   initTable("tableId");
}

var sForm="srcForm";
var pageaction="<%=path%>/MessageServlet?method=receivemessage";
function restoredl()
{
if (!hasSelectedOne('uuidbox'))
    {
     alert('��ѡ��һ����¼');
     return;
    }else{
    var uuid_zp=selectValue('uuidbox').split('��');
    document.getElementById("uuid").value=uuid_zp[0];
    document.srcForm.action="<%=path%>?method=huifudl";
	document.srcForm.submit();
	}
}
function restore()
{
if (!hasSelectedOne('uuidbox'))
    {
     alert('��ѡ��һ����¼');
     return;
    }else{
    var uuid_zp=selectValue('uuidbox').split('��');
    document.getElementById("uuid").value=uuid_zp[0];
    document.srcForm.action="<%=path%>/MessageServlet?method=huifu&xians=duanxx";
	document.srcForm.submit();
	}
}
function _delete()
{
 var j=0;
 var checkBoxObj = document.getElementsByName("uuidbox");
 for(var i=0;i<checkBoxObj.length;i++)
		 {
		 if(checkBoxObj[i].checked)
		 {
		 j++;
		 }		 
		 }
		 if(j==0)
		  {
		     alert('��ѡ������һ����Ч����');
		     return;
		  }else
		 {
		 if(confirm('ȷʵҪɾ��?'))
		 {
		 document.srcForm.action="<%=path%>/MessageServlet?method=gbbox";
         document.srcForm.submit();
		 }
		 }
}
function yidongxj()
{
   var j=0;
   var checkBoxObj = document.getElementsByName("uuidbox");
   var mbbox=document.getElementById("zcwjj").value;
    for(var i=0;i<checkBoxObj.length;i++)
		 {
		 if(checkBoxObj[i].checked)
		 {
		 j++;
		 }		 
		 }
		 if(j==0)
		  {
		     alert('��ѡ������һ����Ч����');
		     document.getElementById("zcwjj").value="";
		     return;
		  }else
		  if(mbbox=="")
		  {
		  alert('��ѡ��һ��Ŀ���ļ���');
		  return;
		  }else{
		  if(confirm('ȷʵҪ�ƶ�?'))
		  {
		  document.srcForm.action="<%=path%>/MessageServlet?method=xidongxj";
          document.srcForm.submit();     
		  }else
		  {
		  document.getElementById("zcwjj").value="";
		  return;
		  }
		  }
   window.parent.leftFrame.location.reload();
}
function add()
{
	document.srcForm.action="<%=path%>/MessageServlet?method=tiaozhuan";
	document.srcForm.submit();
}
function adddl()
{
	document.srcForm.action="<%=path%>?method=tiaozhuandl";
	document.srcForm.submit();
}
function hzdetail(uuid)
{
 window.open('<%=path %>/MessageServlet?method=hzdetail&uuid='+uuid,'��ִ���','location=0,status=0,scrollbars=0,width=400,height=315');
}
 function read(uuid)
 {  
    window.top._showpagemsg(uuid);
 }
var num_c=0;
function selectAll(){
	var obj_uuidboxs=document.getElementsByName("uuidbox");
	//ȫ����ѡ��
	if(num_c==0){
	for(var i=0;i<obj_uuidboxs.length;i++){
		if(obj_uuidboxs[i].checked){
			
		}else{
			obj_uuidboxs[i].checked=true;
		}
	}
	num_c=1;
	//ȫ����ѡ
	}else{
	for(var j=0;j<obj_uuidboxs.length;j++){
		if(obj_uuidboxs[j].checked){
		    obj_uuidboxs[j].checked=false;
		}else{
			
		}
	}
	num_c=0;
	}
}


function seluuidbox(method){
    var obj_uuidboxs=document.getElementsByName("uuidbox");
   if(method=="reverse"){
		for(var j=0;j<obj_uuidboxs.length;j++){
			if(obj_uuidboxs[j].checked){
			    obj_uuidboxs[j].checked=false;
			}else{
				obj_uuidboxs[j].checked=true;
			}
		}
   }else if(method=="readed"){
        var readflags=document.getElementsByName("readflags");
        for(var j=0;j<readflags.length;j++){
			if(readflags[j].value=="1"){
			    obj_uuidboxs[j].checked=true;
			}else{
				obj_uuidboxs[j].checked=false;
			}  
		}
   }else if(method=="notreaded"){
        var readflags=document.getElementsByName("readflags");
        for(var j=0;j<readflags.length;j++){
			if(readflags[j].value=="1"){
			    obj_uuidboxs[j].checked=false;
			}else{
				obj_uuidboxs[j].checked=true;
			}  
		}
   }
}

</script>
   <body id="body" style="margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-bottom: 0px;" onload="_loadlist()">
  <form  name="srcForm" method="post" action="MessageServlet?method=receivemessage&boxuuid=<%=boxuuid%>">
   <input type="hidden" name="dataListSize" id="dataListSize" value="<%=dataList.size() %>" />
    <input type="hidden" name="uuid" id="uuid" >
  <input type="hidden" name="boxuuid" id="boxuuid" value="<%=boxuuid %>" >
  <!--����������ݿ������ʾ(���������ݿ�������Բ���)--> 
		<input type="hidden" name="compositor" id="compositor" value="" />
		<input type="hidden" name="ordertype" id="ordertype" value="" />
		<!-- 
   <div class="titleContent" align="left" style="background:url(<%=resourcepath%>/message/images/bg_title2.gif);height:35px;line-height:35px;vertical-align:middle;">&nbsp;&nbsp;<%=boxname %></div>
	 -->
	<OA:table tableid="tableId" tableclass="table_c">
	<!--
	<OA:thead theadclass="">
	<OA:th name="ѡ���" width="4%" sortType="none" />
     <OA:th name="���" width="7%" sortType="none" />
     -->
	<!-- 
	<OA:th name="������" width="10%" sortType="none" />
	<OA:th name="�ռ���" width="15%" sortType="none" />
	<OA:th name="������" width="10%" sortType="none" />
	<OA:th name="����" width="50%" sortType="none" />
	 -->
	<!-- 
	<OA:th name="����Ϣʱ��" width="15%" sortType="none" />
	<OA:th name="��Ϣ״̬" width="15%" sortType="none" />
	</OA:thead>
	 -->
	<OA:tbody>
	<%int i;
	    for(i=0;i<dataList.size();i++){
	    Data data=dataList.getData(i);
	   %>
	  <tr>
	  
	    <td width="10%"><%=i+1 %></td>
	     
	    <td width="90%" style="text-align: left;"><a href="#;" onClick="read('<%=data.getString("UUID","")%>');"><%=data.getString("MAILTITLE","&nbsp;") %></a></td>
		 
	    </tr>
	  <%} %>
	      <% for(int j=i;j<10;j++)
	           {
	           %>
	           <tr> 
			   <td>&nbsp;</td>
			   <td>&nbsp;</td>
			   
	           </tr>
	           <% 
	           }
	           %> 
	</OA:tbody>
	</OA:table>
	<!--
  <table width="100%">
      <tr style="font-size:12px;background-color: #F7F7F7">
      <td style="padding-left:20px;">ѡ��:
       <a href='#' onclick="num_c=0;selectAll();return false;" onmouseover=this.style.cursor="hand" onmouseout=this.style.cursor="default" >ȫ��</a>
        -
       <a href='#' onclick="seluuidbox('notreaded');return false;" onmouseover=this.style.cursor="hand" onmouseout=this.style.cursor="default" >δ��</a>
        -  
       <a href='#' onclick="seluuidbox('readed');return false;" onmouseover=this.style.cursor="hand" onmouseout=this.style.cursor="default" >�Ѷ�</a>
        -
       <a href='#' onclick="seluuidbox('reverse');return false;" onmouseover=this.style.cursor="hand" onmouseout=this.style.cursor="default" >��ѡ</a>
        -
       <a href='#' onclick="num_c=1;selectAll();return false;" onmouseover=this.style.cursor="hand" onmouseout=this.style.cursor="default" >��ѡ</a>
			</td>
	  <td align="right"></td>
      </tr>
      <tr>
      <td>
		<input type="button" name="Submit22" value="�½�" onclick="<%if(type.equals("duli")) {%>adddl();<%}else{ %>add();<%} %>" class="btn2"/>&nbsp;
		<input type="button" name="Submit22" value="�ظ�" onclick="<%if(type.equals("duli")) {%>restoredl();<%}else{ %>restore();<%} %>" class="btn2"/>
		<input type="button" name="Submit22" value="ɾ��" onclick="_delete();" class="btn2"/>&nbsp; 
		<select name="zcwjj" id="zcwjj" onchange="yidongxj();">
		<option value="">�ƶ���....</option>
		<%for(int j=0;j<yddataMsg.size();j++)
		{
		Data data=yddataMsg.getData(j);
		 %>
		 <option value="<%=data.getString("UUID","") %>"><%=data.getString("NAME","") %></option>
		 <%} %>
		</select>
	</td>
	<td><BZ:page form="srcForm" property="dataMsg"/></td>
      </tr>
  </table>
  -->
</form>
  </body>
</BZ:html>
