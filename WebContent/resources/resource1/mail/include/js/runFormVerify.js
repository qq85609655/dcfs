/**
* bodyonload��������ҳ����Ҫ��BODY��onload�¼���ִ�еĳ���
* ��ҳ�������js�ļ�ʱ��Ҫ��ҳ���BODY��ǩ�в�������onload�¼���
* ��Ҫ�ڴ��¼���ִ�е�JS���������õ��˱����С�������ҳ���onload�¼���ִ����Щ���롣
* ���磺
* <script language="javascript" src="runFormVerify.js"></script>
* <script language="javascript">
* 	bodyonload = "alert('onload�¼������еĳ���')";
* </script>
*/
var allHtml = "B,BIG,APPLET,ABBR,ACRONYM,ADDRESS,BASEFONT,BDO,BGSOUND,BIG,BLINK,BLOCKQUOTE,BR,BUTTON,CENTER,CITE,CITE,CODE,DEL,DFN,DIR,DIV,DL,EM,EMBED,FIELDSET,FONT,H1,H6,H2,H3,H4,H5,HR,I,IFRAME,IMG,INS,,KBD,LABEL,MAP,MARQUEE,MENU,NOBR,NOFRAMES,NOSCRIPT,OBJECT,OL,P,PRE,Q,S,SAMP,SCRIPT,SELECT,SMALL,SPAN,STRIKE,STRONG,SUB,SUP,TABLEtrtd,TEXTAREA,TT,U,UL,VAR,WBR";
var allHtml1 = "INPUT,ISINDEX";
var searchHtml = "',\",?,%";
var inputHtml = "\",>,<";
 	var htmlChar1 = allHtml1.split(",");
	var htmlChar = allHtml.split(",");
	var searchChar = searchHtml.split(",");
	var inputChar = inputHtml.split(",");
var formTitle = "formTitle"; 
var allMsg="";
var allHtmlMsg="";
//Ϊ����ʾ�����Ժ������һ�������Ϲ����ҳ��
var errObj = null;
var gifResource = new Array();
gifResource["info"] = "../images/MessageInfo.gif";
gifResource["infoColor"] = "#009900";
gifResource["infoClass"] = "show_info";
gifResource["debug"] = "../images/MessageDebug.gif";
gifResource["debugColor"] = "#0066FF";
gifResource["debugClass"] = "show_debug";
gifResource["warn"] = "../images/MessageWarn.gif";
gifResource["warnColor"] = "#0066FF";
gifResource["warnClass"] = "show_warn";
gifResource["error"] = "../images/MessageError.gif";
gifResource["errorColor"] = "#FF0000";
gifResource["errorClass"] = "show_error";
gifResource["fatal"] = "../images/MessageFatal.gif";
gifResource["fatalColor"] = "#0066FF";
gifResource["fatalClass"] = "show_fatal";
var gifPath=gifResource["info"];
var color=gifResource["infoColor"];
var clssName=gifResource["infoClass"];
/**
 * ����ҳ��Ĭ�ϵ�onload����
 */
function _load(){

}

/**
 * ҳ���ύ
 */
function pageshow(form,verify){
	allHtmlMsg = "";
	allMsg = "";
//������֤����֤����input��text��textarea
	//�ж�input
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
function _check(form){
	allHtmlMsg = "";
	allMsg = "";
//������֤����֤����input��text��textarea
	//�ж�input
	var els = form.tags("input");
	var isHtml = false;
	for (var i = 0; i < els.length; i++) {
		var inputValue = els[i].value.toUpperCase();
		var inputValueNoSpace = inputValue.atrim();
		
		//��ѯ�ı��������ַ��Ĵ���
		if (els[i].getAttribute("searchInput")=="true"){
			for (var j=0;j<searchChar.length;j++){
				if(searchChar[j].atrim() != ""){
					if (inputValueNoSpace.indexOf(searchChar[j])!=-1){
						showCheckInfo(els[i],"��ѯ�����в��ܰ���[" + searchChar[j] + "]�ַ�");
						isHtml = true;
						if (errObj == null){
							errObj = els[i];
						}
					}
				}
			}
		}else{
//input��ѯ
			for (var j=0;j<inputChar.length;j++){
				if(inputChar[j].atrim() != ""){
					if (inputValueNoSpace.indexOf(inputChar[j])!=-1){
						showCheckInfo(els[i],"���ܰ���[" + inputChar[j] + "]�ַ�");
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
						showCheckInfo(els[i],"���ܰ���<" + htmlChar1[j] + ">�ڵ�");
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
						showCheckInfo(els[i],"���ܰ���<" + htmlChar[j] + ">�ڵ�");
						isHtml = true;
						if (errObj == null){
							errObj = els[i];
						}
					}
				}
				if (inputValueNoSpace.indexOf("</" + htmlChar[j] + ">")!=-1){
					showCheckInfo(els[i],"���ܰ���</" + htmlChar[j] + ">�ڵ�");
					isHtml = true;
					if (errObj == null){
						errObj = els[i];
					}
				}
			}
		}
	}
	//�ж�textarea
	var els = form.tags("textarea");
	for (var i = 0; i < els.length; i++) {
		var inputValue = els[i].value.toUpperCase();
		var inputValueNoSpace = inputValue.atrim();
		if (inputValue.indexOf("TEXTAREA ") != -1 || inputValueNoSpace.indexOf("TEXTAREA>") != -1){
			if (inputValueNoSpace.indexOf("<TEXTAREA") != -1){
				showCheckInfo(els[i],"���ܰ���<textArea>�ڵ�");
				isHtml = true;
				if (errObj == null){
					errObj = els[i];
				}
			}
		}
		if (inputValueNoSpace.indexOf("</TEXTAREA>") != -1){
			showCheckInfo(els[i],"���ܰ���</textArea>�ڵ�");
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
 * ����ҳ�������а�ť��״̬
 * @param form Ҫִ�еı굥
 * @param disabled �Ƿ�Ϊ���ɲ��� true ���ɲ�����fasle �ɲ���
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
			//errObj.focus();
			errObj.select();
		}
	}catch(e){}
}
function pageClose(form,winObj){
		
		if (runFormVerify(form)){
			winObj.close();
		}
}
function runFormVerify(form,isHtml) {
	//allMsg="";
	//var form = document.forms.item(formI);
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
		var min = el.getAttribute("minlength");
		if (len != null && !isNaN(parseInt(len)) && parseInt(len) > 0) {
			if (el.value.getByte() > parseInt(len)) {
				showCheckInfo(el, "��������ݹ�������󳤶�Ϊ��" + len + "�ַ�");
				if (errObj == null){
					errObj = el;
				}
				return false;
			}
		}
		
		if (min != null && !isNaN(parseInt(min)) && parseInt(min) > 0) {
			if (el.value.getByte() < parseInt(min)) {
				showCheckInfo(el, "��������ݹ��̣���С����Ϊ��" + min + "�ַ�");
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
				try{
					Ext.Msg.alert("��ʾ","У���������restriction�����У�������Ƿ���ȷ��ע���Сд��" + verify + "\n����" + e);
				}catch(e){
					alert("У���������restriction�����У�������Ƿ���ȷ��ע���Сд��" + verify + "\n����" + e);
				}
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

function showCheckInfo(el, msg) {
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
	if (atitle==""){
		allMsg+=atitle + msg+"\n";
		allHtmlMsg+= "&nbsp;&nbsp;<IMG  src="+gifPath+" ><font class=" + clssName + " color="+color+">" + atitle + msg.encodeHtml()+"</font>";
	}else{
		allMsg+="[" + atitle + "]" + msg+"\n";
		allHtmlMsg+= "&nbsp;&nbsp;<IMG  src="+gifPath+" ><font class=" + clssName + " color="+color+">["+atitle + "]" + msg.encodeHtml()+"</font>";
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

//��ȡĳ��HtmlԪ��������ʱ�ľ���λ����Ϣ
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
 * У����Ϣ�����
 */ 
function outputMsg(){

	try{
		document.getElementById("msg").innerHTML=allHtmlMsg;
		document.getElementById("msg").style.display="";
		setClick(document.getElementById("msg"));
		window.location="#";
	}catch(e){
		try{
			Ext.Msg.alert("��ʾ",allMsg);
		}catch(e){
			alert(allMsg);
		}
		
	}
	allHtmlMsg = "";
	allMsg = "";
}
function setClick(obj){
	obj.onclick = function(){
		removeMsg();
	}
	obj.title="����˴�������ʾ��Ϣ";
}
/**
 * ҳ�������У��
 */ 
function outputOtherMsg(msg,msgType){
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
		document.getElementById("msg").innerHTML=htmlMsg;
		document.getElementById("msg").style.display="";
		setClick(document.getElementById("msg"));
		window.location="#";
	}catch(e){
		try{
			Ext.Msg.alert("��ʾ",msg);
		}catch(e){
			alert(msg);
		}
	}
}
function _alert(msg,msgType){
	outputOtherMsg(msg,msgType);
}
/**
 * ��ȥ���д���
 */ 
function removeMsg(){
	try{
		document.getElementById("msg").innerHTML="";
		document.getElementById("msg").style.display="none";
		window.location="#";
	}catch(e){
	}
}
/**
 * ������еĴ���
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
		 
		var msgObj=document.getElementById("msg");
		if (msgObj.innerHTML==""){
			msgObj.innerHTML=htmlMsg;
		}else{
			msgObj.innerHTML+="<br>" + htmlMsg;
		}
		document.getElementById("msg").style.display="";
		setClick(document.getElementById("msg"));
		window.location="#";
	}catch(e){
		try{
			Ext.Msg.alert("��ʾ",msg);
		}catch(e){
			alert(msg);
		}
	}
}
/**
 * �ж��û��Ƿ���ҳ����ѡ��ָ�����Ƶĸ�ѡ��
 * @param name ��ѡ�͸�ѡ������ƣ�name��
 * @param return ��һ��������ѡ�з���true ���򷵻�false
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
 * ȡ��ָ�����Ƶ����и�ѡ��ѡ��
 * @param name ��ѡ�͸�ѡ������ƣ�name��
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
 * �ж��û��Ƿ���ҳ����ѡ����һ���ҽ���һ��ָ�����Ƶĸ�ѡ��
 * @param name ��ѡ�͸�ѡ������ƣ�name��
 * @param return ֻ��һ��ѡ�з���true ���򷵻�false
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
 * �ж��û��Ƿ�ѡ��һ����¼�����ѡ��1����¼������ѡ�е�ֵ�����û��ѡ�л���ѡ�ж����¼������false
 * @param name ��ѡ�͸�ѡ������ƣ�name��
 * @param return ֻ��һ��ѡ�з���ѡ���ֵ ���򷵻�false
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
// ���� select
function selecthidden(){
 var  input_elements=document.getElementsByTagName("select");
 var  theLength=input_elements.length;
 for(i=0;i<theLength;i++)
 {
  input_elements[i].style.visibility="hidden";
  }
}
// ��ʾ select
function selectshow(){
 var  input_elements=document.getElementsByTagName("select");
 var  theLength=input_elements.length;
 for(i=0;i<theLength;i++)
 {
  input_elements[i].style.visibility="";
  }
}
//  ����һ����͸�������ֲ�
function createBlurDiv(msg){
var objScreen = document.createElement("div");
if (msg==null){
	msg="�����ύ���ݣ����Ժ�...";
}
var oS = objScreen.style;
 objScreen.id = "ScreenOver";
 oS.display = "block";
 oS.top = oS.left = oS.margin = oS.padding = "0px";
 if (document.body.scrollHeight)
 {
  var wh = document.body.scrollHeight + "px";
 }else if (window.innerHeight){
   var wh = window.innerHeight + "px";
  }else{
   var wh = "100%";
  }
oS.width = document.body.scrollWidth + "px";

oS.height = wh;
oS.position = "absolute";
oS.zIndex = "3";
oS.background = "#cccccc";
oS.filter = "alpha(opacity=40)";
oS.opacity = 40/100;
oS.MozOpacity = 40/100;
document.body.appendChild(objScreen);
objScreen.innerHTML="<table width=\"100%\" height=\"100%\" border=\"0\"><tr><td valign=\"middle\" align=\"center\" style=\"color: #0000FF\">" + msg + "</td></tr></table>";
selecthidden();
}

//�Ƴ����ֲ�
function removeBlurDiv(){
 var ScreenOver = document.getElementById("ScreenOver");
 document.body.removeChild(ScreenOver);
 selectshow();
}
// ����
function _S_(msg){
 createBlurDiv(msg);
 }
// ��ʧ
function _H_(divname){
 removeBlurDiv();
 }
