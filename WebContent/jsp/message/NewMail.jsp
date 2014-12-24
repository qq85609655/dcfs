<%@page import="hx.util.DateUtility"%>
<%@page import="hx.message.MessageService"%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.common.Constants"%>
<%@page import="hx.taglib.TagTools"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String resourcepath=TagTools.getResourcePath(request,"");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Data data=(Data) request.getAttribute("data")==null?new Data():(Data) request.getAttribute("data");
String boxuuid=(String)request.getAttribute("boxuuid");
String fjr=(String)request.getAttribute("fjr");
String name=(String)request.getAttribute("name");
String reloadleftframe=(String)request.getAttribute("reloadleftframe");
Data maildata=(Data) request.getAttribute("maildata")==null?new Data():(Data) request.getAttribute("maildata");
String result=request.getParameter("result")==null?"":(String)request.getParameter("result");
String signname=(String)request.getAttribute("signname");
String sendsuccess=(String)request.getAttribute("sendsuccess");
if(sendsuccess==null){
    sendsuccess="";
}
String sendjg=(String)request.getParameter("sendjg");
if(sendjg==null){
    sendjg="";
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>  
  <BZ:head> 
<meta http-equiv="Content-Type" content="text/html; charset=GBK"/>
<title>新建邮件</title>  
<style type="text/css">
	<!--

    .x-btn1{text-align:left;font-size:16px;background-color:red;}
    .fujian{
	height:20px;
	line-height:20px;
	border-top:1px solid white;
	}
	
   .transparent{
  filter:alpha(opacity=0);
  -moz-opacity:0;
  opacity:0;
  background-color:#000;
	}
	#popdiv{
	position:absolute;
	Z-INDEX:100;
	height:20px;
	}
  -->
    .sjfxx{
	background-color:#FFFFFF; 
	border: solid 1px #C5D7ED; 
	width: 600px; 
	height: 20px; 
	overflow-y: scroll; 
	scrollbar-face-color: #F0F0F0;
	scrollbar-shadow-color: #7F7F7F;
	scrollbar-highlight-color: #F0F0F0;
	scrollbar-3dlight-color: #7F7F7F;
	scrollbar-darkshadow-color: #F0F0F0;
	scrollbar-track-color: #F0F0F0;
	scrollbar-arrow-color: #7F7F7F;
    }
	 .renyuan
	 {
	 float:left;
	 height:20px;
	 font-size:12px;
	 cursor:hand;
	 text-align:center;
	 line-height:20px;
	 }
	  .wenzi
	 {
	 width:150px;
	 height:20px;
	 overflow:hidden;   
	 text-overflow:ellipsis;   
	 white-space:nowrap;
	 font-size:12px;
	 text-align:center;
	 line-height:20px;
	 }
  </style>
<link href="<%=resourcepath%>/message/css/newStyle.css" rel="stylesheet" type="text/css" />
<link href="<%=resourcepath%>/message/css/mail.css" rel="stylesheet" type="text/css" />
<%
  if(reloadleftframe!=null&&reloadleftframe.equals("true")){%>
    <script>
        window.parent.leftFrame.location.reload();
    </script>
<%}%>
    <link rel="stylesheet" type="text/css" href="<%=resourcepath %>/message/css/csi.css"/>
    <script type="text/javascript" charset="utf-8" src="<%=resourcepath%>/message/kindeditor/kindeditor.js"></script>
    <BZ:script isEdit="true"/>
    <script type="text/javascript">
      KE.show({
      id : 'content1',
      cssPath : '<%=resourcepath%>/message/kindeditor/index.css',
       items : [
        'fullscreen','undo', 'redo','removeformat', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
        'insertunorderedlist','insertorderedlist','insertunorderedlist','indent','outdent','date','time','-',
        'print','title','fontname', 'fontsize', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline','specialchar','emoticons']
      
      });
    </script>
<!-- InstanceBeginEditable name="head" -->
<!-- InstanceEndEditable -->
  <style type="text/css">
   body{
   background-color:#F6F9FD;
 
   }
   </style>
  <style type="text/css" rel="stylesheet">
      form {
      margin: 0;
      }
      .editor {
      margin-top: 5px;
      margin-bottom: 5px;
      }
    </style>
<script language="javascript">
<%if(result.equals("true")){%> 
       window.parent.leftFrame.location.reload();
<%}%>

String.prototype.Trim = function() 
{ 
   return this.replace(/(^\s*)|(\s*$)/g, ""); 
} 

String.prototype.LTrim = function() 
{ 
   return this.replace(/(^\s*)/g, ""); 
} 

String.prototype.RTrim = function() 
{ 
   return this.replace(/(\s*$)/g, ""); 
} 


function isamailadd(mailaddress){
   if(mailaddress.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)!=-1){
       return true;
   }else{
       return false;
   }
}

var res_add_str="";//最终的邮件地址 以“;”号分隔

function goodmailstr(addressstr){
   addressstr=addressstr.Trim();
   var addarr=addressstr.split(";");
   for(var i=0;i<addarr.length;i++){
       var address=addarr[i].Trim();
       if(address!=""){
          if(address.length>3){
             firstpos=address.indexOf("(");
             endpos=address.indexOf(")");
             if(firstpos!=-1&&endpos!=-1&&endpos>firstpos+2)
             {
	             address=address.substring(firstpos+1,endpos);
             }
          }
          if(isamailadd(address)){
              if(res_add_str!=""){
                 res_add_str=res_add_str+";"
              }
              res_add_str=res_add_str+address;
          }else{
              return false;
          }
       }
   }
   return true;
}



  var copyforer_obj=document.getElementById("newmsg_copyforer");
  var secret_obj=document.getElementById("newmsg_secret");

var receiverflag="";
var copyforerflag="";
var secretflag="";
var msg = new Hint(false);
function checkmadd(obj,hidobjname){
   if(document.getElementsByName("mail_type")[0].checked){//如果是发邮件 而不是短消息
       if(document.getElementById("newmsg_receiver").value==""){
	      msg.show(obj,"收件人地址必须填写！",0);
	   }else{
	      msg.hide();
	   }
	   if(goodmailstr(obj.value)){
	      //alert('好邮件');
	      document.getElementById(hidobjname).value=res_add_str;
	      if(obj.value!=""){
	        msg.hide(hidobjname=="");
	      }
	      
	      if(hidobjname=="newmsg_receiver2"){
	         receiverflag="true";
	      }else if(hidobjname=="newmsg_copyforer2"){
	         copyforerflag="true";
	      }else if(hidobjname=="newmsg_secret2"){
	         secretflag="true";
	      }
	   }else{
	      msg.show(obj,"错误的邮件格式！",0);
	      if(hidobjname=="newmsg_receiver2"){
	         receiverflag="false";
	      }else if(hidobjname=="newmsg_copyforer2"){
	         copyforerflag="false";
	      }else if(hidobjname=="newmsg_secret2"){
	         secretflag="false";
	      }
	      
	      return false;
	   }
	   
   }
   res_add_str="";
   return true;
}

   
function goback(){
         document.form1.action="<%=path%>/MessageServlet?method=receivemessage&boxuuid=<%=boxuuid%>";
         document.form1.submit();
}



function sendmessage(){
   if(document.getElementById("hzbox").checked){
       document.getElementById("HZ").value="1";
   }else{
       document.getElementById("HZ").value="0";
   }if(document.getElementById("hzbox1").checked){
       document.getElementById("HZ1").value="1";
   }else{
       document.getElementById("HZ1").value="0";
   }
   var send=document.getElementById('newmsg_receiver').value;
   if(send ==""){
	   alert('请选择收件人');
	   return;
   }else if(_check(document.form1)){	  
		   document.getElementById("contenthtml").value=KE.util.getData('content1');
		   document.getElementById("contenttxt").value=KE.util.getPureData('content1');
		   document.form1.action="<%=path%>/MessageServlet?method=sendmessage&fileNum="+fileNum;
		   document.form1.submit();
   }
   
}


var sjrerro=false;
//用于记录用户上传了几个附件
var fileNum=1; 
var totalError=0; 
function fileopen(obj){
	document.getElementById("errorfj").innerHTML="";
	var path=document.getElementById("fileinput"+fileNum).value;
	var patn = /\.exe$|\.js$/i;
	//判断后缀是否正确
	if(path!="" && patn.test(path)){
	//不符合上传类型
		totalError++;
		//Ext.Msg.alert("提示","附件格式只能是**，请您重新选择");
	     document.getElementById("files").innerHTML=document.getElementById("files").innerHTML+"<div class='fujian' id='div"+fileNum+"'><img src='<%=resourcepath%>/message/images/icon_att.gif'/>"+path+"<img src='<%=resourcepath%>/message/images/delete2.gif' width='19' height='19' onclick='delme(this);' style='cursor: pointer;vertical-align: middle;' title='点击删除'/></a> <span style='padding-left:20px;color:red;'>不支持的附件格式</span></div>";	
	}else{
		document.getElementById("files").innerHTML=document.getElementById("files").innerHTML+"<div class='fujian' id='div"+fileNum+"'><img src='<%=resourcepath%>/message/images/icon_att.gif'/>"+path+"<img src='<%=resourcepath%>/message/images/delete2.gif' width='19' height='19' onclick='delme(this);' style='cursor: pointer;vertical-align: middle;' title='点击删除'/></div>";	
	}

	fileNum++;
	var spanId ="divinput"+fileNum;
	var divc=document.createElement("<span id='"+spanId+"'>");
	var tem=document.createElement("<input onpropertychange='fileopen(this);' class='transparent' style='width:5px;' hidefocus='true'/>");
	tem.type="file";
	tem.name="fileinput"+fileNum;
	tem.id="fileinput"+fileNum;
	divc.appendChild(tem);
	var id =obj.id.replace("fileinput","");
	document.getElementById("test").insertBefore(divc,document.getElementById("divinput"+id));
	document.getElementById("divinput"+id).style.display="none";
}

function delme(obj){
	var p=obj.parentNode.parentNode;
	var pr=obj.parentNode;
	var str=pr.id.split("v");
	document.getElementById("test").removeChild(document.getElementById("divinput"+str[1]));
	p.removeChild(pr);
}

function showPop(){
	var x=document.getElementById("fileinput1");
	var obj=document.getElementById("popdiv");
	obj.style.left=getLeft(x);
	obj.style.top=getTop(x);
}
	
//获取元素的纵坐标
function getTop(e){
	var offset=e.offsetTop;
	if(e.offsetParent!=null) offset+=getTop(e.offsetParent);
	return offset;
	}

//获取元素的横坐标
function getLeft(e){
	var offset=e.offsetLeft;
	if(e.offsetParent!=null) offset+=getLeft(e.offsetParent);
	return offset;
} 
function goSelect(objname){
	  mtype="newmsg";
	  var values=showModalDialog('<%=path%>/MessageServlet?method=xzpersontree',null,"status=no;dialogWidth=500px;dialogHeight=600px;scroll=no");
	 if(values&&values.length>0)
	  {
	  var xshtml=document.getElementById(objname).innerHTML;
	  var sjrxm=document.getElementById("newmsg"+objname).value;
	  var sjrid=document.getElementById("newmsg"+objname+"_personuuid").value;
	  for(var i=0;i<values.length;i++){
       xshtml=xshtml+'<span id="'+objname+values[i].value+'" class="renyuan" onmousemove="moover(this);" onmouseout="moout(this)"><span class="wenzi" title="'+values[i].name+'">&nbsp;&nbsp;&nbsp;'+values[i].name+'&nbsp;</span><img  src="<%=resourcepath%>/message/images/cross.gif" title="删除" style="vertical-align:middle;" onclick="shanchury(\''+values[i].value+'\',\''+values[i].name+'\',\''+objname+'\')" />&nbsp;&nbsp;</span>';
	  sjrxm=sjrxm+values[i].name+';';
	  sjrid=sjrid+values[i].value+'<%=Constants.COMMON_DISTANCE_KEY%>';
	  }
	  document.getElementById("newmsg"+objname).value=sjrxm;
	  document.getElementById("newmsg"+objname+"_personuuid").value=sjrid;
	  document.getElementById(objname).innerHTML=xshtml;
	  document.getElementById(objname).scrollTop+=20;
	 }	  
  }

  function moover(obj)
 {
 obj.style.background='#FFFFCC';
 }
 function moout(obj)
 {
  obj.style.background='#FFFFFF';
 }
 function shanchury(id,name,obj)
 { 
  var   el=null;   
  el=document.getElementById(obj+id);   
  el.removeNode(true);   
 var receiver=document.getElementById("newmsg"+obj).value;
 var receiverid=document.getElementById("newmsg"+obj+"_personuuid").value;
 receiver=receiver.replace(name+';',"");
 receiverid=receiver.replace(id+'<%=Constants.COMMON_DISTANCE_KEY%>',"");
 document.getElementById("newmsg"+obj).value=receiver;
 document.getElementById("newmsg"+obj+"_personuuid").value=receiverid;
 }

</script>
  </BZ:head>

<body>
<form name="form1" id="form1" method="post"  Enctype ="multipart/form-data">
<input name="method" type="text" value="" style="display:none"/>
<input type="hidden" name="contenttxt" value=""/>
<input type="hidden" name="contenthtml" value=""/>
  <input type="hidden" name="boxuuid" value="<%=boxuuid %>"/>
  <input type="hidden" name="newmsg_receiver" value="<%if(!data.getString("SENDER","").equals("")){%><%=data.getString("SENDER","")+";"%><%} %>"/>
  <input type="hidden" name="newmsg_copyforer" />
  <input type="hidden" name="newmsg_secret" />
  <input type="hidden" name="newmsg_receiver_personuuid" value="<%if(!data.getString("RECEIVERUUID","").equals("")){%><%=data.getString("RECEIVERUUID","")+Constants.COMMON_DISTANCE_KEY%><%} %>"/>
  <input type="hidden" name="newmsg_copyforer_personuuid"/>
  <input type="hidden" name="newmsg_secret_personuuid" />
<input type="hidden" name="HZ" id="HZ" >
<input type="hidden" name="HZ1" id="HZ1" >
<table width="100%" class="table01" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td colspan=3  id="newmailhead" name="newmailhead" style="border-bottom:#7CA3D4 1px solid;background:#F6F9FD;font-weight:bold;padding-top:10px;font-size: 17px;" height=36>
         发信
      </td>
    </tr>
    <tr>
      <td width="12%">&nbsp;&nbsp;&nbsp;收件人：
        <%
           String sender=maildata.getString("SENDER","");//SENDER是由发件人姓名 + 分隔符 + 发件人邮件地址构成的
	       String senderaddress="",sendername="";
	       if(!sender.equals("")){
	            sendername = sender.split(Constants.COMMON_DISTANCE_KEY)[0];
	            senderaddress = sender.split(Constants.COMMON_DISTANCE_KEY)[1];
	       }
	       senderaddress=MessageService.eqcharfilter(senderaddress); 
        %>
      </td>
      <td width="3%" align="left">
           <img src="<%=resourcepath%>/message/images/vcard.gif" height="14" width="18" style="cursor: pointer;vertical-align: middle;" onclick="goSelect('_receiver');" alt="点击选择收件人"/></td>
      <td width="84%">
         <div id="_receiver" class="sjfxx"><%if(!data.getString("SENDER","").equals("")){%><span id="_receiver<%=data.getString("RECEIVERUUID","") %>" class="renyuan" onmousemove="moover(this);" onmouseout="moout(this)">&nbsp;&nbsp;&nbsp;<%=data.getString("SENDER","") %>&nbsp;<img  src="<%=resourcepath%>/message/images/cross.gif" title="删除" style="vertical-align:middle;" onclick="shanchury('<%=data.getString("RECEIVERUUID","") %>','<%=data.getString("SENDER","")%>','_receiver')" />&nbsp;&nbsp;</span><%} %></div>
         <input type="hidden"  id="newmsg_receiver2" name="newmsg_receiver2"  cols="80" value="" size="80" />
      </td>
    </tr>   
    
    <tr>
      <td>&nbsp;&nbsp;&nbsp;抄送人：</td>
      <td align="left">
         <img src="<%=resourcepath %>/message/images/vcard.gif" height="14" width="18" style="cursor: pointer;vertical-align: middle;" onclick="goSelect('_copyforer');" alt="点击选择抄送人"/>
      </td>
      <td>
         <div id="_copyforer" class="sjfxx"></div>
         <input type="hidden"  name="newmsg_copyforer2" id="newmsg_copyforer2" value="<%=data.getString("COPYFORER","")%>" size="80" />
      </td>
    </tr>
    <tr> 
      <td>&nbsp;&nbsp;&nbsp;密送：</td>
      <td align="left">
         <img src="<%=resourcepath %>/message/images/vcard.gif" height="14" width="18" style="cursor: pointer;vertical-align: middle;" onclick="goSelect('_secret');" alt="点击选择密送人"/>
      </td>
      <td>
        <div id="_secret" class="sjfxx"></div>
        <input type="hidden" name="newmsg_secret2" id="newmsg_secret2" size="80" />
      </td>
    </tr>
    <tr>
      <td>&nbsp;&nbsp;&nbsp;主题：</td>
      <td></td>
      <td>
         <input  id="newmsg_mailtitle"  name="newmsg_mailtitle" type="text" check message="请输入主题" notnull="主题必须填写" value="<%=data.getString("MAILTITLE","")%><%=maildata.getString("MAILTITLE","")%>" size="80" />
      </td>
    </tr>
    <tr id="fsxx">
      <td>&nbsp;&nbsp;&nbsp;发送选项：</td>
      <td></td>
      <td><input name="hzbox" type="checkbox"  />要求回执<input name="hzbox1" type="checkbox"  />独立发送</td>
    </tr>
    <tr>   
      <td></td>
      <td></td>
      <td>
	      <div>
		  <div id="popdiv" style="padding-top:5px;padding-left:0px;">
		   <a>添加附件</a>
		  <span style="color:red;margin-left:50px;" id="errorfj">
		  </span></div>
		  <div id="test" style="Z-INDEX:130;position:absolute;">
		  <span id="divinput1">
		  <input type="file" name="fileinput1" id="fileinput1" onpropertychange="fileopen(this);" class="transparent" style="width:0px;" hidefocus="true"/>
		  </span>
		  </div>
		  </div> <div id="files" style="padding-top:20px;">
		  </div>
	  </td>
    </tr> 
    <tr> 
      <td>&nbsp;&nbsp;&nbsp;内容：</td>
      <td></td>
      <td>
         <table width="100%"><tr>
           <td width="85%" align="left">  
          <div class="editor">
            <textarea id="content1" name="content" style="width:580px;height:250px;visibility:hidden;">
         <%if(data.size()!=0)
	       {%>
	          <br><br><br><br><br><br><br>在<%=data.getString("MESSAGETIME")%>,<%=data.getString("RECEIVER","")%>写到<br><%=data.getString("CONTENT","")%>
	         <%if(signname!=null&&!signname.equals("")){%>
	             <br><div align=right><br><%=signname%></div>
	          <%}
	   %><%}else if(maildata.size()!=0){%>
	          <br><br><br><br><br><br><br>在<%=maildata.getString("MAILTIME")%>,<%=sendername.equals("")?senderaddress:sendername%>写到<br><%=maildata.getString("MAILTEXT","")%>
	          <%if(signname!=null&&!signname.equals("")){%>
	             <br><div align=right><br><%=signname%></div>
	          <%}
	       }else if(signname!=null&&!signname.equals("")){%>
              <br><br><br><br><br><br><br><br><div align=right><br><%=signname%></div>
         <%}%>
           </textarea>
           </div> 
           </td>
           <td width="15%">
           </td>  
           </tr>
           </table>
      </td>
    </tr>
    
    <tr>
      <td></td>
      <td></td>
      <td>
		  <input type="button" name="smessage" id="smessage" value="发送短消息" onclick="sendmessage();" class="extButtonSmall"/>
          <input type="button" name=""  value="取消" onclick="goback();" class="extButtonSmall"/>
      </td>  
    </tr>
  </table> 
</form>
<%
  if(sendsuccess.equals("true")){%>
     <script>
        if(confirm("发送成功,您要继续发送邮件吗？")){
        }else{
           goback();
        }
     </script>
<%}else if(sendsuccess.equals("false")){%>
     <script>
        if(confirm("发送失败,您要继续发送邮件吗？")){
           history.back();
        }else{
           goback();
        }
     </script> 
  <%}
  if(sendjg.equals("big")){%>
     <script>
       alert('上传附件超过规定10M');
     </script> 
  <%} %>
</body>
</html>


