/*---------------------------------------------------------------------------*\
|  Subject: JavaScript Framework
|  Author:  meizz
|  Created: 2005-02-27
|  Version: 2006-08-11
|-----------------------------------
|  MSN:huangfr@msn.com  QQ:112889082
|  http://www.meizz.com  Copyright (c) meizz   MIT-style license
|  The above copyright notice and this permission notice shall be
|  included in all copies or substantial portions of the Software
\*---------------------------------------------------------------------------*/
//此参数请与TreeTag.SPLIT相同
var TreeTag_SPLIT = ",";


//搜索的结果
var sv=new Array();
var nowIndex=0;
 function _search(){
	 o=document.getElementById('search');
	 nowIndex=0;
	 o1=tree;
	 if (o.value.trim()!=""){
	 sv = searchTreeNode(tree,o.value,false,true,false);
	 }else{
		 sv=new Array();
	 }
	 _showValue(o1);
 }
 function _aa(txt){
	 document.getElementById("ds").innerHTML+=txt;
 }
 function _previous(o){
	 nowIndex--;
	 if (nowIndex<0){
		 nowIndex=0;
	 }
	 _showValue(o);
 }
 function _next(o){
	 nowIndex++;
	 if(sv.length<=nowIndex){
		 nowIndex=sv.length-1;
	 }
	 _showValue(o);
 }
 function _showValue(o){
	 var dis = document.getElementById("searchPlay");
	 var jg="";
	 if(sv.length==0){
		 jg = "没有符合条件的结果";
		 dis.innerHTML=jg;
		 dis.style.display="";
		 document.getElementById("treeDiv").style.height="380px";
		 return;
	 }else if(sv.length==1){
		 jg = "搜索结果：";
	 }else{
		 jg = "共" + sv.length + "条结果，当前第" + (nowIndex+1) + "条："; 
		 document.getElementById("p").style.display="";
		 document.getElementById("n").style.display="";
	 }
	 
	 if(nowIndex>=sv.length){
		 return;
	 }
	 var nodeId = sv[nowIndex];
	 
	 expNode(o,nodeId);
	 var node = o.getNodeById(nodeId);
	 jg+=node.text;
	 dis.innerHTML=jg;
	 dis.style.display="";
	 document.getElementById("treeDiv").style.height="380px";
	 _gotoNode(node.id);
	 node.focus();
 }
 function _gotoNode(n){
	 try {
	 	var nodeDiv = document.getElementById("oneNode_div_" + n);
	 	var div = document.getElementById("treeDiv");
	 	var oneTop = nodeDiv.offsetTop;
	 	//var divTop = div.scrollTop;
	 	div.scrollTop = oneTop;
	 	div.scrollTop = oneTop;
	 } catch (e) {
	 }
 }
 function _keySearch(o){
	var ev = window.event;
	if((ev.keyCode && ev.keyCode==13)){
		_search();
		return;
	}
	if((ev.keyCode && ev.keyCode==33)){
		_previous(o);
		return false;
	}
	if((ev.keyCode && ev.keyCode==34)){
		_next(o);
		return false;
	}
 }
 /**
  * 双击节点时的操作
  * @param node 选中的节点
  */
 function _nodedbClick(node){
	 //alert("双击：" + node.text);
 }
 /**
  * 单击节点时的操作
  * @param node 选中的节点
  */
 function _nodeClick(node,tree){
	
	 //alert("单击：" + node.text);
	 //alert("单击1：" + tree);
	 //兼容之前的tree的点击事件
	 try {
		 L(node.id,true,node,tree);
	} catch (e) {}
	 
 }
 function _getDataValue(o,id){
	 var data = o.dataSource;
	 n = data.getNodeById(id);
 }
 /**
  * 焦点定位时的操作
  * @param node 选中的节点
  */
 function _nodeFocus(node){
	 //alert("焦点：" + node.text);
	 var dis = document.getElementById("disView");
	 var selectValues = getSelectValue(tree,isShowParent,false);
	 var v = "";
	 if (tree.useCheckbox){
		 if(selectValues!=null){
			 for(var i in selectValues){
				 var n = selectValues[i]["name"];
				 if (n!=null){
					 if (v!=""){
						 v+=";";
					 } 
					 v +=n;
				 }
			 }
		 }
	 }else{
		 v = selectValues["name"];
	 }
	 dis.innerHTML=v;
	 dis.title=v;
 }
 function _nodeCheck(node,checked){
	 _nodeFocus(node);
 }
 function expandAll(){
	 tree.expandAll('0');
 }
 function collapseAll(o){
	 var node = o.getNodeById('0');
	 var nodes = node.childNodes;
	 for(var i in nodes){
		 tree.collapseAll(nodes[i].id);
	 }
 }
 
/**
 * 展开指定id的节点
 * @param o tree对象
 * @param nodeId 节点的id
 */
function expNode(o,nodeId){
	 var ids = getExpNodeId(o,nodeId);
	 var len = ids.length;
	 for(var i=len-1;i>=1;i--){
		 o.expand(ids[i]);
	 }
}
/**
 * 得到指定节点以及未展开的所有节点
 * @param o
 * @param nodeId
 * @param ids
 * @param p
 * @returns
 */
function getExpNodeId(o,nodeId,ids,p){
	 var node = o.getNodeById(nodeId);
	 if (ids==null){
		 ids = new Array();
	 }
	 ids[ids.length]=nodeId;
	 if (node==null){
		 var nodes = o.dataSource;
		 for ( var i in nodes) {
			 if (i.indexOf("#") > 0) {
				var t = i.substring(0,i.indexOf("#"));
				var t1 = i.substring(i.indexOf("#")+1);
				if(nodeId==t1){
					if (t=="-1"){
						return ids;
					}else{
						if (t1==nodeId){
							return getExpNodeId(o,t,ids);
						}
					}
				}
			 }
		 }
		 return ids;
	 }else{
		 if(p){
		 	return ids;
		 }else{
			 return getExpNodeId(o,nodeId,ids,true);
		 }
	 }
}
/**
 * 得到指定的树的选择的值
 * 
 * @param name
 *            树对象 如果是单选，则返回{name:名称,value:值}
 *            如果是多选，则返回{{name:名称,value:值},{name:名称,value:值}...}
 * @param isShowParent 是否显示所有名称
 * @param exp 是否全部展开获取所有选中内容
 * @return 数组或二维数组
 */
function getSelectValue(name,isShowParent,exp) {
	var selIds=new Array();
	if(exp==true){
		var r = _expSelectedNode(name);
	}
	if (name.useCheckbox) {
		var selValue = new Array();
		var nodes = name.nodes;
		for ( var i in nodes) {
			if (nodes[i].checked) {
				var id = nodes[i].id;
				//判断只能选择叶子节点
				if(name.onlyCheckChild){
					if(nodes[i].hasChild){
						continue;
					}
				}
				//判断每个节点是否可以选择
				var sindex = nodes[i].sourceIndex;
				if (sindex!=null && sindex!=""){
					var dataStr = name.dataSource[nodes[i].sourceIndex];
					var canCheck = dataStr.getAttribute("canCheck");
					if (canCheck=="false"){
						continue;
					}
				}
				if(selIds[id]!="true"){
					if (id!=null){
						var index = selValue.length;
						selValue[index] = new Array();
						selValue[index]["name"] = getSelValues(nodes[i],isShowParent,false);
						selValue[index]["value"] = id;
						selIds[id]="true";
					}
				}
			}
		}
		return selValue;
	} else {
		var selValue = new Array();
		//判断只能选择叶子节点
		if(name.onlyCheckChild){
			if(name.selectedNode.hasChild){
				selValue["name"]="";
				selValue["value"]="";
				return selValue;	
			}
		}
		//判断每个节点是否可以选择
		var sindex = name.selectedNode.sourceIndex;
		if (sindex!=null && sindex!=""){
			var dataStr = name.dataSource[name.selectedNode.sourceIndex];
			var canCheck = dataStr.getAttribute("canCheck");
			if (canCheck=="false"){
				selValue["name"]="";
				selValue["value"]="";
				return selValue;
			}
		}
		selValue["name"] = getSelValues(name.selectedNode,isShowParent,false);
		selValue["value"] = name.selectedNode.id;
		return selValue;
	}
	// a.collapseAll(1);
}
function _loadChildNodes(nodes){
	for ( var i in nodes) {
		try {
			nodes[i].loadChildNodes();
		} catch (e) {
		}
		var nds = nodes[i].childNodes;
		if(nds!=null){
			_loadChildNodes(nds);
		}
	}
	return 0;
}
function _expSelectedNode(o){
	if (o.useCheckbox) {
		var nodes = o.nodes;
		for ( var i in nodes) {
			if (nodes[i].checked) {
				try {
					nodes[i].loadChildNodes();
				} catch (e) {
				}
				var nds = nodes[i].childNodes;
				_loadChildNodes(nds);
			}
		}
	}
	return 0;
}
function getSelValues(node,isShowParent){
	if(isShowParent){
		var reValue = node.text;
		var pNode = node.parentNode;
		if(pNode.id==0){
			return reValue;
		}else{
			reValue = getSelValues(pNode,isShowParent)+"-"+reValue;
			return reValue;
		}
	}else{
		return node.text;
	}
}
/**
 * 搜索树
 * 
 * @param o
 *            树对象
 * @param str
 *            搜索的条件
 * @param isSplit
 *            是否将条件拆开搜索，默认false
 * @param searchName
 *            true搜索名称
 * @param searchValue
 *            true搜索值 return 符合条件的Node数组，选中只需要Node.focus();
 */
function searchTreeNode(o, str, isSplit, searchName, searchValue) {
	if (isSplit == null) {
		isSplit = false;
	}
	if (searchName == null) {
		searchName = true;
	}
	if (searchValue == null) {
		searchValue = false;
	}
	var reValue = new Array();
	var nodes = o.dataSource;
	for ( var i in nodes) {
		if (isSplit) {
			var len = str.length;
			for ( var i = 0; i < len; i++) {
				var s = str.substring(i, i + 1);
				if (searchName) {
					if (nodes[i].text.indexOf(s) >= 0) {
						reValue[reValue.length] = nodes[i];
						break;
					} else {
						if (searchValue) {
							if (nodes[i].id.indexOf(s) >= 0) {
								reValue[reValue.length] = nodes[i];
								break;
							}
						}
					}
				}
			}
		} else {
			if (searchName) {
				if (i.indexOf("#") > 0) {
					var t = i.substring(i.indexOf("#")+1);
					var str1 = nodes[i].getAttribute("text")+nodes[i].getAttribute("pinyin")+nodes[i].getAttribute("pyhead");
					str1=str1.toLowerCase();
					//alert(str1);
					if (str1.indexOf(str.toLowerCase()) >= 0) {
						reValue[reValue.length] = t;
					} else {
						if (searchValue) {
							if (t.indexOf(str) >= 0) {
								reValue[reValue.length] = t;
							}
						}
					}
				}
			}else{
				if (i.indexOf("#") > 0) {
					var t = i.substring(i.indexOf("#")+1);
					if (searchValue) {
						if (t.indexOf(str) >= 0) {
							reValue[reValue.length] = t;
						}
					}
				}
			}
		}
	}
	return reValue;
}
/**
 * 加载树的值，回显使用（单值）
 * 
 * @param o
 *            树对象
 * @param value
 *            值
 */
function loadTreeValue(o,oStr, value) {
	if (value==null || value==""){
		return;
	}
	if (o.useCheckbox) {
		var vs = value.split(",");
		var isGotoNode = false;
		for(var i=0;i<vs.length;i++){
			if(vs[i]!="" && vs[i]!="null"){
				expNode(o,vs[i]);
				var s = "_checkNode(" + oStr + ",'" + vs[i] + "');";
				setTimeout(s,1);
				//o.getNodeById(vs[i]).checked=true;
				if(!isGotoNode){
					setTimeout("_gotoNode('" + vs[i] + "');",1);
					isGotoNode=true;
				}
			}
		}
	} else {
		value = value.replaceByString(",","");
		if (value=="" || value=="null"){
			return;
		}
		expNode(o,value);
		//o.focus(value);
		setTimeout(oStr + ".focus('" + value + "');",1);
		setTimeout("_gotoNode('" + value + "');",1);
	}
}
function _checkNode(oStr,id){
	//alert(oStr + "|" + id);
	oStr.getNodeById(id).check(true);
}
/**
 * 加载树的值，回显使用（多值）
 * 
 * @param o
 *            树对象
 * @param values
 *            用","分割的值，例如：001,002,003,004
 */
function loadTreeValues(o,oStr, values) {
	loadTreeValue(o,oStr, values);
}
window.System = function() {
	this.setHashCode();
};

System.debug = false; // false
System._codebase = {};
try {
	if (window != parent && parent.System && parent.System._codebase)
		System._codebase = parent.System._codebase;
	else if ("undefined" != typeof opener && opener.System
			&& opener.System._codebase)
		System._codebase = opener.System._codebase;
	else if ("undefined" != typeof dialogArguments && dialogArguments.System)
		System._codebase = dialogArguments.System._codebase;
} catch (ex) {
}

System.MISSING_ARGUMENT = "Missing argument";
System.ARGUMENT_PARSE_ERROR = "The argument cannot be parsed";
System.NOT_SUPPORTED_XMLHTTP = "Your browser do not support XMLHttp";
System.FILE_NOT_FOUND = "File not found";
System.MISCODING = "Maybe file encoding is not ANSI or UTF-8";
System.NAMESPACE_ERROR = " nonstandard namespace";

System.hashCounter = 0;
System.currentVersion = "20060811";
var t = document.getElementsByTagName("SCRIPT");
t = (System.scriptElement = t[t.length - 1]).src.replace(/\\/g, "/");
System.incorporate = function(d, s) {
	for ( var i in s)
		d[i] = s[i];
	return d;
};
System.path = (t.lastIndexOf("/") < 0) ? "." : t.substring(0, t
		.lastIndexOf("/"));
System.getUniqueId = function() {
	return "mz_" + (System.hashCounter++).toString(36);
};
System.toHashCode = function(e) {
	if ("undefined" != typeof e.hashCode)
		return e.hashCode;
	return e.hashCode = System.getUniqueId();
};
System.supportsXmlHttp = function() {
	return "object" == typeof (System._xmlHttp || (System._xmlHttp = new XMLHttpRequest()));
};
System._getPrototype = function(namespace, argu) {
	if ("undefined" == typeof System._prototypes[namespace])
		return new System();
	for ( var a = [], i = 0; i < argu.length; i++)
		a[i] = "argu[" + i + "]";
	return eval("new (System._prototypes['" + namespace + "'])(" + a.join(",")
			+ ")");
};
System.ie = navigator.userAgent.indexOf("MSIE") > 0 && !window.opera;
System.ns = navigator.vendor == "Netscape";
System._alert = function(msg) {
	if (System.debug)
		alert(msg);
};
System._parseResponseText = function(s) {
	if (null == s || "\uFFFD" == s.charAt(0)) {
		System._alert(System.MISCODING);
		return "";
	}
	if ("\xef" == s.charAt(0))
		s = s.substr(3); // for firefox
	return s.replace(/(^|\n)\s*\/\/+\s*((Using|Import|Include)\((\"|\'))/g,
			"$1$2");
};

if (window.ActiveXObject && (System.ie || !window.XMLHttpRequest)) {
	window.XMLHttpRequest = function() {
		var msxmls = [ 'MSXML3', 'MSXML2', 'Microsoft' ], ex;
		for ( var i = 0; i < msxmls.length; i++)
			try {
				return new ActiveXObject(msxmls[i] + '.XMLHTTP')
			} catch (ex) {
			}
		System._xmlHttp = "mz";
		throw new Error(System.NOT_SUPPORTED_XMLHTTP);
	}
}
System.load = function(namespace, path) {
	try {
		if (System.supportsXmlHttp()) {
			path = System._mapPath(namespace, path);
			var x = System._xmlHttp;
			x.open("GET", path, false);
			x.send(null);
			if (x.readyState == 4) {
				if (x.status == 0 || /^file\:/i.test(path))
					return System._parseResponseText(x.responseText);
				else if (x.status == 200)
					return System._parseResponseText(x.responseText);
				else if (x.status == 404)
					System._alert(namespace + "\n" + System.FILE_NOT_FOUND);
				else
					throw new Error(x.status + ": " + x.statusText);
			}
		} else
			System._alert(System.NOT_SUPPORTED_XMLHTTP);
	} catch (ex) {
		System._alert(namespace + "\n" + ex.message);
	}
	return "";
};
System._eval = function(namespace, path) {
	// alert("System._eval(\""+namespace+"\")=\r\n"+System._codebase[namespace]);
	try {
		if (window.execScript)
			window.execScript(System._codebase[namespace]);
		else {
			var script = document.createElement("SCRIPT");
			script.type = "text/javascript";
			script.innerHTML = "eval(System._codebase['" + namespace + "']);";
			document.getElementsByTagName("HEAD")[0].appendChild(script);
			setTimeout(function() {
				script.parentNode.removeChild(script)
			}, 99);
		}
	} catch (ex) {
		alert(ex);
		System._alert("Syntax error on load " + namespace);
	}
	System._existences[namespace] = System._mapPath(namespace, path);
};
System._exist = function(namespace, path) {
	if ("undefined" == typeof System._existences[namespace])
		return false;
	return System._existences[namespace] == System._mapPath(namespace, path);
};
System._mapPath = function(namespace, path) {
	if ("string" == typeof path && path.length > 3)
		return path.toLowerCase();
	var p = (System.path + "/" + namespace.replace(/\./g, "/") + ".js")
			.toLowerCase();
	return p
			+ (("undefined" == typeof path || path) ? "" : "?t="
					+ Math.random());
};

window.Using = function(namespace, path, rename) {
	if (System._exist(namespace, path)) {
		var s = window[namespace.substr(namespace.lastIndexOf(".") + 1)];
		if (s != System._prototypes[namespace])
			s = System._prototypes[namespace];
		return
	}
	var code = namespace + ".";
	if (!/((^|\.)[\w\$]+)+$/.test(namespace))
		throw new Error(namespace + System.NAMESPACE_ERROR);
	for ( var i = code.indexOf("."); i > -1; i = code.indexOf(".", i + 1)) {
		var e = code.substring(0, i), s = (e.indexOf(".") == -1) ? "window[\""
				+ e + "\"]" : e;
		if (e && "undefined" == typeof (s)) {
			eval(s + "=function(){return System._getPrototype(\"" + e
					+ "\", arguments)}");
		}
	}
	if ("undefined" == typeof path
			&& "string" == typeof System._codebase[namespace]) {
		System._eval(namespace, path);
	} else {
		if (code = System.load(namespace, path)) {
			e = "$" + System.getUniqueId() + "__id" + new Date().getTime()
					+ "$";
			s = "function " + e + "(){\r\n" + code
					+ ";\r\nSystem._prototypes['";
			code = namespace.substr(namespace.lastIndexOf(".") + 1);
			s += namespace + "']=window['" + (rename || code) + "']=" + code
					+ ";\r\n}" + e + "();";
			System._codebase[namespace] = s;
			s = "";
			System._eval(namespace, path);
		}
	}
};
window.Import = function(namespace, path, rename) {
	Using(namespace, path, rename)
};
window.Instance = function(hashCode) {
	return System._instances[hashCode]
};
window.Include = function(namespace, path) {
	if (System._exist(namespace, path))
		return;
	var code;
	if (!/((^|\.)[\w\$]+)+$/.test(namespace))
		throw new Error(namespace + System.NAMESPACE_ERROR);
	if ("undefined" == typeof path
			&& "string" == typeof (System._codebase[namespace])) {
		System._eval(namespace, path);
	} else if (System.supportsXmlHttp()) {
		if (code = System.load(namespace, path)) {
			System._codebase[namespace] = code;
			System._eval(namespace, path);
		}
	} else {
		var script = document.createElement("SCRIPT");
		script.type = "text/javascript";
		script.src = System._existences[namespace] = System._mapPath(namespace,
				path);
		document.getElementsByTagName("HEAD")[0].appendChild(script);
		setTimeout(function() {
			script.parentNode.removeChild(script)
		}, 99);
	}
};

Function.READ = 1;
Function.WRITE = 2;
Function.READ_WRITE = 3;
Function.prototype.addProperty = function(name, initValue, r_w) {
	var capital = name.charAt(0).toUpperCase() + name.substr(1);
	r_w = r_w || Function.READ_WRITE;
	name = "_" + name;
	var p = this.prototype;
	if ("undefined" != typeof initValue)
		p[name] = initValue;
	if (r_w & Function.READ)
		p["get" + capital] = function() {
			return this[name];
		};
	if (r_w & Function.WRITE)
		p["set" + capital] = function(v) {
			this[name] = v;
		};
};
Function.prototype.Extends = function(SuperClass, ClassName) {
	var op = this.prototype, i, p = this.prototype = new SuperClass();
	if (ClassName)
		p._className = ClassName;
	for (i in op)
		p[i] = op[i];
	if (p.hashCode)
		delete System._instances[p.hashCode];
	return p;
};
System._instances = {};
System._prototypes = {
	"System" : System,
	"System.Object" : System,
	"System.Event" : System.Event
};
System._existences = {
	"System" : System._mapPath("System"),
	"System.Event" : System._mapPath("System.Event"),
	"System.Object" : System._mapPath("System.Object")
};
t = System.Extends(Object, "System");
System.Object = System;
t.decontrol = function() {
	var t;
	if (t = this.hashCode)
		delete System._instances[t]
};
t.addEventListeners = function(type, handle) {
	if ("function" != typeof handle)
		throw new Error(this + " addEventListener: " + handle
				+ " is not a function");
	if (!this._listeners)
		this._listeners = {};
	var id = System.toHashCode(handle), t = this._listeners;
	if ("object" != typeof t[type])
		t[type] = {};
	t[type][id] = handle;
};
t.removeEventListener = function(type, handle) {
	if (!this._listeners)
		this._listeners = {};
	var t = this._listeners;
	if (!t[type])
		return;
	var id = System.toHashCode(handle);
	if (t[type][id])
		delete t[type][id];
	if (t[type])
		delete t[type];
};
t.dispatchEvent = function(evt) {
	if (!this._listeners)
		this._listeners = {};
	var i, t = this._listeners, p = evt.type;
	evt.target = evt.srcElement = this;
	if (this[p])
		this[p](evt);
	if ("object" == typeof t[p])
		for (i in t[p])
			t[p][i].call(this, evt);
	delete evt.target;
	delete evt.srcElement;
	return evt.returnValue;
};
t.setHashCode = function() {
	System._instances[(this.hashCode = System.getUniqueId())] = this;
};
t.getHashCode = function() {
	if (!this.hashCode)
		this.setHashCode();
	return this.hashCode;
};
t.toString = function() {
	return "[object " + (this._className || "Object") + "]";
};
System.Event = function(type) {
	this.type = type;
};
t = System.Event.Extends(System, "System.Event");
t.returnValue = true;
t.cancelBubble = false;
t.target = t.srcElement = null;
t.stopPropagation = function() {
	this.cancelBubble = true;
};
t.preventDefault = function() {
	this.returnValue = false;
};

if (System.ie && !System.debug)
	Include("System.Plugins.IE"); // IE UserData
if (window.opera)
	Include("System.Plugins.Opera"); // Opera support
Include("System.Global");