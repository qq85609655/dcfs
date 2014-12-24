
//校验边框颜色
var check_ok = "1px solid #ABBFCF";
var check_warning = "1px solid red";
//提示信息补偿
var tipCompensate = -80;
//默认提示信息宽度
var widths=50;
//提示标题的属性，根据实际情况可以修改
var formTitle = "formTitle"; 
/************************************************************************
 * *************************** 消息页面提示配置 *************************** *
 ************************************************************************/
//提示消息的id,消息的主体
var _msgTitle="msg";
//提示消息的内容区域
var _msgcontent="msgContent";
//是否是在对象上提示
var isObjectTip=true;
/**
 * 页面提示信息的图片
 */

var gifResource = new Array();
gifResource["info"] = "/images/MessageInfo.gif";
gifResource["infoColor"] = "#009900";
gifResource["infoClass"] = "show_info";
gifResource["debug"] = "/images/MessageDebug.gif";
gifResource["debugColor"] = "#0066FF";
gifResource["debugClass"] = "show_debug";
gifResource["warn"] = "/images/MessageWarn.gif";
gifResource["warnColor"] = "#0066FF";
gifResource["warnClass"] = "show_warn";
gifResource["error"] = "/images/MessageError.gif";
gifResource["errorColor"] = "#FF0000";
gifResource["errorClass"] = "show_error";
gifResource["fatal"] = "/images/MessageFatal.gif";
gifResource["fatalColor"] = "#0066FF";
gifResource["fatalClass"] = "show_fatal";
/************************************************************************
 * *********************** 消息页面提示配置结束 ************************ *
 ************************************************************************/
//这两个资源需要在页面中定义，如果使用HEAD标签的话，就自动定义了
//var resourcePath="";
//var path="";
/**
 * 执行校验的JS对象
 */
var exceptName=",resultSql,ins_LAWCONTENT,";
var allHtml = "B,BIG,APPLET,ABBR,ACRONYM,ADDRESS,BASEFONT,BDO,BGSOUND,BIG,BLINK,BLOCKQUOTE,BR,BUTTON,CENTER,CITE,CITE,CODE,DEL,DFN,DIR,DIV,DL,EM,EMBED,FIELDSET,FONT,H1,H6,H2,H3,H4,H5,HR,I,IFRAME,IMG,INS,,KBD,LABEL,MAP,MARQUEE,MENU,NOBR,NOFRAMES,NOSCRIPT,OBJECT,OL,P,PRE,Q,S,SAMP,SCRIPT,SELECT,SMALL,SPAN,STRIKE,STRONG,SUB,SUP,TABLEtrtd,TEXTAREA,TT,U,UL,VAR,WBR";
var allHtml1 = "INPUT,ISINDEX";
var searchHtml = "',\",?,%";
var inputHtml = "\",>,<";
var htmlChar1 = allHtml1.split(",");
var htmlChar = allHtml.split(",");
var searchChar = searchHtml.split(",");
var inputChar = inputHtml.split(",");

var allMsg="";
var allHtmlMsg="";
// 为了提示错误以后移向第一个不符合规则的页面
var errObj = null;



//图片的地址
var gifPath=gifResource["info"];
//字体的颜色
var color=gifResource["infoColor"];
//字体的样式
var clssName=gifResource["infoClass"];

/**********************
 *****单个域校验*******
 **********************/

document.write('<div style="display:none" class="msg_div" id="dhtmltooltip"></div>');
document.write('<img id=\"dhtmlpointer\" style="position:absolute;z-index:9999999;display:none" src=\"\">');
document.write('<div style="display:none" class="msg_info" id="dhtmltooltip_view"></div>');
document.write('<img id=\"dhtmlpointer_view\" style="position:absolute;z-index:9999999;display:none" src=\"\">');
var check_name="";

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
		alert("重复引用，校验或者提示信息将失效！");
	}
};
function getCheckOkImg(){
//	if (path==null || path==""){
//		path="/common/resource";
//	}
	return (resourcePath + "/images/check_awoke.gif");
}
function getWarningImg(){
return "";
//	if (path==null || path==""){
//		path="/common/resource";
//	}
	return ("<img src=\"" + resourcePath + "/images/warning.gif\">");
}
function ieclick(){
	hide();
	//fdo.className = "txt_" + getClassNameTxt();
	//fdo.focus();
}
Hint.prototype.show=function(n,s,w,isAlert){
		this.tipobj.style.width=w+"px";
		var clName="msg_div_td";
		if(isAlert){
			clName="msg_info_td";
		}
		this.tipobj.innerHTML="<table style=\"width: 100%\"><tr><td onClick=\"ieclick();\" class=\"" + clName + "\" nowrap>" + getWarningImg() + s +"</td></tr></table>" ;
		//this.tipobj.focus;
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
			this.tipobj.style.left=(absObj.absoluteLeft+(sourceObj.clientWidth*1.2)+tipCompensate)+"px";
			
			this.pointerobj.style.left=(absObj.absoluteLeft+(sourceObj.clientWidth*1.2+15)+tipCompensate)+"px";
			
			this.tipobj.style.top=absObj.absoluteTop-(sourceObj.clientHeight+14)+"px";
			
			this.pointerobj.style.top=absObj.absoluteTop-(sourceObj.clientHeight-7)+"px";
			
			this.tipobj.style.visibility="visible";
			this.tipobj.style.display="block";
	
			//this.tipobj.focus();
			this.pointerobj.style.visibility="visible";
			this.pointerobj.style.display="block";
	}else{
		if(this.enabletip){
			this.tipobj.style.left=(absObj.absoluteLeft+(sourceObj.clientWidth*1.2)+tipCompensate)+"px";
			
			this.pointerobj.style.left=(absObj.absoluteLeft+(sourceObj.clientWidth*1.2+15)+tipCompensate)+"px";
			
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
function hide(isAlert){
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
	if (path==null){
		path="./";
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
	hide();
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
//	if(typeof w!="undefined"){
//		widths=w;
//	}
	if (w==null){
		w=widths;
	}
	showHint(n,s,w);
}
function showMsg(n,s,w) {
	if (!system_return){
		return;
	}
	fdo = n;
//	if(typeof w!="undefined"){
//		//widths=w;
//		
//	}
	if (w==null){
		w=widths;
	}
	showHintAlert(n,s,widths);
}
function showHintAlert(n,s,w){
	hide(true);
	var hint = getHintAlert();
	hint.show(n,s,w,true);
}
function _check_one(obj){
	allHtmlMsg = "";
	allMsg = "";
//不管验证不验证，将input的text和textarea
	//判断input
   var jg;
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
		hide();
		//obj.className="txt_ok" + classNameEnd;
		obj.style.border = check_ok;
			var tagName = obj.tagName.toUpperCase();
		if(tagName=="SELECT"){
			obj.parentNode.className="select_jiaoyan_ok";
		}
		return true;
		return ;
	}
	//打印信息
	var tempWidth = (check_msg.getByte()*6)+5;
	if (tempWidth<widths){
		tempWidth=widths;
	}
	showInfo(obj,check_msg,tempWidth);
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
	//obj.className="txt_warn" + classNameEnd;
	obj.style.border = check_warning;
		var tagName = obj.tagName.toUpperCase();
		if(tagName=="SELECT"){
			obj.parentNode.className="select_jiaoyan";
		}
	return false;
	
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
//				alert("校验错误，请检查restriction输入的校验类型是否正确，注意大小写：" + verify + "\n错误：" + e);
				var estr = "校验错误，请检查restriction输入的校验类型是否正确，注意大小写\nrestriction=\"" + verify + "\"\n错误信息为：" + e + "\n";
				estr+="restriction可输入的内容包括以下之一或多项，多项时用;（分号）分割：\n";
				estr+="number;int;float;plus;plusInt;plusFloat;minus;minusInt;minusFloat;email;wordchar;zip;mobile;telephone;date;time;dateTime;hasSpecialChar;afterDate;beforeDate;afterDateTime;beforeDateTime;inValue;outValue;inField;outField;uperValue;lowerValue;uperField;lowerField";
				alert(estr);
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
		check_msg+="<br>";
	}
	check_msg+=msg;
}
function _inputMouseFocus(obj,newColor){
	if (newColor == null){
		//obj.style.backgroundColor = "#FFFF99";
		//obj.style.backgroundColor = "#FEFFF0";
	}else{
		obj.style.backgroundColor = newColor;
	}
}
function _inputMouseOver(obj,newColor){
	//obj.focus();
}
function _inputMouseOut(obj,newColor){
	return;
	var tmpColor =obj.getAttribute("temColor");
	if (tmpColor==null){
		tmpColor ="#FFFFFF";
	}
	if (newColor == null){
		obj.style.backgroundColor = tmpColor;
	}else{
		obj.style.backgroundColor = newColor;
	}
}
function _inputMouseBlur(obj,newColor){
	var tmpColor =obj.getAttribute("temColor");
	if (tmpColor==null){
		tmpColor ="";
	}
	if (newColor == null){
		obj.style.backgroundColor = tmpColor;
	}else{
		obj.style.backgroundColor = newColor;
	}
}
/**************
 *****统一校验**
 **************/


/**
 * 页面提交
 */
function pageshow(form,verify){
	hide();
	allHtmlMsg = "";
	allMsg = "";
// 不管验证不验证，将input的text和textarea
	// 判断input
	if (verify == false){
		if (isHtml){
			outputMsg();
			onFocus();
			return false;
		}
		form.submit();
		return true;
	}else{
		if (_check(form)){
			form.submit();
			return true;
		}
		onFocus();
		return false;
	}
}

function _check_nomb(form){
	allHtmlMsg = "";
	allMsg = "";
// 不管验证不验证，将input的text和textarea
	// 判断input
	var els = form.tags("input");
	var isHtml = false;
	for (var i = 0; i < els.length; i++) {
		var inputValue = els[i].value.toUpperCase();
		if (exceptName.indexOf(','+els[i].name+',')>-1){
			continue;
		}
		var inputValueNoSpace = inputValue.atrim();
		// 查询文本框特殊字符的处理
		if (els[i].getAttribute("searchInput")=="true"){
			for (var j=0;j<searchChar.length;j++){
				if(searchChar[j].atrim() != ""){
					if (inputValueNoSpace.indexOf(searchChar[j])!=-1){
						showCheckInfo(els[i],"查询条件中不能包含[" + searchChar[j] + "]字符");
						isHtml = true;
						if (errObj == null){
							errObj = els[i];
						}
					}
				}
			}
		}else{
// input查询
			for (var j=0;j<inputChar.length;j++){
				if(inputChar[j].atrim() != ""){
					if (inputValueNoSpace.indexOf(inputChar[j])!=-1){
					
						showCheckInfo(els[i],"不能包含[" + inputChar[j] + "]字符");
						isHtml = true;
						if (errObj == null){
							errObj = els[i];
						}
					}
				}
			}
		}
		for (var j=0;j<htmlChar1.length;j++){
			if(htmlChar1[j].atrim() != ""){
				if (inputValueNoSpace.indexOf("<" + htmlChar1[j] + ">")!=-1 || inputValue.indexOf(htmlChar1[j] + " ") != -1 || inputValueNoSpace.indexOf(htmlChar[j] + ">")!=-1 || (inputValueNoSpace.indexOf("<" + htmlChar1[j]) + htmlChar1[j].length + 1 == inputValueNoSpace.length)){
					if (inputValueNoSpace.indexOf("<" + htmlChar1[j])!=-1){
						showCheckInfo(els[i],"不能包含<" + htmlChar1[j] + ">节点");
						isHtml = true;
						if (errObj == null){
							errObj = els[i];
						}
					}
				}
			}
		}
		for (var j=0;j<htmlChar.length;j++){
			if(htmlChar[j].atrim() != ""){
				if (inputValueNoSpace.indexOf("<" + htmlChar[j] + ">")!=-1 || inputValue.indexOf(htmlChar[j] + " ") != -1 || inputValueNoSpace.indexOf(htmlChar[j] + ">")!=-1 || (inputValueNoSpace.indexOf("<" + htmlChar[j]) + htmlChar[j].length + 1 == inputValueNoSpace.length)){
					if (inputValueNoSpace.indexOf("<" + htmlChar[j])!=-1){
						showCheckInfo(els[i],"不能包含<" + htmlChar[j] + ">节点");
						isHtml = true;
						if (errObj == null){
							errObj = els[i];
						}
					}
				}
				if (inputValueNoSpace.indexOf("</" + htmlChar[j] + ">")!=-1){
					showCheckInfo(els[i],"不能包含</" + htmlChar[j] + ">节点");
					isHtml = true;
					if (errObj == null){
						errObj = els[i];
					}
				}
			}
		}
	}
	// 判断textarea
	var els = form.tags("textarea");
	for (var i = 0; i < els.length; i++) {
		var inputValue = els[i].value.toUpperCase();
		var inputValueNoSpace = inputValue.atrim();
		if (inputValue.indexOf("TEXTAREA ") != -1 || inputValueNoSpace.indexOf("TEXTAREA>") != -1){
			if (inputValueNoSpace.indexOf("<TEXTAREA") != -1){
				showCheckInfo(els[i],"不能包含<textArea>节点");
				isHtml = true;
				if (errObj == null){
					errObj = els[i];
				}
			}
		}
		if (inputValueNoSpace.indexOf("</TEXTAREA>") != -1){
			showCheckInfo(els[i],"不能包含</textArea>节点");
			isHtml = true;
			if (errObj == null){
				errObj = els[i];
			}
		}
	}
	if (runFormVerify(form,false)){
	//	_checkButton(form);
		return true;
	}
	//onFocus();
	return false;
}

function _check(form){
	allHtmlMsg = "";
	allMsg = "";
// 不管验证不验证，将input的text和textarea
	// 判断input
	var els = form.tags("input");
	var isHtml = false;
	for (var i = 0; i < els.length; i++) {
		var inputValue = els[i].value.toUpperCase();
		if (exceptName.indexOf(','+els[i].name+',')>-1){
			continue;
		}
		var inputValueNoSpace = inputValue.atrim();
		// 查询文本框特殊字符的处理
		if (els[i].getAttribute("searchInput")=="true"){
			for (var j=0;j<searchChar.length;j++){
				if(searchChar[j].atrim() != ""){
					if (inputValueNoSpace.indexOf(searchChar[j])!=-1){
						showCheckInfo(els[i],"查询条件中不能包含[" + searchChar[j] + "]字符");
						isHtml = true;
						if (errObj == null){
							errObj = els[i];
						}
					}
				}
			}
		}else{
// input查询
			for (var j=0;j<inputChar.length;j++){
				if(inputChar[j].atrim() != ""){
					if (inputValueNoSpace.indexOf(inputChar[j])!=-1){
					
						showCheckInfo(els[i],"不能包含[" + inputChar[j] + "]字符");
						isHtml = true;
						if (errObj == null){
							errObj = els[i];
						}
					}
				}
			}
		}
		for (var j=0;j<htmlChar1.length;j++){
			if(htmlChar1[j].atrim() != ""){
				if (inputValueNoSpace.indexOf("<" + htmlChar1[j] + ">")!=-1 || inputValue.indexOf(htmlChar1[j] + " ") != -1 || inputValueNoSpace.indexOf(htmlChar[j] + ">")!=-1 || (inputValueNoSpace.indexOf("<" + htmlChar1[j]) + htmlChar1[j].length + 1 == inputValueNoSpace.length)){
					if (inputValueNoSpace.indexOf("<" + htmlChar1[j])!=-1){
						showCheckInfo(els[i],"不能包含<" + htmlChar1[j] + ">节点");
						isHtml = true;
						if (errObj == null){
							errObj = els[i];
						}
					}
				}
			}
		}
		for (var j=0;j<htmlChar.length;j++){
			if(htmlChar[j].atrim() != ""){
				if (inputValueNoSpace.indexOf("<" + htmlChar[j] + ">")!=-1 || inputValue.indexOf(htmlChar[j] + " ") != -1 || inputValueNoSpace.indexOf(htmlChar[j] + ">")!=-1 || (inputValueNoSpace.indexOf("<" + htmlChar[j]) + htmlChar[j].length + 1 == inputValueNoSpace.length)){
					if (inputValueNoSpace.indexOf("<" + htmlChar[j])!=-1){
						showCheckInfo(els[i],"不能包含<" + htmlChar[j] + ">节点");
						isHtml = true;
						if (errObj == null){
							errObj = els[i];
						}
					}
				}
				if (inputValueNoSpace.indexOf("</" + htmlChar[j] + ">")!=-1){
					showCheckInfo(els[i],"不能包含</" + htmlChar[j] + ">节点");
					isHtml = true;
					if (errObj == null){
						errObj = els[i];
					}
				}
			}
		}
	}
	// 判断textarea
	var els = form.tags("textarea");
	for (var i = 0; i < els.length; i++) {
		var inputValue = els[i].value.toUpperCase();
		var inputValueNoSpace = inputValue.atrim();
		if (inputValue.indexOf("TEXTAREA ") != -1 || inputValueNoSpace.indexOf("TEXTAREA>") != -1){
			if (inputValueNoSpace.indexOf("<TEXTAREA") != -1){
				showCheckInfo(els[i],"不能包含<textArea>节点");
				isHtml = true;
				if (errObj == null){
					errObj = els[i];
				}
			}
		}
		if (inputValueNoSpace.indexOf("</TEXTAREA>") != -1){
			showCheckInfo(els[i],"不能包含</textArea>节点");
			isHtml = true;
			if (errObj == null){
				errObj = els[i];
			}
		}
	}
	if (runFormVerify(form,isHtml)){
		_checkButton(form);
		return true;
	}
	onFocus();
	return false;
}

/**
 * 设置页面上所有按钮的状态
 * 
 * @param form
 *            要执行的标单
 * @param disabled
 *            是否为不可操作 true 不可操作，fasle 可操作
 */
function _checkButton(form,disabled){
	if (disabled==null){
		disabled = true;
	}else if (!disabled){
		disabled = false;
	}
	var els = form.tags("button");
	for (var i = 0; i < els.length; i++) {
		els[i].disabled = disabled;
	}
	els = form.tags("input");
	for (var i = 0; i < els.length; i++) {
		if (els[i].type=="button" || els[i].type=="submit" || els[i].type=="reset" || els[i].type=="image"){
			els[i].disabled = disabled;
		}
	}
	if(disabled){
		_S_();
	}else{
		_H_();
	}
}
function onFocus(){
	try{
		if (errObj == null){
			return false;
		}
		var tagName = errObj.tagName.toLowerCase();
		if ((tagName == "input" && (errObj.type == "text" || errObj.type == "password")) || tagName == "textarrea") {
			// errObj.focus();
			errObj.select();
		}
		errObj=null;
	}catch(e){
	}
}
function pageClose(form,winObj){
		
		if (runFormVerify(form)){
			winObj.close();
		}
}
function runFormVerify(form,isHtml) {
	// allMsg="";
	// var form = document.forms.item(formI);
	var result = true;
	var els = form.tags("input");
	for (var i = 0; i < els.length; i++) {

		if (!checkVerify(els[i])) {
			result = false;
		}
	}
	var els = form.tags("textarea");
	for (var i = 0; i < els.length; i++) {

		if (!checkVerify(els[i])) {
			result = false;
		}
	}
	var els = form.tags("select");
	for (var i = 0; i < els.length; i++) {

		if (!checkVerify(els[i])) {
			result = false;
		}
	}
	if (isHtml){
		result = false;
	}
	if (result == false) {
		outputMsg();
	}
	return result;
}

function checkVerify(el) {

	var tagName = el.tagName.toLowerCase();
	
	var notNull = el.getAttribute("notnull");
	if (notNull != null && notNull.trim() != "") {
		if (el.value == null || el.value.trim() == "") {
			showCheckInfo(el, notNull);
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
				showCheckInfo(el, "输入的内容过长！最大长度为：" + len + "字符");
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
				var estr = "校验错误，请检查restriction输入的校验类型是否正确，注意大小写\nrestriction=\"" + verify + "\"\n错误信息为：" + e + "\n";
				estr+="restriction可输入的内容包括以下之一或多项，多项时用;（分号）分割：\n";
				estr+="number;int;float;plus;plusInt;plusFloat;minus;minusInt;minusFloat;email;wordchar;zip;mobile;telephone;date;time;dateTime;hasSpecialChar;afterDate;beforeDate;afterDateTime;beforeDateTime;inValue;outValue;inField;outField;uperValue;lowerValue;uperField;lowerField";
				alert(estr);
			}
			if(success != checkResult)
				showCheckInfo(el, checkResult);
		}
		
	}
	if (reValue) {
		return true;
	}
	if (errObj == null){
		errObj = el;
	}
	return false;
}
 //当区域出现错误之后鼠标点击事件
 function error_onclick(el){
 	var classname=el.className;
 	if(!classname){
 		classname="";
 	}
  if(classname=='jiaoyanred'||classname=='select_jiaoyan'){
 	if(!_check_one(el)){
			var errMsg ="您输入的内容不符合要求，请重新输入"
			el.style.backgroundColor="";
			//打印信息
			var tempWidth = (errMsg.getByte()*6)+5;
			if (tempWidth<widths){
				tempWidth=widths;
			}
			showInfo(el,errMsg,tempWidth);
			}
   }
 }
  //当区域出现错误之后焦点离开事件
 function error_onblur(el){
 	var classname=el.className;
 	if(!classname){
 		classname="";
 	}
 	if(classname=='jiaoyanred'||classname=='select_jiaoyan'){
 	_check_one_jd(el); 
 	}
 }

function showCheckInfo(el, msg) {
	//如果是在域中提示，则执行以下代码
	if(isObjectTip){
		el.setAttribute("tipError",msg);
		//在这里写出现错误以后的对象的样式
		el.className="jiaoyanred";
		var tagName = el.tagName.toUpperCase();
		if(tagName=="SELECT"){
			el.parentNode.className="select_jiaoyan";
		}
		return;
	}
	if (msg==null){
		return;
	}
	var atitle = el.getAttribute(formTitle);
	if (atitle == null){
		atitle = el.title;
	}
	if (atitle == null){
		atitle = "";
	}
	if (allMsg!=""){
		allMsg+="\n";
	}
	if (allHtmlMsg!=""){
		allHtmlMsg+="<br>";
	}
	var gifResourcePath=resourcePath;
	//if (gifResourcePath.length>1){
//		gifResourcePath+="/";
	//}
	if (atitle==""){
		allMsg+=atitle + msg;
		allHtmlMsg+= "&nbsp;&nbsp;<IMG  src="+gifResourcePath + gifPath+" ><font class=" + clssName + " color="+color+">" + atitle + msg.encodeHtml()+"</font>";
	}else{
		allMsg+="[" + atitle + "]" + msg;
		allHtmlMsg+= "&nbsp;&nbsp;<IMG  src="+gifResourcePath+gifPath+" ><font class=" + clssName + " color="+color+">["+atitle + "]" + msg.encodeHtml()+"</font>";
	}
}
function msgClick(msgdiv) {
	var msgname = msgdiv.id.replace(new RegExp("^(.*)" + SUF_MSGDIV_ID + "$"), "$1");
	var index = 0;

	msgdiv.style.display = "none";
	try {
		document.getElementsByName(msgname)[index].focus();
	}
	catch (e) {}
}

// 获取某个Html元素在运行时的绝对位置信息
function GetAbsoluteLocationEx(element) 
{ 
	if ( arguments.length != 1 || element == null ) { 
		return null; 
	} 
	var elmt = element; 
	var offsetTop = elmt.offsetTop; 
	var offsetLeft = elmt.offsetLeft; 
	var offsetWidth = elmt.offsetWidth; 
	var offsetHeight = elmt.offsetHeight; 
	while( elmt = elmt.offsetParent ) { 
		// add this judge
		if ( elmt.style.position == 'absolute' || elmt.style.position == 'relative'  
			|| ( elmt.style.overflow != 'visible' && elmt.style.overflow != '' ) ) { 
			break; 
		}  
		offsetTop += elmt.offsetTop; 
		offsetLeft += elmt.offsetLeft; 
	} 
	return { absoluteTop: offsetTop, absoluteLeft: offsetLeft, 
		offsetWidth: offsetWidth, offsetHeight: offsetHeight }; 
}
/**
 * 校验信息的输出
 */ 
function outputMsg(){
	try{
		var o = document.getElementById(_msgcontent);
		var oTitle = document.getElementById(_msgTitle);
		if (o==null){
			o = oTitle;
		}
		o.innerHTML=allHtmlMsg;
		oTitle.style.display="";
		setClick(oTitle);
		window.location="#";
	}catch(e){
		if(!isObjectTip){
		alert(allMsg);
		}
	}
	allHtmlMsg = "";
	allMsg = "";
}
function setClick(obj){
	obj.onclick = function(){
		removeMsg();
	};
	obj.style.cursor="hand";
	obj.title="点击此处隐藏提示信息";
}
/**
 * 页面的特殊校验
 * @param msg 消息
 * @param msgType 消息的类型 info;debug;warn;error;fatal
 * @param isAdd 是否是清除以前的消息，true为不清楚，继续增加，false为清除
 */
function outputOtherMsg(msg,msgType,isAdd){
	try{
		var gifMsgPath;
		var colorMsg;
		var colorClass;
		if (msgType == null){ 
			gifMsgPath = gifResource["info"];
			colorMsg = gifResource["infoColor"];
			colorClass = gifResource["infoClass"];
		}else{
			gifMsgPath = gifResource[msgType];
			colorMsg = gifResource[msgType + "Color"];
			colorClass = gifResource[msgType + "Class"];
		}

		var htmlMsg = "&nbsp;&nbsp;<IMG  src="+gifMsgPath+" ><font class=" + colorClass + " color="+colorMsg+">" + msg+"</font>";
		output_Msg(htmlMsg,isAdd);
	}catch(e){
		alert(msg);
	}
}
function output_Msg(msg,isadd){
	var o = document.getElementById(_msgcontent);
	var oTitle = document.getElementById(_msgTitle);
	if (o==null){
		o = oTitle;
	}
	if (isadd){
		oldMsg = o.innerHTML;
		if (oldMsg==null || oldMsg==""){
			o.innerHTML=msg;
		}else{
			o.innerHTML=oldMsg + "<br>" + msg;
		}
	}else{
		o.innerHTML=msg;
	}
	o.style.display="";
	setClick(oTitle);
	window.location="#";
}
/**
 * 弹出提示信息
 * @param msg  消息
 * @param msgType 消息的类型 info;debug;warn;error;fatal
 * @return
 */
function _alert(msg,msgType){
	outputOtherMsg(msg,msgType);
}
/**
 * 除去所有错误
 */ 
function removeMsg(){
	try{
		var o = document.getElementById(_msgcontent);
		var oTitle = document.getElementById(_msgTitle);
		if (o==null){
			o = oTitle;
		}
		o.innerHTML="";
		oTitle.style.display="none";
		window.location="#";
	}catch(e){
	}
}
/**
 * 输出所有的错误
 */ 
function outputMsgs(msg,msgType){
	try{
		var gifMsgPath;
		var colorMsg;
		var colorClass;
		if (msgType == null){ 
			gifMsgPath = gifResource["info"];
			colorMsg = gifResource["infoColor"];
			colorClass = gifResource["infoClass"];
		}else{
			gifMsgPath = gifResource[msgType];
			colorMsg = gifResource[msgType + "Color"];
			colorClass = gifResource[msgType + "Class"];
		}

		var htmlMsg = "&nbsp;&nbsp;<IMG  src="+gifMsgPath+" ><font class=" + colorClass + " color="+colorMsg+">" + msg+"</font>";
		output_Msg(htmlMsg,true);
	}catch(e){
		alert(msg);
	}
}
/**
 * 判断用户是否在页面上选择指定名称的复选框
 * 
 * @param name
 *            单选和复选框的名称（name）
 * @param return
 *            有一个或以上选中返回true 否则返回false
 */
function hasSelected(name,char) {
	var selectValue = "";
	var selElements = document.getElementsByName(name);
	var isSel = false;
	for (var i = 0; i < selElements.length; i++) {
		if (selElements[i].tagName.toLowerCase() == "input") {
			if (selElements[i].type.toLowerCase() == "checkbox" || selElements[i].type.toLowerCase() == "radio") {
				if (selElements[i].checked) {
					if (char==null){
						return true;
					}else{
						if(selElements[i].value.indexOf(char)==-1){
							return false;
						}else{
							isSel=true;
						}
					}
				}
			}
			
		}
	}
	
	if (char==null){
		return false;
	}else{
		return isSel;
	}
}
/**
 * 取消指定名称的所有复选框选定
 * 
 * @param name
 *            单选和复选框的名称（name）
 */
function removeSelected(name) {
	var selElements = document.getElementsByName(name);
	for (var i = 0; i < selElements.length; i++) {
		if (selElements[i].tagName.toLowerCase() == "input") {
			if (selElements[i].type.toLowerCase() == "checkbox" || selElements[i].type.toLowerCase() == "radio") {
				selElements[i].checked = false;
			}
		}
	}
}
/**
 * 判断用户是否在页面上选择了一个且仅有一个指定名称的复选框
 * 
 * @param name
 *            单选和复选框的名称（name）
 * @param return
 *            只有一个选中返回true 否则返回false
 */
function hasSelectedOne(name) {
	var selElements = document.getElementsByName(name);
	var selected = false;
	for (var i = 0; i < selElements.length; i++) {
		if (selElements[i].tagName.toLowerCase() == "input") {
			if (selElements[i].type.toLowerCase() == "checkbox" || selElements[i].type.toLowerCase() == "radio") {
				if (selElements[i].checked) {
					if (selected == false) {
						selected = true;
					}
					else {
						return false;
					}
				}
			}
		}
	}
	return selected;
}
/**
 * 判断用户是否选中一个记录，如果选中1个记录，返回选中的值，如果没有选中或者选中多个记录，返回false
 * 
 * @param name
 *            单选和复选框的名称（name）
 * @param return
 *            只有一个选中返回选择的值 否则返回false
 */
function selectValue(name){
	var selElements = document.getElementsByName(name);
	var selected = false;
	var selValue = "";
	for (var i = 0; i < selElements.length; i++) {
		if (selElements[i].tagName.toLowerCase() == "input") {
			if (selElements[i].type.toLowerCase() == "checkbox" || selElements[i].type.toLowerCase() == "radio") {
				if (selElements[i].checked) {
					if (selected == false) {
						selected = true;
						selValue = selElements[i].value;
					}
					else {
						return false;
					}
				}
			}
		}
	}
	if (selected){
		return selValue;
	}else{
		return false;
	}
}

function _check_one_jd(obj){
	allHtmlMsg = "";
	allMsg = "";
//不管验证不验证，将input的text和textarea
	//判断input
   var jg;
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
		hide();
		//obj.className="txt_ok" + classNameEnd;
		obj.style.border = check_ok;
		var tagName = obj.tagName.toUpperCase();
		if(tagName=="SELECT"){
			obj.parentNode.className="select_jiaoyan_ok";
		}
		return true;
		return ;
	}
	//打印信息
	var tempWidth = (check_msg.getByte()*6)+5;
	if (tempWidth<widths){
		tempWidth=widths;
	}
	showInfo(obj,check_msg,tempWidth);
	check_msg="";
	//system_return=false;
	var tmp = obj.value;
	if(tmp!=null){
		tmp.substring(0,(tmp.length-1));
	}else{
		tmp="";
	}
	obj.style.border = check_warning;
	var tagName = obj.tagName.toUpperCase();
		if(tagName=="SELECT"){
			obj.parentNode.className="select_jiaoyan";
		}
	return false;
	
}