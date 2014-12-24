<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
 <%
 String path  = request.getContextPath();
 String PACKAGE_ID =(String)request.getAttribute("PACKAGE_ID");
 String ENTITY_NAME =(String)request.getAttribute("ENTITY_NAME");
 String BIG_TYPE =(String)request.getAttribute("BIG_TYPE");
 String SMALL_TYPE_CODE =(String)request.getAttribute("SMALL_TYPE_CODE");
 String CREATE_USER =(String)request.getAttribute("CREATE_USER");
 String ATT_FORMAT =(String)request.getAttribute("ATT_FORMAT");
 String ATT_SIZE =(String)request.getAttribute("ATT_SIZE");
 String ATT_MORE =(String)request.getAttribute("ATT_MORE");
 String PATH_ARGS =(String)request.getAttribute("PATH_ARGS");
 String IS_NAILS =(String)request.getAttribute("IS_NAILS");
 String IS_EN =(String)request.getAttribute("IS_EN");
 ATT_FORMAT = ATT_FORMAT.replaceAll("\\|\\|", ";");
 
 String btnAdd1 = "添加多文件";
 String btnAdd2 = "添加单文件";
 String btnPause = "暂停上传";
 String btnContinue = "开始上传"; 
 String btnReflesh = "刷新"; 
 
 String alert01 = "个文件正在上传";
 String alert02 = "支持格式";
 String alert03 = "文件尺寸：每个文件小于";
 String alert04 = "上传/分析进度";
 String alert05 = "文件正在上传中,您确认要关闭吗";
 String alert06 = " 的大小大于"+ATT_SIZE+"M，请选择"+ATT_SIZE+"M以下的文件";
 if("true".equals(IS_EN)){
	 btnAdd1 = "Add";
	 btnAdd2 = "Add";
	 btnPause = "Pause";
	 btnContinue = "Continue"; 
	 btnReflesh = "Refresh"; 
	 alert01 = "files are uploaded";
	 alert02 = "Supported formats";
	 alert03 = "File size: each files smaller than";
	 
	 alert04=" Upload / progress analysis";
	 alert05 = "The file is uploaded, are you sure you want to close it?";
	 alert06 = "File size limit exceeded";

 }
 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link rel="stylesheet" href="<%=path %>/upload/css/style.css" media="screen" type="text/css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/upload/css/upload.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/upload/css/all_icon.css">
<style type="text/css">
#AllFilesInfo .single-upload-item {
	height: 40px; border-bottom-color: rgb(217, 217, 217); border-bottom-width: 1px; border-bottom-style: solid; position: relative;
}
#AllFilesInfo .single-upload-item .bg-progress {
	left: 0px; top: 0px; height: 40px; position: absolute; background-color: rgb(228, 242, 234);
}
#AllFilesInfo .single-upload-item .upload-item-info-line {
	overflow: hidden; margin-right: 10px; margin-left: 10px; vertical-align: middle; position: absolute; _margin-top: 18px; _padding-bottom: 2px;
}
#AllFilesInfo .single-upload-item .upload-file-title-line {
	width: 333px;
}
#AllFilesInfo .single-upload-item .upload-file-title-line .ic {
	_margin-right: 3px;
}
#AllFilesInfo .single-upload-item .upload-file-title-line .upload-file-title {
	width: 250px; overflow: hidden; white-space: nowrap; -ms-text-overflow: ellipsis; _line-height: 1;
}

.ib {
	vertical-align: middle; display: inline-block; position: relative;
}

.ic {
	vertical-align: -3px;
}



</style>

<script type="text/javascript" src='<%=path %>/upload/js/jquery.js'></script>
<title>上传文件</title>
<script type="text/javascript" language="JavaScript">

	//提示用户选择文件并上传。参数说明是否允许选择多个文件
	function AddAndUpload(isMulti)
	{
		try
		{
			AddLocalFile(isMulti);
			BeginSaveToURL();
		}
		catch(err)
		{
			if(document.all("Ntko.LargeFileUploader").StatusCode == 10)
			{
				//用户取消
			}
			else
			{
				alert("err：" + err.number + ":" + err.description);
			}
		}
	}
	function AddLocalFile(isMulti)
	{
		try
		{  
			if(!isMulti&&document.all("Ntko.LargeFileUploader").FilesCount==1){
				alert("目前为单文件上传模式,无法选择多个上传文件");
			}else{
				document.all("Ntko.LargeFileUploader").AddLocalFile("",isMulti,"<%=ATT_FORMAT%>");
				BeginSaveToURL();
			}
		}
		catch(err)
		{
			if(document.all("Ntko.LargeFileUploader").StatusCode == 10)
			{
				//用户取消
			}
			else
			{
				alert("err：" + err.number + ":" + err.description);
			}
		}
	}
	function BeginSaveToURL()
	{
		 var user = encodeURI(encodeURI("<%=CREATE_USER%>"));
		 var PATHARGS = encodeURI(encodeURI("<%=PATH_ARGS%>"));
		blocksProcessURL = "<%=path%>/upload?method=savefileblocks&PACKAGE_ID=<%=PACKAGE_ID%>&ENTITY_NAME=<%=ENTITY_NAME%>&BIG_TYPE=<%=BIG_TYPE%>&SMALL_TYPE_CODE=<%=SMALL_TYPE_CODE%>&CREATE_USER="+user+"&PATH_ARGS="+PATHARGS;
		blocksFileField = "NTKO_LF_BLOCK";
		//注意以下两个属性是必须设定的
		document.all("Ntko.LargeFileUploader").QueryFileStatusURL="<%=path%>/upload?method=filestatus&PACKAGE_ID=<%=PACKAGE_ID%>&ENTITY_NAME=<%=ENTITY_NAME%>&BIG_TYPE=<%=BIG_TYPE%>&SMALL_TYPE_CODE=<%=SMALL_TYPE_CODE%>&CREATE_USER="+user+"&PATH_ARGS="+PATHARGS;
		document.all("Ntko.LargeFileUploader").FinishedUploadURL="<%=path%>/upload?method=finishedupload&PACKAGE_ID=<%=PACKAGE_ID%>&ENTITY_NAME=<%=ENTITY_NAME%>&BIG_TYPE=<%=BIG_TYPE%>&SMALL_TYPE_CODE=<%=SMALL_TYPE_CODE%>&IS_NAILS=<%=IS_NAILS%>&CREATE_USER="+user+"&PATH_ARGS="+PATHARGS;
		document.all("Ntko.LargeFileUploader").BeginSaveToURL(blocksProcessURL,blocksFileField,"QiTa=其他用户表单数据2");
	}
	function StopSaveToURL()
	{
		document.all("Ntko.LargeFileUploader").StopSaveToURL();
	}
	function ResetControl()
	{
		try
		{
			document.all('Ntko.LargeFileUploader').Reset();
			document.all("AllFilesInfo").innerHTML = "";
		}
		catch(err)
		{
			alert("err：" + err.number + ":" + err.description);
		}
	}
	function alertAllFiles()
	{
		var obj = document.all("Ntko.LargeFileUploader");
		if (obj.FilesCount == 0)
		{
			alert("没有文件.");
		}
		else
		{
			for(i=0;i<obj.FilesCount;i++)
			{
				fileObj = obj.GetFile(i);
				alert(fileObj.FilePath+":\r\n大小:"+formatSize(fileObj.FileSize)+"字节");
			}
		}
	}
	function alertAllRetMessage()
	{
		var obj = document.all("Ntko.LargeFileUploader");
		alert("LastQueryStatusRetMes=\r\n" + obj.LastQueryStatusRetMes);
		alert("LastFinishedUploadRetMes=\r\n" + obj.LastFinishedUploadRetMes);
		for(i=0;i<5;i++)
		{
			alert("GetLastUploadRetMes(" + i +")=\r\n" + obj.GetLastUploadRetMes(i));
		}
	}
	function beforeCloseAsk()
	{
		var obj = document.all("Ntko.LargeFileUploader");
		if(obj.IsUploading)
		{
			event.returnValue = "<%=alert05%>";
		}
	}
	function formatSize(fsize)
	{
		re=/(\d{1,3})(?=(\d{3})+(?:$|\.))/g;
		return fsize.toString().replace(re,"$1,");
	}
	var filenum = 1;
	
	function _change(){
		if(document.getElementById("stop_savetourl").style.display == "none"){
			document.getElementById("stop_savetourl").style.display = "";
		}else{
			document.getElementById("stop_savetourl").style.display = "none";
		}
		if(document.getElementById("begin_savetourl").style.display == "none"){
			document.getElementById("begin_savetourl").style.display = "";
		}else{
			document.getElementById("begin_savetourl").style.display = "none";
		}
	}
	
</script>
</head>
<body onbeforeunload="beforeCloseAsk();">
<input type="hidden" id="nowfileid" name="nowfileid" value="1"/>
<div style="height: 5px"></div>
<!-- button area:start -->
<table width="100%">
	<tr>
		<td style="height:30px;">
		<%if("1".equals(ATT_MORE)){ %>
		<input type="button" value="<%=btnAdd1 %>" alt="可以选择单个文件进行上传" onclick="AddLocalFile(false);" class="btn btn-sm btn-primary"/>&nbsp;&nbsp;
		<%}else{ %>
		<input type="button" value="<%=btnAdd2 %>" alt="可以选择多个文件进行上传" onclick="AddLocalFile(true);" class="btn btn-sm btn-primary"/>&nbsp;&nbsp;
		<%} %>
		<input type="button" value="<%=btnPause %>" alt="暂停上传" onclick="_change();StopSaveToURL();"  class="btn btn-sm btn-primary" id="stop_savetourl"/>
		<input type="button" value="<%=btnContinue %>" alt="开始上传" onclick="_change();BeginSaveToURL();"  class="btn btn-sm btn-primary" id="begin_savetourl" style="display:none"/>
		&nbsp;&nbsp;

		<!-- <input type="button" value="<%=btnReflesh %>" alt="可以选择多个文件进行上传" onclick="document.location.reload();" class="btn btn-sm btn-primary"/>-->
		</td>
		<td style="font-size:12px;"><span id="upload_file_num">0 </span> <%=alert01 %></td>

	</tr>
</table>
<!-- button area:end -->
<div style="height: 5px"></div>
<div style="height: 1px;background-color: #ccc"></div>

<div style="height:280px;overflow: auto;">
	
<div id="AllFilesInfo" style="width:100%">
</div>
</div>
<div style="height: 5px"></div>
<div style="height: 1px;background-color: #ccc"></div>
<table style="font-size:12px;background-color:#EEE;width: 100%">
	<tr style="height:30px">
		<td style="width:5%;vertical-align: bottom;">&nbsp;<img src="<%=path%>/resource/images/bs_gray_icons/info-sign.png"></td><td><b><%=alert03 %> <span style="font-size:20px;color: red "><%= ATT_SIZE%></span> M</b></td>
	</tr>
	<tr style="height:30px">
		<td></td>
		<td><%=alert02 %>：<b><%=ATT_FORMAT %></b></td>
	</tr>
</table>


    <script type="text/javascript" language ="javascript" src="<%=path %>/resource/bigfileuploadcontrol/ntkogenUploaderObj.js"></script>
	<script language="JScript" for="Ntko.LargeFileUploader" event="OnLocalFileAdded(fullname,fname,fsize)">
	    
		//var ml = "
		//<div class=\"skillbar clearfix\" data-percent=\"100%\" id=\"skillbar"+filenum+"\">		
		//<div class=\"skillbar-bar\" style=\"background: #4288d0;\"></div>
		//<div class=\"skill-bar-percent\" id=\"skill-bar-percent"+filenum+"\" >"+fname+"(上传/分析进度0%)</div>
		//</div>"
	
		var arrList = fullname.split(".");
        var fileType = arrList[arrList.length-1];
        
		var newHtml = "<li class=\"single-upload-item\" data-percent=\"100%\" id=\"skillbar"+filenum+"\">"; 
		newHtml +="<div class=\"bg-progress\" style=\"width: 0%;\"></div>"
		newHtml +="<p class=\"upload-item-info-line\">";
		newHtml +="<span class=\"upload-file-title-line ib\">  ";
		//newHtml +="<b class=\"ic ic-xlsx\"> </b> ";
		newHtml +="<span class=\"ico global-icon-16 global-icon-16-"+fileType+"\" style=\"vertical-align: middle; \"></span>";
		newHtml +="<span title=\""+fname+"\" class=\"upload-file-title ib\">"+fname+"</span> </span> ";
		newHtml +="<span class=\"single-upload-msg\" id=\"skill-bar-percent"+filenum+"\" >(<%=alert04 %>    0%)</span> </p> </li>";

		document.all("AllFilesInfo").innerHTML += newHtml;
		$("#upload_file_num").html(filenum);
		filenum++;
	    //document.getElenemtById("filetpid").value=filenum;

	</script>
	<script language="JScript" for="Ntko.LargeFileUploader" event="OnStatusChange(mes,code)">
	
	</script>
	<script language="JScript" for="Ntko.LargeFileUploader" event="OnFileProcessStatusChange(AttachFile,mes,isPersent,Persent)">
	if(isPersent)
	{
		var num = document.getElementById("nowfileid").value;
		//document.all("skill-bar-percent"+num).innerHTML = AttachFile.FileName+"(上传/分析进度"+Persent + "%"+")" ;
		document.all("skill-bar-percent"+num).innerHTML = "(<%=alert04 %>"+Persent + "%"+")" ;
		//document.all("skillbar"+num).setAttribute("data-percent",Persent + "%");
		
		$('#skillbar'+num).each(function(){
			//$(this).find('.skillbar-bar').animate({
			//	width:$(this).attr('data-percent')
			//},1);
			var totalWidth =  parseInt($('#skillbar'+num).css("width"));
			$(this).find('.bg-progress').css("width",Persent*totalWidth/100);
			alert($(this).find('.bg-progress').css());
		});
	}
	</script>
	<script language="JScript" for="Ntko.LargeFileUploader" event="OnManagerStatusChange(mes,isPersent,Persent)">
	if(isPersent)
	{
	}
	</script>
	
	<script language="JScript" for="Ntko.LargeFileUploader" event="BeforeFileAdded(fullname,fname,fsize)">
	var dx = parseInt('<%=ATT_SIZE %>');
	if(fsize>dx*1024*1024)
	{
		alert(fullname + " <%=alert06%>");
		CancelLastCommand = true;
	}
	</script>
	
	<script language="JScript" for="Ntko.LargeFileUploader" event="OnOneFileUploadFinished(AttachFile,IsAllUploaded)">
	if(IsAllUploaded){
		var num = parseInt(document.getElementById("nowfileid").value);
		document.getElementById("nowfileid").value = num+1;
	}
	</script>
	<script language="JScript" for="Ntko.LargeFileUploader" event="OnSaveToURLFinished(IsAllUploaded)">
		if(IsAllUploaded)
		{
		}
	</script>
</body>
</html>