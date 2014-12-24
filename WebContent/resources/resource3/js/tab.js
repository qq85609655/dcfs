var params = new Array();
var mainSave = false;
window.onload = function() {
	try {
		_load();
	} catch (e) {
	}
	try {
		_frame_load();
	} catch (e) {
	}
};
function _frame_load() {
	var mainName = document.getElementsByName("_TAB_MAIN")[0].value;
	_tab_click_me(null, mainName);
}

function getMainState() {
	return mainSave;
}
function setMainState(_mainSave) {
	mainSave = _mainSave;
}

function getParam(name) {
	return params[name];
}
function setParam(name, value, id) {
	refurbish(id);
	params[name] = value;
}
function refurbish(id) {
	var fs = document.getElementsByTagName("iframe");
	for (var i = 0; i < fs.length; i++) {
		var fo = fs[i];
		var name = fo.getAttribute("name");
		if (name != ("_TAB_FRAME_" + id)) {
			fo.setAttribute("refurbish", "true");
			if (fo.src.indexOf("waitingBlank.jsp") < 0){
				fo.src = resourcePath + "/share/pages/waitingBlank.jsp";
			}
		}
	}
}
function getAllParamStr(p) {
	if (p==null){
		p = new Array();
	}
	for (var i in params){
		p[i] = params[i];
	}
	var str = "";
	for (var name in p) {
		str += name + "=" + p[name] + "&";
	}
	str += "runTime=" + new Date().getTime();
	return str;
}
function getFrameSrc(name) {
	var src = document.getElementsByName("_TAB_SRC_" + name)[0];
	var url = src.value;
	var p = new Array();
	if (url.indexOf("?") > 0) {
		var paramStr = url.substr(url.indexOf("?")+1);
		url = url.substr(0, url.indexOf("?"));
		var params = paramStr.split("&");
		for (var i in params){
			if ("SortBy" == i){
				continue;
			}
			var temp = params[i].split("=");
			p[temp[0]] = temp[1];
		}
	}
	url += "?" + getAllParamStr(p);
	return url;
}
function _tab_click_me(o) {
	var mainName = document.getElementsByName("_TAB_MAIN")[0].value;
	var frameName = mainName;

	if (o != null) {
		frameName = o.getAttribute("frameName");
	}
	try {
		if (frameName == "") {
			var stab = document.getElementsByName("_TAB_VALUES")[0].value;
			frameName = stab.substring(0, stab.indexOf(","));
		}
	} catch (e) {
	}
	if (mainName != "" && mainName != frameName) {
		if (!getMainState()) {
			var mainNameValue = document.getElementsByName("_TAB_MAIN_NAME")[0].value;
			alert("标签：【" + mainNameValue + "】必须保存后才能操作其它标签！");
			return;
		}
	}
	var fObjs = document.getElementsByName(frameName);
	var fs = document.getElementsByTagName("iframe");
	for (var i = 0; i < fs.length; i++) {
		var fo = fs[i];
		if (fo.getAttribute("name") == "_TAB_FRAME_" + frameName) {
			var refurbish = fo.getAttribute("refurbish");
			if (fo.src == "") {
				//:TODO lizb 修改
				fo.src = "";
			}
			// alert("URL=" + getFrameSrc(frameName));
			if (fo.src == "" || fo.src.indexOf("waitingBlank.jsp") > 0 || refurbish == "true") {
				// alert(getFrameSrc(frameName));
				fo.src = getFrameSrc(frameName);
				fo.setAttribute("refurbish", "false");
			}
			fo.style.display = "";
		} else {
			fo.style.display = "none";
		}
	}
	var vo = document.getElementsByName("_TAB_VALUES")[0];
	var value = vo.value.split(",");
	for (var i = 0; i < value.length; i++) {
		var v = value[i];
		if (frameName == v) {
			document.getElementById("_TAB_IMG1_" + v).src = resourcePath
					+ "/images/tab/tab_01.jpg";
			var tabtxt = document.getElementById("_TAB_IMG2_" + v);
			tabtxt.className = "TAB_TXT";
			document.getElementById("_TAB_IMG3_" + v).src = resourcePath
					+ "/images/tab/tab_03.jpg";
		} else {
			document.getElementById("_TAB_IMG1_" + v).src = resourcePath
					+ "/images/tab/tab_h_01.jpg";
			var tabtxt = document.getElementById("_TAB_IMG2_" + v);
			tabtxt.className = "TAB_TXT1";
			document.getElementById("_TAB_IMG3_" + v).src = resourcePath
					+ "/images/tab/tab_h_03.jpg";
		}
	}
}
/**
 * @author 龙翔
 * @description 
 * 隐藏相关的TAB页标签
 * @param tabs {Array/String} 要隐藏的tab页标签的名称。
 */
function hideTab(tabs) {
	if (!_isArray(tabs)) {
		tabs = [tabs];
	}
	/*
	 * 获得需要被hide的element集合
	 */
	var hideTabs=[];
	for (i=0; i<tabs.length; i++) {
		var elements = document.getElementsByTagName("td");
		for (j=0; j<elements.length; j++) {
			if (elements[j].getAttribute("frameName") && elements[j].getAttribute("frameName") == tabs[i]) {
				hideTabs.push(elements[j]);
			}
		}
	}
	for (i=0; i<hideTabs.length; i++) {
		hideTabs[i].style.display = "none";
	}
}
/**
 * @author 龙翔
 * @description 
 * 取消相关的TAB页标签
 * @param tabs {Array/String} 要取消隐藏的tab页标签的名称。
 */
function unHideTab(tabs) {
	if (!_isArray(tabs)) {
		tabs = [tabs];
	}
	/*
	 * 获得需要被unHide的element集合
	 */
	var hideTabs=[];
	for (i=0; i<tabs.length; i++) {
		var elements = document.getElementsByTagName("td");
		for (j=0; j<elements.length; j++) {
			if (elements[j].getAttribute("frameName") && elements[j].getAttribute("frameName") == tabs[i]) {
				hideTabs.push(elements[j]);
			}
		}
	}
	for (i=0; i<hideTabs.length; i++) {
		hideTabs[i].style.display = "inline";
	}
}
/**
 * @author 龙翔
 * @description
 * 获得扩展TAB标签的Element
 * 注：扩展TAB标签的frameName的值固定为_TAB_EXPAND
 * @return Object Expand的TAB标签对象
 */
function getExpandTab() {
	var elements = document.getElementsByTagName("td");
	for (j=0; j<elements.length; j++) {
		if (elements[j].getAttribute("frameName") && elements[j].getAttribute("frameName") == "_TAB_EXPAND") {
			return elements[j];
		}
	}
}
/**
 * @author 龙翔
 * @description
 * 将HTML代码加入扩展TAB标签内，实现自定义扩展标签。
 * @param html 填充到扩展TAB标签内的HTML代码。如果html为空，即清除标签内的HTML代码。
 */
function setExpandTabHtml(html) {
	var expandTab = getExpandTab();
	if (expandTab) {
		expandTab.innerHTML = html?html:'';
	} 
}