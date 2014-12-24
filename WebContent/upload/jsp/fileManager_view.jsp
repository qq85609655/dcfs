<%@page import="hx.util.Base64Util"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%
String path  = request.getContextPath();
List<Map<String,Object>> list = (List<Map<String,Object>>)request.getAttribute("list");
List<Map<String,String>> type_list = (List<Map<String,String>>)request.getAttribute("type_list");
String PACKAGE_ID =(String)request.getAttribute("PACKAGE_ID");
String ENTITY_NAME =(String)request.getAttribute("ENTITY_NAME");
String BIG_TYPE =(String)request.getAttribute("BIG_TYPE");
String SMALL_TYPE =(String)request.getAttribute("SMALL_TYPE");
String IS_EN =(String)request.getAttribute("IS_EN");
String SMALL_TYPE_CODE =(String)request.getAttribute("SMALL_TYPE_CODE");
String CREATE_USER =(String)request.getAttribute("CREATE_USER");
String ATT_FORMAT =(String)request.getAttribute("ATT_FORMAT");
String ATT_SIZE =(String)request.getAttribute("ATT_SIZE");
String ATT_MORE =(String)request.getAttribute("ATT_MORE");
String PATH_ARGS =(String)request.getAttribute("PATH_ARGS");
String JSONSTR =(String)request.getAttribute("JSONSTR");
if(JSONSTR==null){
    JSONSTR = "";
}
String type =(String)request.getAttribute("type");
if(type==null){
    type = "";
}
String VIEWTYPE =(String)request.getAttribute("VIEWTYPE");
if(VIEWTYPE==null){
    VIEWTYPE = "list";
}
String IS_NAILS =(String)request.getAttribute("IS_NAILS");
if(IS_NAILS==null){
    IS_NAILS = "";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title><%if("true".equals(IS_EN)){ %>file upload<%}else{ %>文件上传<%} %></title>
<meta http-equiv="X-UA-Compatible" content="IE=7,9,10,11">
<meta content="max-age=30" http-equiv="Cache-Control">
<link rel="stylesheet" type="text/css" href="<%=path%>/upload/css/all_icon.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/upload/css/reset.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/upload/css/global.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/upload/css/widget.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/upload/css/toast.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/upload/css/global.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/upload/css/layout2.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/upload/css/upload.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/upload/css/widget_bfca94c.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/upload/css/view.css">
<script type="text/javascript" src="<%=path%>/upload/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/upload/js/popwin.js"></script>
<script>

function tanchuiframe(){
	var vl = document.getElementById("SMALL_TYPE_CODE").value;
	 if(vl==""){
		 alert('请先选择文件分类再进行文件上传');
	 }else{
		 var user = encodeURI(encodeURI("<%=CREATE_USER%>"));
		 var FORMAT = encodeURI(encodeURI("<%=ATT_FORMAT%>"));
		 var PATHARGS = encodeURI(encodeURI("<%=PATH_ARGS%>"));
		 var ATT_MORE = "<%=ATT_MORE%>";
		 var filen = <%=list.size()%> ; 
		 if(ATT_MORE=="1"&&filen==1){
			 alert('目前分类仅支持单文件上传');
		 }else{
			 popWin.showWin("500","300","<%if("true".equals(IS_EN)){ %>file upload<%}else{ %>文件上传<%} %>","iframe","<%=path%>/upload?method=fileupload&PACKAGE_ID=<%=PACKAGE_ID%>&ENTITY_NAME=<%=ENTITY_NAME%>&BIG_TYPE=<%=BIG_TYPE%>&ATT_SIZE=<%=ATT_SIZE%>&ATT_MORE=<%=ATT_MORE%>&IS_NAILS=<%=IS_NAILS%>&SMALL_TYPE_CODE="+vl+"&CREATE_USER="+user+"&ATT_FORMAT="+FORMAT+"&PATH_ARGS="+PATHARGS);
		 }
	}
}
//文件上传页面关闭事件
function _fileUploadclose(){
	document.srcForm.action="<%=path%>/uploadManager";
	document.srcForm.submit();
}

function _changeSMALL_TYPE(smcode){
	document.getElementById("SMALL_TYPE_CODE").value=smcode;
	document.srcForm.action="<%=path%>/uploadManager";
	document.srcForm.submit();
}

function _select(obj){
	var st = document.getElementsByName("fileselect");
	var now_s = obj.checked;
	if(st.length>0){
	   for(var i=0;i<st.length;i++){
		  st[i].checked = now_s;
		  var p = i+1;
          if(now_s){
        	  <%if(!"show".equals(type)) {%>
        	  document.getElementById("delete_id").style.display="inline";
        	  document.getElementById("aselect"+p).style.borderBottom="4px solid #A6CAF0";
        	  <%}%>
        	  document.getElementById("downloadid").style.display="inline";
		  }else{
			  document.getElementById("delete_id").style.display="none";
			  document.getElementById("aselect"+p).style.borderBottom="";
			  document.getElementById("downloadid").style.display="none";
		  }
	   }
	}
}

function _select_c(obj,objname){
	 if(obj.style.borderBottom==""){
		 obj.style.borderBottom="4px solid #A6CAF0";
		 document.getElementById(objname).checked=true;
	 }else{
		 obj.style.borderBottom=""; 
		 document.getElementById(objname).checked=false;
	 }
	 var sfxz = "0";
	 var st = document.getElementsByName("fileselect");
	 if(st.length>0){
		   for(var i=0;i<st.length;i++){
	          if(st[i].checked){
	        	  sfxz = "1";
			  }
		   }
	 }
	 if(sfxz=="1"){
		 <%if(!"show".equals(type)) {%>
		 document.getElementById("delete_id").style.display="inline"; 
		 <%}%>
		 document.getElementById("downloadid").style.display="inline";
	 }else{
		 document.getElementById("delete_id").style.display="none"; 
		 document.getElementById("downloadid").style.display="none";
	 }
}

function _delete(){
	var st = document.getElementsByName("fileselect");
	if(st.length>0){
	 for(var i=0;i<st.length;i++){
		 if(st[i].checked){
			 document.getElementById("DELETEID").value +=st[i].value+"#"; 
		 }
	 }
	 if(confirm('是否确定删除选择的文件？')){
		 document.srcForm.action="<%=path%>/uploadManager?method=delete";
		 document.srcForm.submit();
	 }
    }else{
    	alert('请选择需要删除的文件');
    }
}

function _download(){
	var st = document.getElementsByName("fileselect");
	if(st.length>0){
	 for(var i=0;i<st.length;i++){
		 if(st[i].checked){
			 document.getElementById("DELETEID").value +=st[i].value+"#"; 
		 }
	 }
	 document.srcForm.action="<%=path%>/uploadManager?method=download";
	 document.srcForm.submit();
    }else{
    	alert('请选择需要下载的文件');
    }
}

function _change_view(type){
	document.getElementById("VIEWTYPE").value=type;
	document.srcForm.action="<%=path%>/uploadManager";
	document.srcForm.submit();
}


function _changediv(){
	var he = document.body.scrollHeight-10;
	document.getElementById("modulediv").style.height=he+"px";
}


</script>
</head>
<body onload="_changediv()">
<form name="srcForm" action="<%=path%>/uploadManager" method="post">
<input type="hidden" id="JSON_STR" name="JSON_STR" value="<%=JSONSTR %>"/>
<input type="hidden" id="SMALL_TYPE_CODE" name="SMALL_TYPE_CODE" value="<%=SMALL_TYPE_CODE%>"/>
<input type="hidden" id="PACKAGE_ID" name="PACKAGE_ID" value="<%=PACKAGE_ID%>"/>
<input type="hidden" id="SMALL_TYPE" name="SMALL_TYPE" value="<%=SMALL_TYPE%>"/>
<input type="hidden" id="ENTITY_NAME" name="ENTITY_NAME" value="<%=ENTITY_NAME%>"/>
<input type="hidden" id="BIG_TYPE" name="BIG_TYPE" value="<%=BIG_TYPE%>"/>
<input type="hidden" id="IS_EN" name="IS_EN" value="<%=IS_EN%>"/>
<input type="hidden" id="CREATE_USER" name="CREATE_USER" value="<%=CREATE_USER%>"/>
<input type="hidden" id="PATH_ARGS" name="PATH_ARGS" value="<%=PATH_ARGS%>"/>
<input type="hidden" id="DELETEID" name="DELETEID" />
<input type="hidden" id="type" name="type" value="<%=type%>"/>
<input type="hidden" id="VIEWTYPE" name="VIEWTYPE" value="<%=VIEWTYPE%>"/>
<div id="bd" class="clearfix">
<div id="yao-main">
<div class="yao-b">
<div node-type="module" class="module-toolbar">
<div node-type="bar" class="bar global-clearfix" style="visibility: visible;">
<%if("list".equals(VIEWTYPE)){ %>
<a node-type="btn-view" href="javascript:void(0);" class="view " onclick="_change_view('view')"></a>
<a node-type="btn-list" href="javascript:void(0);" class="list list-selected"></a>
<%}else{ %>
<a node-type="btn-view" href="javascript:void(0);" class="view view-selected"></a>
<a node-type="btn-list" href="javascript:void(0);" class="list" onclick="_change_view('list')"></a>
<%} %>
<%if(!"show".equals(type)) {%>
<span style="position:relative;">
<a href="javascript:void(0);" class="icon-btn-upload" onclick = "tanchuiframe();" style="margin-top:10px;">
<span class="ico"></span>
<span class="text"><%if("true".equals(IS_EN)){ %>file upload<%}else{ %>文件上传<%} %></span></a>
</span>
<%} %>
<span class="ico"></span>
</div>
</div>
<div node-type="module" class="module-crumbs">
<div class="title global-clearfix">
<span node-type="crumbs" class="crumbs">    
<span class="item"><%if("true".equals(IS_EN)){ %><%}else{ %>全部文件<%} %></span></span>
<span node-type="load-num" class="loaded"><%if("true".equals(IS_EN)){ %><%}else{ %>已全部加载，共<%=list.size() %>个<%} %></span>
</div>
</div>
<div node-type="module" class="module-list-view" style="display: block;">
<div node-type="wrapper" class="list-view-home">
<div node-type="title" class="title" style="padding-right: 0px;">       
    <div class="item global-clearfix">
            <!-- 第一列 -->
          <div node-type="title-col" data-key="name" class="col c1" style="width:100%">
                <span node-type="chk-all" class="chk">
                    <input type="checkbox" style="vertical-align:middle;margin-top:12px;" name="all" onclick="_select(this)"/>
                </span>
                <div class="name">
                    <span node-type="order-status" class="asc desc" style="visibility: hidden;"></span>
                    <span id="delete_id" style="display:none;"><input type="button" value="删&nbsp;&nbsp;除" onclick="_delete()" class="btn btn-sm btn-primary"/></span>
                </div>
            </div>
        </div> 
    </div>
     <div node-type="list" class="list" style="overflow: auto;">
     
	<div class="in-qq in-box">
	<% for(int i=1;i<=list.size();i++){ 
      Map<String,Object> map = list.get(i-1);
      if(i%3==0||i==list.size()){
     %>
	  <dd>
	  <div style="display:none"><input type="checkbox" style="vertical-align:middle;margin-top:12px;" name="fileselect" id="fileselect<%=i%>" value="<%=map.get("ID")%>" /></div>
	  <a href="#" onclick="_select_c(this,'fileselect<%=i%>');return false;" id="aselect<%=i%>">
	  <p>
	  <%if("1".equals(map.get("IS_NAILS"))){ %>
	  <img src="<%=path%>/uploadManager?method=img&FILE_ID=<%=map.get("ID")%>&ENTITY_NAME=<%=ENTITY_NAME%>">
	  <%}else{ %>
	  <%if("DOC".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"DOCX".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_doc.png">
	  <%}else if("EXE".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_exe.png">
	  <%}else if("PDF".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_pdf.png">
	  <%}else if("PPT".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"PPTX".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_ppt.png">
	  <%}else if("TXT".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_txt.png">
	  <%}else if("XLS".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"XLSX".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_xls.png">
	  <%}else if("ZIP".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"RAR".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"7Z".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_zip.png">
	  <%}else{%>
	  <img src="<%=path%>/upload/images/other.png">
	  <%} %>
	  <%} %>
	  </p><%=map.get("ATT_NAME") %></a><i></i></dd>
	  </dl>
	   <%}else if(i%3==1){ %>
	   <dl>
	   <dd>
	   <div style="display:none"><input type="checkbox" style="vertical-align:middle;margin-top:12px;" name="fileselect" id="fileselect<%=i%>" value="<%=map.get("ID")%>" /></div>
	   <a href="#" onclick="_select_c(this,'fileselect<%=i%>');return false;" id="aselect<%=i%>">
	   <p>
	   <%if("1".equals(map.get("IS_NAILS"))){ %>
	  <img src="<%=path%>/uploadManager?method=img&FILE_ID=<%=map.get("ID")%>&ENTITY_NAME=<%=ENTITY_NAME%>">
	  <%}else{ %>
	  <%if("DOC".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"DOCX".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_doc.png">
	  <%}else if("EXE".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_exe.png">
	  <%}else if("PDF".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_pdf.png">
	  <%}else if("PPT".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"PPTX".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_ppt.png">
	  <%}else if("TXT".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_txt.png">
	  <%}else if("XLS".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"XLSX".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_xls.png">
	  <%}else if("ZIP".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"RAR".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"7Z".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
	  <img src="<%=path%>/upload/images/view_zip.png">
	  <%}else{%>
	  <img src="<%=path%>/upload/images/other.png">
	  <%} %>
	  <%} %>
	   </p><%=map.get("ATT_NAME") %></a><i></i></dd>
	   <%}else if(i%3==2){ %>
	    <dd>
	    <div style="display:none"><input type="checkbox" style="vertical-align:middle;margin-top:12px;" name="fileselect" id="fileselect<%=i%>" value="<%=map.get("ID")%>" /></div>
	    <a href="#" onclick="_select_c(this,'fileselect<%=i%>');return false;" id="aselect<%=i%>">
	    <p>
		   <%if("1".equals(map.get("IS_NAILS"))){ %>
		  <img src="<%=path%>/uploadManager?method=img&FILE_ID=<%=map.get("ID")%>&ENTITY_NAME=<%=ENTITY_NAME%>">
		  <%}else{ %>
		  <%if("DOC".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"DOCX".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
		  <img src="<%=path%>/upload/images/view_doc.png">
		  <%}else if("EXE".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
		  <img src="<%=path%>/upload/images/view_exe.png">
		  <%}else if("PDF".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
		  <img src="<%=path%>/upload/images/view_pdf.png">
		  <%}else if("PPT".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"PPTX".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
		  <img src="<%=path%>/upload/images/view_ppt.png">
		  <%}else if("TXT".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
		  <img src="<%=path%>/upload/images/view_txt.png">
		  <%}else if("XLS".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"XLSX".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
		  <img src="<%=path%>/upload/images/view_xls.png">
		  <%}else if("ZIP".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"RAR".equals(((String)map.get("ATT_TYPE")).toUpperCase())||"7Z".equals(((String)map.get("ATT_TYPE")).toUpperCase())){ %>
		  <img src="<%=path%>/upload/images/view_zip.png">
		  <%}else{%>
		  <img src="<%=path%>/upload/images/other.png">
		  <%} %>
		  <%} %>
	    </p><%=map.get("ATT_NAME") %></a><i></i>
	    </dd>
	   <%} %>
         <%} %> 
	</div>
    </div>
</div>
</div>
</div>
</div>
<div class="yao-b">
<div node-type="module" class="module-aside aside" id="modulediv"  style="min-height:300px;">
<ul class="b-list-3">
<li node-type="list-item" data-key="all" class="b-list-item <%if("".equals(SMALL_TYPE_CODE)){%>active<%}%>">
<a class="sprite2 b-no-ln" hidefocus="true" href="#" onclick="_changeSMALL_TYPE('');return false;">
<span class="text1">
<span class="img-ico aside-disk"></span>
<%if("true".equals(IS_EN)){ %><%}else{ %>全部文件<%} %></span>
</a>
</li>
<%for(int i=0;i<type_list.size();i++){
    Map<String,String> map = type_list.get(i);
    String realName = "";
    String showName = "";
    if("true".equals(IS_EN)){ 
    	realName=map.get("ENAME");
    	if(realName.length()>14)
        	showName = realName.substring(0,13)+"...";
    	else
    		showName = realName;
    }else{
    	realName=map.get("CNAME");
    	if(realName.length()>7)
        	showName = realName.substring(0,6)+"...";
    	else
    		showName = realName;
    }
 %>
<li node-type="list-item" data-key="doc" class="b-list-item <%if(SMALL_TYPE_CODE.equals(map.get("CODE"))){%>active<%}%>">
<a cat="4" class="b-no-ln" hidefocus="true" href="#" onclick="_changeSMALL_TYPE('<%=map.get("CODE")%>');return false;">
<span class="text1" title="<%=realName %>">
<span class="img-ico aside-mdoc"></span>
<%=showName%>
</span>
</a>
</li>
<%} %>
<li class="b-list-item separator-1">
</li>
</ul>
</div>
</div>
</div>
</form>
</body>
</html>