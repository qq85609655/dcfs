var MB_OK = 0;
var MB_CANCEL = 1;
var MB_OKCANCEL = 2;
var MB_YES = 3;
var MB_NO = 4;
var MB_YESNO = 5;
var MB_YESNOCANCEL = 6;
var MB_OK_TEXT = "确定";
var MB_CANCEL_TEXT = "取消";
var MB_YES_TEXT = " 是 ";
var MB_NO_TEXT = " 否 ";
var MB_OK_METHOD = null;
var MB_CANCEL_METHOD = null;
var MB_YES_METHOD = null;
var MB_NO_METHOD = null;
var MB_BACKCALL = null;
var MB_STR = '<style type="text/css"><!--' +
'body{margin:0px;}' +
'.msgbox_title{background-color: #B1CDF3;height:25px;position:relative;font-size:14px;line-height:25px;padding-left:10px;border-bottom:1px solid #000;}' +
'.msgbox_control{text-align:center;clear:both;height:28px;}' +
'.msgbox_button{background-color: #B1CDF3;border:1px solid #003366;font-size:12px;line-height:20px;height:21px;}' +
'.msgbox_content{padding:10px;float:left;line-height: 20px;}' +
'.msgbox_mask{position:absolute;left:0px;top:0px;z-index:99999;background-color:#333333;width:100%;height:100%;}' +
'.msgbox{background-color: #EFFAFE;position: absolute;height:auto;font-size:12px;top:50%;left:50%;border:1px solid #999999;}' +
'--></style>' +
'<div id="msgBoxMask" class="msgbox_mask" style="filter: alpha(opacity=0);display:none;"></div>' +
'<div class="msgbox" style="display:none; z-index:100000;" id="msgBox">' +
'<div class="msgbox_title" id="msgBoxTitle"></div>' +
'<div class="msgbox_content" id="msgBoxContent"></div>' +
'<div class="msgbox_control" id="msgBoxControl"></div></div>';
var Timer = null;
document.write(MB_STR);
function MessageBox(){
var _content = arguments[0] || "这是一个对话框！";
var _title   = arguments[1] || "提示";
var _button  = arguments[2] || MB_OK;
MB_BACKCALL  = arguments[3];

var _btnStr  = '<input name="{0}" id="{0}" type="button" class="msgbox_button" value="{1}" onclick="MBMethod(this)" />';


switch(_button)
{
case MB_CANCEL      : _btnStr = _btnStr.toFormatString("msgBoxBtnCancel", MB_CANCEL_TEXT); break;

case MB_YES         : _btnStr = _btnStr.toFormatString("msgBoxBtnYes", MB_YES_TEXT); break;

case MB_NO          : _btnStr = _btnStr.toFormatString("msgBoxBtnNo", MB_NO_TEXT); break;

case MB_OKCANCEL    :
		_btnStr = _btnStr.toFormatString("msgBoxBtnOk", MB_OK_TEXT) + "&nbsp;&nbsp;" +
				_btnStr.toFormatString("msgBoxBtnCancel", MB_CANCEL_TEXT);
	break;

case MB_YESNO       :
		_btnStr = _btnStr.toFormatString("msgBoxBtnYes", MB_YES_TEXT) + "&nbsp;&nbsp;" +
				_btnStr.toFormatString("msgBoxBtnNo", MB_NO_TEXT);
	break;

case MB_YESNOCANCEL :
		_btnStr = _btnStr.toFormatString("msgBoxBtnYes", MB_YES_TEXT) + "&nbsp;&nbsp;" +
				_btnStr.toFormatString("msgBoxBtnNo", MB_NO_TEXT) + "&nbsp;&nbsp;" +
	_btnStr.toFormatString("msgBoxBtnCancel", MB_CANCEL_TEXT);
	break;

default :  _btnStr = _btnStr.toFormatString("msgBoxBtnOk", MB_OK_TEXT);  break;

}
ScrollTop = GetBrowserDocument().scrollTop;
ScrollLeft = GetBrowserDocument().scrollLeft;
GetBrowserDocument().style.overflow = "hidden";
GetBrowserDocument().scrollTop = ScrollTop;
GetBrowserDocument().scrollLeft = ScrollLeft;

$("msgBoxTitle").innerHTML = _title;
$("msgBoxContent").innerHTML = _content;
$("msgBoxControl").innerHTML =  _btnStr;

OpacityValue = 0;
$("msgBox").style.display = "";
try{$("msgBoxMask").filters("alpha").opacity = 0;}catch(e){};
$("msgBoxMask").style.opacity = 0;
$("msgBoxMask").style.display = "";
$("msgBoxMask").style.height = GetBrowserDocument().scrollHeight + "px";
$("msgBoxMask").style.width = GetBrowserDocument().scrollWidth + "px";

Timer = setInterval("DoAlpha()",1);
$("msgBox").style.width = "100%";
$("msgBox").style.width = ($("msgBoxContent").offsetWidth + 2) + "px";

$("msgBox").style.marginTop = (-$("msgBox").offsetHeight/2 + GetBrowserDocument().scrollTop) + "px";
$("msgBox").style.marginLeft = (-$("msgBox").offsetWidth/2 + GetBrowserDocument().scrollLeft) + "px";

if(_button == MB_OK || _button == MB_OKCANCEL){
	$("msgBoxBtnOk").focus();
}else if(_button == MB_YES || _button == MB_YESNO || _button == MB_YESNOCANCEL){
	$("msgBoxBtnYes").focus();
}
}
var OpacityValue = 0;
var ScrollTop = 0;
var ScrollLeft = 0;
function GetBrowserDocument()
{
var _dcw = document.documentElement.clientHeight;
var _dow = document.documentElement.offsetHeight;
var _bcw = document.body.clientHeight;
var _bow = document.body.offsetHeight;

if(_dcw == 0) return document.body;
if(_dcw == _dow) return document.documentElement;

if(_bcw == _bow && _dcw != 0)
	return document.documentElement;
else
	return document.body;
}
function SetOpacity(obj,opacity){
if(opacity >=1 ) opacity = opacity / 100;

try{obj.style.opacity = opacity; }catch(e){}

try{
if(obj.filters){
	obj.filters("alpha").opacity = opacity * 100;
}

}catch(e){}
}

function DoAlpha(){
if (OpacityValue > 20){clearInterval(Timer);return 0;}
OpacityValue += 5;
SetOpacity($("msgBoxMask"),OpacityValue);
}
function MBMethod(obj)
{
switch(obj.id)
{
	case "msgBoxBtnOk" : if(MB_BACKCALL) {MB_BACKCALL(MB_OK);} else {if(MB_OK_METHOD) MB_OK_METHOD();} break;
case "msgBoxBtnCancel" : if(MB_BACKCALL) {MB_BACKCALL(MB_CANCEL);} else {if(MB_CANCEL_METHOD) MB_CANCEL_METHOD();} break;
case "msgBoxBtnYes" : if(MB_BACKCALL) {MB_BACKCALL(MB_YES);} else {if(MB_YES_METHOD) MB_YES_METHOD();} break;
case "msgBoxBtnNo" : if(MB_BACKCALL) {MB_BACKCALL(MB_NO);} else {if(MB_NO_METHOD) MB_NO_METHOD();} break;
}

MB_OK_METHOD = null;
MB_CANCEL_METHOD = null;
MB_YES_METHOD = null;
MB_NO_METHOD = null;
MB_BACKCALL = null;

MB_OK_TEXT = "确定";
MB_CANCEL_TEXT = "取消";
MB_YES_TEXT = " 是 ";
MB_NO_TEXT = " 否 ";

$("msgBox").style.display = "none";
$("msgBoxMask").style.display = "none";
GetBrowserDocument().style.overflow = "";
GetBrowserDocument().scrollTop = ScrollTop;
GetBrowserDocument().scrollLeft = ScrollLeft;
}
String.prototype.toFormatString = function(){
var _str = this;
for(var i = 0; i < arguments.length; i++){
	_str = eval("_str.replace(/\\{"+ i +"\\}/ig,'" + arguments[i] + "')");
}
return _str;
}
function $(obj){
return document.getElementById(obj);
}
function callback(value)
{
	return value;
}
function empty(v){
	switch (typeof v){
		case 'undefined' : return true;
		case 'string'    : if(trim(v).length == 0) return true; break;
		case 'boolean'   : if(!v) return true; break;
		case 'number'    : if(0 === v) return true; break;
		case 'object'    :
			if(null === v) return true;
			if(undefined !== v.length && v.length==0) return true;
			for(var k in v){return false;} return true;
			break;
	}
	return false;
}