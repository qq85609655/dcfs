/**
 * 基础的OnLoad方法
 * @return
 */
function _baseOnLoad_reset(){
	//获取有多少form
	var fs = document.forms;
	var len = fs.length;
	//循环获取form中的所有信息
	for(var i=0;i<len;i++){
		//获取 input
		var els = fs[i].tags("input");
		for (var j = 0; j < els.length; j++) {
			var el = els[j];
			if (el.type=="reset"){
				el.setAttribute("formindex",i);
				el.onclick=function(){
					_reset(this);
					return false;
				};
			}
		}
	}
}
/**
 * reset的触发事件
 * @param o
 * @return
 */
function _reset(o){
	var i = o.getAttribute("formindex");
	var f = document.forms[i];
	var els = f.tags("input");
	for (var j = 0; j < els.length; j++) {
		var el = els[j];
		if (el.type=="radio"){
			el.checked=false;
		}else if (el.type=="checkbox"){
			el.checked = false;
		}else if (el.type=="text" || el.type==""){
			el.value = "";
		}
	}
	
	var els = f.tags("textarea");
	for (var j = 0; j < els.length; j++) {
		var el = els[j];
		el.value = "";
	}
	var els = f.tags("select");
	for (var j = 0; j < els.length; j++) {
		var el = els[j];
		el.selectedIndex=0;
	}
}


/**
 * 页面跳转
 * @param form 要提交的form对象
 * @param page 当前页面
 * @param pageNum 总页数
 */
function _goto(form,page,pageNum){
	if (page>pageNum){
		alert("页码超出最大页数！");
		return;
	}
	if (page<1){
		alert("页面不能小于1！");
		return;
	}
	if (!page.isPlusInt()){
		alert("页数必须是正整数！");
		return;
	}
	form.page.value = page;
	form.submit();
}
/**
 * 页面跳转
 * @param form 要提交的form对象
 * @param page 当前页面
 * @param pageNum 总页数
 */
function _gotoEnter(form,page,pageNum){
	if((event.keyCode && event.keyCode==13)){
		_goto(form,page,pageNum);
	}
}