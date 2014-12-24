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
 */
function _goto(form,page,pageNum){
	if (page>pageNum){
		alert("ҳ�볬�����ҳ����");
		return;
	}
	if (page<1){
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
 * ҳ����ת
 * @param form Ҫ�ύ��form����
 * @param page ��ǰҳ��
 * @param pageNum ��ҳ��
 */
function _gotoEnter(form,page,pageNum){
	if((event.keyCode && event.keyCode==13)){
		_goto(form,page,pageNum);
	}
}