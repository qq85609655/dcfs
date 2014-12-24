var formsData = new Array();
function _baseOnLoad_reset(){
	//��ȡ�ж���form
	var fs = document.forms;
	var len = fs.length;
	//ѭ����ȡform�е�������Ϣ
	for(var i=0;i<len;i++){
		var eradio=new Array();
		var echeckbox=new Array();
		var etext=new Array();
		//��ȡ input
		var els = fs[i].tags("input");
		for (var j = 0; j < els.length; j++) {
			var el = els[j];
			if (el.type=="radio"){
				if(el.checked){
					eradio[el.name]=el.value;
				}
			}else if (el.type=="checkbox"){
				echeckbox[el.name + "|" + el.value]=el.checked;
			}else if (el.type=="text" || el.type==""){
				etext[el.name]=el.value;
			}else if (el.type=="reset"){
				el.setAttribute("formindex",i);
				el.onclick=function(){
					_reset(this);
					return false;
				};
			}
		}
		formsData[i]=new Array();
		formsData[i]["eradio"]=eradio;
		formsData[i]["echeckbox"]=echeckbox;
		formsData[i]["etext"]=etext;
		var etextarea=new Array();
		//��ȡ textarea
		var els = fs[i].tags("textarea");
		for (var j = 0; j < els.length; j++) {
			var el = els[j];
			etextarea[el.name]=el.value;
		}
		//��ȡ select
		var els = fs[i].tags("select");
		var eselect=new Array();
		for (var j = 0; j < els.length; j++) {
			var el = els[j];
			eselect[el.name]=el.value;
		}
		formsData[i]["etextarea"]=etextarea;
		formsData[i]["eselect"]=eselect;
	}
}
/**
 * �༭ҳ���reset�ع�
 * @param o
 * @return
 */
function _reset(o){
	var i = o.getAttribute("formindex");
	var f = document.forms[i];
	var el = formsData[i];
	var eradio = el["eradio"];
	var echeckbox = el["echeckbox"];
	var etext = el["etext"];
	var ereset = el["ereset"];
	var etextarea = el["etextarea"];
	var eselect = el["eselect"];
	var els = f.tags("input");
	for (var j = 0; j < els.length; j++) {
		var el = els[j];
		if (el.type=="radio"){
			if(eradio[el.name]==el.value){
				el.checked=true;
			}else{
				el.checked=false;
			}
		}else if (el.type=="checkbox"){
			el.checked = echeckbox[el.name + "|" + el.value];
		}else if (el.type=="text" || el.type==""){
			el.value = etext[el.name];
		}
	}
	
	var els = f.tags("textarea");
	for (var j = 0; j < els.length; j++) {
		var el = els[j];
		el.value = etextarea[el.name];
	}
	var els = f.tags("select");
	for (var j = 0; j < els.length; j++) {
		var el = els[j];
		el.value = eselect[el.name];
	}
}

