function doifreamesize(iframe_ary) {
	var parent_str = "";
	for(var x=0;x<iframe_ary.length;x++) {
		parent_str +="parent.";
		IFrameReSize(parent_str, iframe_ary[x]);
	}
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
			pTar.style.height = Math.max(pTar.contentDocument.body.offsetHeight, topH-breadH-2, windowH)+20+'px';
		} else if (pTar.Document && pTar.Document.body.scrollHeight) {
			pTar.style.height = Math.max(pTar.Document.body.scrollHeight, topH-breadH-2, windowH)+20+'px';
		}
		sidebar.style.height = Math.max(topH, windowH, pTar.offsetHeight)+'px';
	}
}

function dyniframesize(iframe_ary) {
	if(/webkit/.test(navigator.userAgent.toLowerCase())){
		return;
	}
	doifreamesize(iframe_ary);
	document.onclick=function(){
		doifreamesize(iframe_ary);
	};
}