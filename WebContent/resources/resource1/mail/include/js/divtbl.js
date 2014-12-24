var IMGPATH		= '/';
var form='';
var php_bgPicture   = "orangebg.gif";   
var php_arrow       = "orangearrow.gif";
var php_bgColor     = "#FF831F";
var objX = 0;
var objY = 0;
var bodyScrollWidth=0;
var bodyScrollHeight=0;
var screenAvailWidth=window.screen.availWidth;
var screenAvailHeight=window.screen.availHeight;
var bdMvEvt;
var bdUpEvt;
function recoverBodyEvent() {
    document.body.onmousemove = bdMvEvt;
    document.body.onmouseup = bdUpEvt;
}
if(navigator.appName.indexOf("Explorer") > -1){//ie
	var exp=1;
} 
else{//for ff
	var exp=2;
}
var layer=new Array();
var dragObj;
var dragObjId;
reCalBodySize();
function reCalBodySize(){
	bodyScrollWidth=document.documentElement.scrollWidth;
	bodyScrollHeight=document.documentElement.scrollHeight;
}
function checkAndResetStyleTop (obj) {
	var clientHeight=obj.firstChild.clientHeight;
	var styleTop=parseInt(obj.style.top.substring(0,obj.style.top.length-2));
	if ( clientHeight+styleTop>bodyScrollHeight ) {
		obj.style.top=(bodyScrollHeight- clientHeight)+'px';
	}
}
	
function set_div_style(obj,id,top,left,width,height,position,border,cursor,background) {
        var obj = obj;
        obj.id = id?id:null;
        obj.style.top = top?top:'0px';
        obj.style.left = left?left:'0px';
        obj.style.width = width?width:'0px';
        obj.style.height = height?height:'0px';
        obj.style.position = position?position:"static";
        obj.style.border = border?border:"1px #000 solid";
        obj.style.cursor = cursor?cursor:"default";
        obj.style.background = background?background:"";
        return obj;
}
function drag_mouse_down(event,obj){
	var obj_left = obj.style.left;
	var obj_top = obj.style.top;
	var obj_left = obj_left.replace(/p|x/g,"");
	var obj_top = obj_top.replace(/p|x/g,"");
	if ( event == null ) {//IE必须
		event=window.event;
	}
	var clientX = String(event.clientX).replace(/p|x/g,"");
	var clientY = String(event.clientY).replace(/p|x/g,"");
	objX = clientX - obj_left;
	objY = clientY - obj_top;
}
function drag(event,obj){
	if( objX != 0 && objY != 0 ) {
		if ( event == null ) {//IE必须
			event=window.event;
		}
		if ( event.button == 1 ||  event.button == 0 ){
			var objWidth=obj.firstChild.clientWidth;
			var objHeight=obj.firstChild.clientHeight;
			reCalBodySize();
			var leftPo= event.clientX-objX;
			if ( leftPo < 0 ) {
				leftPo=0;
			}
			if ( leftPo > bodyScrollWidth-objWidth ) {
				leftPo=bodyScrollWidth-objWidth;
			}
			var topPo=event.clientY-objY;
			if ( topPo < 0 ) {
				topPo=0;
			}
			if ( topPo > bodyScrollHeight-objHeight ) {
				topPo=bodyScrollHeight-objHeight;
			}
			obj.style.left=leftPo+'px';
			obj.style.top=topPo+'px';
		}
	}
}
function GetLength(strTemp){
	var i,sum;
	sum=0;
	for(i=0;i<strTemp.length;i++){
		if ((strTemp.charCodeAt(i)>=0) && (strTemp.charCodeAt(i)<=255)) 
			sum = sum + 1;
		else 
			sum=sum + 2;
	}
	return sum;
}
function subStringPro(str, length){
	var stri = '';
	for(i=0,j=0; j<length;){
		if ((str.charCodeAt(i)>=0) && (str.charCodeAt(i)<=255)) {
			stri += str.charAt(i);
			j++;
		} else {
			stri += str.charAt(i);
			j += 2;
		}
		i++;
	}
	return stri;
}
//*********************
//隐藏元素
function HideElement(strElementTagName){
	try{
		for(i=0;i<window.document.all.tags(strElementTagName).length; i++){
			var objTemp = window.document.all.tags(strElementTagName)[i];
			objTemp.style.visibility = "hidden";
		}
	}catch(e){
		alert(e.message);
	}
}
//显示元素
function ShowElement(strElementTagName){
	try{
		for(i=0;i<window.document.all.tags(strElementTagName).length; i++){
			var objTemp = window.document.all.tags(strElementTagName)[i];
			objTemp.style.visibility = "visible";
		}
	}catch(e){
		alert(e.message);
	}
}
function hideElementAll(){
	HideElement("SELECT");
	HideElement("OBJECT");
	HideElement("IFRAME");
}
function showElementAll(){
	ShowElement("SELECT");
	ShowElement("OBJECT");
	ShowElement("IFRAME");
}
//滤镜效果
function hide() {
	synSizeByBody("globalDiv");
	document.getElementById("globalDiv").style.display = "block";
	if ( 1 == exp ) {
		hideElementAll();
	}
}
function cancel() {
	document.getElementById("globalDiv").style.display = "none";
	if ( 1 == exp ) {
		showElementAll();
	}
	
	recoverBodyEvent();
}
function buildGlobalDiv(){
		var globalDiv=document.createElement('div');
		globalDiv.id='globalDiv';
		globalDiv.style.display='none';
		globalDiv.style.zIndex='107';
		
		globalDiv = set_div_style(globalDiv,'globalDiv','0px','0px',bodyScrollWidth+'px',bodyScrollHeight+'px',"absolute"," #333333 0px solid","default","darkgray");
		
		
		if ( 1 == exp ) {
			globalDiv.style.filter="alpha(opacity=30)";
		}
		else {
			globalDiv.style.opacity=30/100;
		}
		document.body.appendChild(globalDiv);
}
function synSizeByBody() {
	reCalBodySize();
	var argArr=synSizeByBody.arguments;
	for ( var i=0;i<argArr.length;i++ ) {
		if ( document.getElementById(argArr[i]) != null ) {
			document.getElementById(argArr[i]).style.width = (bodyScrollWidth)+'px';
			document.getElementById(argArr[i]).style.height = (bodyScrollHeight)+'px';
		}
	}
}
//将悬浮层的位置定位在body可见区域中央
function GetCenterXY_ForLayer(objdiv){
	objdiv.style.display='block';
	var styleWidth=objdiv.style.width.substring(0,objdiv.style.width.length-2);
	var clientHeight=objdiv.clientHeight;
	var objLeft = parseInt(document.documentElement.scrollLeft+(document.documentElement.clientWidth - styleWidth)/2)+'px';
	var relTop=(document.documentElement.clientHeight-clientHeight)/2 > 0 ? (document.documentElement.clientHeight-clientHeight)/2:0;
	var objTop = parseInt(document.documentElement.scrollTop+relTop)+'px';
	objdiv.style.top = objTop;
	objdiv.style.left = objLeft;
	checkAndResetStyleTop(objdiv);
}
//************************************************************
function $(str) {//通过对象ID返回对象
	if (typeof str == 'string' && document.getElementById(str) != null ) {
		return document.getElementById(str);
	}
	return false;
}
function buildDiv(myLayerID){
		dragObjId=document.getElementById(myLayerID);
		dragObjId.style.visibility='hidden';
		dragObjId.style.zIndex='999';
		var styleWidth=dragObjId.firstChild.clientWidth+'px'
		var styleHeight=dragObjId.firstChild.clientHeight+'px';
		var layerId = myLayerID;
		//dragObjId = set_div_style(dragObjId,layerId,'0px','0px','100px','100px',"absolute","0px solid #c0d4db","default","#fff");
		dragObjId.style.marginTop=(bodyScrollHeight-dragObjId.clientHeight)/2;
		dragObjId.style.marginLeft=(bodyScrollWidth-dragObjId.clientWidth)/2;
		dragObj=dragObjId.firstChild;
		dragObj.style.cursor='move';
		dragObj.onmousedown = function(event){drag_mouse_down(event,this.parentNode)};
		dragObjId.onselectstart=function(){return false};
		if ( 1 == exp ) {
			dragObjId.firstChild.onresize=function(){checkAndResetStyleTop(this.parentNode)};
		}
		else {
			dragObjId.firstChild.onclick=function(){checkAndResetStyleTop(this.parentNode)};
		}
}
function hiddenLayerOther(layerID){
	for( var i=0;i<dragObjId.length;i++ ){
		if ( dragObjId[i] != layerID && document.getElementById(dragObjId[i]) != null ) {
			hiddenLayer(dragObjId[i]);
		}
	}
}

function displayLayer1(layerID){
	buildDiv(layerID);
	if ( document.getElementById(layerID) != null){
		var dv = document.getElementById(layerID);
		
		//hiddenLayerOther(layerID);
		if ( dv.style.visibility == "hidden" ) {
			GetCenterXY_ForLayer(dv);
			dv.style.visibility = "visible";
		}
		document.body.onmousemove = function (event){drag(event,dv)};
		document.body.onmouseup = function(){objX = 0;objY=0};
	}
	return false;
}
function displayLayer2(layerID,ccid){
		var ccidd = document.getElementById("ccidd");
		ccidd.value=ccid;
		document.getElementById("ccnamed").value="";
		document.getElementById("cccoded").value="";
		document.getElementById("ccnumberd").value="";
		document.getElementById("ccdescriptiond").value="";
	buildDiv(layerID);
	if ( document.getElementById(layerID) != null){
		var dv = document.getElementById(layerID);
		
		//hiddenLayerOther(layerID);
		if ( dv.style.visibility == "hidden" ) {
			GetCenterXY_ForLayer(dv);
			dv.style.visibility = "visible";
		}
		document.body.onmousemove = function (event){drag(event,dv)};
		document.body.onmouseup = function(){objX = 0;objY=0};
	}
	return false;
}

function displayLayer6(layerID,ccid,ccname,cccode,ccnumber,ccdesc)
{
		var dccid = document.getElementById("dccid");
		var dccname=document.getElementById("dccname");
		var dcccode = document.getElementById("dcccode");
		var dccnumber = document.getElementById("dccnumber");
		var dccdesc = document.getElementById("dccdescription");
		dccid.value=ccid;
		dccname.value=ccname;
		dcccode.value=cccode;
		dccnumber.value=ccnumber;
		dccdesc.value=ccdesc;
	buildDiv(layerID);
	if ( document.getElementById(layerID) != null){
		var dv = document.getElementById(layerID);
		
		//hiddenLayerOther(layerID);
		if ( dv.style.visibility == "hidden" ) {
			GetCenterXY_ForLayer(dv);
			dv.style.visibility = "visible";
		}
		document.body.onmousemove = function (event){drag(event,dv)};
		document.body.onmouseup = function(){objX = 0;objY=0};
	}
	return false;
}


function hiddenLayer(){
	var argArr = hiddenLayer.arguments;
	for(var i=0;i<argArr.length;i++){
		if ( document.getElementById(argArr[i])!=null ) {
			if ( argArr[i] == 'popupArea' ) {
				//document.getElementById('sub_'+argArr[i]).innerHTML='';
				//document.getElementById('tr_sub_'+argArr[i]).style.display='none';
			}
			document.getElementById(argArr[i]).style.visibility = "hidden";
		}
	}
}


var theFlag = 0;//操作是否开始(1是；0否)
var theDiv;//拖曳对象
var x = 0;//鼠标按下时的初始x座标
var y = 0;//鼠标按下时的初始y座标
var divTop = 0;//拖曳对象当前的top值
var divLeft = 0;//拖曳对象当前的left值

//鼠标按下事件
function selectBegin(e)
{
    theFlag = 1;
    e.setCapture();
    
    theDiv = document.getElementById(e.id);
    //鼠标起始值
    x = parseInt(document.body.scrollLeft) + parseInt(event.clientX);//鼠标按下初始x座标值
    y = parseInt(document.body.scrollTop) + parseInt(event.clientY);//鼠标按下初始y座标值
    divTop = parseInt(theDiv.offsetTop);//拖曳对象当前的top值
    divLeft = parseInt(theDiv.offsetLeft);//拖曳对象当前的left值
}
//鼠标移动事件
function selectMove(e)
{
    if(theFlag == 1)
    {
        var mouseX = parseInt(document.body.scrollLeft) + parseInt(event.clientX);//捕获鼠标当前座标
        var mouseY = parseInt(document.body.scrollTop) + parseInt(event.clientY);
        theDiv.style.top = divTop + (mouseY - y);//重置拖曳对象位置
        theDiv.style.left = divLeft + (mouseX - x);
    }
}
//鼠标松开事件
function selectEnd(e)
{
    theFlag = 0;
    e.releaseCapture();
}
var selectObj;
function _resizeClientHeight(id,e,height,fangxiang,selectID){
 	var obj=selectObj;
   	var xy = _getSelectPosition(obj);
	var treeDiv = document.getElementById(id);
	var treeFrame = document.getElementById(id+"treeFrame");
    if (e.clientHeight>=height)
    {
    	treeDiv.style.overflow="auto";
    	treeDiv.style.overflowX = "hidden";
    	treeDiv.style.height=height;
    	treeFrame.style.height=treeDiv.offsetHeight;
		treeFrame.style.width=treeDiv.offsetWidth;
    }
    else
    {
    	treeDiv.style.height=e.clientHeight+5;
    	treeFrame.style.height=treeDiv.offsetHeight;
		treeFrame.style.width=treeDiv.offsetWidth;
    	
    }
    if (fangxiang=="left"){
		treeDiv.style.posLeft=xy[0]-(treeDiv.clientWidth-obj.offsetWidth);
		treeDiv.style.posTop=xy[1]+20;
		treeFrame.style.posLeft=xy[0]-(treeDiv.clientWidth-obj.offsetWidth);
		treeFrame.style.posTop=xy[1]+20;
	}else if(fangxiang=="top"){
		treeDiv.style.posLeft=xy[0]-(treeDiv.clientWidth-obj.offsetWidth);
		treeDiv.style.posTop=xy[1]-treeDiv.clientHeight;
		treeFrame.style.posLeft=xy[0]-(treeDiv.clientWidth-obj.offsetWidth);
		treeFrame.style.posTop=xy[1]-treeDiv.clientHeight;
	}else{
		treeDiv.style.posLeft=xy[0];
		treeDiv.style.posTop=xy[1]+20;
		treeFrame.style.posLeft=xy[0];
		treeFrame.style.posTop=xy[1]+20;
	}
}


function _displayDiv(obj,id,isShow,fangxiang)
{	
	var xy = _getSelectPosition(obj);
	selectObj = obj;
	var treeDiv = document.getElementById(id);
	var treeFrame = document.getElementById(id+"treeFrame");
	
	if (isShow=="yes")
	{
		hide();		
		treeDiv.style.display = 'block';
		treeDiv.style.visibility="visible";
	}
	else
	{
		treeFrame.style.display = 'block';
		treeFrame.style.visibility="visible";
		treeDiv.style.display = 'block';
		treeDiv.style.visibility="visible";
		treeFrame.style.height=treeDiv.offsetHeight;
		treeFrame.style.width=treeDiv.offsetWidth;
	}
	if (fangxiang=="left")
	{

		treeDiv.style.posLeft=xy[0]-(treeDiv.clientWidth-obj.offsetWidth);
		treeDiv.style.posTop=xy[1]+20;
		treeFrame.style.posLeft=xy[0]-(treeDiv.clientWidth-obj.offsetWidth);
		treeFrame.style.posTop=xy[1]+20;
	}else if(fangxiang=="top"){
		treeDiv.style.posLeft=xy[0]-(treeDiv.clientWidth-obj.offsetWidth);
		treeDiv.style.posTop=xy[1]-treeDiv.clientHeight;
		treeFrame.style.posLeft=xy[0]-(treeDiv.clientWidth-obj.offsetWidth);
		treeFrame.style.posTop=xy[1]-treeDiv.clientHeight;
	}else{
		
		treeDiv.style.posLeft=xy[0];
		treeDiv.style.posTop=xy[1]+20;
		treeFrame.style.posLeft=xy[0];
		treeFrame.style.posTop=xy[1]+20;
	}
		
}
function _getSelectPosition(obj){   
    var objLeft=obj.offsetLeft;   
    var objTop=obj.offsetTop;   
    var objParent=obj.offsetParent;
    while(objParent.tagName!="BODY"&&objParent.tagName!="HTML"){   
	     objLeft+=objParent.offsetLeft;   
	     objTop+=objParent.offsetTop;   
	     objParent=objParent.offsetParent;   
    }   
    return([objLeft,objTop]);   
}

function _createDiv(id,title,textdivid,path,height,selectID,fangxiang,hanShuM)
{

	bdMvEvt= document.body.onmousemove;
	bdUpEvt= document.body.onmouseup;
	buildGlobalDiv();
	
	var div=document.createElement('div');
	div.id=id;
	div.style.position='absolute';
	div.style.display='none';
	div.style.zIndex='999';
	div.style.border='2px solid #b3c4db';
	var html="";
	html+="<div  class='extPanel' style='border-width:0px;'><table class='extPanelSubject' onresize=\"_resizeClientHeight('"+id+"',this,"+height+",'"+fangxiang+"','"+selectID+"');\">";
	html+="<tr >";
	html+="<td align='left'>"+title+"</td>";
	html+="<td align='right' style='padding-right:14px;'>";
	if (hanShuM!="")
	{
		html+="<img src=\""+path+"/include/images/clean.gif\"";
		html+="onclick=_resetThisValue('"+hanShuM+"','"+id+"')";
		html+=" style='cursor:hand;height:16px;width:16px;' title='清空值'>&nbsp;";
	}
	html+="<img src=\""+path+"/include/images/closediv.gif\"";
	html+="onclick=\"_closeDiv('"+id+"')\"";
	html+="style='cursor:hand;height:16px;width:16px;'>";
	html+="</td></tr><tr><td colspan='2' style='padding-right:14px;'>"+document.getElementById(textdivid).innerHTML+"</td></tr></table></div>";

	div.innerHTML=html;
	
	var ifram=document.createElement('iframe');
	ifram.id=id+'treeFrame';
	ifram.style.position='absolute';
	ifram.style.display='none';
	document.body.appendChild(ifram);
	document.body.appendChild(div);
}
function _closeDiv(id)
{
	document.getElementById(id).style.display='none';
	document.getElementById(id).style.visibility='hidden';
	document.getElementById(id+'treeFrame').style.display='none';
	document.getElementById(id).style.visibility='hidden';
	cancel();
}
function _resetThisValue(HSM,id)
{

	try{
		eval(HSM);
	}catch(e)
	{
		alert ("清空函数不存在！");
	}
	_closeDiv(id);
}


function _downLoadFile(src,id)
{
	document.getElementById(id).src=src;
}
