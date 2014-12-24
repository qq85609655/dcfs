/* ******************************************
 *	FileProgress Object
 *	Control object for displaying file info
 * ****************************************** */

function FileProgress(file, bytesLoaded, targetID) {
	this.fileProgressID = file.id + "Ω" + targetID;
	var percent = Math.ceil((bytesLoaded / file.size) * 100);
	this.fileProgressWrapper = document.getElementById(this.fileProgressID);
	if (!this.fileProgressWrapper) {
		//外层table
		this.fileProgressWrapper = document.createElement("table");
		this.fileProgressWrapper.className = "progressTable";
		this.fileProgressWrapper.setAttribute("cellpadding","0");
		this.fileProgressWrapper.setAttribute("cellspacing","0");
		this.fileProgressWrapper.id = this.fileProgressID;
		
		//第一行,上传文件+名称
		var firstLine = document.createElement("tr");
		var firstLineTd1 = document.createElement("td");
		firstLineTd1.className = "progressCommTitle";
		firstLineTd1.id = "up_name_title";
		firstLineTd1.innerHTML = "上传文件：";
		var firstLineTd2 = document.createElement("td");
		firstLineTd2.className = "progressCommValue";
		firstLineTd2.title = file.name;
		firstLineTd2.id = "up_name_value";
		firstLineTd2.innerHTML = file.name;
		//关系
		firstLine.appendChild(firstLineTd1);
		firstLine.appendChild(firstLineTd2);
		
		//第二行,进度当前大小/总大小
		var secondLine = document.createElement("tr");
		var secondLineTd1 = document.createElement("td");
		secondLineTd1.className = "progressCommTitle";
		secondLineTd1.id = "up_progress_title";
		secondLineTd1.innerHTML = "进度：";
		var secondLineTd2 = document.createElement("td");
		secondLineTd2.className = "progressCommValue";
		secondLineTd2.id = "up_progress_value";
		//计算大小部分
		var curKb = bytesLoaded/1024;
		var curMb = 0;
		if(curKb > 1024){
			curMb = curKb/1024;
		}
		var curStr = Math.round(curMb) > 0 ? Math.round(curMb) + "MB" : Math.round(curKb) + "KB";
		
		var tolKb = file.size/1024;
		var tolMb = 0;
		if(tolKb > 1024){
			tolMb = tolKb/1024;
		}
		var tolStr = Math.round(tolMb) > 0 ? Math.round(tolMb) + "MB" : Math.round(tolKb) + "KB";
		//计算结束
		secondLineTd2.innerHTML = curStr + "/" + tolStr;
		//关系
		secondLine.appendChild(secondLineTd1);
		secondLine.appendChild(secondLineTd2);
		
		//第三行 速度
		//TODO
		
		//第四行 剩余时间
		//TODO
		
		//第五行 进度条
		var fifthLine = document.createElement("tr");
		var fifthLineTd = document.createElement("td");
		fifthLineTd.setAttribute("colspan","2");
		fifthLineTd.className = "progressLine";
		fifthLineTd.id = "up_progress_core";
		var fifthLineDiv = document.createElement("div");
		fifthLineDiv.className = "core";
		fifthLineDiv.style.width = percent + "%";
		fifthLineDiv.innerHTML = percent + "%";
		//关系
		fifthLineTd.appendChild(fifthLineDiv);
		fifthLine.appendChild(fifthLineTd);
		
		//第六行,上传文件+名称
		var sixLine = document.createElement("tr");
		var sixLineTd1 = document.createElement("td");
		sixLineTd1.className = "progressScTitle";
		sixLineTd1.id = "up_stop_title";
		var sixLineTd1A = document.createElement("a");
		sixLineTd1A.href = "javaScript:void(0);";
		sixLineTd1A.innerHTML = "停止上传";
		var sixLineTd2 = document.createElement("td");
		sixLineTd2.className = "progressScTitle";
		sixLineTd2.id = "up_cancel_value";
		var sixLineTd2A = document.createElement("a");
		sixLineTd2A.href = "javaScript:void(0);";
		sixLineTd2A.innerHTML = "取消上传";
		//关系
		sixLineTd1.appendChild(sixLineTd1A);
		sixLineTd2.appendChild(sixLineTd2A);
		sixLine.appendChild(sixLineTd1);
		sixLine.appendChild(sixLineTd2);
		
		//总关系
		this.fileProgressWrapper.appendChild(firstLine);
		this.fileProgressWrapper.appendChild(secondLine);
		this.fileProgressWrapper.appendChild(fifthLine);
		//停止和取消
		//this.fileProgressWrapper.appendChild(sixLine);
		
		//淡出
		//fadeInJQ(targetID,1000);
	} else {
		this.fileProgressWrapper.getElementsByTagName("tr")[0].getElementsByTagName("td")[1].innerHTML = file.name;
	}
}

/**
 * 更新进度条数据
 */
FileProgress.prototype.setProgress = function (percentage, bytesLoaded, fileSize) {
	//计算大小部分
	var curKb = bytesLoaded/1024;
	var curMb = 0;
	if(curKb > 1024){
		curMb = curKb/1024;
	}
	var curStr = Math.round(curMb) > 0 ? Math.round(curMb) + "MB" : Math.round(curKb) + "KB";
	
	var tolKb = fileSize/1024;
	var tolMb = 0;
	if(tolKb > 1024){
		tolMb = tolKb/1024;
	}
	var tolStr = Math.round(tolMb) > 0 ? Math.round(tolMb) + "MB" : Math.round(tolKb) + "KB";
	//结束计算
	this.fileProgressWrapper.getElementsByTagName("tr")[1].getElementsByTagName("td")[1].innerHTML = curStr + "/" + tolStr;
	this.fileProgressWrapper.getElementsByTagName("tr")[2].getElementsByTagName("div")[0].style.width = percentage + "%";
	this.fileProgressWrapper.getElementsByTagName("tr")[2].getElementsByTagName("div")[0].innerHTML = percentage + "%";
};

FileProgress.prototype.setComplete = function () {
	

};

FileProgress.prototype.setError = function () {


};

FileProgress.prototype.setCancelled = function () {
/*	this.fileProgressSizeSpanright.innerHTML = "";
	this.fileProgressLineCore.style.width = "0%";
	this.fileProgressLineCore.innerHTML = "0%";*/

};
FileProgress.prototype.setStatus = function (status) {
	this.fileProgressWrapper.childNodes[0].childNodes[1].innerHTML = status;
};

FileProgress.prototype.setToTarget = function (id) {
	document.getElementById(id).appendChild(this.fileProgressWrapper);
};

FileProgress.prototype.setToTargetByHtml = function (id) {
	document.getElementById(id).innerHTML = this.fileProgressWrapper.outerHTML;
};

FileProgress.prototype.registOnclickEvent = function (swfuploadInstance) {
	if (swfuploadInstance) {
		var fileID = this.fileProgressID;
		var fileId = "";
		if(fileID != null && fileID != "" && fileID.indexOf("Ω") > 0){
			fileId = fileID.split("Ω")[0];
		}
		if(fileId != null && fileId != ""){
			
			//存在问题，无法调用---------------
			this.fileProgressWrapper.getElementsByTagName("tr")[3].getElementsByTagName("td")[1].firstChild.onclick = function(){
				this.cancelFileUpload(fileId,swfuploadInstance);
			};
		}
		
		//停止
		//存在问题，无法调用-----------------
		this.fileProgressWrapper.getElementsByTagName("tr")[3].getElementsByTagName("td")[0].firstChild.onclick = function(){
			this.stopFileUpload(swfuploadInstance);
		};
	}
};

FileProgress.prototype.cancelFileUpload = function (id,swfu) {
	alert(swfu.singleAttSuccessedListNumber);
	swfu.cancelUpload(id);
	return false;
};

FileProgress.prototype.stopFileUpload = function (swfu) {
	alert(swfu.singleAttSuccessedListNumber);
	swfu.stopUpload();
	return false;
};