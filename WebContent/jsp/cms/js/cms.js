//分页表单提交
function _pageGoto(formId,param,page,pageTotal){
	var curP = page;
	if(param == 'previous'){
		if(page > 1){
			curP = page - 1;
		}else{
			alert("页面不能小于1!");
			return;
		}
	}
	if(param == 'next'){
		if(page < pageTotal){
			curP = page + 1;
		}else{
			alert("页码超出最大页数!");
			return;
		}
	}
	
	//校验开始
	if(curP > pageTotal){
		curP = pageTotal;
	}
	if(curP < 1){
		curP = 1;
	}
	//校验结束
	
	document.getElementById(formId+"_page").value = curP;
	document.getElementById(formId).submit();
}

//去除前后空格
String.prototype.trim=function(){
	return this.replace(/(^\s*)|(\s*$)/g, "");
}
//去除左边空格
String.prototype.ltrim=function(){
	return this.replace(/(^\s*)/g,"");
}
//去除右边空格
String.prototype.rtrim=function(){
	return this.replace(/(\s*$)/g,"");
}

/**
 * 处理图片
 */
function initImages(){
	var contentObj = document.getElementById("contentText");
	//alert(contentObj);
	if (contentObj!=null){
		var imgs = contentObj.getElementsByTagName("IMG");
		var len =imgs.length;
		for(var i=0;i<len;i++){
			imgs[i].onclick=function(){
				openImg(this.src);
			};
			imgs[i].title="点击此处，查看原尺寸图片.";
			imgs[i].style.cursor="pointer";
		}
	}
	
}
