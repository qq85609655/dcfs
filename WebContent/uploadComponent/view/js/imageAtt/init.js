//﻿定义swfupload组件
function initUpload(id,root,attTypeCode,packageId,uuidForPackageId,requestPrefix,firstColWidth,secondColWidth,thirdColWidth,forthColWidth,autoUpload,titleLength,selectTitle,appendOnclick,hiddenSelectTitle,buttonImage,successMess,unit,personalParams,hiddenProcess,selectTitleWidth,selectTitleHeight,selectTitlePaddingLeft,isImage) {

	//定义swfupload组件初始化的参数对象
	var settings = {};
	
	//初始化附件类型的约束，呈现到界面
	resetUploadParams(root,attTypeCode,id,settings,requestPrefix,selectTitle,hiddenSelectTitle,unit);
	
	if(packageId == "null" || packageId == "" || packageId == null){
		packageId = uuidForPackageId;
	}
	
	// 请求的Servlet地址
	settings.upload_url = root+"/att_upload/Upload."+requestPrefix+"?param=doUpload";
	settings.file_upload_limit = "0";

	// 事件回调设置
	settings.file_queue_error_handler = fileQueueError;
	settings.file_dialog_complete_handler = fileDialogComplete;//选择好文件后提交
	settings.file_queued_handler = fileQueued;
	settings.upload_progress_handler = uploadProgress;
	settings.upload_error_handler = uploadError;
	settings.upload_success_handler = uploadSuccess;
	settings.upload_complete_handler = uploadComplete;
		
	//设置上传框中的图片背景
	if(buttonImage != null && buttonImage != ""){
		if(buttonImage.indexOf("http") < 0 && buttonImage.indexOf("HTTP") < 0){
			settings.button_image_url = root + buttonImage;
		}else{
			settings.button_image_url = buttonImage;
		}
	}else{
		settings.button_image_url = root+"/uploadComponent/view/images/SmallSpyGlassWithTransperancy_17x18.png";
	}
	
	// Button Settings
	settings.button_placeholder_id = "spanButtonPlaceholder"+id;
	settings.button_width = selectTitleWidth==undefined?180:selectTitleWidth;
	settings.button_height = selectTitleHeight==undefined?18:selectTitleHeight;
	settings.button_text_style = '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size= 10pt; }';
	settings.button_text_top_padding = 0;
	settings.button_text_left_padding = selectTitlePaddingLeft==undefined?18:selectTitlePaddingLeft;
	settings.button_window_mode = SWFUpload.WINDOW_MODE.TRANSPARENT;
	settings.button_cursor = SWFUpload.CURSOR.HAND;
	
	// 指定flash目录
	settings.flash_url = root+"/uploadComponent/view/js/swfupload.swf";
	settings.custom_settings = {};
	settings.custom_settings.upload_target = "divFileProgressContainer"+id;
	
	// 调试设置
	settings.debug = false;
				
	//初始化swfupload组件
	var swfu = new SWFUpload(settings,id,requestPrefix,root,firstColWidth,secondColWidth,thirdColWidth,forthColWidth,autoUpload,titleLength,appendOnclick,successMess,personalParams,hiddenProcess,isImage);

	/*不为空那么就查询对应的所有附件显示到首页
	要得到当前附件类型的CODE以便得到附件表名
	--------就算packageId为空，也要先赋值然后执行这里，如果不执行那么有些页面初始化不完整*/
	$.ajax({
		type: "post",//请求方式
		url: root+"/att_upload/Upload."+requestPrefix+"?param=ajaxFindAtts&upload_att_packageid="+encodeURI(encodeURI(packageId))+"&upload_att_smalltype="+encodeURI(encodeURI(personalParams.smallType))+"&upload_att_type_code="+encodeURI(encodeURI(attTypeCode)),
		data: "time=" + new Date().valueOf(),  //加上时间戳作为参数，防止IE访问同一地址时使用缓存而不真正的请求服务器
		async : false, //采用同步方式，否则flash得到ajax返回的数据之前就会初始化
		dataType: "json", //返回数据类型为XML类型
		error: function(rs){
			if(rs.status == '400'){
				alert("未找到目标");
			}else{
				alert("初始化数据出错");
			}
		},
		success: function(rs){  
			//回调函数，参数就是服务器端返回的数据
			var arr = rs.json;
			//循环每个附件类型
			$.each(arr,function(i,n){
				//填充到上传队列
				initUploadedFiles(root,id,n.id,n.fileName,n.code,n.packageId,requestPrefix,firstColWidth,secondColWidth,thirdColWidth,forthColWidth,titleLength,successMess);
			});
		}
	});
		
	//初始化包ID和附件类型到swf对象，防止同一个页面多个附件上传传递的这两个参数冲突
	swfu.code = attTypeCode;
	swfu.packageId = packageId;
	
	//返回
	return swfu;
}

//附件列表初始化方法，这里可以去掉所有的swfupload组件内容 listCellStyle是列表的超链接<a>标签的样式
function initUploadList(id,root,attTypeCode,packageId,uuidForPackageId,requestPrefix,firstColWidth,secondColWidth,thirdColWidth,forthColWidth,autoUpload,titleLength,appendOnclick,listCellStyle,personalParams) {

	//定义swfupload组件初始化的参数对象
	var settings = {};
	
	//初始化附件类型的约束，呈现到界面，最后一个参数为下拉列表的选择标题
	resetUploadParams(root,attTypeCode,id,settings,requestPrefix,"选择文件",false,"兆");
	
	if(packageId == "null" || packageId == "" || packageId == null){
		packageId = uuidForPackageId;
	}
	
	// 请求的Servlet地址
	settings.upload_url = root+"/att_upload/Upload."+requestPrefix+"?param=doUpload";
	settings.file_upload_limit = "0";

	// 事件回调设置
	settings.file_dialog_complete_handler = fileDialogComplete;//选择好文件后提交
	settings.file_queued_handler = fileQueued;
	settings.upload_progress_handler = uploadProgress;
	settings.upload_error_handler = uploadError;
	settings.upload_success_handler = uploadSuccess;
	settings.upload_complete_handler = uploadComplete;
		
	// Button Settings
	settings.button_image_url = root+"/uploadComponent/view/images/SmallSpyGlassWithTransperancy_17x18.png";
	settings.button_placeholder_id = "spanButtonPlaceholder"+id;
	settings.button_width = 180;
	settings.button_height = 18;
	settings.button_text_style = '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size= 10pt; }';
	settings.button_text_top_padding = 0;
	settings.button_text_left_padding = 18;
	settings.button_window_mode = SWFUpload.WINDOW_MODE.TRANSPARENT;
	settings.button_cursor = SWFUpload.CURSOR.HAND;
	
	// 指定flash目录
	settings.flash_url = root+"/uploadComponent/view/js/swfupload.swf";
	settings.custom_settings = {};
	settings.custom_settings.upload_target = "divFileProgressContainer"+id;
	
	// 调试设置
	settings.debug = false;
				
	//初始化swfupload组件
	var swfu = new SWFUpload(settings,id,requestPrefix,root,firstColWidth,secondColWidth,thirdColWidth,forthColWidth,autoUpload,titleLength,appendOnclick,"");

	/*不为空那么就查询对应的所有附件显示到首页
	要得到当前附件类型的CODE以便得到附件表名
	--------就算packageId为空，也要先赋值然后执行这里，如果不执行那么有些页面初始化不完整*/
	$.ajax({
		type: "post",//请求方式
		url: root+"/att_upload/Upload."+requestPrefix+"?param=ajaxFindAtts&upload_att_packageid="+encodeURI(encodeURI(packageId))+"&upload_att_smalltype="+encodeURI(encodeURI(personalParams.smallType))+"&upload_att_type_code="+encodeURI(encodeURI(attTypeCode)),
		data: "time=" + new Date().valueOf(),  //加上时间戳作为参数，防止IE访问同一地址时使用缓存而不真正的请求服务器
		async : false, //采用同步方式，否则flash得到ajax返回的数据之前就会初始化
		dataType: "json", //返回数据类型为XML类型
		error: function(rs){
			if(rs.status == '400'){
				alert("未找到目标");
			}else{
				alert("初始化数据出错");
			}
		},
		success: function(rs){  
			//回调函数，参数就是服务器端返回的数据
			var arr = rs.json;
			//循环每个附件类型
			$.each(arr,function(i,n){
				//填充到上传队列
				initUploadedFilesList(root,id,n.id,n.fileName,n.code,n.packageId,requestPrefix,firstColWidth,secondColWidth,thirdColWidth,forthColWidth,titleLength,listCellStyle);
			});
		}
	});
		
	//初始化包ID和附件类型到swf对象，防止同一个页面多个附件上传传递的这两个参数冲突
	swfu.code = attTypeCode;
	swfu.packageId = packageId;
	
	//返回
	return swfu;
}

//开始上传
function startUploadFile(upComId,hiddenProcess){
	//判断是否存在要上传的文件
	if(eval("swfu"+upComId).getStats().files_queued > 0){
		if(eval("swfu"+upComId).settings.file_queue_limit == '1' && eval("swfu"+upComId).singleAttSuccessedListNumber > 0){
			//为单附件
			alert("请选择文件!");
		}else{
			//显示进度条
			if(!hiddenProcess){
				toggleCancel(true,eval("swfu"+upComId).customSettings.upload_target,eval("swfu"+upComId));
			}
			//开始上传
			eval("swfu"+upComId).startUpload();
			//设置参数附件类型
			eval("swfu"+upComId).addPostParam("CODE",eval("swfu"+upComId).code);
			eval("swfu"+upComId).addPostParam("PACKAGE_ID",eval("swfu"+upComId).packageId);
			eval("swfu"+upComId).addPostParam("DISKSTORE_RULE_PARAMVALUES",eval("swfu"+upComId).personalParams.diskStoreRuleParamValues);
			eval("swfu"+upComId).addPostParam("SMALL_TYPE",eval("swfu"+upComId).personalParams.smallType);
			eval("swfu"+upComId).addPostParam("BIG_TYPE",eval("swfu"+upComId).personalParams.bigType);
			eval("swfu"+upComId).addPostParam("UP_TYPE",eval("swfu"+upComId).personalParams.upType);
		}
	}else{
		alert("请选择文件!");
	}
}

/*
选择一次类型就重置一次swfupload的参数
ajax请求要用同步，如果异步会导致ajax请求得到的数据会在flash加载完后返回，
不能顺利的初始化flash，导致上传的一些限制条件无法添加
*/
function resetUploadParams(root,code,upComId,settings,requestPrefix,selectTitle,hiddenSelectTitle,unit){
	if(code != null && code != ""){
		$.ajax({
			type: "post",//请求方式
			url: root+"/att_upload/Upload."+requestPrefix+"?param=ajaxUploadParams&code="+encodeURI(encodeURI(code)),
			data: "time=" + new Date().valueOf(),    //加上时间戳作为参数，防止IE访问同一地址时使用缓存而不真正的请求服务器
			dataType: "json", //返回数据类型为XML类型
			async : false, //采用同步方式，否则flash将在得到ajax返回的参数之前初始化加载
			error: function(rs){   
				alert("重置上传组件出错");   
			},
			success: function(rs){  //回调函数，参数就是服务器端返回的数据
				var obj = rs.json;
				//重置参数
				settings.file_size_limit = obj.ATT_SIZE+" MB";
				//设置上传单、多方式
				if(obj.ATT_MORE == "1"){
					//单文件上传方式
					settings.button_action = SWFUpload.BUTTON_ACTION.SELECT_FILE;
					settings.file_queue_limit = "1";
				}else{
					//多文件上传方式，此时obj.ATT_MORE = 2
					settings.button_action = SWFUpload.BUTTON_ACTION.SELECT_FILES;
				}
				settings.file_types = obj.ATT_FORMAT;
				//显示内容
				if(obj.ATT_FORMAT == "*.*;"){
					settings.file_types_description = "所有文件";
				}else{
					settings.file_types_description = "文本文档";
				}
				
				//隐藏选择标题
				if(hiddenSelectTitle){
					settings.button_text = "";
				}else{
					settings.button_text = "<span class='button'>"+selectTitle+" <span class='buttonSmall'>(Max "+obj.ATT_SIZE+" "+unit+")</span></span>";
				}
			}
		});
	}else{
		settings.file_size_limit = "1000 MB";
		settings.file_types = "*.*";
		settings.file_types_description = "所有文件";
		
		//隐藏选择标题
		if(hiddenSelectTitle){
			settings.button_text = "";
		}else{
			settings.button_text = "<span class='button'>"+selectTitle+" <span class='buttonSmall'>(Max 1000 "+unit+")</span></span>";
		}
	}
}