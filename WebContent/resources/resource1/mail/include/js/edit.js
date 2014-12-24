

window.onload=function()
{
	try {
		_onLoad();
	}
	catch (e)
	{}
	_onLoadCheck();
}

function _loadVerify()
{
	try {
		_onLoad();
	}
	catch (e)
	{}
	_onLoadCheck();
}
function _onLoadCheck()
{
	try{
	_load();
	}
	catch(e){
	}
	
	try{
		loadInputStyle();
	}catch(e){
	}
	try{
		_loadSub();
	}catch(e){
	}
}
document.write('<div style="display:none" class="msg_div" id="dhtmltooltip"></div>');
document.write('<img id=\"dhtmlpointer\" style="position:absolute;z-index:9999999;display:none" src=\"\">');
document.write('<div style="display:none" class="msg_info" id="dhtmltooltip_view" ></div>');
document.write('<img id=\"dhtmlpointer_view\" style="position:absolute;z-index:9999999;display:none" src=\"\">');
var check_name="";
var widths="220";//默认提示宽度
var path;
var system_return=true;
var check_msg="";
function Hint(isAlert){
	this.ie=document.all;
	this.ns6=document.getElementById&&!document.all;
	this.enabletip=false;
	if(isAlert){
		this.tipobj=document.all?document.all["dhtmltooltip_view"]:document.getElementById?document.getElementById("dhtmltooltip_view"):"";
		this.pointerobj=document.all?document.all["dhtmlpointer_view"]:document.getElementById?document.getElementById("dhtmlpointer_view"):"";
		this.pointerobj.src=getCheckAlertImg();
	}else{
		this.tipobj=document.all?document.all["dhtmltooltip"]:document.getElementById?document.getElementById("dhtmltooltip"):"";
		this.pointerobj=document.all?document.all["dhtmlpointer"]:document.getElementById?document.getElementById("dhtmlpointer"):"";
		this.pointerobj.src=getCheckOkImg();
	}
	if(this.tipobj==null || this.pointerobj==null){
		alert("您在页面上没有引入<RO:script isEdit=\"true\">或者重复引用，校验或者提示信息将失效！");
	}
};
function getCheckOkImg(){
	if (path==null || path==""){
		path="/fsms/include";
	}
	return (path + "/images/check_awoke.gif");
}
function getWarningImg(){
return "";
	if (path==null || path==""){
		path="/fsms/include";
	}
	return ("<img src=\"" + path + "/images/warning.gif\">");
}
function iepopclick(){ 
	_hide();
		
}
function ieclick(){ 
	_hide();
	fdo.className = "txt_" + getClassNameTxt(); 
	fdo.focus();
		
}
Hint.prototype.show=function(n,s,w,isAlert){
		 w = s.length * 13;
		if(w<4*13){
		 w=4*13;
		 }
		this.tipobj.style.width=w + "px";
		var clName="msg_div_td";
		if(isAlert){
			clName="msg_info_td";
		}
		//this.tipobj.innerHTML=s ;
		//this.tipobj.focus;
		this.tipobj.innerHTML="<iframe src=\"javascript:false\" style=\"position:absolute; visibility:inherit; top:-1px; left:-1px; width:"+w+"px; height:22px; z-index:-1; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';\"></iframe><table style=\"z-index:1\"><tr><td onClick=\"ieclick();\" class=\"" + clName + "\" nowrap>" + getWarningImg() + s +"</td></tr></table>" ;
		this.enabletip=true;
		this.positiontip(n,isAlert);
};
Hint.prototype.showpop=function(n,s,w,isAlert){
		 w = s.length * 13;
		if(w<4*13){
		 w=4*13;
		 }
		this.tipobj.style.width=w + "px";
		var clName="msg_div_td";
		if(isAlert){
			clName="msg_info_td";
		}
		//this.tipobj.innerHTML=s ;
		//this.tipobj.focus;
		this.tipobj.innerHTML="<iframe src=\"javascript:false\" style=\"position:absolute; visibility:inherit; top:-1px; left:-1px; width:"+w+"px; height:22px; z-index:-1; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';\"></iframe><table style=\"z-index:1\"><tr><td onClick=\"iepopclick();\" class=\"" + clName + "\" nowrap>" + getWarningImg() + s +"</td></tr></table>" ;
		this.enabletip=true;
		this.positiontip(n,isAlert);
};
Hint.prototype.hide=function(){
		this.enabletip=false;
		this.tipobj.style.visibility="hidden";
		this.tipobj.style.left="-1000px";
		this.tipobj.style.backgroundColor='';
		this.tipobj.style.width='';
		this.tipobj.style.display="none";
		this.pointerobj.style.visibility="hidden";
		this.pointerobj.style.display="none";
		this.pointerobj.style.left="-1000px";
		this.pointerobj.style.backgroundColor='';
		this.pointerobj.style.width='';
};
Hint.prototype.positiontip=function(e,isAlert){
	var sourceObj=e!=undefined?e:event.srcElement;
	var absObj=GetAbsoluteLocationEx(sourceObj);
	if(isAlert){
			this.tipobj.style.left=absObj.absoluteLeft+(sourceObj.clientWidth*1.2)+"px";
			
			this.pointerobj.style.left=absObj.absoluteLeft+(sourceObj.clientWidth*1.2+15)+"px";
			
			this.tipobj.style.top=absObj.absoluteTop-(sourceObj.clientHeight+14)+"px";
			
			this.pointerobj.style.top=absObj.absoluteTop-(sourceObj.clientHeight-7)+"px";
			
			this.tipobj.style.visibility="visible";
			this.tipobj.style.display="block";
	
			//this.tipobj.focus();
			this.pointerobj.style.visibility="visible";
			this.pointerobj.style.display="block";
	}else{
		if(this.enabletip){
			this.tipobj.style.left=absObj.absoluteLeft+(sourceObj.clientWidth*1.2)+"px";
			
			this.pointerobj.style.left=absObj.absoluteLeft+(sourceObj.clientWidth*1.2+15)+"px";
			
			this.tipobj.style.top=absObj.absoluteTop+(sourceObj.clientHeight+14)+"px";
			
			this.pointerobj.style.top=absObj.absoluteTop+(sourceObj.clientHeight)+"px";
			
			this.tipobj.style.visibility="visible";
			this.tipobj.style.display="block";
	
			//this.tipobj.focus();
			this.pointerobj.style.visibility="visible";
			this.pointerobj.style.display="block";
			//alert(absObj.absoluteLeft);
			//alert(absObj.absoluteTop);
		}
	}
};
function _hide(isAlert){
	var hint;
	if (isAlert){
		hint=getHintAlert();
	}else{
		hint=getHint();
	}
	hint.hide();	
}
function getHintAlert(){
	var hint=getHint(true);
	return hint;
} 
function getCheckAlertImg(){
	if (path==null || path==""){
		path="/fsms/include";
	}
	return (path + "/images/check_info.gif");
}
function get_offset_left(o){
	var left = o.offsetLeft;
	var po = o.offsetParent;
	if(po!=null){
		left += get_offset_left(po);
	}
	return left;
}
function get_offset_top(o){
	var top = o.offsetTop;
	var po = o.offsetParent;
	if(po!=null){
		top += get_offset_top(po);
	}
	return top;
}
function GetAbsoluteLocationEx(element){
	if(element==null){
		return null;
	};
	var elmt=element;
	var s="左：" + elmt.offsetLeft;
	s+="\n上：" + elmt.offsetTop;
	s+="\n宽：" + elmt.offsetWidth;
	s+="\n高：" + elmt.offsetHeight;
	//alert(s);
	var offsetTop=get_offset_top(elmt);	
	var offsetLeft= get_offset_left(elmt);/*elmt.;*/
	var offsetWidth=elmt.scrollWidth;
	var offsetHeight=elmt.scrollHeight;
	//elmtz.xx.sss;
	//offsetTop += offsetHeight/2;
	offsetLeft =offsetLeft-offsetWidth/2;
	return{absoluteTop:offsetTop,absoluteLeft:offsetLeft,offsetWidth:offsetWidth,offsetHeight:offsetHeight};
}
function showHint(n,s,w){
	_hide();
	var hint = getHint();
	hint.show(n,s,w);
}
//隐藏提示框方法，若使用FIREFOX需把此方法加<body onBlur="hide();">
function getHint(isAlert){
	return new Hint(isAlert);
}
var fdo;

function getClassNameTxt(){
	if (fdo==null){
		return "txt";
	}else{
		return fdo.tagName.toLowerCase();
	}
}
//弹出试错误提示（控件名称，[错误信息]，[弹出框宽度]）
function showInfo(n,s,w) {


	if (!system_return){
		return;
	}
	fdo = n;
	if(typeof w!="undefined"){
		widths=w;
	}
	showHint(n,s,widths);
}
function showMsg(n,s,w) {
	if (!system_return){
		return;
	}
	fdo = n;
	if(typeof w!="undefined"){
		widths=w;
	}
	showHintAlert(n,s,widths);
}
function showHintAlert(n,s,w){
	_hide(true);
	var hint = getHintAlert();
	hint.show(n,s,w,true);
}
function _check_one(obj){
	allHtmlMsg = "";
	allMsg = "";
//不管验证不验证，将input的text和textarea
	//判断input

	var isHtml = false;
	var inputValue = obj.value.toUpperCase();
	var inputValueNoSpace = inputValue.atrim();
	var tagName = obj.tagName.toUpperCase();
	if(tagName=="INPUT"){
		//查询文本框特殊字符的处理
		if (obj.getAttribute("searchInput")=="true"){
			for (var j=0;j<searchChar.length;j++){
				if(searchChar[j].atrim() != ""){
					if (inputValueNoSpace.indexOf(searchChar[j])!=-1){
						showCheckOneInfo(obj,"查询条件中不能包含[" + searchChar[j] + "]字符");
						isHtml = true;
						if (errObj == null){
							errObj = obj;
						}
					}
				}
			}
		}else{
//input查询
			for (var j=0;j<inputChar.length;j++){
				if(inputChar[j].atrim() != ""){
					if (inputValueNoSpace.indexOf(inputChar[j])!=-1){
						showCheckOneInfo(obj,"不能包含[" + inputChar[j] + "]字符");
						isHtml = true;
						if (errObj == null){
							errObj = obj;
						}
					}
				}
			}
		}
		for (var j=0;j<htmlChar1.length;j++){
			if(htmlChar1[j].atrim() != ""){
				if (inputValueNoSpace.indexOf("<" + htmlChar1[j] + ">")!=-1 || inputValue.indexOf(htmlChar1[j] + " ") != -1 || inputValueNoSpace.indexOf(htmlChar[j] + ">")!=-1 || (inputValueNoSpace.indexOf("<" + htmlChar1[j]) + htmlChar1[j].length + 1 == inputValueNoSpace.length)){
					if (inputValueNoSpace.indexOf("<" + htmlChar1[j])!=-1){
						showCheckOneInfo(obj,"不能包含<" + htmlChar1[j] + ">节点");
						isHtml = true;
						if (errObj == null){
							errObj = obj;
						}
					}
				}
			}
		}
		for (var j=0;j<htmlChar.length;j++){
			if(htmlChar[j].atrim() != ""){
				if (inputValueNoSpace.indexOf("<" + htmlChar[j] + ">")!=-1 || inputValue.indexOf(htmlChar[j] + " ") != -1 || inputValueNoSpace.indexOf(htmlChar[j] + ">")!=-1 || (inputValueNoSpace.indexOf("<" + htmlChar[j]) + htmlChar[j].length + 1 == inputValueNoSpace.length)){
					if (inputValueNoSpace.indexOf("<" + htmlChar[j])!=-1){
						showCheckOneInfo(obj,"不能包含<" + htmlChar[j] + ">节点");
						isHtml = true;
						if (errObj == null){
							errObj = obj;
						}
					}
				}
				if (inputValueNoSpace.indexOf("</" + htmlChar[j] + ">")!=-1){
					showCheckOneInfo(obj,"不能包含</" + htmlChar[j] + ">节点");
					isHtml = true;
					if (errObj == null){
						errObj = obj;
					}
				}
			}
		}
	}if(tagName=="INPUT"){
	//判断textarea
		var inputValue = obj.value.toUpperCase();
		var inputValueNoSpace = inputValue.atrim();
		if (inputValue.indexOf("TEXTAREA ") != -1 || inputValueNoSpace.indexOf("TEXTAREA>") != -1){
			if (inputValueNoSpace.indexOf("<TEXTAREA") != -1){
				showCheckOneInfo(obj,"不能包含<textArea>节点");
				isHtml = true;
				if (errObj == null){
					errObj = obj;
				}
			}
		}
		if (inputValueNoSpace.indexOf("</TEXTAREA>") != -1){
			showCheckOneInfo(obj,"不能包含</textArea>节点");
			isHtml = true;
			if (errObj == null){
				errObj = obj;
			}
		}
	}
	var classNameEnd = "_" + tagName.toLowerCase();
	if (checkOneVerify(obj) && !isHtml){
		_hide();
	//	obj.className="txt_ok" + classNameEnd;
		obj.style.borderColor='#888888';
		return ;
	}
	//打印信息
	showInfo(obj,check_msg);
	check_msg="";
	//system_return=false;
	var tmp = obj.value;
	if(tmp!=null){
		tmp.substring(0,(tmp.length-1));
	}else{
		tmp="";
	}

	obj.value = tmp;
	obj.focus();
	
//	obj.className="txt_warn" + classNameEnd;
	obj.style.borderColor='red';
	
}

function checkOneVerify(el) {

	var tagName = el.tagName.toLowerCase();
	
	var notNull = el.getAttribute("notnull");
	if (notNull != null && notNull.trim() != "") {
		if (el.value == null || el.value.trim() == "") {
			showCheckOneInfo(el, notNull);
			if (errObj == null){
				errObj = el;
			}
			return false;
		}
	}
	if ((tagName == "input" && el.type == "text") || tagName == "textarea") {
		var len = el.getAttribute("maxlength");
		if (len != null && !isNaN(parseInt(len)) && parseInt(len) > 0) {
			if (el.value.getByte() > parseInt(len)) {
				showCheckOneInfo(el, "输入的内容过长！最大长度为：" + len + "字符");
				if (errObj == null){
					errObj = el;
				}
				return false;
			}
		}
	}
	var reValue = true;
	var verifys = el.getAttribute("restriction");
	if (verifys!=null && verifys != ""){
		var vver = verifys.split(";");
		for(var j=0;j<vver.length;j++){
			var checkResult;
			var verify = vver[j];
			
			if (tagName == "select" 
				|| verify == null 
				|| verify.trim() == "" 
				|| el.value == null
				|| el.value.trim() == "") {
				if (errObj == null){
					errObj = el;
				}
				return true;
			}
			var paras = verify.split(",");
			var program = paras[0] + "Verify(el";
			for (var i = 1; i < paras.length; i++) {
				var para = paras[i];
				program += (", \"" + para + "\"");
			}
			program += ");";
			try{
				checkResult = eval(program);
				if (reValue){
					if (success != checkResult) {
						reValue = false;
					}
				}
			}catch(e){
				alert("校验错误，请检查restriction输入的校验类型是否正确，注意大小写：" + verify + "\n错误：" + e);
			}
			
			if(success != checkResult)
				showCheckOneInfo(el, checkResult);
		}
		
	}
	if (reValue) {
		return true;
	}
	return false;
}
function showCheckOneInfo(el,msg){
	if (check_msg!=""){
		check_msg+="\n";
	}
	check_msg+=msg;
}