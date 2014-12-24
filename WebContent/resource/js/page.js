var contextPathRoot=path;

var pathRoot=contextPathRoot;

//必填项变色
var nullcolor = "#FFFFFF";
//一维数组的排序
// type 参数
// 0 字母顺序（默认）
// 1 大小 比较适合数字数组排序
// 2 拼音 适合中文数组
// 3 乱序 有些时候要故意打乱顺序，呵呵
// 4 带搜索 str 为要搜索的字符串 匹配的元素排在前面

//Array.prototype.SortBy(type,str){
//	switch (type)
//	{
//		case "0":
//			this.sort();
//			break;
//		case "1":
//			this.sort(function(a,b){ return a-b; });
//			break;
//		case "2":
//			this.sort(function(a,b){ return a.localeCompare(b) });
//			break;
//		case "3":
//			this.sort(function(){ return Math.random()>0.5?-1:1; });
//			break;
//		case "4":
//			this.sort(function(a,b){ return a.indexOf(str)==-1?1:-1; });
//			break;
//		case "5":
//			this.sort(function(a,b){ return a-b; });
//			break;
//		default:
//			this.sort();
//	};
//}
function _inputMouseFocus(obj,newColor){
	//var tmpColor = obj.style.backgroundColor;
	//if (tmpColor==null || tmpColor==""){
	//	tmpColor="#FFFFFF";
	//}
	//obj.setAttribute("tmpColor",tmpColor);
	if (newColor == null){
		//obj.style.backgroundColor = "#FFFF99";
		obj.style.backgroundColor = "#FEFFF0";
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
		tmpColor ="#FFFFFF";
	}
	if (newColor == null){
		obj.style.backgroundColor = tmpColor;
	}else{
		obj.style.backgroundColor = newColor;
	}
}
function loadInputStyle(){
	var el = document.getElementsByTagName("input");
	for (var i=0;i<el.length;i++){
		var e = el[i];
		if (e.type=="text"){
			setInputObj(e);
		}else if (e.type=="password"){
			setInputObj(e);
		}
	}
	var el1 = document.getElementsByTagName("textarea");
	for (var i=0;i<el1.length;i++){
		var e = el1[i];
		e.className="txt_textarea";
		setInputObj(e);
	}
	var el2 = document.getElementsByTagName("select");
	for (var i=0;i<el2.length;i++){
		var e = el2[i];
		setSelectObj(e);
	}
}
function setSelectObj(e){
	if (e.getAttribute("notnull")!=null){
		e.setAttribute("temColor",nullcolor);
		e.style.backgroundColor = nullcolor;
	}
	var onclickStr = e.getAttribute("onclick");
	if (onclickStr==null){
		e.onclick=function(){
			//try{
//				_check_one(this);
			//}catch(e){

			//}
		};
	}
}
function setInputObj(e){
	if (e.getAttribute("notnull")!=null){
		e.setAttribute("temColor",nullcolor);
		e.style.backgroundColor = nullcolor;
		var t = e.title;
		if (t.indexOf("")==-1){
			if (t==null || t==""){
				t="[必填项]";
			}else{
				t="[必填项]\n" + t;
			}
		}
		e.title=t;
	}

	var onclickStr = e.getAttribute("onclick");
	var onkeyup = e.getAttribute("onkeyup");
	if (e.readOnly && onclickStr==null){
		//e.style.backgroundColor = "#E0DFD1";
	}else{
		e.onblur = function(){
			_inputMouseBlur(this);
			hide(true);
		};
		e.onfocus = function(){
			_inputMouseFocus(this);
			this.select();
			var msg = this.getAttribute("message");
			if (msg!=null){
				showMsg(this,msg);
			}
		};
		e.onmouseover=function(){
			_inputMouseOver(this);
		};
		e.onmouseout =function(){
			_inputMouseOut(this);
		};
		if (onkeyup==null || onkeyup==""){
			e.onkeyup=function(){
				try{
					_check_one(this);
				}catch(e){
				}
			};
		}
		if (onclickStr==null){
			e.onclick=function(){
				//this.value="";
			};
		}
	}
}
/**
 * 弹出模式窗体
 * @param url 地址
 * @param obj 参数
 * @param dialogWidth IE7宽度
 * @param dialogHeight IE7高度
 * @return 返回结果
 */
function modalDialog(url,obj,dialogWidth,dialogHeight){
	dialogWidth=ieX(dialogWidth);
	dialogHeight=ieY(dialogHeight);
	var p = url.indexOf("?");
	var vp = "?";
	if (p>0){
		vp = "&";
	}
	url = url + vp + "nowtimelong=" + (new Date()).getTime();
	return window.showModalDialog(url,obj,"dialogWidth:" + dialogWidth + "px; dialogHeight:" + dialogHeight + "px; help:no; status:0"+";location:no;");
}
/**
 * 弹出模式窗体
 * @param url 地址
 * @param obj 参数
 * @param dialogWidth IE7宽度
 * @param dialogHeight IE7高度
 * @return 返回结果
 */
function modalessDialog(url,obj,dialogWidth,dialogHeight){
	dialogWidth=ieX(dialogWidth);
	dialogHeight=ieY(dialogHeight);
	var p = url.indexOf("?");
	var vp = "?";
	if (p>0){
		vp = "&";
	}
	url = url + vp + "nowtimelong=" + (new Date()).getTime();
	return window.showModelessDialog(url,obj,"dialogWidth:" + dialogWidth + "px; dialogHeight:" + dialogHeight + "px; help:no; status:0");
}
function modelessDialog(url,obj,dialogWidth,dialogHeight){
	return modalessDialog(url,obj,dialogWidth,dialogHeight);
}
/*
alwaysLowered | yes/no | 指定窗口隐藏在所有窗口之后
alwaysRaised | yes/no | 指定窗口悬浮在所有窗口之上
depended | yes/no | 是否和父窗口同时关闭
directories | yes/no | Nav2和3的目录栏是否可见
height | pixel value | 窗口高度
hotkeys | yes/no | 在没菜单栏的窗口中设安全退出热键
innerHeight | pixel value | 窗口中文档的像素高度
innerWidth | pixel value | 窗口中文档的像素宽度
location | yes/no | 位置栏是否可见
menubar | yes/no | 菜单栏是否可见
outerHeight | pixel value | 设定窗口(包括装饰边框)的像素高度
outerWidth | pixel value | 设定窗口(包括装饰边框)的像素宽度
resizable | yes/no | 窗口大小是否可调整
screenX | pixel value | 窗口距屏幕左边界的像素长度
screenY | pixel value | 窗口距屏幕上边界的像素长度
scrollbars | yes/no | 窗口是否可有滚动栏
titlebar | yes/no | 窗口题目栏是否可见
toolbar | yes/no | 窗口工具栏是否可见
Width | pixel value | 窗口的像素宽度
z-look | yes/no | 窗口被激活后是否浮在其它窗口之上
*/
function _open(url,name,iWidth,iHeight,iLeft,iTop){
	var url;                                 //转向网页的地址;
	var name;                           //网页名称，可为空;
	iWidth = ieX(iWidth);                          //弹出窗口的宽度;
	iHeight = ieY(iHeight);                     //弹出窗口的高度;
	if (iTop==null)
	iTop = (window.screen.availHeight-30-iHeight)/2;       //获得窗口的垂直位置;
	if (iLeft==null)
	iLeft = (window.screen.availWidth-10-iWidth)/2;           //获得窗口的水平位置;
	//window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
	window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

/**
 * 全选/不选
 * @param obj 选择的checkbox框,一般为this
 * @param name 单选和复选框的名称（name）
 */
function changeSelect(obj,name) {
	var checkValue = false;
	if (obj.checked){
		checkValue = true;
	}
	var selElements = document.getElementsByName(name);
	for (var i = 0; i < selElements.length; i++) {
		if (selElements[i].tagName.toLowerCase() == "input") {
			if (selElements[i].type.toLowerCase() == "checkbox" || selElements[i].type.toLowerCase() == "radio") {
				if (selElements[i].disabled || selElements[i].readOnly){
					selElements[i].checked =false;
				}else{
					selElements[i].checked = checkValue;
				}
			}
		}
	}
	return false;
}
/**
 * 列表的
 * @param obj 选择的checkbox框,一般为this
 * @param name 单选和复选框的名称（name）
 */
function fieldsCheck(obj,name) {
	var checkValue = false;
	if (obj.checked){
		checkValue = true;
	}
	var selElements = document.getElementsByName(name);
	for (var i = 0; i < selElements.length; i++) {
		if (selElements[i].tagName.toLowerCase() == "input") {
			if (selElements[i].type.toLowerCase() == "checkbox" || selElements[i].type.toLowerCase() == "radio") {
				if (selElements[i].disabled || selElements[i].readOnly){
					selElements[i].checked =false;
				}else{
					selElements[i].checked = checkValue;
				}
				selElements[i].onclick();
			}
		}
	}
	return false;
}
/**
 * 得到IE的版本
 */
function getIEVersonNumber(){
		var ua = navigator.userAgent;
		var msieOffset = ua.indexOf("MSIE ");
		if(msieOffset < 0)
		{
				return 0;
		}
		return parseFloat(ua.substring(msieOffset + 5, ua.indexOf(";", msieOffset)));
}
var ieVer = getIEVersonNumber();
/**
 * 处理弹出窗口的宽度
 * @param n IE7宽度
 * @return 返回当前浏览器版本所需要的宽度
 */
function ieX(n){
	/**if (ieVer<7){
		n = n+10
	}
	if (n<0){
		n=0;
	}**/
	return n;
}
/**
 * 处理弹出窗口的高度
 * @param n IE7高度
 * @return 返回当前浏览器版本所需要的高度
 */
function ieY(n){
	/**if (ieVer<7){
		n = n+10
	}
	if (n<0){
		n=0;
	}**/
	return n;
}
//以下为索引使用的js -=开始=-
/**
 * 索引选择方法
 * @param oList 列表对象
 * @param inputTxt 索引input的对象
 */
function IndexListOnChange1(oList,inputTxt) {
	var iSelect = oList.selectedIndex;
	var text = oList.item(iSelect).text;
	text = escape(text);
	text = text.replace(/^(%A0)+/g, "");
	text = unescape(text);
	text = text.replace(/^\s+/g, "");
	inputTxt.value = text;
	oList.focus();
}
/**
 * 索引input键盘抬起时处理事件
 * @param oList 列表对象
 * @param inputTxt 索引input的对象
 */
function IndexEntryOnKeyUp1(oList,inputTxt) {
	var ListLen = oList.length;
	var iCurSel = oList.selectedIndex;
	var text = inputTxt.value.toUpperCase();
	var TextLen = text.length;
	for (var i = 0; i < ListLen; i++) {
		var listitem = oList.item(i).text.substr(0, TextLen).toUpperCase();
		if (listitem == text) {
			if (i != iCurSel) oList.selectedIndex = i;
			break;
		}
	}
	return(true);
}
/**
 * 索引input键盘按下时处理事件
 * @param oList 列表对象
 * @param inputTxt 索引input的对象
 */
function KeyDownEvent1(oList,inputTxt) {
	if ((event.which && event.which==39) || (event.keyCode && event.keyCode==39) || (event.which && event.which==40) || (event.keyCode && event.keyCode==40)) {
		oList.focus();
	}
	if ((event.which && event.which==13) || (event.keyCode && event.keyCode==13)) {
		IndexListOnChange1(oList,inputTxt);
		return(false);
	} else{
		return(true);
	}
}
/**
 * 列表中设置索引文本
 * @param oList 列表对象
 * @param inputTxt 索引input的对象
 */
function setText1(oList,inputTxt){
	var selIndex = 0;
	if (oList.selectedIndex>0){
		selIndex = oList.selectedIndex;
	}
	inputTxt.value = oList.options[selIndex].text;
}
/**
 * 列表中键盘移动处理
 * @param inputTxt 索引input的对象
 */
function moveFocus(inputTxt){
	if ((event.which && event.which==37) || (event.keyCode && event.keyCode==37)) {
		inputTxt.focus();
	}
}
//以上为索引使用的js -=结束=-
/**
 * 弹出选择树
 */

function openCode_tree(codeSortId,base,type,title,showObj,vName,all,whereSql,isParent,pId,likeId){

	var pS = "";
	if (pId!=null && likeId !=null){
		pS = "&likeId=" + likeId + "&parentId=" + pId;
	}

	pS+="&all=" + all + "&isParent=" + isParent;
	var ltime = new Date().getTime();
		var style = "status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;statusbar:no;dialogWidth:385px;dialogHeight:580px";
	var url = "/" + pathRoot + "/codeTree.do?method=tree&whereSql=" + encodeURI(whereSql) + "&codeSortId=" + codeSortId + "&type=" + type + "&title=" + encodeURI(title) + "&base=" + base + "&value=" + document.getElementsByName(vName)[0].value + "&time=" + ltime + pS;
	_S_("选择信息中...");
	var rValue = showModalDialog(url,showObj.value,style);
	_H_();
	if (rValue!=null){
		if (type=="0" || type=="4"){
			showObj.value = rValue["name"];
			var els = document.getElementsByName(showObj.name);
			var i=0;
			for(;i<els.length;i++){
				if (showObj==els[i]){
					break;
				}
			}
			document.getElementsByName(vName)[i].value = rValue["value"];
		}else{
			var m = rValue.length;
			var showValue="";
			var showName="";
			for(var i=0;i<m;i++){
				if (i>0){
					showValue +=",";
					showName +=";";
				}
					showValue +=rValue[i]["value"];
					showName +=rValue[i]["name"];
			}
			showObj.value = showName;
			var els = document.getElementsByName(showObj.name);
			var i=0;
			for(;i<els.length;i++){
				if (showObj==els[i]){
					break;
				}
			}
			document.getElementsByName(vName)[i].value=showValue;
			showObj.title= showName;
		}
	}
	//window.open(url);
}
function openPdtCode_tree(type,title,showObj,vName,isParent,pId,likeId){
	var pS = "";
	if (pId!=null && likeId !=null){
		pS = "&likeId=" + likeId + "&parentId=" + pId;
	}
	pS+="&isParent=" + isParent;
	var ltime = new Date().getTime();
		var style = "status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;statusbar:no;dialogWidth:385px;dialogHeight:580px";
	var url = "/" + pathRoot + "/pdtTree.do?method=tree&type=" + type + "&title=" + encodeURI(title) + "&value=" + document.getElementsByName(vName)[0].value + "&time=" + ltime + pS;
	_S_("选择产品中...");
	var rValue = showModalDialog(url,showObj.value,style);
	_H_();
	if (rValue!=null){
		if (type=="0" || type=="4"){
			showObj.value = rValue["name"];
			var els = document.getElementsByName(showObj.name);
			var i=0;
			for(;i<els.length;i++){
				if (showObj==els[i]){
					break;
				}
			}
			document.getElementsByName(vName)[i].value = rValue["value"];
		}else{
			var m = rValue.length;
			var showValue="";
			var showName="";
			for(var i=0;i<m;i++){
				if (i>0){
					showValue +=",";
					showName +=";";
				}
					showValue +=rValue[i]["value"];
					showName +=rValue[i]["name"];
			}
			showObj.value = showName;
			showObj.title= showName;
			var els = document.getElementsByName(showObj.name);
			var i=0;
			for(;i<els.length;i++){
				if (showObj==els[i]){
					break;
				}
			}
			document.getElementsByName(vName)[i].value=showValue;
		}
	}
}
/*********************************DataMsg*****************************************/
/**
 * DataMsg对象
 */
function DataMsg(){
	this.array = new Array();
	//当前页
	this.page=0;
	//每页多少条数据
	this.pageSize = 0;
	//一共多少条数据
	this.pageTotal = 0;
	//一共多少页
	this.pageNum = 1;
	this.addData=function(data){
		this.array[this.array.length]=data;
	};
	/**
	 * 得到一个Data
	 * @param i 索引
	 */
	this.getData=function(i){
		return this.array[i];
	};
	/**
	 * 得到当前页
	 */
	this.getPage=function(){
		return this.page;
	};
	/**
	 * 设置当前页
	 * @param page 当前页
	 */
	this.setPage=function(page){
		this.page=page;
	};
	/**
	 * 得到每页多少条数据
	 */
	this.getPageSize=function(){
		return this.pageSize;
	};
	/**
	 * 设置每页多少条数据
	 * @param pageSize 每页的数据
	 */
	this.setPageSize=function(pageSize){
		this.pageSize=pageSize;
	};
	/**
	 * 得到总数据
	 */
	this.getPageTotal=function(){
		return this.pageTotal;
	};
	/**
	 * 设置总数据
	 * @param pageTotal 总数据
	 */
	this.setPageTotal=function(pageTotal){
		this.pageTotal=pageTotal;
	};
	/**
	 * 得到页面一共多少页
	 */
	this.getPageNum=function(){
		return this.pageNum;
	};
	/**
	 * 设置一共多少页
	 * @param pageNum 总页数
	 */
	this.setPageNum=function(pageNum){
		this.pageNum = pageNum;
	};
	this.size=function(){
		return this.array.length;
	};
	this.toString = function(){
		var s="{";
		var size = this.size();
		for(var i=0;i<size;i++){
			var data = this.getData(i);
			if (i>0){
				s+=",";
			}
			s+=data.toString();
		}
		return (s + "}");
	};
}
/**
 * Data对象
 */
function Data(){
	this.array = new Array();
	this.setData = function(array1){
		this.array = array1;
	};
	this.getString=function(key,defaultValue){
		var value = this.array[key];
		if (value==null){
			return defaultValue;
		}else{
			return value;
		}
	};
	this.getDate=function(key){
		var value = this.array[key];
		if (value==null){
			return "";
		}else{
			try{
				return value.substring(0,d.indexOf(" "));
			}catch(e){
				return value;
			}
		}
	};
	this.getDateTime=function(key){
		var value = this.array[key];
		if (value==null){
			return "";
		}else{
			return value;
		}
	};
	this.add=function(key,value){
		this.array[key]=value;
	};
	this.getKey=function(index){
		var i=0;
		for(var o in this.array){
			if (i==index){
				return o;
			}
			i++;
		}
	};
	this.size=function(){
		var i=0;
		for(var o in this.array){
			i++;
		}
		return i;
	};
	this.toString = function(){
		var s="[";
		var size = this.size();
		for(var i=0;i<size;i++){
			if (i>0){
				s+=",";
			}
			var key = this.getKey(i);
			s+=this.getKey(i) + "=" + this.getString(key);
		}
		return (s + "]");
	};
}
function keyReturn(){
	alert(event.keyCode);
	if ((event.which && event.which==39) || (event.keyCode && event.keyCode==39) || (event.which && event.which==40) || (event.keyCode && event.keyCode==40)) {

	}
}
	function getHostUrl(){
		return "http://" + document.location.host;
	}

	//清除内容
function clearValue(obj,obj1){
	document.getElementsByName(obj)[0].value="";
	document.getElementsByName(obj1)[0].value="";
}
/**
 * @author 龙翔
 * @description
 * 根据用户传入的表单域前缀，将页面内所有匹配的域的值保存进数组并返回。
 * @param formName 表单的名称(大小写敏感)
 * @param prefix 域前缀
 * @param defaultFormData 需要被叠加的数据的formData,用于多种prefix过滤条件的判断
 */
function _loadFormData(formName, prefix, defaultFormData) {
	var form;
	for (i=0; i<document.forms.length; i++) {
		if (document.forms[i].name == formName) {
			form = document.forms[i];
		}
	}
	if (!form) {
		alert("_loadFormData()调用失败，没有找到formName对应的form");
		return;
	}

	var formData = {};
	if (defaultFormData) {
		/*
		 * 如果有defaultFormData，那么将defaultFormData属性都拷贝到formData内
		 */
		_apply(formData, defaultFormData);
	}

	var elements = form.elements;
	for (j=0; j<elements.length; j++) {
		if (elements[j].getAttribute("name").startsWith(prefix)) {
			/*
			 * 找到匹配的控件，将控件的值加入formData
			 */
			var key = elements[j].getAttribute("name");
			if (elements[j].getAttribute("type") == "radio" || elements[j].getAttribute("type") == "checkbox") {
				if (elements[j].checked) {
					if (!formData[key]) {
						formData[key] = [elements[j].value];
					} else {
						var tempArray = formData[key];
						tempArray[tempArray.length] = elements[j].value;
						formData[key] = tempArray;
					}
				}
			} else {
				var obj = eval("document."+formName+"."+key);
				if(obj.length==undefined || obj.tagName=="SELECT"){
					formData[key] = obj.value;
				} else {
					var arr = new Array();
					for(k=0; k<obj.length; k++){
						arr[k] = obj[k].value;
					}
					formData[key]=arr;
				}
			}
		}
	}
	return formData;
}
/**
 * @author 龙翔
 * @description
 * 将config里面所有的属性拷贝到object内。
 * @param o {object}object 属性的接收者
 * @param c {object}config 属性的来源
 */
function _apply(o, c) {
	if(o && c && typeof c == 'object'){
				for(var p in c){
						o[p] = c[p];
				}
		}
		return o;
}
/**
 * @author 龙翔
 * @description
 * 比较两个数组是不是相同。
 * 暂时还不对array里面的array，object和function进行比较。如果有这些子集的存在，将默认两个array不相同。
 * 即只能对一维数组，且数组内元素为最基础类型。
 * @param arr1
 * @param arr2
 */
function _compareArray(arr1, arr2) {
	if (_isArray(arr1) && _isArray(arr2)) {
		if (arr1.length == arr2.length) {
			for (i=0; i<arr1.length; i++) {
				if (arr1[i] != arr2[i]) {
					return false;
				}
			}
		} else {
			return false;
		}
	} else {
		return false;
	}
	return true;
}
/**
 * @author 龙翔
 * @description
 * 判断传入的参数是否为数组
 * @param v Object
 */
function _isArray(v){
	return v && typeof v.pop == 'function';
}
/**
 * @author 龙翔
 * @description
 * 判断两个object对象是不是完全一样，当两个object内的所有的property和array都相同的时候就为是同一object.将忽略里面的function.
 * @param o1
 * @param o2
 */
function _compareObject(o1, o2) {
	if (o1 && o2) {
		for (var p in o1) {
			if (typeof o1[p] == "function") {
				/*
				 * 忽略function
				 */
				continue;
			}
			if (_isArray(o1[p])) {
				if (!_compareArray(o1[p], o2[p])) {
					return false;
				}
			} else {
				if (o1[p] != o2[p]) {
					return false;
				}
			}
		}
	} else {
		return false;
	}
	return true;
}
/**
 * 清除数据
 * @param id0
 * @param id
 * @returns
 */
function _clearHelperValue(id0,id){
	var obj= document.getElementById(id0);
	var _v = document.getElementById(id);
	obj.value="";
	obj.title="";
	_v.value="";
}
/**
 * 显示助手
 * @param obj 要显示内容的对象
 * @param id 要存储值的id
 * @param title 助手的标题
 * @param code 代码 详见helperCode.properties
 * @param showParent 是否显示全内容
 * @param params 扩展参数
 * @param type 树的类型 0-单选，1-多选
 * @param sync 树的加载形式 true-一次性加载，false-异步加载
 */
function _showHelper(id0,id,title,code,showParent,params,type,sync){
	var obj = document.getElementById(id0);
	var _v = document.getElementById(id);
	var values = _v.value;

	//var url = path + "helper/tree?";
	var url = path + "treeServlet?";//显示助手的入口改为treeServlet by 马志慧 at 20121207
	if("true"!=showParent){
		showParent="false";
	}
	var selValues = new Array();
		selValues[0]=values;
	var p = "code=" + code + "&value=" +values+ "&title=" + title + "&parent=" + showParent + "&param=" + params + "&type=" + type + "&sync=" + sync;
	var reValue = modalDialog(url + p, selValues, 450, 500);
//	var reValue = _open(url + p, "aaa", 450, 400);

	if (reValue!=null){
		if(type=="0" || type=="-1"){
			obj.value=reValue["name"];
			if(reValue["name"]!=""){

				obj.title="双击此处清除选择内容：" + reValue["name"];
			}else{
				obj.title=reValue["name"];
			}
			_v.value=reValue["value"];
		}else{
			var n="";
			var v="";
			var len = reValue.length;
			for(var i=0;i<len;i++){
				if(n!=""){
					n+=",";
					v+=",";
				}
				n+=reValue[i]["name"];
				v+=reValue[i]["value"];
			}
			obj.value=n;
			if(n!=""){
				obj.title="双击此处清除选择内容：" + n;
			}else{
				obj.title=n;
			}
			_v.value=v;
		}
	}
	try {
		_selectTree(id0,id,title,code,showParent,params,type);
	} catch (e) {
		// TODO: handle exception
	}
}
/***************jsCode**********************/
/**
 * 得到指定的代码值的名称
 * @param codeSort
 * @param name
 * @returns
 */
function _getCodeName(codeSort,value){
	if(jsCodeList!=null){
		var codes = jsCodeList[codeSort];
		if (codes!=null){
			var c = codes[value];
			if (c!=null){
				return c;
			}else{
				return "";
			}
		}else{
			return "";
		}
	}else{
		return "";
	}
}

function _moveImg(o,className){
	o.className=className;
}

//对Date的扩展，将 Date 转化为指定格式的String
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
//例子：
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
Date.prototype.Format = function(fmt) { //author: meizz
var o = {
	"M+": this.getMonth() + 1,
	//月份
	"d+": this.getDate(),
	//日
	"h+": this.getHours(),
	//小时
	"m+": this.getMinutes(),
	//分
	"s+": this.getSeconds(),
	//秒
	"q+": Math.floor((this.getMonth() + 3) / 3),
	//季度
	"S": this.getMilliseconds() //毫秒
};
if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
for (var k in o) if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
return fmt;
};

function formatDate(datestring){
	var ds = datestring.split("-");
	return (new Date(ds[0],(parseInt(ds[1],10)-1),ds[2])).Format("yyyy年MM月dd日");
}

function isEnter(){
	if ((window.event.which && window.event.which==13) || (window.event.keyCode && window.event.keyCode==13)) {
		return true;
	}else{
		return false;
	}
}
function _selectAll(o,name){
	var checks = document.getElementsByName(name);
	for(var i=0;i<checks.length;i++){
		checks[i].checked=o.checked;
	}
}

function killerrors() {
	return true;
}
//window.onerror = killerrors;

function radioLabelClick(o){
	//var radio = o.parentNode.getElementsByTagName("INPUT")[0];
	//alert(radio.outerHTML);
	//if (radio.checked){
	//	radio.checked=false;
	//}else{
	//	radio.checked=true;
	//}
}
