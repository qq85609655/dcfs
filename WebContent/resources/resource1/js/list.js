/**
 * ������OnLoad����
 * @return
 */
function _baseOnLoad_reset(){
	//��ȡ�ж���form
	var fs = document.forms;
	var len = fs.length;
	//ѭ����ȡform�е�������Ϣ
	for(var i=0;i<len;i++){
		//��ȡ input
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
 * reset�Ĵ����¼�
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
 * ҳ����ת
 * @param form Ҫ�ύ��form����
 * @param page ��ǰҳ��
 * @param pageNum ��ҳ��
 * @param iscount �Ƿ���ܼ���
 */
function _goto(form,page,pageNum,iscount){
	if (iscount=="true"){
		//alert("page:"+page+",pageNum:"+pageNum);
		if (parseInt(page)>parseInt(pageNum)){
			//alert(parseInt(page)>parseInt(pageNum));
			alert("ҳ�볬�����ҳ����");
			return;
		}	
	}
	
	if (parseInt(page)<1){
		alert("ҳ�治��С��1��");
		return;
	}
	if (!page.isPlusInt()){
		alert("ҳ����������������");
		return;
	}
	form.page.value = page;
	form.submit();
}
/**
 * ����ҳ������ݻ�����Ϣ
 * @param page_j_countSql ���ܵ�key
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
 * �����ļ�
 * @param form ��
 * @param type ����
 */
function _exportFile(form,type){
	document.getElementById("exportType").value=type;
	var oldTarget=form.target;
	var oldAction = form.action;
	form.target="_self";
	form.action=path+"/export/export";
	var total = document.getElementById("page_dataTotal").value;
	if (total==0 || total>60000){
		alert("��Ҫ�������������ܴ������ĵȴ�...");
	}
	form.submit();
	form.target=oldTarget;
	form.action=oldAction;
}
/**
 * ҳ����ת
 * @param form Ҫ�ύ��form����
 * @param page ��ǰҳ��
 * @param pageNum ��ҳ��
 */
function _gotoEnter(form,page,pageNum,iscount){
	if((event.keyCode && event.keyCode==13)){
		_goto(form,page,pageNum,iscount);
	}
}