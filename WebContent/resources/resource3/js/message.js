var showTime = 10;
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
function MM_findObj(n, d) { //v4.01
  /**var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;*/
	return document.getElementById(n);
}
function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}
function MM_dragLayer(objName,x,hL,hT,hW,hH,toFront,dropBack,cU,cD,cL,cR,targL,targT,tol,dropJS,et,dragJS) { //v4.01
  //Copyright 1998 Macromedia, Inc. All rights reserved.
  var i,j,aLayer,retVal,curDrag=null,curLeft,curTop,IE=document.all,NS4=document.layers;
  var NS6=(!IE&&document.getElementById), NS=(NS4||NS6); if (!IE && !NS) return false;
  retVal = true; if(IE && event) event.returnValue = true;
  if (MM_dragLayer.arguments.length > 1) {
	curDrag = MM_findObj(objName);
	document.allLayers=new Array();
    document.allLayers[0]=curDrag;
    curDrag.MM_dragOk=true; curDrag.MM_targL=targL; curDrag.MM_targT=targT;
    curDrag.MM_tol=Math.pow(tol,2); curDrag.MM_hLeft=hL; curDrag.MM_hTop=hT;
    curDrag.MM_hWidth=hW; curDrag.MM_hHeight=hH; curDrag.MM_toFront=toFront;
    curDrag.MM_dropBack=dropBack; curDrag.MM_dropJS=dropJS;
    curDrag.MM_everyTime=et; curDrag.MM_dragJS=dragJS;
    curDrag.MM_oldZ = (NS4)?curDrag.zIndex:curDrag.style.zIndex;
    curLeft= (NS4)?curDrag.left:(NS6)?parseInt(curDrag.style.left):curDrag.style.pixelLeft; 
    if (String(curLeft)=="NaN") curLeft=0; curDrag.MM_startL = curLeft;
    curTop = (NS4)?curDrag.top:(NS6)?parseInt(curDrag.style.top):curDrag.style.pixelTop; 
    if (String(curTop)=="NaN") curTop=0; curDrag.MM_startT = curTop;
    curDrag.MM_bL=(cL<0)?null:curLeft-cL; curDrag.MM_bT=(cU<0)?null:curTop-cU;
    curDrag.MM_bR=(cR<0)?null:curLeft+cR; curDrag.MM_bB=(cD<0)?null:curTop+cD;
    curDrag.MM_LEFTRIGHT=0; curDrag.MM_UPDOWN=0; curDrag.MM_SNAPPED=false; //use in your JS!
    document.onmousedown = MM_dragLayer; document.onmouseup = MM_dragLayer;
    if (NS) document.captureEvents(Event.MOUSEDOWN|Event.MOUSEUP);
  } else {
    var theEvent = ((NS)?objName.type:event.type);
    if (theEvent == 'mousedown') {
	      var mouseX = (NS)?objName.pageX : event.clientX + document.body.scrollLeft;
	      var mouseY = (NS)?objName.pageY : event.clientY + document.body.scrollTop;
	      var maxDragZ=null; document.MM_maxZ = 500;
	      for (i=0; i<document.allLayers.length; i++) { 
	    	  
	    	  aLayer = document.allLayers[i];
	    	  
	    	//将所有窗口的zIndex设置为100，将本身设置为200
		      // msg_prefix message_win dialog
		      var dialog_nodes = document.getElementById("dialogPoPWindow").childNodes;
		      var dialog_nodes_size = dialog_nodes.length;
		      for(var i=0;i<dialog_nodes_size;i++){
		    	 var dialog_win = dialog_nodes[i];
		    	 if(dialog_win.tagName=="DIV" && dialog_win.getAttribute("dialog")=="true" && dialog_win!=curDrag){
		    		 dialog_win.style.zIndex=100;
		    	 }
		      }
		      var message_win = document.getElementById("message_win");
		      if (message_win!=curDrag){
		    	  message_win.style.zIndex=100;
		      }
		      aLayer.style.zIndex=500;
		      
		      
	    	  
	        var aLayerZ = (NS4)?aLayer.zIndex:parseInt(aLayer.style.zIndex);
	        if (aLayerZ > document.MM_maxZ) document.MM_maxZ = aLayerZ;
	        var isVisible = (((NS4)?aLayer.visibility:aLayer.style.visibility).indexOf('hid') == -1);
	        if (aLayer.MM_dragOk != null && isVisible) with (aLayer) {
	          var parentL=0; var parentT=0;
	          if (NS6) { parentLayer = aLayer.parentNode;
	            while (parentLayer != null && parentLayer.style.position) {             
	              parentL += parseInt(parentLayer.offsetLeft); parentT += parseInt(parentLayer.offsetTop);
	              parentLayer = parentLayer.parentNode;
	          } } else if (IE) { parentLayer = aLayer.parentElement;       
	            while (parentLayer != null && parentLayer.style.position) {
	              parentL += parentLayer.offsetLeft; parentT += parentLayer.offsetTop;
	              parentLayer = parentLayer.parentElement; } }
	          var tmpX=mouseX-(((NS4)?pageX:((NS6)?parseInt(style.left):style.pixelLeft)+parentL)+MM_hLeft);
	          var tmpY=mouseY-(((NS4)?pageY:((NS6)?parseInt(style.top):style.pixelTop) +parentT)+MM_hTop);
	          if (String(tmpX)=="NaN") tmpX=0; if (String(tmpY)=="NaN") tmpY=0;
	          var tmpW = MM_hWidth;  if (tmpW <= 0) tmpW += ((NS4)?clip.width :offsetWidth);
	          var tmpH = MM_hHeight; if (tmpH <= 0) tmpH += ((NS4)?clip.height:offsetHeight);
	          if ((0 <= tmpX && tmpX < tmpW && 0 <= tmpY && tmpY < tmpH) && (maxDragZ == null
	              || maxDragZ <= aLayerZ)) { curDrag = aLayer; maxDragZ = aLayerZ; } } }
	      if (curDrag) {
	        document.onmousemove = MM_dragLayer; if (NS4) document.captureEvents(Event.MOUSEMOVE);
	        curLeft = (NS4)?curDrag.left:(NS6)?parseInt(curDrag.style.left):curDrag.style.pixelLeft;
	        curTop = (NS4)?curDrag.top:(NS6)?parseInt(curDrag.style.top):curDrag.style.pixelTop;
	        if (String(curLeft)=="NaN") curLeft=0; if (String(curTop)=="NaN") curTop=0;
	        MM_oldX = mouseX - curLeft; MM_oldY = mouseY - curTop;
	        document.MM_curDrag = curDrag;  curDrag.MM_SNAPPED=false;
	        if(curDrag.MM_toFront) {
	          //eval('curDrag.'+((NS4)?'':'style.')+'zIndex=document.MM_maxZ+1');
	          if (!curDrag.MM_dropBack) document.MM_maxZ++; }
	        retVal = false; if(!NS4&&!NS6) event.returnValue = false;
	    } 
    	
    } else if (theEvent == 'mousemove') {
      if (document.MM_curDrag) with (document.MM_curDrag) {
        var mouseX = (NS)?objName.pageX : event.clientX + document.body.scrollLeft;
        var mouseY = (NS)?objName.pageY : event.clientY + document.body.scrollTop;
        newLeft = mouseX-MM_oldX; newTop  = mouseY-MM_oldY;
        if (MM_bL!=null) newLeft = Math.max(newLeft,MM_bL);
        if (MM_bR!=null) newLeft = Math.min(newLeft,MM_bR);
        if (MM_bT!=null) newTop  = Math.max(newTop ,MM_bT);
        if (MM_bB!=null) newTop  = Math.min(newTop ,MM_bB);
        MM_LEFTRIGHT = newLeft-MM_startL; MM_UPDOWN = newTop-MM_startT;
        if (NS4) {left = newLeft; top = newTop;}
        else if (NS6){style.left = newLeft; style.top = newTop;}
        else {style.pixelLeft = newLeft; style.pixelTop = newTop;}
        if (MM_dragJS) eval(MM_dragJS);
        retVal = false; if(!NS) event.returnValue = false;
    } } else if (theEvent == 'mouseup') {
      document.onmousemove = null;
      if (NS) document.releaseEvents(Event.MOUSEMOVE);
      if (NS) document.captureEvents(Event.MOUSEDOWN); //for mac NS
      if (document.MM_curDrag) with (document.MM_curDrag) {
        if (typeof MM_targL =='number' && typeof MM_targT == 'number' &&
            (Math.pow(MM_targL-((NS4)?left:(NS6)?parseInt(style.left):style.pixelLeft),2)+
             Math.pow(MM_targT-((NS4)?top:(NS6)?parseInt(style.top):style.pixelTop),2))<=MM_tol) {
          if (NS4) {left = MM_targL; top = MM_targT;}
          else if (NS6) {style.left = MM_targL; style.top = MM_targT;}
          else {style.pixelLeft = MM_targL; style.pixelTop = MM_targT;}
          MM_SNAPPED = true; MM_LEFTRIGHT = MM_startL-MM_targL; MM_UPDOWN = MM_startT-MM_targT; }
        if (MM_everyTime || MM_SNAPPED) eval(MM_dropJS);
        retVal = false; if(!NS) event.returnValue = false; }
      document.MM_curDrag = null;
    }
    if (NS) document.routeEvent(objName);
  } return retVal;
}
/**
 * 渐变的效果加载窗口
 * @param obj DIV窗口的ID
 */
function loadwin(obj){
	MM_findObj(obj).style.display="";
//	with(MM_findObj(obj))with(style){
//		filters[0].apply();
//		display='';
//		filters[0].play();
//	}
}
var autoOpen=true;
function _autoOpenWindow(o){
	if(o.checked){
		autoOpen=true;
	}else{
		autoOpen=false;
	}
}

function cs(captionBG,bodyBG,tableBG){
oldBody=document.body;
	with(oldBody){
		var newBody=cloneNode();
		style.filter='blendtrans(duration=1)';
		filters[0].apply();
		with(document.styleSheets[0]){
			with(rules[0].style){backgroundColor=captionBG;}
			with(rules[1].style){backgroundColor=bodyBG;}
			with(rules[2].style){backgroundColor=tableBG;}
		}
		filters[0].play();
		setTimeout(function(){
				if(oldBody!=null){
					oldBody.applyElement(newBody, "inside");
					oldBody.swapNode(newBody);
					oldBody.removeNode(true);
					}
				},showTime);
	}
}
function _moveClose(o,img){
	o.src=img;
}
/**
 * 关闭指定的窗口
 * @param o DIV窗口的ID
 */
function _close(o){
	document.getElementById(o).style.display="none";
}

function _selType(o){
	var tds = o.parentNode.getElementsByTagName("TD");
	for(var td in tds){
		if(td!=o){
			if(tds[td].className=="th_title_sel"){
				tds[td].className="th_title";
			}
		}
	}
	o.className="th_title_sel";
}

function _moveUser(o){
	o.className="msg_user_move";
}
function _moveOutUser(o){
	o.className="msg_user";

}

function _msg_move(o){
	o.className="info_div_hover";
}
function _msg_moveOut(o){
	o.className="info_div";
}
function _openDiv(o,type){
	var tb = o.parentNode.parentNode.parentNode.parentNode;
	var divs = tb.getElementsByTagName("DIV");
	for(var i=0;i<divs.length;i++){
		var d = divs[i];
		var t = d.getAttribute("type");
		if(t!=null){
			if (t==type){
				d.style.display="block";
			}else{
				d.style.display="none";
			}
		}
	}
}
function _keySend(txtid){
	var ev = window.event;
	var typeId = txtid + "_sendType";
	if (document.getElementById(typeId).checked){
		if((ev.keyCode && ev.keyCode==13)){
			_sendTalkMsg(txtid,true);
			return;
		}
	}
	//83=s/13=回车
	if((ev.keyCode && ev.ctrlKey && ev.keyCode==13) ||((ev.keyCode && ev.altKey && ev.keyCode==83))){
		_sendTalkMsg(txtid,true);
	}
}
var isInputTxt =0; 
function _clearTxtEnter(o){
	if(o.innerText.length==0){
		o.value="";
	}
	isInputTxt++;
}
function _sendAction(){
	if (isInputTxt>0){
		_runLoad();
		isInputTxt=0;
		try {
			document.getElementById("ttt").innerHTML=isInputTxt;
		} catch (e) {
			// TODO: handle exception
		}
	}
}
window.setInterval("_sendAction()", 10000);
var attUrlPrefix=path + "jsp/message/att_upload/Upload.up?param=ajaxDownloadAtt&amp;IDANDCODE=";
var attUrlExp = ",MESSAGE_ATT%250D%250A";
/**
 * 发送附件
 * @param txtid 发送人的窗口ID
 * @param atts 附件信息 atts[i]["fileName"]  atts[i]["url"]
 */
function _sendAtt(txtid,atts){
	var mj = "";
	var qx = "";
	if(isSecurity){
		var mjObj = document.getElementById(txtid + "_att_mj");
		var qxObj = document.getElementById(txtid + "_att_qx");
		mj = mjObj.value;
		qx = qxObj.value;
		var mjText = "";
		var qxText = "";
		var opsMj = mjObj.options;
		var opsQx = qxObj.options;
		for(var i=0;i<opsMj.length;i++){
			if(opsMj[i].selected){
				mjText = opsMj[i].text;
			}
		}
		for(var i=0;i<opsQx.length;i++){
			if(opsQx[i].selected){
				qxText = opsQx[i].text;
			}
		}
	}
	var txtObj = document.getElementById(txtid + "_txt");
	var uuid = txtObj.getAttribute("uuid");
	var toUserName = txtObj.getAttribute("userName");
	
	var content = "";
	var attName = "";
	var atturl = "";
	for(var i=0;i<atts.length;i++){
		if(i>0){
			attName+="|";
			atturl+="|";
		}
		var att = atts[i];
		var fileName = att["fileName"];
		var url = att["id"];
		attName+=fileName;
		atturl+=url;
	}
	var xml = _sendMsg2Server(txtid,uuid,content,mj,qx,"1",attName,atturl);
	_addState2Dialog(txtid,"附件发送成功。","_att");
}
/**
 * 发送对话消息
 * @param txtid 以用户登录ID+前缀的id
 */
function _sendTalkMsg(txtid,flag){
	var mj = "";
	var qx = "";
	if(isSecurity){
		var mjObj = document.getElementById(txtid + "_mj");
		var qxObj = document.getElementById(txtid + "_qx");
		mj = mjObj.value;
		qx = qxObj.value;
		var mjText = "";
		var qxText = "";
		var opsMj = mjObj.options;
		var opsQx = qxObj.options;
		for(var i=0;i<opsMj.length;i++){
			if(opsMj[i].selected){
				mjText = opsMj[i].text;
			}
		}
		for(var i=0;i<opsQx.length;i++){
			if(opsQx[i].selected){
				qxText = opsQx[i].text;
			}
		}
	}
	var txtObj = document.getElementById(txtid + "_txt");
	
	var uuid = txtObj.getAttribute("uuid");
	var toUserName = txtObj.getAttribute("userName");
	var content = txtObj.value;
	if (txtObj.innerText.length==0){
		if(flag){
			return;
		}
		alert("请输入消息。");
		txtObj.focus();
		return;
	}
	txtObj.value="";
	
	_addMsg2Dialog(txtid,content,mjText,qxText);
	_sendMsg2Server(txtid,uuid,content,mj,qx,"0");
	
}
/**
 * 发送文件到服务器
 * @param uuid 发送到的人员的uuid
 * @param content 内容
 * @param mj 密级
 * @param qx 期限
 * @param type 1为附件 0为文本消息
 */
function _sendMsg2Server(txtid,uuid,content,mj,qx,type,attname,atturl){
	content = content.replaceByString("&","щ");
	content = content.replaceByString("?","ц");
	if (type=="1"){
		attname = attname.replaceByString("&","щ");
		atturl = atturl.replaceByString("?","ц");
	}
	//ч
	var param = "to=" + uuid + "&type=" + type + "&miji=" + mj + "&qixian=" + qx + "&attname=" + attname + "&atturl=" + atturl + "&content=" + content;
	var xml = getXml("hx.message.ajax.SendMessage",param);
	//_addState2Dialog(txtid,"成功发送" + xml + "条消息。");
	return xml;
}



/*********************************************************************/
function executeMsg2Server(className, param) {
	if (className==null){
		alert("参数“实现类className”不能为null。");
	}
	if(param==null){
		param="";
	}
	xmlhttp = getXmlHttpRequest();
	//path为全局的上下文根
	var url = path + "AjaxExecute";
	if (xmlhttp != null) {
		xmlhttp.open("POST", url, false);
		//if (!asyn) {
		//	xmlhttp.onreadystatechange = OnReadyStateChng;
		//}
		// 这一句是用post方法发送的时候必须写的
	    xmlhttp.setrequestheader('cache-control','no-cache');  
	    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
		// 提交的参数
		var postParam = "className=" + className + "&" + param;
		postParam = encodeURI(postParam);
		postParam = encodeURI(postParam);//2次编码是为了解决乱码问题
		xmlhttp.onreadystatechange=OnReadyStateMessage2Server; 
		xmlhttp.send(postParam);
	}
}

function OnReadyStateMessage2Server()
{
    if (xmlhttp.readyState == 1)
    {
    	
    }
    else if (xmlhttp.readyState == 4)
    {
        var xml = xmlhttp.responseText; //处理完毕
        _getMsg2ServerXml(xml);
    }
}


var newMessageObj = new Array();
/**
 * 得到消息
 * @param uuid 用户的uuid
 * @param offline true为离线，false或不传为在线，离线从数据库中读取消息
 */
function _getMsg2Server(uuid,offline){
	var param = "uuid=" + uuid;
	if(offline){
		param +="&offline=true";
	}else{
		param +="&offline=false";
	}
	executeMsg2Server("hx.message.ajax.ReceiveMessage",param);
}
function _getMsg2ServerXml(xml){
	var root = loadXml(xml);
	var nodeList = root.childNodes;
	var nodeSize = nodeList.length; 
	for(var i=0;i<nodeSize;i++){
		var msg = nodeList.item(i);
		var contents = msg.childNodes;
		var c = contents.item(0);
		//内容
		var content = c.childNodes.item(0).text;
		//发送者
		var sender = getAttribute(msg,"sender");
		var account = getAttribute(msg,"account");
		var senderUUID = getAttribute(msg,"senderUUID");
		var organName = getAttribute(msg,"senderOrganName");
		var sendTime = getAttribute(msg,"sendTime");
		var sendIp = getAttribute(msg,"sendIp");
		var type = getAttribute(msg,"type");
		var miji = getAttribute(msg,"miji","");
		var qixian = getAttribute(msg,"qixian","");
		var objId = msg_prefix + account;
		var obj = _openTalking(sender,organName,objId,senderUUID);
		var l = newMessageObj.length;
		if(autoOpen){
			obj.style.display="block";
		}
		if(obj.style.display=="none"){
			newMessageObj[l]=objId;
		}
		if(type=="0"){
			//加载文本消息
			content = content.replaceByString("щ","&");
			content = content.replaceByString("ц","?");
			_addMsg2Dialog(objId,content,miji,qixian,sender,sendTime);
		}else{
			//加载附件消息
			var att = contents.item(1).childNodes;
			var atturl = att.item(0).text;
			var attname = att.item(1).text;
			atturl = atturl.replaceByString("щ","&");
			atturl = atturl.replaceByString("ц","?");
			attname = attname.replaceByString("щ","&");
			attname = attname.replaceByString("ц","?");
			_addMsg2DialogAtt(objId,content,miji,qixian,sender,sendTime,attname,atturl,senderUUID,null,true);
		}
	}
	if(newMessageObj.length>0){
		_setMessageState();
	}
}

/*********************************************************************/



/**
 * 编辑常用联系人
 * @param selfuuid
 * @param uuid
 */
function _setContact(o,state,selfuuid,uuid){
	var param = "operation=" + state + "&uuid=" + uuid + "&selfuuid=" + selfuuid;
	param+="&pno=" + (contactCount+1);
	getStr("hx.message.ajax.SetContact",param);
	if(state=="add"){
		contactCount++;
		contactAll+=uuid + ",";
		//将联系人添加至页面
		_addContactToDiv(o);
	}else{
		contactAll.replaceByString(uuid + ",","");
		//将联系人从页面中移除
		_removeContactToDiv(uuid);
	}
	_setContactStateImg(uuid,state);
}
function _setContactStateImg(uuid,state){
	var div1 = document.getElementById("msgObj_allUsersDiv");
	var div2 = document.getElementById("msgObj_selfDiv1");
	var div3 = document.getElementById("msgObj_selfDiv2");
	var div4 = document.getElementById("msgObj_oftenDiv1");
	var div5 = document.getElementById("msgObj_oftenDiv2");
	_setContactStateImgOne(div1,uuid,state);
	_setContactStateImgOne(div2,uuid,state);
	_setContactStateImgOne(div3,uuid,state);
	_setContactStateImgOne(div4,uuid,state);
	_setContactStateImgOne(div5,uuid,state);
}
function _setContactStateImgOne(div,uuid,state){
	var imgs = div.getElementsByTagName("IMG");
	var len = imgs.length;
	for(var i=0;i<len;i++){
		var img = imgs[i];
		var u = img.getAttribute("uuid");
		var src = img.src;
		if(uuid==u){
			if(state=="add"){
				img.src=resourcePath + "images/message/contact_delete.png";
				img.onclick=function(){
					var u = this.getAttribute("uuid");
					_setOften(this,"remove",u);
				};
				img.title="从常用联系人列表中移除";
				img.style.cursor="pointer";
			}else{
				img.src=resourcePath + "images/message/contact_add.png";
				img.onclick=function(){
					var u = this.getAttribute("uuid");
					_setOften(this,"add",u);
				};
				img.title="添加为常用联系人";
				img.style.cursor="pointer";
			}
		}
	}
}
function _removeContactToDiv(uuid){
	var div1 = document.getElementById("msgObj_oftenDiv1");
	var div2 = document.getElementById("msgObj_oftenDiv2");
	var tb1 = div1.childNodes.item(0);
	var tb2 = div2.childNodes.item(0);
	var trs1 = tb1.rows;
	var trs2 = tb2.rows;
	var l1 = trs1.length;
	var l2 = trs2.length;
	for(var i=0;i<l1;i++){
		var u = trs1(i).getAttribute("uuid");
		if(u==uuid){
			tb1.deleteRow(trs1(i).rowIndex);
			return;
		}
	}
	for(var i=0;i<l2;i++){
		var u = trs2(i).getAttribute("uuid");
		if(u==uuid){
			tb2.deleteRow(trs2(i).rowIndex);
			return;
		}
	}
}
/**
 * 将常用联系人增加到列表中
 * @param o
 */
function _addContactToDiv(o){
	var tr = o.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
	var uData = new Data();
	uData.add("ORGID",tr.getAttribute("orgid"));
	uData.add("NAME",tr.getAttribute("userName"));
	uData.add("ORGNAME",tr.getAttribute("organName"));
	uData.add("ID",tr.getAttribute("uuid"));
	uData.add("ROOM",tr.getAttribute("room"));
	uData.add("TEL",tr.getAttribute("tel"));
	uData.add("EMAIL",tr.getAttribute("email"));
	uData.add("ACCOUNT",tr.getAttribute("account"));
	var con = _getContactTR(uData);
	//判断哪个联系人列人少
	var div1 = document.getElementById("msgObj_oftenDiv1");
	var div2 = document.getElementById("msgObj_oftenDiv2");
	var tb1 = div1.childNodes.item(0).tBodies[0];
	var tb2 = div2.childNodes.item(0).tBodies[0];
//	if (tb1.tagName!="TABLE"){
//		tb1 = document.createElement("TABLE");
//		tb1.style.width="100%";
//		tb1.cellSpacing="1";
//		div1.innerHTML="";
//		div1.appendChild(tb1);
//	}
//	if (tb2.tagName!="TABLE"){
//		tb2 = document.createElement("TABLE");
//		tb2.style.width="100%";
//		tb2.cellSpacing="1";
//		div2.innerHTML="";
//		div2.appendChild(tb2);
//	}
	var trs1 = tb1.rows;
	var trs2 = tb2.rows;
	var l1 = trs1.length;
	var l2 = trs2.length;
	if (l1>l2){
		tb2.appendChild(con);
	}else{
		tb1.appendChild(con);
	}
}
/**
 * 得到联系人信息的TR
 * @param uData
 * @returns
 */
function _getContactTR(uData){
	var uOrgId = uData.getString("ORGID");
	var userName=uData.getString("NAME");
	var orgName=uData.getString("ORGNAME");
	var id = uData.getString("ID");
	var room = uData.getString("ROOM");
	var tel = uData.getString("TEL");
	var email = uData.getString("EMAIL");
	var account = uData.getString("ACCOUNT");
	var online="offline";//online
	var onlineStr="离线";//在线
	var tr =  createTr();
	tr.setAttribute("orgid",uOrgId);
	tr.setAttribute("room",room);
	tr.setAttribute("tel",tel);
	tr.setAttribute("email",email);
	tr.setAttribute("account",account);
	tr.setAttribute("uuid",id);
	tr.setAttribute("userName",userName);
	tr.setAttribute("organName",orgName);
	var td = createTd();
	td.className="msg_user";
	td.onmouseover=function(){
		_moveUser(this);
	};
	td.onmouseout=function(){
		_moveOutUser(this);
	};
	//tr.onclick=function(){
	//	_talking(this);
	//};
	td.setAttribute("uuid",id);
	var s = "<table style=\"width: 100%\" cellspacing=\"0\" cellpadding=\"0\"><tr><td style=\"cursor:pointer;\" onclick=\"_talking(this);\" rowspan=\"2\" style=\"width: 50px;\" >";
	s+="<img src=\"" + resourcePath + "images/message/user";
	s+=online;
	s+=".png\" /></td><td style=\"cursor:pointer;\" onclick=\"_talking(this);\" class=\"msg_userTitle\" title=\"" + userName + "\">";
	s+=_filterUser(userName,6);
	s+="(" + onlineStr + ")";
	s+="</td>";
	//s+="<td rowspan=\"2\" class=\"msg_userTitle3\">";
	//s+="<img src=\"" + resourcePath + "images/message/contacts.png\" />";
	//s+="</td>";
	s+="</tr><tr><td class=\"msg_userTitle2\">";
	s+=orgName;
	
	if(contactAll.indexOf("," + id + ",")>=0){
		s+="&nbsp;&nbsp;&nbsp;&nbsp;<img title=\"从常用联系人列表中移除\" onclick=\"_setOften(this,'remove','" + id + "');\" style=\"cursor:pointer;\" uuid=\"" + id + "\" src=\"" + resourcePath + "images/message/contact_delete.png\">";
	}else{
		s+="&nbsp;&nbsp;&nbsp;&nbsp;<img title=\"添加为常用联系人\" onclick=\"_setOften(this,'add','" + id + "');\" style=\"cursor:pointer;\" uuid=\"" + id + "\" src=\"" + resourcePath + "images/message/contact_add.png\">";	
	}
	s+="</td></tr></table>";
	td.innerHTML=s;
	tr.appendChild(td);
	return tr;
}
var contactCount=0;
var contactAll=",";
/**
 * 得到所有的常用联系人
 * @param uuid 本人的uuid
 * @returns {DataList}
 */
function _getContacts(uuid){
	var xml = getXml("hx.message.ajax.Contact","uuid=" + uuid);
	var root = loadXml(xml);
	var nodeList = root.childNodes;
    var nodeSize = nodeList.length; 
    var dl = new DataList();
    contactCount = nodeSize;
    for(var i=0;i<nodeSize;i++){
    	var con = nodeList.item(i);
    	var cname = getAttribute(con,"cname");
		var uuid = getAttribute(con,"uuid");
		var orgName = getAttribute(con,"orgName");
		var roomNumber = getAttribute(con,"roomNumber","");
		var orgId = getAttribute(con,"orgId","");
		var tel = getAttribute(con,"tel","");
		var email = getAttribute(con,"email","");
		var account = getAttribute(con,"account");
		var data = new Data();
		data.add("ORGID",orgId);
		data.add("NAME",cname);
		data.add("ORGNAME",orgName);
		data.add("ID",uuid);
		data.add("ROOM",roomNumber);
		data.add("TEL",tel);
		data.add("EMAIL",email);
		data.add("ACCOUNT",account);
		contactAll+=uuid +",";
		dl.addData(data);
    }
    return dl;
}
/**
 * 设置即时消息的跳动
 */
function _setMessageState(){
	//(条新消息)
	//xxjl_newMessageSize
	//xxjl_ico
	var len = newMessageObj.length;
	if(len>0){
		_flashGo(true);
		//document.getElementById("xxjl_newMessageSize").innerHTML="(" + len + "条新消息)";
		document.getElementById("xxjl_newMessageSize").innerHTML=len;
		var ico = document.getElementById("xxjl_ico");
		ico.src=resourcePath + "/images/message/msging.gif";
	}
}

/**
 * 清除消息跳动
 */
function _clearMessageState(){
	//(条新消息)
	//xxjl_newMessageSize
	//xxjl_ico
	var len = newMessageObj.length;
	for(var i=0;i<len;i++){
		document.getElementById(newMessageObj[i]).style.display="block";
	}
	_flashGo(false);
	document.getElementById("xxjl_newMessageSize").innerHTML="0";
	newMessageObj=new Array();
	var ico = document.getElementById("xxjl_ico");
	ico.src=resourcePath + "/images/message/msg.gif";
}
/**
 * 添加自定义内容到窗口
 * @param id
 * @param content
 */
function _addState2Dialog(id,content,att,ext){
	if(att==null){
		att="";
	}
	var div = createDiv();
	div.className="info_div";
	div.onmouseover=function(){
		_msg_move(this);
	};
	div.onmouseout=function(){
		_msg_moveOut(this);
	};
	var nowDate = (new Date()).Format("yyyy-MM-dd hh:mm:ss");
	var dialog="";
	dialog += '<div class="info_msg">';
	dialog += nowDate + "&nbsp;&nbsp;";
	dialog += content;
	dialog += '</div>';
	div.innerHTML = dialog;
	if (ext==null){
		ext = "_msg";
	}
	document.getElementById(id + att + ext).appendChild(div);
}
/**
 * 添加信息至窗口
 * @param id
 * @param content
 * @param mjText
 * @param qxText
 * @param sender
 * @param nowDate
 */
function _addMsg2Dialog(id,content,mjText,qxText,sender,nowDate,ext){
	var mjStr = "";
	switch (mjText){
	case "": 
		mjStr="";
	break;
	case "无": 
		mjStr="";
		break;
	case "内部资料": 
		mjStr="内部资料 注意保管";
		break;
	case "null": 
		mjStr="";
		break;
	case null: 
		mjStr="";
		break;
	default:
		switch (qxText){
		case "": 
			mjStr= "（" + mjText + "★" + "）";
		break;
		default:
			mjStr="（" + mjText + "★" + qxText + "）";
		}
	}
	var div = createDiv();
	div.className="info_div";
	div.onmouseover=function(){
		_msg_move(this);
	};
	div.onmouseout=function(){
		_msg_moveOut(this);
	};
	if(nowDate==null){
		nowDate = (new Date()).Format("yyyy-MM-dd hh:mm:ss");
	}
	if(sender==null){
		sender = myName;
	}
	var dialog="";
	//content = content.replaceByString("\r","<br>");
	content = content.replaceByString("\n","<br>");
	content = content.replaceByString(" ","&nbsp;");
	content = content.replaceByString("й"," ");
	dialog += '<div class="info_name">';
	dialog += sender + '说：' + mjStr + '<span>' + nowDate + '</span></div>';
	dialog += '<div class="info_msg">';
	dialog += content;
	dialog += '</div>';
	div.innerHTML = dialog;
	if (ext==null){
		ext = "_msg";
	}
	var divObj = document.getElementById(id+ext);
	
	divObj.appendChild(div);
	//document.getElementById(id+ext+"End").click();
	//divObj.scrollIntoView(false);
   // divObj.style.height=divObj.clientHeight;
	//alert(divObj.scrollHeight);
	//divObj.scrollTop=divObj.scrollHeight;
	_gotoScrollTop(id+ext);
	setTimeout("_gotoScrollTop('" + id+ext + "');",10);
	setTimeout("_gotoScrollTop('" + id+ext + "');",100);
	setTimeout("_gotoScrollTop('" + id+ext + "');",500);
}
function _gotoScrollTop(ostr){
	var divObj = document.getElementById(ostr);
	divObj.scrollTop=divObj.scrollHeight;
}
function _addMsg2DialogAtt(objId,content,mjText,qxText,sender,sendTime,attname,atturl,senderUUID,ext,noDownload){
	var mjStr = "";
	switch (mjText){
	case "": 
		mjStr="";
	break;
	case "无": 
		mjStr="";
		break;
	case "内部资料": 
		mjStr="内部资料 注意保管";
		break;
	case "null": 
		mjStr="";
		break;
	case null: 
		mjStr="";
		break;
	default:
		switch (qxText){
		case "": 
			mjStr= "（" + mjText + "★" + "）";
		break;
		case "无": 
			mjStr= "（" + mjText + "★" + "）";
		break;
		default:
			mjStr="（" + mjText + "★" + qxText + "）";
		}
	}
	var div = createDiv();
	div.className="info_div";
	div.onmouseover=function(){
		_msg_move(this);
	};
	div.onmouseout=function(){
		_msg_moveOut(this);
	};
	if(sendTime==null){
		sendTime = (new Date()).Format("yyyy-MM-dd hh:mm:ss");
	}
	if(sender==null){
		sender = myName;
	}
	var dialog="";
	//content = content.replaceByString("\r","<br>");
	content = content.replaceByString("\n","<br>");
	content = content.replaceByString(" ","&nbsp;");
	dialog += '<div class="info_name">';						
	dialog += '<span>' + sendTime + '</span><br>';						
	dialog += sender + '发送文件：' + mjStr + '</div>';						
	dialog += '<div>';						
	dialog += '<table style="width: 100%">';
	var names = attname.split("|");
	var urls = atturl.split("|");
	var len = names.length;
	for(var i=0;i<len;i++){
		dialog += '<tr>';
		dialog += '<td style="width: 140px;" class="info_attmsg">';
		dialog += names[i];
		dialog += '</td>';
		if(noDownload){
			dialog += '<td style="width: 34px;" class="info_jishou" nowrap>';
			dialog += '<a target="_self" onclick="_downloadThisFile(this,\'' + senderUUID + '\',\'' + mjStr + '\',\'' + mjText + '\');"  href="';
			dialog += attUrlPrefix;
			dialog += urls[i];
			dialog += attUrlExp;
			dialog += '" title="';
			dialog += names[i];
			dialog += '">接收</a>';
			dialog += '</td>';
			dialog += '<td style="width: 34px;" class="info_jishou" nowrap>';
			dialog += '<a href="#" onclick="_hidden(this);">隐藏</a>';
			dialog += '</td>';
		}
		dialog += '</tr>';
	}
	dialog += '</table>';						
	dialog += '</div>';		
	div.innerHTML = dialog;
	if(ext==null){
		ext = "_att_msg";
	}
	document.getElementById(objId+ext).appendChild(div);
}
function _hidden(o){
	var d = o.parentNode.parentNode;
	var t = d.parentNode;
	var dtop = d.parentNode.parentNode.parentNode.parentNode;
	d.style.display="none";
	var divs = t.rows;
	var b = true;
	for(var i=0;i<divs.length;i++){
		if(divs[i].style.display!="none"){
			b=false;
			break;
		}
	}
	if(b){
		dtop.style.display="none";
	}
}
/**
 * 点击接收后给发送者一个消息
 */
function _downloadThisFile(o,uuid,mjStr,mjText){
	var mj="";
	var qx="";
	if(isSecurity){
		var mj = document.getElementById("TMP_MJ");
		var qx = document.getElementById("TMP_QX");
		var mjops = mj.options;
		var qxops = qx.options;
		
		for(var i=0;i<mjops.length;i++){
			if(mjops[i].text ==mjStr){
				mj = mjops[i].value;
			}
		}
		for(var i=0;i<qxops.length;i++){
			if(qxops[i].text ==mjText){
				qx = qxops[i].value;
			}
		}
	}
	var content = "我已经开始接收您发给我的文件：“" + o.title + "”";
	_sendMsg2Server(null,uuid,content,mj,qx,"0");
}

function _showGroup(o,group){
	var tb = o.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
	var trs = tb.rows;

	for(var i=0;i<trs.length;i++){
		var tr = trs.item(i);
		var g = tr.getAttribute("group");
		if(g!=null){
			if (g==group){
				tr.style.display="block";
			}else{
				tr.style.display="none";
			}
		}
	}

}
var tree;
var isLoadOrgTree=false;

function createTd(){
	return document.createElement("TD");
}
function createTr(){
	return document.createElement("TR");
}

var isSelf=false;
var isOften=false;
//加载指定的数据
function _loadData(type,orgId,uuid){
	switch (type){
		case "all": 
			_addUsers(orgId,_getUserDataList(uuid));
			nowUsersObj=new Array();
			nowUsersObj[nowUsersObj.length] = document.getElementById("msgObj_allUsersDiv");
		break;
		case "self": 
			if(!isSelf){
				_addSelf(orgId,_getUserDataList(uuid));
				isSelf=true;
			}
			nowUsersObj=new Array();
			nowUsersObj[nowUsersObj.length] = document.getElementById("msgObj_selfDiv1");
			nowUsersObj[nowUsersObj.length] = document.getElementById("msgObj_selfDiv2");
		break;
		case "often": 
			if(!isOften){
				_addOften(uuid);
				isOften=true;
			}
			nowUsersObj=new Array();
			nowUsersObj[nowUsersObj.length] = document.getElementById("msgObj_oftenDiv1");
			nowUsersObj[nowUsersObj.length] = document.getElementById("msgObj_oftenDiv2");
		break;
		default:
		break;
	}
}
var userDataList;
/**
 * 得到所有用户信息
 * @param uuid
 * @returns
 */
function _getUserDataList(uuid){
	if(userDataList==null){
		// AJAX得到所有用户
		//将用户数设置在右下角
		//得到所有用户
		userDataList = getDataList("hx.message.ajax.Person","uuid=" + uuid);
		var allUserShow = document.getElementById("msgObj_allUserSize");
		//将所有人数设置在右下角
		allUserShow.innerHTML=userDataList.size();
	}
	return userDataList;
}
var msgObj_selectCount;

function _loadSearchMsg(id,uuid){
	var o = document.getElementById(id + "_search");
	if(o.innerHTML==""){
		_searchMessage(uuid,id,null,null,null,1,5);
	}
}


function _searchMsgToTop(o){
	v = o.parentNode;
	var objId = v.getAttribute("objId");
	var page = 1;
	var pageSize = v.getAttribute("pageSize");
	var uuid = v.getAttribute("uuid");
	var c = document.getElementById(objId + "_search_txt").value;
	_searchMessage(uuid,objId,null,null,c,page,5);
	
}
function _searchMsgToEnd(o){
	v = o.parentNode;
	var objId = v.getAttribute("objId");
	var pageSize = v.getAttribute("pageSize");
	var page = v.getAttribute("pageTotal");
	var uuid = v.getAttribute("uuid");
	var c = document.getElementById(objId + "_search_txt").value;
	_searchMessage(uuid,objId,null,null,c,page,5);
}
function _searchMsgTo(o,i){
	v = o.parentNode;
	var objId = v.getAttribute("objId");
	var p = v.getAttribute("page");
	var page = parseInt(p, 10) + i;
	var pageSize = v.getAttribute("pageSize");
	var pageTotal = v.getAttribute("pageTotal");
	var pNum = parseInt(pageTotal);
	if (page<=0){
		page=1;
	}
	if(page>pNum){
		page = pNum;
	}
	var uuid = v.getAttribute("uuid");
	var c = document.getElementById(objId + "_search_txt").value;
	_searchMessage(uuid,objId,null,null,c,page,5);
}

function _searchMsgTos(objId,uuid){
	var c = document.getElementById(objId + "_search_txt").value;
	_searchMessage(uuid,objId,null,null,c,1,5);
}
function _searchKey(objId,uuid){
	var ev = window.event;
	//83=s/13=回车
	if((ev.keyCode && ev.keyCode==13)){
		_searchMsgTos(objId,uuid);
	}
}
function _searchKeyPage(o){
	var ev = window.event;
	//83=s/13=回车
	if((ev.keyCode && ev.keyCode==13)){
		v = o.parentNode;
		var objId = v.getAttribute("objId");
		var pageTotal = v.getAttribute("pageTotal");
		var uuid = v.getAttribute("uuid");
		var page = o.value;
		if(page>pageTotal){
			o.value = pageTotal;
			page = pageTotal;
		}
		if(page<0){
			o.value = 0;
			page = 0;
		}
		var c = document.getElementById(objId + "_search_txt").value;
		_searchMessage(uuid,objId,null,null,c,page,5);
	}
}
/**
 * 查询历史数据
 * @param start 开始日期
 * @param end 结束日期
 * @param c 内容
 * @param page 当前页
 * @param pageSize 每页多少条数据
 */
function _searchMessage(uuid,objId,start,end,c,page,pageSize){
	var param = "touuid=" + uuid;
	if(start!=null){
		param += "&start=" + start;
	}
	if(end!=null){
		param += "&end=" + end;
	}
	if(c!=null){
		param += "&c=" + c;
	}
	if(page!=null){
		param += "&page=" + page;
	}
	if(pageSize!=null){
		param += "&pageSize=" + pageSize;
	}
	var list = getDataList("hx.message.ajax.SearchMessage",param);
	var len = list.size();
	var bar_pageTotal = list.getPageNum();
	var bar_totalData = list.getdataTotal();
	var bar_nowPage = list.getNowPage();
	var bar_pageSize = 5;
	var bar = document.getElementById(objId + "_bar");
	document.getElementById(objId + "_bar_pageTotal").innerHTML=bar_pageTotal;
	document.getElementById(objId + "_bar_dataTotal").innerHTML=bar_totalData;
	document.getElementById(objId + "_bar_page").value=bar_nowPage;
	bar.setAttribute("page",bar_nowPage);
	bar.setAttribute("pageTotal",bar_pageTotal);
	bar.setAttribute("pageSize",bar_pageSize);
	bar.setAttribute("dataTotal",bar_totalData);
	document.getElementById(objId+"_search").innerHTML="";
	for(var i=0;i<len;i++){
		var d = list.getData(i);
		var type = d.getString("TYPE");
		if(type=="0"){
			//加载文本消息
			var content = d.getString("CONTENT_TXT");
			content = content.replaceByString("щ","&");
			content = content.replaceByString("ц","?");
			var miji = d.getString("MIJI");
			var qixian = d.getString("QIXIAN");
			var sender = d.getString("SENDER");
			var sendTime = d.getString("SENDTIME");
			if(c!=null && c!="" && c.atrim()!="" && c.atrim()!="null"){
				content = content.replaceByString(c,"<spanйclass='info_searchMsg'>" + c + "</span>");
			}
			_addMsg2Dialog(objId,content,miji,qixian,sender,sendTime,"_search");
		}else{
			//加载附件消息
			var atturl = d.getString("ATTURL");
			var attname = d.getString("ATTNAME");
			atturl = atturl.replaceByString("щ","&");
			atturl = atturl.replaceByString("ц","?");
			attname = attname.replaceByString("щ","&");
			attname = attname.replaceByString("ц","?");
			var miji = d.getString("MIJI");
			var qixian = d.getString("QIXIAN");
			var sender = d.getString("SENDER");
			var sendTime = d.getString("SENDTIME");
			var senderUUID = d.getString("SENDERUUID");
			_addMsg2DialogAtt(objId,"",miji,qixian,sender,sendTime,attname,atturl,senderUUID,"_search",false);
		}
		
	}
	
}

/**
 * 得到选择的组的人员在线情况,不会请求服务器
 */
function _setNowUsersValue(){
	if(msgObj_selectCount==null){
		msgObj_selectCount = document.getElementById("msgObj_selectCount");
	}
	msgObj_selectCount.innerHTML="";
	if (nowUsersObj==null){
		return;
	}
	var offlineUsersInt=0;
	var onlineUsersInt=0;
	for(var i=0;i<nowUsersObj.length;i++){
		var table = nowUsersObj[i].childNodes(0);
		var trs = table.rows;
		if (trs==null){
			break;
		}
		var len = trs.length;
		for(var j=0;j<len;j++){
			if(trs.item(j).getAttribute("online")=="false"){
				offlineUsersInt++;
			}else if(trs.item(j).getAttribute("online")=="true"){
				onlineUsersInt++;
			}
		}
	}
	var allUser = offlineUsersInt+onlineUsersInt;
	if(allUser>0){
		msgObj_selectCount.innerHTML = onlineUsersInt + "/" + allUser;
	}
	
}
/**
 * 添加所有人
 * @param orgId 处室的OrganId
 * @param dataList 所有用户的列表
 */
var nowUsersObj;
function _addUsers(orgId,dataList){
	var div = document.getElementById("msgObj_allUsersDiv");
	div.innerHTML="";
	var dl = _getDataList(orgId,dataList);
	var table = _addUsersTable(dl);
	nowUsersObj=new Array();
	nowUsersObj[nowUsersObj.length] = div;
	div.appendChild(table);
}

/**
 * 添加本处室人员
 * @param orgId 处室的OrganId
 * @param dataList 所有用户的列表
 */
function _addSelf(orgId,dataList){
	var div1 = document.getElementById("msgObj_selfDiv1");
	var div2 = document.getElementById("msgObj_selfDiv2");
	var dl = _getDataList(orgId,dataList);
	var len = dl.size();
	var len1 = parseInt(len/2,10);
	var dl1 = new DataList();
	for(var i=0;i<len1;i++){
		dl1.addData(dl.getData(i));
	}
	var dl2 = new DataList();
	for(var i=len1;i<len;i++){
		dl2.addData(dl.getData(i));
	}
	div1.appendChild(_addUsersTable(dl1));
	
	div2.appendChild(_addUsersTable(dl2));
	nowUsersObj=new Array();
	nowUsersObj[nowUsersObj.length] = div1;
	nowUsersObj[nowUsersObj.length] = div2;
}

/**
 * 添加常用联系人
 * @param uuid 本人的uuid
 */
function _addOften(uuid){
	var div1 = document.getElementById("msgObj_oftenDiv1");
	var div2 = document.getElementById("msgObj_oftenDiv2");
	var dl = _getContacts(uuid);
	var len = dl.size();
	var len1 = parseInt(len/2,10);
	var dl1 = new DataList();
	for(var i=0;i<len1;i++){
		dl1.addData(dl.getData(i));
	}
	var dl2 = new DataList();
	for(var i=len1;i<len;i++){
		dl2.addData(dl.getData(i));
	}
	div1.appendChild(_addUsersTable(dl1));
	
	div2.appendChild(_addUsersTable(dl2));
	nowUsersObj=new Array();
	nowUsersObj[nowUsersObj.length] = div1;
	nowUsersObj[nowUsersObj.length] = div2;
}
//所有组织对象
var subOrgs = new Array();
function _getUserOrganDataList(orgId){
	if (orgId==null || orgId=="ALL"){
		return "ALL";
	}
	var s = subOrgs[orgId];
	if (s==null){
		var param = "orgId=" + orgId;
		var orgDataList = getDataList("hx.message.ajax.Org",param);
		var len = orgDataList.size();
		s = splitChar;
		for(var i=0;i<len;i++){
			s+=orgDataList.getData(i).getString("ID") + splitChar;
		}
		subOrgs[orgId]=s;
	}
	return s;
}
//得到指定组织的所有人
function _getDataList(orgId,dataList){
	var orgIds = _getUserOrganDataList(orgId);
	if(orgIds=="ALL"){
		return dataList;
	}
	var dl = new DataList();
	var len = dataList.size();
	for(var i=0;i<len;i++){
		var uData = dataList.getData(i);
		var uOrgId = splitChar + uData.getString("ORGID")+splitChar;
		if(orgIds.indexOf(uOrgId)<0){
			continue;
		}
		dl.addData(uData);
	}
	return dl;
}
//将指定的DataList加入表中
function _addUsersTable(dataList){
	var table = document.createElement("TABLE");
	table.style.width="100%";
	table.cellSpacing="1";
	var tbody = document.createElement("TBODY");
	var len = dataList.size();
	for(var i=0;i<len;i++){
		var uData = dataList.getData(i);
		var uOrgId = uData.getString("ORGID");
		var userName=uData.getString("NAME");
		var orgName=uData.getString("ORGNAME");
		var id = uData.getString("ID");
		var room = uData.getString("ROOM");
		var tel = uData.getString("TEL");
		var email = uData.getString("EMAIL");
		var account = uData.getString("ACCOUNT");
		var online="offline";//online
		var onlineStr="离线";//在线
		var tr =  createTr();
		tr.setAttribute("orgid",uOrgId);
		tr.setAttribute("room",room);
		tr.setAttribute("tel",tel);
		tr.setAttribute("email",email);
		tr.setAttribute("account",account);
		tr.setAttribute("uuid",id);
		tr.setAttribute("userName",userName);
		tr.setAttribute("organName",orgName);
		var td = createTd();
		td.className="msg_user";
		td.onmouseover=function(){
			_moveUser(this);
		};
		td.onmouseout=function(){
			_moveOutUser(this);
		};
		//tr.onclick=function(){
		//	_talking(this);
		//};
		td.setAttribute("uuid",id);
		var s = "<table style=\"width: 100%\" cellspacing=\"0\" cellpadding=\"0\"><tr><td style=\"cursor:pointer;\" onclick=\"_talking(this);\" rowspan=\"2\" style=\"width: 50px;\" >";
		s+="<img src=\"" + resourcePath + "images/message/user";
		s+=online;
		s+=".png\" /></td><td style=\"cursor:pointer;\" onclick=\"_talking(this);\" class=\"msg_userTitle\" title=\"" + userName + "\">";
		s+=_filterUser(userName,6);
		s+="(" + onlineStr + ")";
		s+="</td>";
		//s+="<td rowspan=\"2\" class=\"msg_userTitle3\">";
		//s+="<img src=\"" + resourcePath + "images/message/contacts.png\" />";
		//s+="</td>";
		s+="</tr><tr><td class=\"msg_userTitle2\">";
		s+=orgName;
		
		if(contactAll.indexOf("," + id + ",")>=0){
			s+="&nbsp;&nbsp;&nbsp;&nbsp;<img title=\"从常用联系人列表中移除\" onclick=\"_setOften(this,'remove','" + id + "');\" style=\"cursor:pointer;\" uuid=\"" + id + "\" src=\"" + resourcePath + "images/message/contact_delete.png\">";
		}else{
			s+="&nbsp;&nbsp;&nbsp;&nbsp;<img title=\"添加为常用联系人\" onclick=\"_setOften(this,'add','" + id + "');\" style=\"cursor:pointer;\" uuid=\"" + id + "\" src=\"" + resourcePath + "images/message/contact_add.png\">";	
		}
		s+="</td></tr></table>";
		td.innerHTML=s;
		tr.appendChild(td);
		tbody.appendChild(tr);
	}
	//for循环结束
	table.appendChild(tbody);
	return table;
}
function _filterUser(userName,len){
	var l = userName.length;
	if(l>len){
		userName = userName.substring(0,len-1) + "...";
	}
	return userName;
}
//得到在线人员列表，进行在线人员处理
var splitChar=",";
var showOffline=true;
//设置是否显示离线用户
function _setShowOffline(o){
	if(o.checked){
		showOffline=true;
	}else{
		showOffline=false;
	}
	_refreshUserState();
}
/**
 * 获取在线用户
 * @param uuid
 * @returns {String} 逗号分隔的uuid
 */
function _getOnlineUsers(uuid){
	try {
	//得到在线用户
	var xml = getXml("hx.message.ajax.Online","uuid=" + uuid);
	//alert(xml);
	var root = loadXml(xml);
	//全部数据 
	var nodeList = root.childNodes;
	//判断是否超时，超时马上退出
	var logout = getAttribute(root,"logout");
	if (logout=="true"){
		window.top.document.location=path + "auth/logout.action?t=1";
		return;
	}
	var t = getAttribute(root,"time");
	if (t!=null){
		try {
			t = parseInt(t/1000/60,10);
		} catch (e) {
			t=0;
		}
	}
	try {
		timesInt =t;
	} catch (e) {
		timesInt=10;
	}
	var len = nodeList.length;
	var onlineShow = document.getElementById("msgObj_onlineUserSize");
	var xxjlShowOnlineUserSize = document.getElementById("xxjl_showOnlineUserSize");
	
	//将在线人数设置在右下角
	xxjlShowOnlineUserSize.innerHTML=len;
//	xxjlShowOnlineUserSize.innerHTML=len + "人在线";
	//将在线人数设置在首页右上角
	onlineShow.innerHTML=len;
	var userIds = splitChar;
	for(var i=0;i<len;i++){
		var node = nodeList.item(i);
		var userId = node.text;
		userIds+=userId + splitChar;
	}
		return userIds;
	} catch (e) {
		return null;
	}
	
}
function _loginMessage(uuid){
	//得到在线用户
	var xml = getXml("hx.message.ajax.Login","uuid=" + uuid);
	switch (xml) {
	case "Success":
		return true;
		break;
		case "Invalid":
		return false;
		break;
	case "NoUser":
		return false;
	break;
	case "ERROR":
		return false;
	break;

	default:
		mo.innerHTML="未知登录信息";
		return false;
		break;
	}

}
/**
 * 设置在线用户状态（需要定时执行）
 * @param uuid 当前人的uuid
 */
function _setOnlineUsers(uuid){
	var onlineUsers = _getOnlineUsers(uuid);
	if (onlineUsers==null){
		onlineUsers="";
	}
	//msgObj_oftenDiv1
	//msgObj_selfDiv1
	//msgObj_allUsersDiv
	var div1 = document.getElementById("msgObj_allUsersDiv");
	var div2 = document.getElementById("msgObj_selfDiv1");
	var div3 = document.getElementById("msgObj_selfDiv2");
	var div4 = document.getElementById("msgObj_oftenDiv1");
	var div5 = document.getElementById("msgObj_oftenDiv2");
	_setOnlineForOne(div1,onlineUsers,true);
	_setOnlineForOne(div2,onlineUsers);
	_setOnlineForOne(div3,onlineUsers);
	_setOnlineForOne(div4,onlineUsers);
	_setOnlineForOne(div5,onlineUsers);
}
/**
 * 修改状态
 * @param div
 * @param onlineUsers
 * @param flag true代表有搜索框
 */
function _setOnlineForOne(div,onlineUsers,flag){
	var tmps = div.childNodes;
	if(tmps.length>0){
		var table = tmps.item(0);
		if(table.tagName=="TABLE"){
			var trs = table.rows;
			var len = trs.length;
			for(var i=0;i<len;i++){
				var td = trs(i).cells(0);
				//如果uuid在在线列表中，则点亮图标
				//设置id的online=true
				var uuid = td.getAttribute("uuid");
				uuid = splitChar + uuid + splitChar;
				if(onlineUsers.indexOf(uuid)>=0){
					//在线
					td.setAttribute("online","true");
					trs(i).setAttribute("online","true");
					//trs(i).onclick=function(){
					//	_talking(this);
					//};
					var img = td.childNodes.item(0).rows(0).cells(0).childNodes.item(0);
					var newMsg = img.getAttribute("newMsg");
					if(newMsg=="true"){
						
					}else{
						var src = img.src;
						src = src.replaceByString("msg.gif","online.png");
						src = src.replaceByString("offline","online");
						img.src = src;
					}
					
					var ouserName = td.childNodes.item(0).rows(0).cells(1);
					var u = ouserName.innerHTML;
					u = u.replaceByString("(离线)","(在线)");
					ouserName.innerHTML = u;
					//显示在线用户,如果是搜索的，那么就停住
					if(flag && isPSearch){
						
					}else{
						trs(i).style.display="block";
					}
				}else{
					//离线
					td.setAttribute("online","false");
					trs(i).setAttribute("online","false");
					//trs(i).onclick=function(){
					//	_talking(this);
					//};
					//隐藏离线用户
					if(flag && isPSearch){
						
					}else{
						if(!showOffline){
							trs(i).style.display="none";
						}else{
							trs(i).style.display="block";
						}
					}
					var img = td.childNodes.item(0).rows(0).cells(0).childNodes.item(0);
					var newMsg = img.getAttribute("newMsg");
					if(newMsg=="true"){
						
					}else{
						var src = img.src;
						src = src.replaceByString("msg.gif","offline.png");
						src = src.replaceByString("online","offline");
						img.src = src;
					}
					var ouserName = td.childNodes.item(0).rows(0).cells(1);
					var u = ouserName.innerHTML;
					u = u.replaceByString("(在线)","(离线)");
					ouserName.innerHTML = u;
				}
				
			}
		}
	}
}
/**
 * 设置有消息的用户图标
 * @param img
 */

function _setMsgUserState(img){
	var src = img.src;
	src = src.replaceByString("offline.png","msg.gif");
	src = src.replaceByString("online.png","msg.gif");
	img.src = src;
	img.setAttribute("newMsg","true");
}
/**
 * 设置
 * @param img
 */
function _removeMsgUserState(img){
	img.setAttribute("newMsg","false");
	var src = img.src;
	src = src.replaceByString("msg.gif","online.png");
	img.src = src;
}
/*****************************************以上是主窗口的操作，以下是对话的操作********************************************************/
var msg_prefix = "dialogObj_";
var imgPath = resourcePath + "images/message/";


//点击用户打开对话框
function _talking(o){
	o = o.parentNode.parentNode.parentNode.parentNode.parentNode;
	var account = o.getAttribute("account");
	var uuid = o.getAttribute("uuid");
	var userName = o.getAttribute("userName");
	var organName = o.getAttribute("organName");
	var objId = msg_prefix + account;
	var obj = _openTalking(userName,organName,objId,uuid);
	//obj.onmousedown=_mm_move();
	//loadwin(objId);
	
	_removeNewMsgObj(objId);
	var img = o.cells(0).childNodes.item(0).rows(0).cells(0).childNodes.item(0);
	_removeMsgUserState(img);
	obj.style.display="block";
	_runLoad();
}
/**
 * 删除已经点击的新消息对象
 */
function _removeNewMsgObj(objId){
	var len = newMessageObj.length;
	for(var i=0;i<len;i++){
		if(newMessageObj[i]==objId){
			newMessageObj = newMessageObj.splice(i, 1);
			break;
		}
	}
}

/**
 * 初始化对话框
 * @param userName
 * @param organName
 * @param objId
 * @param uuid
 * @returns
 */
function _openTalking(userName,organName,objId,uuid){
	var obj = document.getElementById(objId);
	if (obj==null){
		_addDialogWindow(userName,organName,objId,uuid);
		obj = document.getElementById(objId);
	}
	return obj;
}
function _mm_move(o){
	MM_dragLayer(o.id,true,0,0,600,43,true,false,-1,-1,-1,-1,204,68,50,'',false,'');
}
function _getMjStr(objId){
	if(!isSecurity){
		return "";
	}
	var mj = document.getElementById("TMP_MJ");
	var qx = document.getElementById("TMP_QX");
	var mjops = mj.options;
	var qxops = qx.options;
	
	var	dialog = '密级：<select id="' + objId + '_mj" class="dialog_mj" onchange="_selectMj(this,\'' + objId + '_qx\')">';
	var len = mjops.length;
	for(var i=0;i<len;i++){
		var option = mjops(i);
		var text = option.text;
		var value = option.value;
		var letter = option.getAttribute("letter");
		var title = option.title;
		if (value!=null && value!=""){
			var l = parseInt(value,10);
			if (l>=0){
				dialog +="<option title=\"" + title + "\" value=\"" + value + "\"";
				if(l==0){
					dialog += " selected";
				}
				dialog += ">" + text + "</option>";
			}
		}
	}
	dialog += '</select>';
	dialog += '&nbsp;&nbsp; 期限：<select style="width:70px;" class="dialog_mj" id="' + objId + '_qx">';
	var len1 = qxops.length;
	for(var i=0;i<len1;i++){
		var option = qxops(i);
		var text = option.text;
		var value = option.value;
		var letter = option.getAttribute("letter");
		var title = option.title;
		if (letter!=null && letter!=""){
			letter = "," + letter + ",";
			if (letter.indexOf(",0,")>=0){
				dialog +="<option letter=\"" + letter + "\" title=\"" + title + "\" value=\"" + value + "\"";
				dialog += ">" + text + "</option>";
			}
		}
	}
	dialog += '</select>';
	return dialog;
}
function _selectMj(o,qxid){
	var letterValue = o.value;
	var qixian = document.getElementById(qxid);
	qixian.options.length=0;
	var qx = document.getElementById("TMP_QX");
	var qxops = qx.options;
	var len1 = qxops.length;
	for(var i=0;i<len1;i++){
		var option = qxops(i);
		var text = option.text;
		var value = option.value;
		var letter = option.getAttribute("letter");
		var title = option.title;
		if (letter!=null && letter!=""){
			letter = "," + letter + ",";
			if (letter.indexOf(letterValue)>=0){
				var op = new Option();
				op.text = text;
				op.value = value;
				op.setAttribute("letter", letter);
				op.setAttribute("title", title);
				if (letter.indexOf("|" + letterValue + "|")>=0){
					op.selected=true;
				}
				qixian.options.add(op);
			}
		}
	}
}
function _addDialogWindow(userName,organName,objId,uuid){
	
	var dialog = '<div id="' + objId + '" dialog="true" style="position:absolute; left:400px; top:60px; width:650px; z-index:100;display:none;" class="win"';
	dialog += "onmousedown='_mm_move(this);'";
	dialog += '><table id=\"' + objId + '_drag\" class="msg_main" width="600" border="1" cellpadding="0" cellspacing="0" class="win">';
	dialog += '<tr>';
	dialog += '<td class="dialog_title noBoder">';
	dialog += '<table width="100%" border="0" cellspacing="0" cellpadding="0">';
	dialog += '<tr>';
	dialog += '<td class="dialog_userLog">';
	dialog += '<img src="' + imgPath + 'user1.png" title="" alt="" height="35px" width="35px"></td>';
	dialog += '<td class="dialog_caption">' + userName + '<br>' + organName + '</td>';
	dialog += '<td class="dialog_close">';
	dialog += '<img onclick="_close(\'' + objId + '\');" onmouseover="_moveClose(this,\'' + imgPath + 'msg_title_close_move.jpg\');" onmouseout="_moveClose(this,\'' + imgPath + 'msg_title_close.jpg\');" src="' + imgPath + '/msg_title_close.jpg" title="" alt=""></td>';
	dialog += '</tr>';
	dialog += '</table>';
	dialog += '</td>';
	dialog += '</tr>';
	dialog += '<tr>';
	dialog += '<td valign="top">';
	dialog += '<table style="width: 600px; height: 400px" cellspacing="0" cellpadding="0">';
	dialog += '<tr>';
	dialog += '<td style="width: 360px; vertical-align: top; background-color: #ffffff">';
	dialog += '<table style="width: 100%" cellspacing="0" cellpadding="0">';
	dialog += '<tr>';
	dialog += '<td>';
	dialog += '<div class="dialog_content" id="' + objId + '_msg" desc="即时消息">';
	//dialog += '<div class="dialog_content1"  desc="即时消息">';



	//dialog += '</div><div><a id="' + objId + '_msgEnd" name="' + objId + '_Bookmark" href="#' + objId + '_Bookmark" target="_self" >&nbsp</a></div>';
	dialog += '</div>';
	dialog += '</td>';
	dialog += '</tr>';
	dialog += '<tr>';
	dialog += '<td class="dialog_miji">';
	dialog += '<table style="width: 100%" cellspacing="0" cellpadding="0">';
	dialog += '<tr>';
	dialog += '<td style="width: 28px;">';
	dialog += '<img src="' + imgPath + 'msg_dialog.png"></td>';

	//密级
	dialog += '<td class="dialog_miji_font">';
	dialog += _getMjStr(objId);
	dialog += '</td>';



	dialog += '<td></td>';
	dialog += '</tr>';
	dialog += '</table>';
	dialog += '</td>';
	dialog += '</tr>';
	dialog += '<tr>';
	dialog += '<td class="dialog_txtWindow">';

	//发送消息
	dialog += '<textarea  userName="' + userName + '" uuid="' + uuid + '" id="' + objId + '_txt" class="dialog_txt" onkeyup="_clearTxtEnter(this);" onkeydown="_keySend(\'' + objId + '\');"></textarea>';



	dialog += '</td>';
	dialog += '</tr>';
	dialog += '</table>';
	dialog += '</td>';
	dialog += '<td style="width: 4px; background-color: #c9ddeb">&nbsp;</td>';
	dialog += '<td style="width: 238px; background-color: #ffffff; vertical-align: top">';
	dialog += '<table style="width: 100%; height: 32px" cellspacing="0" cellpadding="0">';
	dialog += '<tr class="dialog_tab">';
	dialog += '<td style="width: 10px;">&nbsp;</td>';
	dialog += '<td style="width: 3px;">';
	dialog += '<img src="' + imgPath + 'th_left.jpg" style="height:32px;" alt=""></td>';
	dialog += '<td style="width: 80px;" class="th_title_sel" onclick="_selType(this);_openDiv(this,\'att\');">';
	dialog += '发送文件</td>';
	dialog += '<td style="width: 3px;">';
	dialog += '<img src="' + imgPath + 'th_right.jpg" style="height:32px;"  alt=""></td>';
	dialog += '<td style="width: 3px;">';
	dialog += '<img src="' + imgPath + 'th_left.jpg" style="height:32px;"  alt=""></td>';
	dialog += '<td style="width: 80px;" class="th_title" onclick="_selType(this);_openDiv(this,\'message\');_loadSearchMsg(\'' + objId + '\',\'' + uuid + '\');">';
	dialog += '消息历史</td>';
	dialog += '<td style="width: 3px;">';
	dialog += '<img src="' + imgPath + 'th_right.jpg" alt=""></td>';
	dialog += '<td>&nbsp;</td>';
	dialog += '</tr>';
	dialog += '</table>';
	dialog += '<div desc="消息历史" type="message"  class="dialog_msgs" style="display: none;">';
	dialog += '<table style="width: 233px;" cellspacing="0" cellpadding="0">';
	dialog += '<tr>';						
	dialog += '<td class="dialog_s">';
	dialog += '<div class="dialog_search" id="' + objId + '_search">';	

	dialog += '</div>';
	dialog += '</td>';						
	dialog += '</tr>';	
	
	dialog += '<tr>';						
	dialog += '<td class="msg_bar" uuid="' + uuid + '" id="' + objId + '_bar" page="1" pageSize="5" objId="' + objId + '" style="padding-right:5px;;height: 24px; background-color: #c9ddeb;border-bottom: 1px solid #ffffff;text-align:right;">';	
	dialog += '<span  onclick="javascript:_searchMsgToTop(this);">首页</span>&nbsp;<span onclick="javascript:_searchMsgTo(this,1);">下页</span>&nbsp;<span onclick="javascript:_searchMsgTo(this,-1);">上页</span>&nbsp;<span onclick="javascript:_searchMsgToEnd(this);">尾页</span>&nbsp;<input id="' + objId + '_bar_page" type="text" onkeyup="_searchKeyPage(this)" style="width:18px">/<span id="' + objId + '_bar_pageTotal"></span>页(<span id="' + objId + '_bar_dataTotal"></span>条)';
	dialog += '</td>';						
	dialog += '</tr>';	
	
	dialog += '<tr>';						
	dialog += '<td class="msg_bar" style="height: 24px; background-color: #c9ddeb;padding-left: 5px;">';	
	dialog += '内容：<input type="text" style="width:100px" id="' + objId + '_search_txt" onkeyup="_searchKey(\'' + objId + '\',\'' + uuid + '\')">&nbsp;&nbsp;&nbsp;<span onclick="javascript:_searchMsgTos(\'' + objId + '\',\'' + uuid + '\');">搜索</span>';
	dialog += '</td>';						
	dialog += '</tr>';										
									
	dialog += '</table>';	
	dialog += '</div>';
	dialog += '<div desc="发送文件" type="att">';

	 
	dialog += '<table style="width: 233px;" cellspacing="0" cellpadding="0">';
	dialog += '<tr>';						
	dialog += '<td class="dialog_att">';
	
	dialog += '<div class="dialog_miji_font dialog_miji_div">';
	dialog += _getMjStr(objId + "_att");
	dialog += '</div>';

	dialog += '<div class="dialog_miji_font dialog_miji_div">';		

	//为附件留的位置
	dialog += '<iframe frameborder="0" class="dialog_att_div" src="' + path + 'jsp/message/messageAtt.jsp?objId=' + objId + '"></iframe>';						

	dialog += '</div>';						
	dialog += '</td>';						
	dialog += '</tr>';						
	dialog += '<tr>';						
	dialog += '<td style="height: 4px; background-color: #c9ddeb">';						
	dialog += '</td>';						
	dialog += '</tr>';						
	dialog += '<tr>';						
	dialog += '<td>';						
	dialog += '<div class="dialog_attmsg" id="' + objId + '_att_msg">';	

	//附件消息

	dialog += '</div>';						
	dialog += '</td>';						
	dialog += '</tr>';						
	dialog += '</table>';						
	dialog += '</div>';						
	dialog += '</td>';						
	dialog += '</tr>';						
	dialog += '</table>';						
	dialog += '</td>';						
	dialog += '</tr>';						
	dialog += '<tr>';						
	dialog += '<td class="statusbar" style="text-align: center;">';						
	dialog += '<table style="width: 100%">';						
	dialog += '<tr>';						
	dialog += '<td class="dialog_tip">提示："Alt+s" 或者"Ctrl+回车"可以发送消息。</td>';						
	dialog += '<td style="text-align: left;">';						
	dialog += '<img src="' + imgPath + 'send.jpg" style="cursor: pointer" onclick="_sendTalkMsg(\'' + objId + '\',false);">';
	dialog += '<input type="checkbox" id="' + objId + '_sendType" checked><span style="cursor: pointer;" onclick="document.getElementById(\'' + objId + '_sendType\').click();">按Enter键发送消息</span>';						
	dialog += '</td>';						
	dialog += '</tr>';						
	dialog += '</table>';						
	dialog += '</td>';						
	dialog += '</tr>';						
	dialog += '</table>';						
	dialog += '<br>';						
	dialog += '</div></div>';						
//	var div = createDiv();
//	<div id="' + objId + '" class="win dialog_win_master" onmousedown="MM_dragLayer(\'' + objId + '\',\'\',0,0,490,45,true,false,-1,-1,-1,-1,204,68,50,\'\',false,\'\')">
//	div.id = objId;
//	div.className="dialog_win_master";
	//div.setAttribute("onmousedown","MM_dragLayer(objId,'',0,0,490,45,true,false,-1,-1,-1,-1,204,68,50,'',false,'')");
//	div.innerHTML=dialog;
//	document.getElementById("dialogPoPWindow").appendChild(div);
//	document.getElementById("dialogPoPWindow").outerHTML +=dialog;
//	document.body.appendChild(div);
	document.getElementById("dialogPoPWindow").innerHTML+=dialog;
	
}
function createDiv(){
	return document.createElement("DIV");
}

function _selectValue(o){
	o.select();
}
function _pSearchFocus(){
	try {
		var o = document.getElementById("xxjl_person_search");
		o.value="";
		o.focus();
	} catch (e) {
	}
}
var isPSearch=false;
function _keyPSearch(){
	var ev = window.event;
	//83=s/13=回车
	if((ev.keyCode && ev.keyCode==13)){
		_pSearch();
	}
}
function _pSearch(){
	var txt = document.getElementById("xxjl_person_search").value;
	var trs = document.getElementById("msgObj_allUsersDiv").childNodes(0).rows;
	var len = trs.length;
	for(var i=0;i<len;i++){
		var tr = trs[i];
		var name = tr.getAttribute("userName");
		var org = tr.getAttribute("organName");
		if(txt==""){
			tr.style.display="";
			isPSearch=false;
		}else{
			if(name!=null && org!=null){
				isPSearch=true;
				if(name.indexOf(txt)>=0 || org.indexOf(txt)>=0){
					tr.style.display="";
				}else{
					tr.style.display="none";
				}
			}
		}
	}
}