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
	    	  
	    	//�����д��ڵ�zIndex����Ϊ100������������Ϊ200
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
 * �����Ч�����ش���
 * @param obj DIV���ڵ�ID
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
 * �ر�ָ���Ĵ���
 * @param o DIV���ڵ�ID
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
	//83=s/13=�س�
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
 * ���͸���
 * @param txtid �����˵Ĵ���ID
 * @param atts ������Ϣ atts[i]["fileName"]  atts[i]["url"]
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
	_addState2Dialog(txtid,"�������ͳɹ���","_att");
}
/**
 * ���ͶԻ���Ϣ
 * @param txtid ���û���¼ID+ǰ׺��id
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
		alert("��������Ϣ��");
		txtObj.focus();
		return;
	}
	txtObj.value="";
	
	_addMsg2Dialog(txtid,content,mjText,qxText);
	_sendMsg2Server(txtid,uuid,content,mj,qx,"0");
	
}
/**
 * �����ļ���������
 * @param uuid ���͵�����Ա��uuid
 * @param content ����
 * @param mj �ܼ�
 * @param qx ����
 * @param type 1Ϊ���� 0Ϊ�ı���Ϣ
 */
function _sendMsg2Server(txtid,uuid,content,mj,qx,type,attname,atturl){
	content = content.replaceByString("&","��");
	content = content.replaceByString("?","��");
	if (type=="1"){
		attname = attname.replaceByString("&","��");
		atturl = atturl.replaceByString("?","��");
	}
	//��
	var param = "to=" + uuid + "&type=" + type + "&miji=" + mj + "&qixian=" + qx + "&attname=" + attname + "&atturl=" + atturl + "&content=" + content;
	var xml = getXml("hx.message.ajax.SendMessage",param);
	//_addState2Dialog(txtid,"�ɹ�����" + xml + "����Ϣ��");
	return xml;
}



/*********************************************************************/
function executeMsg2Server(className, param) {
	if (className==null){
		alert("������ʵ����className������Ϊnull��");
	}
	if(param==null){
		param="";
	}
	xmlhttp = getXmlHttpRequest();
	//pathΪȫ�ֵ������ĸ�
	var url = path + "AjaxExecute";
	if (xmlhttp != null) {
		xmlhttp.open("POST", url, false);
		//if (!asyn) {
		//	xmlhttp.onreadystatechange = OnReadyStateChng;
		//}
		// ��һ������post�������͵�ʱ�����д��
	    xmlhttp.setrequestheader('cache-control','no-cache');  
	    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
		// �ύ�Ĳ���
		var postParam = "className=" + className + "&" + param;
		postParam = encodeURI(postParam);
		postParam = encodeURI(postParam);//2�α�����Ϊ�˽����������
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
        var xml = xmlhttp.responseText; //�������
        _getMsg2ServerXml(xml);
    }
}


var newMessageObj = new Array();
/**
 * �õ���Ϣ
 * @param uuid �û���uuid
 * @param offline trueΪ���ߣ�false�򲻴�Ϊ���ߣ����ߴ����ݿ��ж�ȡ��Ϣ
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
		//����
		var content = c.childNodes.item(0).text;
		//������
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
			//�����ı���Ϣ
			content = content.replaceByString("��","&");
			content = content.replaceByString("��","?");
			_addMsg2Dialog(objId,content,miji,qixian,sender,sendTime);
		}else{
			//���ظ�����Ϣ
			var att = contents.item(1).childNodes;
			var atturl = att.item(0).text;
			var attname = att.item(1).text;
			atturl = atturl.replaceByString("��","&");
			atturl = atturl.replaceByString("��","?");
			attname = attname.replaceByString("��","&");
			attname = attname.replaceByString("��","?");
			_addMsg2DialogAtt(objId,content,miji,qixian,sender,sendTime,attname,atturl,senderUUID,null,true);
		}
	}
	if(newMessageObj.length>0){
		_setMessageState();
	}
}

/*********************************************************************/



/**
 * �༭������ϵ��
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
		//����ϵ�������ҳ��
		_addContactToDiv(o);
	}else{
		contactAll.replaceByString(uuid + ",","");
		//����ϵ�˴�ҳ�����Ƴ�
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
				img.title="�ӳ�����ϵ���б����Ƴ�";
				img.style.cursor="pointer";
			}else{
				img.src=resourcePath + "images/message/contact_add.png";
				img.onclick=function(){
					var u = this.getAttribute("uuid");
					_setOften(this,"add",u);
				};
				img.title="���Ϊ������ϵ��";
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
 * ��������ϵ�����ӵ��б���
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
	//�ж��ĸ���ϵ��������
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
 * �õ���ϵ����Ϣ��TR
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
	var onlineStr="����";//����
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
		s+="&nbsp;&nbsp;&nbsp;&nbsp;<img title=\"�ӳ�����ϵ���б����Ƴ�\" onclick=\"_setOften(this,'remove','" + id + "');\" style=\"cursor:pointer;\" uuid=\"" + id + "\" src=\"" + resourcePath + "images/message/contact_delete.png\">";
	}else{
		s+="&nbsp;&nbsp;&nbsp;&nbsp;<img title=\"���Ϊ������ϵ��\" onclick=\"_setOften(this,'add','" + id + "');\" style=\"cursor:pointer;\" uuid=\"" + id + "\" src=\"" + resourcePath + "images/message/contact_add.png\">";	
	}
	s+="</td></tr></table>";
	td.innerHTML=s;
	tr.appendChild(td);
	return tr;
}
var contactCount=0;
var contactAll=",";
/**
 * �õ����еĳ�����ϵ��
 * @param uuid ���˵�uuid
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
 * ���ü�ʱ��Ϣ������
 */
function _setMessageState(){
	//(������Ϣ)
	//xxjl_newMessageSize
	//xxjl_ico
	var len = newMessageObj.length;
	if(len>0){
		_flashGo(true);
		//document.getElementById("xxjl_newMessageSize").innerHTML="(" + len + "������Ϣ)";
		document.getElementById("xxjl_newMessageSize").innerHTML=len;
		var ico = document.getElementById("xxjl_ico");
		ico.src=resourcePath + "/images/message/msging.gif";
	}
}

/**
 * �����Ϣ����
 */
function _clearMessageState(){
	//(������Ϣ)
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
 * ����Զ������ݵ�����
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
 * �����Ϣ������
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
	case "��": 
		mjStr="";
		break;
	case "�ڲ�����": 
		mjStr="�ڲ����� ע�Ᵽ��";
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
			mjStr= "��" + mjText + "��" + "��";
		break;
		default:
			mjStr="��" + mjText + "��" + qxText + "��";
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
	content = content.replaceByString("��"," ");
	dialog += '<div class="info_name">';
	dialog += sender + '˵��' + mjStr + '<span>' + nowDate + '</span></div>';
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
	case "��": 
		mjStr="";
		break;
	case "�ڲ�����": 
		mjStr="�ڲ����� ע�Ᵽ��";
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
			mjStr= "��" + mjText + "��" + "��";
		break;
		case "��": 
			mjStr= "��" + mjText + "��" + "��";
		break;
		default:
			mjStr="��" + mjText + "��" + qxText + "��";
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
	dialog += sender + '�����ļ���' + mjStr + '</div>';						
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
			dialog += '">����</a>';
			dialog += '</td>';
			dialog += '<td style="width: 34px;" class="info_jishou" nowrap>';
			dialog += '<a href="#" onclick="_hidden(this);">����</a>';
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
 * ������պ��������һ����Ϣ
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
	var content = "���Ѿ���ʼ�����������ҵ��ļ�����" + o.title + "��";
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
//����ָ��������
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
 * �õ������û���Ϣ
 * @param uuid
 * @returns
 */
function _getUserDataList(uuid){
	if(userDataList==null){
		// AJAX�õ������û�
		//���û������������½�
		//�õ������û�
		userDataList = getDataList("hx.message.ajax.Person","uuid=" + uuid);
		var allUserShow = document.getElementById("msgObj_allUserSize");
		//�������������������½�
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
	//83=s/13=�س�
	if((ev.keyCode && ev.keyCode==13)){
		_searchMsgTos(objId,uuid);
	}
}
function _searchKeyPage(o){
	var ev = window.event;
	//83=s/13=�س�
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
 * ��ѯ��ʷ����
 * @param start ��ʼ����
 * @param end ��������
 * @param c ����
 * @param page ��ǰҳ
 * @param pageSize ÿҳ����������
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
			//�����ı���Ϣ
			var content = d.getString("CONTENT_TXT");
			content = content.replaceByString("��","&");
			content = content.replaceByString("��","?");
			var miji = d.getString("MIJI");
			var qixian = d.getString("QIXIAN");
			var sender = d.getString("SENDER");
			var sendTime = d.getString("SENDTIME");
			if(c!=null && c!="" && c.atrim()!="" && c.atrim()!="null"){
				content = content.replaceByString(c,"<span��class='info_searchMsg'>" + c + "</span>");
			}
			_addMsg2Dialog(objId,content,miji,qixian,sender,sendTime,"_search");
		}else{
			//���ظ�����Ϣ
			var atturl = d.getString("ATTURL");
			var attname = d.getString("ATTNAME");
			atturl = atturl.replaceByString("��","&");
			atturl = atturl.replaceByString("��","?");
			attname = attname.replaceByString("��","&");
			attname = attname.replaceByString("��","?");
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
 * �õ�ѡ��������Ա�������,�������������
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
 * ���������
 * @param orgId ���ҵ�OrganId
 * @param dataList �����û����б�
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
 * ��ӱ�������Ա
 * @param orgId ���ҵ�OrganId
 * @param dataList �����û����б�
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
 * ��ӳ�����ϵ��
 * @param uuid ���˵�uuid
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
//������֯����
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
//�õ�ָ����֯��������
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
//��ָ����DataList�������
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
		var onlineStr="����";//����
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
			s+="&nbsp;&nbsp;&nbsp;&nbsp;<img title=\"�ӳ�����ϵ���б����Ƴ�\" onclick=\"_setOften(this,'remove','" + id + "');\" style=\"cursor:pointer;\" uuid=\"" + id + "\" src=\"" + resourcePath + "images/message/contact_delete.png\">";
		}else{
			s+="&nbsp;&nbsp;&nbsp;&nbsp;<img title=\"���Ϊ������ϵ��\" onclick=\"_setOften(this,'add','" + id + "');\" style=\"cursor:pointer;\" uuid=\"" + id + "\" src=\"" + resourcePath + "images/message/contact_add.png\">";	
		}
		s+="</td></tr></table>";
		td.innerHTML=s;
		tr.appendChild(td);
		tbody.appendChild(tr);
	}
	//forѭ������
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
//�õ�������Ա�б�����������Ա����
var splitChar=",";
var showOffline=true;
//�����Ƿ���ʾ�����û�
function _setShowOffline(o){
	if(o.checked){
		showOffline=true;
	}else{
		showOffline=false;
	}
	_refreshUserState();
}
/**
 * ��ȡ�����û�
 * @param uuid
 * @returns {String} ���ŷָ���uuid
 */
function _getOnlineUsers(uuid){
	try {
	//�õ������û�
	var xml = getXml("hx.message.ajax.Online","uuid=" + uuid);
	//alert(xml);
	var root = loadXml(xml);
	//ȫ������ 
	var nodeList = root.childNodes;
	//�ж��Ƿ�ʱ����ʱ�����˳�
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
	
	//�������������������½�
	xxjlShowOnlineUserSize.innerHTML=len;
//	xxjlShowOnlineUserSize.innerHTML=len + "������";
	//������������������ҳ���Ͻ�
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
	//�õ������û�
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
		mo.innerHTML="δ֪��¼��Ϣ";
		return false;
		break;
	}

}
/**
 * ���������û�״̬����Ҫ��ʱִ�У�
 * @param uuid ��ǰ�˵�uuid
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
 * �޸�״̬
 * @param div
 * @param onlineUsers
 * @param flag true������������
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
				//���uuid�������б��У������ͼ��
				//����id��online=true
				var uuid = td.getAttribute("uuid");
				uuid = splitChar + uuid + splitChar;
				if(onlineUsers.indexOf(uuid)>=0){
					//����
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
					u = u.replaceByString("(����)","(����)");
					ouserName.innerHTML = u;
					//��ʾ�����û�,����������ģ���ô��ͣס
					if(flag && isPSearch){
						
					}else{
						trs(i).style.display="block";
					}
				}else{
					//����
					td.setAttribute("online","false");
					trs(i).setAttribute("online","false");
					//trs(i).onclick=function(){
					//	_talking(this);
					//};
					//���������û�
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
					u = u.replaceByString("(����)","(����)");
					ouserName.innerHTML = u;
				}
				
			}
		}
	}
}
/**
 * ��������Ϣ���û�ͼ��
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
 * ����
 * @param img
 */
function _removeMsgUserState(img){
	img.setAttribute("newMsg","false");
	var src = img.src;
	src = src.replaceByString("msg.gif","online.png");
	img.src = src;
}
/*****************************************�����������ڵĲ����������ǶԻ��Ĳ���********************************************************/
var msg_prefix = "dialogObj_";
var imgPath = resourcePath + "images/message/";


//����û��򿪶Ի���
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
 * ɾ���Ѿ����������Ϣ����
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
 * ��ʼ���Ի���
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
	
	var	dialog = '�ܼ���<select id="' + objId + '_mj" class="dialog_mj" onchange="_selectMj(this,\'' + objId + '_qx\')">';
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
	dialog += '&nbsp;&nbsp; ���ޣ�<select style="width:70px;" class="dialog_mj" id="' + objId + '_qx">';
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
	dialog += '<div class="dialog_content" id="' + objId + '_msg" desc="��ʱ��Ϣ">';
	//dialog += '<div class="dialog_content1"  desc="��ʱ��Ϣ">';



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

	//�ܼ�
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

	//������Ϣ
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
	dialog += '�����ļ�</td>';
	dialog += '<td style="width: 3px;">';
	dialog += '<img src="' + imgPath + 'th_right.jpg" style="height:32px;"  alt=""></td>';
	dialog += '<td style="width: 3px;">';
	dialog += '<img src="' + imgPath + 'th_left.jpg" style="height:32px;"  alt=""></td>';
	dialog += '<td style="width: 80px;" class="th_title" onclick="_selType(this);_openDiv(this,\'message\');_loadSearchMsg(\'' + objId + '\',\'' + uuid + '\');">';
	dialog += '��Ϣ��ʷ</td>';
	dialog += '<td style="width: 3px;">';
	dialog += '<img src="' + imgPath + 'th_right.jpg" alt=""></td>';
	dialog += '<td>&nbsp;</td>';
	dialog += '</tr>';
	dialog += '</table>';
	dialog += '<div desc="��Ϣ��ʷ" type="message"  class="dialog_msgs" style="display: none;">';
	dialog += '<table style="width: 233px;" cellspacing="0" cellpadding="0">';
	dialog += '<tr>';						
	dialog += '<td class="dialog_s">';
	dialog += '<div class="dialog_search" id="' + objId + '_search">';	

	dialog += '</div>';
	dialog += '</td>';						
	dialog += '</tr>';	
	
	dialog += '<tr>';						
	dialog += '<td class="msg_bar" uuid="' + uuid + '" id="' + objId + '_bar" page="1" pageSize="5" objId="' + objId + '" style="padding-right:5px;;height: 24px; background-color: #c9ddeb;border-bottom: 1px solid #ffffff;text-align:right;">';	
	dialog += '<span  onclick="javascript:_searchMsgToTop(this);">��ҳ</span>&nbsp;<span onclick="javascript:_searchMsgTo(this,1);">��ҳ</span>&nbsp;<span onclick="javascript:_searchMsgTo(this,-1);">��ҳ</span>&nbsp;<span onclick="javascript:_searchMsgToEnd(this);">βҳ</span>&nbsp;<input id="' + objId + '_bar_page" type="text" onkeyup="_searchKeyPage(this)" style="width:18px">/<span id="' + objId + '_bar_pageTotal"></span>ҳ(<span id="' + objId + '_bar_dataTotal"></span>��)';
	dialog += '</td>';						
	dialog += '</tr>';	
	
	dialog += '<tr>';						
	dialog += '<td class="msg_bar" style="height: 24px; background-color: #c9ddeb;padding-left: 5px;">';	
	dialog += '���ݣ�<input type="text" style="width:100px" id="' + objId + '_search_txt" onkeyup="_searchKey(\'' + objId + '\',\'' + uuid + '\')">&nbsp;&nbsp;&nbsp;<span onclick="javascript:_searchMsgTos(\'' + objId + '\',\'' + uuid + '\');">����</span>';
	dialog += '</td>';						
	dialog += '</tr>';										
									
	dialog += '</table>';	
	dialog += '</div>';
	dialog += '<div desc="�����ļ�" type="att">';

	 
	dialog += '<table style="width: 233px;" cellspacing="0" cellpadding="0">';
	dialog += '<tr>';						
	dialog += '<td class="dialog_att">';
	
	dialog += '<div class="dialog_miji_font dialog_miji_div">';
	dialog += _getMjStr(objId + "_att");
	dialog += '</div>';

	dialog += '<div class="dialog_miji_font dialog_miji_div">';		

	//Ϊ��������λ��
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

	//������Ϣ

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
	dialog += '<td class="dialog_tip">��ʾ��"Alt+s" ����"Ctrl+�س�"���Է�����Ϣ��</td>';						
	dialog += '<td style="text-align: left;">';						
	dialog += '<img src="' + imgPath + 'send.jpg" style="cursor: pointer" onclick="_sendTalkMsg(\'' + objId + '\',false);">';
	dialog += '<input type="checkbox" id="' + objId + '_sendType" checked><span style="cursor: pointer;" onclick="document.getElementById(\'' + objId + '_sendType\').click();">��Enter��������Ϣ</span>';						
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
	//83=s/13=�س�
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