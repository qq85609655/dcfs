//附件类型格式初始化
function att_type_format_init(root,requestPrefix){
	var node = $("#att_type_format");
	$.ajax({
		type: "post",//请求方式
        url: root+"/att_type/AttType."+requestPrefix+"?param=ajaxFormat",
        data: "time=" + new Date().valueOf(),    //加上时间戳作为参数，防止IE访问同一地址时使用缓存而不真正的请求服务器
        dataType: "xml", //返回数据类型为XML类型
        error: function(xml){   
        	alert("加载xml配置文件出错");   
    		},
        success: function(xml){  //回调函数，参数就是服务器端返回的数据
    		var arr = $(xml).find("format");
    		var tr = "";
    		arr.each(function(i){   
    			var value = $(this).attr("value");
    			var name = $(this).attr("name");
    			
    			if(i == 0){
    				tr += "<tr>";
    			}
    			
    			tr += "<td width='25%' align='left' valign='middle'><input type='checkbox' name='ATT_FORMAT' id='ATT_FORMAT_"+i+"' value='"+value+"'>"+name+"</td>"
    			
    			if((i+1)%4 == 0 || (i+1) == arr.length){
    				tr += "</tr>";
    				node.append(tr);
    				tr = "<tr>";
    			}
            });
    	}
	});
}

//附件类型格式初始化
function att_type_format_init2(root, attFormat, requestPrefix){
	var formatList = attFormat.split("|");
	var node = $("#att_type_format");
	$.ajax({
		type: "post",//请求方式
        url: root+"/att_type/AttType."+requestPrefix+"?param=ajaxFormat",
        data: "time=" + new Date().valueOf(),    //加上时间戳作为参数，防止IE访问同一地址时使用缓存而不真正的请求服务器
        dataType: "xml", //返回数据类型为XML类型
        error: function(xml){   
        	alert("加载xml配置文件出错");   
    		},
        success: function(xml){  //回调函数，参数就是服务器端返回的数据
    		var arr = $(xml).find("format");
    		var tr = "";
    		arr.each(function(i){   
    			var value = $(this).attr("value");
    			var name = $(this).attr("name");
    			
    			if(i == 0){
    				tr += "<tr>";
    			}
    			
    			var flag = false;
    			for(var j = 0 ; j < formatList.length; j++){
    				if(formatList[j] == value){
    					flag = true;
    					break;
    				}
    			}
    			
    			if(flag){
    				tr += "<td width='25%' align='left' valign='middle'><input checked='checked' type='checkbox' name='ATT_FORMAT' id='ATT_FORMAT_"+i+"' value='"+value+"' >"+name+"</td>"
    			}else{
    				tr += "<td width='25%' align='left' valign='middle'><input type='checkbox' name='ATT_FORMAT' id='ATT_FORMAT_"+i+"' value='"+value+"'>"+name+"</td>"
    			}
    			
    			if((i+1)%4 == 0 || (i+1) == arr.length){
    				tr += "</tr>";
    				node.append(tr);
    				tr = "<tr>";
    			}
            });
    	}
	});
}
//磁盘存储规则初始化
function att_type_diskrule_init(root,requestPrefix){
	var node = $("#FILE_SORT_WEEK");
	$.ajax({
		type: "post",//请求方式
		url: root+"/att_type/AttType."+requestPrefix+"?param=ajaxFormat",
		data: "time=" + new Date().valueOf(),    //加上时间戳作为参数，防止IE访问同一地址时使用缓存而不真正的请求服务器
		dataType: "xml", //返回数据类型为XML类型
		error: function(xml){   
			alert("加载xml配置文件出错");   
		},
		success: function(xml){  //回调函数，参数就是服务器端返回的数据
			var arr = $(xml).find("diskStoreRule");
			var option = "";
			arr.each(function(i){   
				var value = $(this).attr("value");
				var name = $(this).attr("name");
				option += "<option value='"+value+"'>"+name+"</option>";
			});
			node.append(option);			
		}
	});
}

function att_type_diskrule_init2(root, diskRule, requestPrefix){
	var node = $("#FILE_SORT_WEEK_NOSUB");
	$.ajax({
		type: "post",//请求方式
        url: root+"/att_type/AttType."+requestPrefix+"?param=ajaxFormat",
        data: "time=" + new Date().valueOf(),    //加上时间戳作为参数，防止IE访问同一地址时使用缓存而不真正的请求服务器
        dataType: "xml", //返回数据类型为XML类型
        error: function(xml){   
        	alert("加载xml配置文件出错");   
    	},
        success: function(xml){  //回调函数，参数就是服务器端返回的数据
    		var arr = $(xml).find("diskStoreRule");
    		var option = "";
    		arr.each(function(i){   
    			var value = $(this).attr("value");
				var name = $(this).attr("name");
				if(value == diskRule){
					option += "<option value='"+value+"' selected='selected'>"+name+"</option>";
				}else{
					option += "<option value='"+value+"'>"+name+"</option>";
				}
            });
    		node.append(option);
    	}
	});
}

// 初始化对接应用程序名称
function initApplicationNames(root,requestPrefix){
	var appName = $("#APP_NAME");
	var appNode = document.getElementById("APPLICATION_TR");
	$.ajax({
		type: "post",//请求方式
        url: root+"/att_type/AttType."+requestPrefix+"?param=ajaxAppNames",
        data: "time=" + new Date().valueOf(),    //加上时间戳作为参数，防止IE访问同一地址时使用缓存而不真正的请求服务器
        dataType: "json", //返回数据类型为XML类型
        error: function(rs){   
        	alert("加载数据出错");   
    		},
        success: function(rs){  //回调函数，参数就是服务器端返回的数据
    		var arr = rs.json;
    		appName.empty();
    		if(arr[0].name == undefined || arr[0].name == null){
    			appNode.parentNode.removeChild(appNode);
    		}else{
	    		var op = "<option value=''>选择应用程序名字</option>";
	    		$.each(arr,function(i,value){
	    			op += "<option value='"+value.name+"'>"+value.name+"</option>";
	    		});
	    		appName.append(op);
    		}
    	}
	});
}

//初始化对接应用程序名称
function initApplicationNames2(root,applicationName,requestPrefix){
	var appName = $("#APP_NAME");
	var appNode = document.getElementById("APPLICATION_TR");
	$.ajax({
		type: "post",//请求方式
        url: root+"/att_type/AttType."+requestPrefix+"?param=ajaxAppNames",
        data: "time=" + new Date().valueOf(),    //加上时间戳作为参数，防止IE访问同一地址时使用缓存而不真正的请求服务器
        dataType: "json", //返回数据类型为XML类型
        error: function(rs){   
        	alert("加载数据出错");   
    		},
        success: function(rs){  //回调函数，参数就是服务器端返回的数据
    		var arr = rs.json;
    		appName.empty();
    		if(arr[0].name == undefined || arr[0].name == null){
    			appNode.parentNode.removeChild(appNode);
    		}else{
	    		var op = "<option value=''>选择应用程序名字</option>";
	    		$.each(arr,function(i,value){
	    			if(applicationName == value.name){
	    				op += "<option value='"+value.name+"' selected='selected'>"+value.name+"</option>";
	    			}else{
	    				op += "<option value='"+value.name+"'>"+value.name+"</option>";
	    			}
	    		});
	    		appName.append(op);
    		}
    	}
	});
}

//初始化对接应用程序的模块名称
function initModuleNames(root,appNameNode,requestPrefix){
	var modName = $("#MOD_NAME");
	var appNode = document.getElementById("APPLICATION_TR");
	$.ajax({
		type: "post",//请求方式
        url: root+"/att_type/AttType."+requestPrefix+"?param=ajaxModNames&appName="+encodeURI(encodeURI($(appNameNode).val())),
        data: "time=" + new Date().valueOf(),    //加上时间戳作为参数，防止IE访问同一地址时使用缓存而不真正的请求服务器
        dataType: "json", //返回数据类型为XML类型
        error: function(rs){   
        	alert("加载数据出错");   
    		},
        success: function(rs){  //回调函数，参数就是服务器端返回的数据
    		var arr = rs.json;
    		modName.empty();
    		if(arr[0].name == undefined || arr[0].name == null){
    			appNode.parentNode.removeChild(appNode);
    		}else{
	    		var op = "<option value=''>选择模块名字</option>";
	    		$.each(arr,function(i,value){
	    			op += "<option value='"+value.name+"'>"+value.name+"</option>";
	    		});
	    		modName.append(op);
    		}
    	}
	});
}

//初始化对接应用程序的模块名称
function initModuleNames2(root,appNameNode,moduleName,requestPrefix){
	var modName = $("#MOD_NAME");
	var appNode = document.getElementById("APPLICATION_TR");
	$.ajax({
		type: "post",//请求方式
        url: root+"/att_type/AttType."+requestPrefix+"?param=ajaxModNames&appName="+encodeURI(encodeURI(appNameNode)),
        data: "time=" + new Date().valueOf(),    //加上时间戳作为参数，防止IE访问同一地址时使用缓存而不真正的请求服务器
        dataType: "json", //返回数据类型为XML类型
        error: function(rs){   
        	alert("加载数据出错");   
    		},
        success: function(rs){  //回调函数，参数就是服务器端返回的数据
    		var arr = rs.json;
    		modName.empty();
    		if(arr[0].name == undefined || arr[0].name == null){
    			appNode.parentNode.removeChild(appNode);
    		}else{
	    		var op = "<option value=''>选择模块名字</option>";
	    		$.each(arr,function(i,value){
	    			if(moduleName == value.name){
	    				op += "<option value='"+value.name+"' selected='selected'>"+value.name+"</option>";	
	    			}else{
	    				op += "<option value='"+value.name+"'>"+value.name+"</option>";
	    			}
	    		});
	    		modName.append(op);
    		}
    	}
	});
}