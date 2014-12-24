//﻿当有包ID时,先初始化upComId为组件唯一ID
function initUploadedFiles(root,upComId,id,fileName,code,packageid,requestPrefix,firstCol,secondCol,thirdCol,forthCol,titleLength,successMess){
	//截断标题
	var srcFileName = fileName;
	if(titleLength > 0){
		if(fileName.length > 0 && fileName.length > titleLength){
			fileName = fileName.substring(0,titleLength) + "...";
		}
	}
	//用表格显示
	var infoTable = document.getElementById("infoTable"+upComId);
	var row = infoTable.insertRow();
	row.id = id;
	var col1 = row.insertCell();
	var col2 = row.insertCell();
	var col3 = row.insertCell();
	var col4 = row.insertCell();
	col4.align = "right";
	col1.innerHTML = "<img src='"+root+"/uploadComponent/view/images/att_sign.png'/>";
	col2.innerHTML = "<a title='"+srcFileName+"' href='"+root+"/att_upload/Upload."+requestPrefix+"?param=ajaxDownloadAtt&IDANDCODE="+encodeURI(encodeURI(id+","+code))+"'><font size='2'>"+fileName+"</font></a>";
	if(status!=null&&status!=""){
		col3.innerHTML="<font color='green'>"+successMess+"</font>";
	}else{
		col3.innerHTML="<font color='green'>"+successMess+"</font>";
	}
	col4.innerHTML = "<a href='javascript:deleteFileAndDatabase(\""+id+"\",\""+id+","+code+"\",\""+upComId+"\",\""+requestPrefix+"\")'><font size='2'>Del</font></a>";
	col1.style.width=firstCol;
	col2.style.width=secondCol;
	col3.style.width=thirdCol;
	col4.style.width=forthCol;
	
	//初始化图片删除
	var deleteTag = document.getElementById("deleteAtagId_"+upComId);
	if(deleteTag != null && deleteTag != undefined){
		document.getElementById("deleteAtagId_"+upComId).style.display = "block";
		document.getElementById("deleteAtagId_"+upComId).href = "javascript:deleteFileAndDatabase(\""+id+"\",\""+id+","+code+"\",\""+upComId+"\",\""+requestPrefix+"\");flushImageFrame(\""+upComId+"\");";
	}
}

/**
 * 图片上传时需要删除时删除页面中所有多余的附件，即多余的tr，因为上传图片时是上传时删除所有库中图片，
 * 但是页面没做处理，页面相当于还是生成了多个附件代码，所以删除时需要清空，否则显示会有问题
 */
function deleteImgDisplay(upComId){
	alert(document.getElementById("infoTable"+upComId).parentNode.innerHTML);
	document.getElementById("infoTable"+upComId).parentNode.innerHTML = "";
}

//填充附件列表中的list方法
function initUploadedFilesList(root,upComId,id,fileName,code,packageid,requestPrefix,firstCol,secondCol,thirdCol,forthCol,titleLength,listCellStyle){
	//截断标题
	var srcFileName = fileName;
	if(titleLength > 0){
		if(fileName.length > 0 && fileName.length > titleLength){
			fileName = fileName.substring(0,titleLength) + "...";
		}
	}
	//用表格显示
	var infoTable = document.getElementById("infoTable"+upComId);
	var row = infoTable.insertRow();
	row.id = id;
	var col1 = row.insertCell();
	var col2 = row.insertCell();
	//var col3 = row.insertCell();
	//var col4 = row.insertCell();
	//col4.align = "right";
	col1.innerHTML = "<img src='"+root+"/uploadComponent/view/images/att_sign.png'/>";
	col2.innerHTML = "<a title='"+srcFileName+"' style='"+listCellStyle+"' href='"+root+"/att_upload/Upload."+requestPrefix+"?param=ajaxDownloadAtt&IDANDCODE="+encodeURI(encodeURI(id+","+code))+"'>"+fileName+"</a>";
	
	/*if(status!=null&&status!=""){
		col3.innerHTML="<font color='green'>上传完成</font>";
	}else{
		col3.innerHTML="<font color='green'>上传完成</font>";
	}*/
	
	//col4.innerHTML = "<a href='javascript:deleteFileAndDatabase(\""+id+"\",\""+id+","+code+"\",\""+upComId+"\",\""+requestPrefix+"\")'><font size='2'>Del</font></a>";
	col1.style.width=firstCol;
	col2.style.width=secondCol;
	//col3.style.width=thirdCol;
	//col4.style.width=forthCol;
}

function fileQueueError(file, errorCode, message) {
	try {
		//var imageName = "<font color='red'>上传错误</font>";
		var imageName = "<font color='red'>出错</font>";
		var errorName = "";
		if (errorCode === SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED) {
			//errorName = "附件数目超出列表限制!";
			errorName = "超出!";
		}
		
		if (errorName !== "") {
			alert(errorName);
			return;
		}
		
		switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			//imageName = "<font color='red'>文件为零</font>";
			imageName = "<font color='red'>为零</font>";
			break;
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			imageName = "<font color='red'>太大</font>";
			break;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
		default:
			alert(errorName);
			break;
		}
		//addReadyFileInfo(file.id,file.name,imageName,"无法上传",this.upComId,this.firstCol,this.secondCol,this.thirdCol,this.forthCol,this.titleLength);
		addReadyFileInfo(file.id,file.name,imageName,"出错",this.upComId,this.firstCol,this.secondCol,this.thirdCol,this.forthCol,this.titleLength);

	} catch (ex) {
		this.debug(ex);
	}
}

/**
 * 当文件选择对话框关闭消失时，如果选择的文件成功加入上传队列，
 * 那么针对每个成功加入的文件都会触发一次该事件（N个文件成功加入队列，就触发N次此事件）。
 * @param {} file
 * id : string,			    // SWFUpload控制的文件的id,通过指定该id可启动此文件的上传、退出上传等
 * index : number,			// 文件在选定文件队列（包括出错、退出、排队的文件）中的索引，getFile可使用此索引
 * name : string,			// 文件名，不包括文件的路径。
 * size : number,			// 文件字节数
 * type : string,			// 客户端操作系统设置的文件类型
 * creationdate : Date,		// 文件的创建时间
 * modificationdate : Date,	// 文件的最后修改时间
 * filestatus : number		// 文件的当前状态，对应的状态代码可查看SWFUpload.FILE_STATUS }
 */
function fileQueued(file){
	addReadyFileInfo(file.id,file.name,"<img src='"+this.root+"/uploadComponent/view/images/att_sign.png'/>","",this.upComId,this.firstCol,this.secondCol,this.thirdCol,this.forthCol,this.titleLength);
}

function fileDialogComplete(numFilesSelected, numFilesQueued) {
	
	try {
		
		if (numFilesQueued > 0) {
			//自动上传判断;当为单附件时，选中的为多附件时返回
			if(this.autoUpload && this.autoUploadFlag == "1"){
				startUploadFile(this.upComId,this.hiddenProcess);
			}else if(!this.autoUpload){
				document.getElementById('btnUpload'+this.upComId).disabled = "";
			}
		}else{
			if(!this.autoUpload){
				document.getElementById('btnUpload'+this.upComId).disabled = "";
			}
		}
	} catch (ex) {
		this.debug(ex);
	}
}

//上传进度条
function uploadProgress(file, bytesLoaded) {

	if(this.hiddenProcess){
		return;
	}
	
	var fileSize = file.size;
	try{
		//当前上传的总百分比
		var percent = Math.ceil((bytesLoaded / fileSize) * 100);
		
		var progress = new FileProgress(file, bytesLoaded, this.customSettings.upload_target);
		
		//注册取消、停止事件
		//progress.registOnclickEvent(this);
		
		//更新进度
		progress.setProgress(percent, bytesLoaded, fileSize);
		//设置内容
		progress.setToTargetByHtml(this.customSettings.upload_target);
		if (percent === 100) {
			toggleCancel(false,this.customSettings.upload_target,this);
		} else {
			toggleCancel(true,this.customSettings.upload_target,this);
		}
	}catch (ex) {
		this.debug(ex);
	}
}

//上传成功
function uploadSuccess(file, serverData) {
	try {
		addFileInfo(file,this.successMess,serverData,this.upComId,this.requestPrefix,this.titleLength);
		
		//添加图片删除
		//alert(this.upComId);
		var deleteTag = document.getElementById("deleteAtagId_"+this.upComId);
		if(deleteTag != null && deleteTag != undefined){
			document.getElementById("deleteAtagId_"+this.upComId).style.display = "block";
			document.getElementById("deleteAtagId_"+this.upComId).href = "javascript:deleteFileAndDatabase(\""+file.id+"\",\""+serverData+"\",\""+this.upComId+"\",\""+this.requestPrefix+"\");flushImageFrame(\""+this.upComId+"\");";
		}
		
		//隐藏下边的上传进程
		toggleCancel(false,this.customSettings.upload_target,this);
	} catch (ex) {
		this.debug(ex);
	}
}

function addFileInfo(file,message,databaseFileId,upComId,requestPrefix,titleLength){
	var fileName = file.name;
	var srcFileName = fileName;
	//截断标题
	if(titleLength > 0){
		if(fileName.length > 0 && fileName.length > titleLength){
			fileName = fileName.substring(0,titleLength) + "...";
		}
	}

	var row = document.getElementById(file.id);
	row.cells[2].innerHTML = "<font color='green'>"+message+"</font>";
	//清空，重置事件
	row.cells[1].innerHTML = "<a title='"+srcFileName+"' href='att_upload/Upload."+requestPrefix+"?param=ajaxDownloadAtt&IDANDCODE="+encodeURI(encodeURI(databaseFileId))+"'><font size='2'>"+fileName+"</font></a>";
	row.cells[3].innerHTML = "<a href='javascript:deleteFileAndDatabase(\""+file.id+"\",\""+databaseFileId+"\",\""+upComId+"\",\""+requestPrefix+"\")'><font size='2'>Del</font></a>";
}

//删除界面同时删除数据库数据,upComId为组件唯一ID
function deleteFileAndDatabase(fileid,databaseFileId,upComId,requestPrefix){
	//删除附件
	$.ajax({
		type: "post",//请求方式
        url: "att_upload/Upload."+requestPrefix+"?param=ajaxDelAtt&IDANDCODE="+encodeURI(encodeURI(databaseFileId)),
        data: "time=" + new Date().valueOf()  //加上时间戳作为参数，防止IE访问同一地址时使用缓存而不真正的请求服务器
	});
	deleteFile(fileid,upComId);
}

function addReadyFileInfo(fileid,fileName,message,status,upComId,firstCol,secondCol,thirdCol,forthCol,titleLength){
	//截断标题
	var srcFileName = fileName;
	if(titleLength > 0){
		if(fileName.length > 0 && fileName.length > titleLength){
			fileName = fileName.substring(0,titleLength) + "...";
		}
	}

	//用表格显示
	var infoTable = document.getElementById("infoTable"+upComId);
	var row = infoTable.insertRow();
	row.id = fileid;
	var col1 = row.insertCell();
	var col2 = row.insertCell();
	var col3 = row.insertCell();
	var col4 = row.insertCell();
	col4.align = "right";
	//col1.innerHTML = message+" : ";
	col1.innerHTML = message;
	col2.title = srcFileName;
	col2.innerHTML = fileName;
	if(status!=null&&status!=""){
		col3.innerHTML="<font color='red'>"+status+"</font>";
	}else{
		col3.innerHTML="";
	}
	col4.innerHTML = "<a href='javascript:deleteFile(\""+fileid+"\",\""+upComId+"\")'><font size='2'>Del</font></a>";
	col1.style.width=firstCol;
	col2.style.width=secondCol;
	col3.style.width=thirdCol;
	col4.style.width=forthCol;
}

function cancelUpload(){
	alert("cancelUpload called");
	var infoTable = document.getElementById("infoTable");
	var rows = infoTable.rows;
	var ids = new Array();
	if(rows==null){
		return false;
	}
	for(var i=0;i<rows.length;i++){
		ids[i] = rows[i].id;
	}	
	for(var i=0;i<ids.length;i++){
		deleteFile(ids[i],this.upComId);
	}	
}

function deleteFile(fileId,upComId){
	//alert(fileId+":"+upComId);
	//用表格显示
	var infoTable = document.getElementById("infoTable"+upComId);
	var row = document.getElementById(fileId);
	infoTable.deleteRow(row.rowIndex);
	eval("swfu"+upComId).cancelUpload(fileId,false);
	//删除时隐藏进度
	toggleCancel(false, eval("swfu"+upComId).customSettings.upload_target, eval("swfu"+upComId));
	
	
	//如果是图片上传的删除，那么需要删除所有tr内容
	var flag = eval("swfu"+upComId).personalParams.upType;
	var img = eval("swfu"+upComId).personalParams.upTypeImg;
	if(img == flag){
		var len = infoTable.rows.length;
	    for (var i=0;i<len;i++){
	    	infoTable.deleteRow(i);
	    	len=len-1;
	    	i=i-1;
	    }
	}
	
	//追加删除后的方法
	var methods = eval("swfu"+upComId).personalParams.afterDeleteClick;
	if(methods != null && methods != ""){
		eval(methods);
	}
}

//上传完成
function uploadComplete(file) {
	try {
		/*  I want the next upload to continue automatically so I'll call startUpload here */
		if (this.getStats().files_queued > 0) {
			this.startUpload();
		} else {
			//var progress = new FileProgress(file,  this.customSettings.upload_target);
			//progress.setComplete();
			//progress.setStatus("<font color='red'>上传完毕!</b></font>");
			toggleCancel(false, this.customSettings.upload_target,this);
			
			//自动调用加载图片的函数
			if(this.isImage){
				eval("_attImage_"+this.upComId+"();");
			}
			
			//上传完毕后，调用自定义的追加js方法
			if(this.appendOnclick != "" || this.appendOnclick != null){
				eval(this.appendOnclick);
			}
		}
	} catch (ex) {
		this.debug(ex);
	}
}

//上传出错
function uploadError(file, errorCode, message) {
	var imageName =  "<font color='red'>出错!</font>";
	try {
		switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
			try {
				//progress = new FileProgress(file,  this.customSettings.upload_target);
				//progress.setCancelled();
				//progress.setStatus("<font color='red'>取消上传!</font>");
				toggleCancel(false,this.customSettings.upload_target,this);
			}
			catch (ex1) {
				this.debug(ex1);
			}
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			try {
				//progress = new FileProgress(file,  this.customSettings.upload_target);
				//progress.setCancelled();
				//progress.setStatus("<font color='red'>停止上传!</font>");
				toggleCancel(false,this.customSettings.upload_target,this);
			}
			catch (ex2) {
				this.debug(ex2);
			}
		case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
			imageName = "<font color='red'>太大!</font>";
			break;
		default:
			alert(message);
			break;
		}
		addFileInfo(file.id,imageName,this.upComId);
	} catch (ex3) {
		this.debug(ex3);
	}
}


function addImage(src) {
	var newImg = document.createElement("img");
	newImg.style.margin = "5px";

	document.getElementById("thumbnails"+this.upComId).appendChild(newImg);
	if (newImg.filters) {
		try {
			newImg.filters.item("DXImageTransform.Microsoft.Alpha").opacity = 0;
		} catch (e) {
			// If it is not set initially, the browser will throw an error.  This will set it if it is not set yet.
			newImg.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(opacity=' + 0 + ')';
		}
	} else {
		newImg.style.opacity = 0;
	}

	newImg.onload = function () {
		fadeIn(newImg, 0);
	};
	newImg.src = src;
}

/************************************自定义方法************************************/

/**
 * 隐藏或显示
 * @param show
 * @param id
 */
function toggleCancel(show, id, swfu) {
	if(show){
		document.getElementById(id).style.display = "inLine";
	}else{
		$(document.getElementById(id)).fadeOut(1600,function(){
			//初始化进度条中的数据
			document.getElementById(id).innerHTML = "";
		});
	}
};

/**
 * 调用jquery的fadeIn
 * @param id
 */
function fadeInJQ(id,speed){
	$(document.getElementById(id)).fadeIn(speed);
}

/*********************淡入淡出原生js实现方式 开始*********************/
//定义渐隐渐现的基础类
var operrate={
	setOpacity:function(ev,v){
		ev.filters ? ev.style.filter='alpha(opacity='+v+')':ev.style.opacity=v/100; //设置透明度 
	}
};
/**
 * 淡入
 * @param elem 淡入的元素节点对象
 * @param speed 速度
 * @param opacity 透明度（指淡入最终的透明度）
 */
function fadeIn(elem,speed,opacity){
	//elem指定的元素        
	//spee动画的速度        
	//opacityz指定的透明度        
	speed=speed||20;
	//默认为20        
	opacity=opacity||100;
	//默认为100        
	elem.style.display="block";
	//首先将display设为block        
	operrate.setOpacity(elem,0);
	//将透明度设为0.，处于不可见状态        
	var val=0;        
	(function(){            
		operrate.setOpacity(elem,val);            
		val+=5;            
		if(val<opacity){                
			setTimeout(arguments.callee,speed);                            
		}        
	})();
}
/**
 * 淡出
 * @param elem 淡出的节点对象
 * @param speed 速度
 * @param opacity 透明度（指开始淡出的初始透明度）
 */
function fadeOut(elem, speed, opacity){        
	speed = speed || 20;        
	opacity = opacity || 0;
	//初始化透明度变化值为0        
	var val = 100;        
	//循环将透明值以5递减,即淡出效果        
	(function(){            
		operrate.setOpacity(elem, val);            
		val -= 5;
		if (val >= opacity) {                
			setTimeout(arguments.callee, speed);            
		}else if (val < 0) {                
			//元素透明度为0后隐藏元素               
			elem.style.display = 'none';            
		}        
	})();
}

/**
 * 图片删除时需要刷新iframe图片区
 */
function flushImageFrame(upComId){
	var deleteTag = document.getElementById("deleteAtagId_"+upComId);
	if(deleteTag != null && deleteTag != undefined){
		var src = document.getElementById("attImageFrame_"+upComId).src;
		document.getElementById("attImageFrame_"+upComId).src = src;
		document.getElementById("deleteAtagId_"+upComId).style.display = "none";
	}
}
/*********************淡入淡出原生js实现方式 结束*********************/