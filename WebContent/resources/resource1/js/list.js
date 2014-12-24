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
 * @param iscount 是否汇总计算
 */
function _goto(form,page,pageNum,iscount){
	if (iscount=="true"){
		//alert("page:"+page+",pageNum:"+pageNum);
		if (parseInt(page)>parseInt(pageNum)){
			//alert(parseInt(page)>parseInt(pageNum));
			alert("页码超出最大页数！");
			return;
		}	
	}
	
	if (parseInt(page)<1){
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
 * 加载页面的数据汇总信息
 * @param page_j_countSql 汇总的key
 */
function _loadDataCount(pageSize,countSql,nowPage){
	var pageSizeInt = parseInt(pageSize);
	var page_j_dataTotal = getStr("hx.database.databean.AjaxPage",countSql);
	var page_j_dataTotalInt = parseInt(page_j_dataTotal);
	var page_j_pageNum = Math.ceil(page_j_dataTotalInt/pageSizeInt);
	var nowPageInt = parseInt(nowPage);
	var page_j_nextPage=nowPageInt+1;
	if(page_j_nextPage>page_j_pageNum){
		page_j_nextPage=page_j_pageNum;
	}
	var page_j_start=((nowPageInt-1)*pageSizeInt)+1;
	var page_j_end=nowPageInt*pageSizeInt;
	document.getElementById("page_pageNum").value=page_j_pageNum;
	document.getElementById("page_nextPage").value=page_j_nextPage;
	document.getElementById("page_page_dataTotal").outerHTML=page_j_dataTotal;
	document.getElementById("page_dataTotal").value=page_j_dataTotal;
	document.getElementById("page_page_start").outerHTML=page_j_start;
	document.getElementById("page_page_end").outerHTML=page_j_end;
	document.getElementById("page_page_pageNum").outerHTML=page_j_pageNum;
	document.getElementById("page_hidden_1").style.display="";
	document.getElementById("page_hidden_2").style.display="";
}
/**
 * 导出文件
 * @param form 表单
 * @param type 类型
 */
function _exportFile(form,type){
	document.getElementById("exportType").value=type;
	var oldTarget=form.target;
	var oldAction = form.action;
	form.target="_self";
	form.action=path+"/export/export";
	var total = document.getElementById("page_dataTotal").value;
	if (total==0 || total>60000){
		alert("需要导出的数据量很大，请耐心等待...");
	}
	form.submit();
	form.target=oldTarget;
	form.action=oldAction;
}
/**
 * 页面跳转
 * @param form 要提交的form对象
 * @param page 当前页面
 * @param pageNum 总页数
 */
function _gotoEnter(form,page,pageNum,iscount){
	if((event.keyCode && event.keyCode==13)){
		_goto(form,page,pageNum,iscount);
	}
}