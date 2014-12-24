var sigle = 'false';

function doifreamesize(iframe_ary) {
	var parent_str = "";
	for(var x=0;x<iframe_ary.length;x++) {
		parent_str +="parent.";
		if(sigle=='false'){
			IFrameReSize(parent_str, iframe_ary[x]);
		}else{
			sigleIFrameReSize(parent_str, iframe_ary[x]);
		}	
	}
}

//add by mayun iframe gaoduzishiying
function adjustIFramesHeightOnLoad(iframe) {
	var iframeHeight = Math.min(iframe.contentWindow.window.document.documentElement.scrollHeight, iframe.contentWindow.window.document.body.scrollHeight);
	$(iframe).height(iframeHeight);
}

function IFrameReSize(pTarStr, iframename){
	eval('window.pTar = '+pTarStr+'document.getElementById("'+iframename+'");');
	
	var sidebar = top.document.getElementById("sidebar");
	var nav = top.document.getElementById("nav").offsetHeight;
	var collapse = top.document.getElementById("sidebar-collapse").offsetHeight;
	var topH = nav+collapse;
	var navH = top.document.getElementById("navbar").offsetHeight;
	var breadH = top.document.getElementById("breadcrumbs").offsetHeight;
	var windowH = top.document.documentElement.clientHeight-navH-breadH;
	
	sidebar.style.display = "block";
	sidebar.style.height = Math.max(topH, windowH)+'px';
	if (pTar && !window.opera) {
		pTar.style.display = "block";
		if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight) {
			pTar.style.height = Math.max(pTar.contentDocument.body.offsetHeight, topH-breadH-2, windowH)+25+'px';
		} else if (pTar.Document && pTar.Document.body.scrollHeight) {
			pTar.style.height = Math.max(pTar.Document.body.scrollHeight, topH-breadH-2, windowH)+25+'px';
		}
		sidebar.style.height = Math.max(topH, windowH, pTar.offsetHeight)+'px';
	}
}

function dyniframesize(iframe_ary) {
	if(/webkit/.test(navigator.userAgent.toLowerCase())){
		return;
	}
	var iframe_ary = iframe_ary;
	doifreamesize(iframe_ary);
	document.onclick=function(){
		doifreamesize(iframe_ary);
	};
}


function intoiframesize(iframename){
	var obj = parent.document.getElementById(iframename);
	obj.style.height =	obj.contentDocument.body.offsetHeight +'px';
}

function setSigle(){
	sigle = 'true';
}

function sigleIFrameReSize(pTarStr, iframename){
	var _height = 0;
	if (iframename=='mainFrame'){
		_height = 25;
	}
	if (iframename=='iframe'){
		_height = 25;
	}
	eval('window.pTar = '+pTarStr+'document.getElementById("'+iframename+'");');
	if (typeof(pTar) == "undefined") { 
		return;
	}
	if (pTar && !window.opera) {
		pTar.style.display = "block";
		if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight) {
			pTar.style.height = pTar.contentDocument.body.offsetHeight+_height+'px';
		} else if (pTar.Document && pTar.Document.body.scrollHeight) {
			pTar.style.height = pTar.Document.body.scrollHeight+_height+'px';
		}
		
	}
}

