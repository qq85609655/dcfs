var contextPathRoot=path;

var pathRoot=contextPathRoot;

//�������ɫ
var nullcolor = "#FFFFFF";
//һά���������
// type ����
// 0 ��ĸ˳��Ĭ�ϣ�
// 1 ��С �Ƚ��ʺ�������������
// 2 ƴ�� �ʺ���������
// 3 ���� ��Щʱ��Ҫ�������˳�򣬺Ǻ�
// 4 ������ str ΪҪ�������ַ��� ƥ���Ԫ������ǰ��

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
				t="[������]";
			}else{
				t="[������]\n" + t;
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
 * ����ģʽ����
 * @param url ��ַ
 * @param obj ����
 * @param dialogWidth IE7���
 * @param dialogHeight IE7�߶�
 * @return ���ؽ��
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
 * ����ģʽ����
 * @param url ��ַ
 * @param obj ����
 * @param dialogWidth IE7���
 * @param dialogHeight IE7�߶�
 * @return ���ؽ��
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
alwaysLowered | yes/no | ָ���������������д���֮��
alwaysRaised | yes/no | ָ���������������д���֮��
depended | yes/no | �Ƿ�͸�����ͬʱ�ر�
directories | yes/no | Nav2��3��Ŀ¼���Ƿ�ɼ�
height | pixel value | ���ڸ߶�
hotkeys | yes/no | ��û�˵����Ĵ������谲ȫ�˳��ȼ�
innerHeight | pixel value | �������ĵ������ظ߶�
innerWidth | pixel value | �������ĵ������ؿ��
location | yes/no | λ�����Ƿ�ɼ�
menubar | yes/no | �˵����Ƿ�ɼ�
outerHeight | pixel value | �趨����(����װ�α߿�)�����ظ߶�
outerWidth | pixel value | �趨����(����װ�α߿�)�����ؿ��
resizable | yes/no | ���ڴ�С�Ƿ�ɵ���
screenX | pixel value | ���ھ���Ļ��߽�����س���
screenY | pixel value | ���ھ���Ļ�ϱ߽�����س���
scrollbars | yes/no | �����Ƿ���й�����
titlebar | yes/no | ������Ŀ���Ƿ�ɼ�
toolbar | yes/no | ���ڹ������Ƿ�ɼ�
Width | pixel value | ���ڵ����ؿ��
z-look | yes/no | ���ڱ�������Ƿ�����������֮��
*/
function _open(url,name,iWidth,iHeight,iLeft,iTop){
	var url;                                 //ת����ҳ�ĵ�ַ;
	var name;                           //��ҳ���ƣ���Ϊ��;
	iWidth = ieX(iWidth);                          //�������ڵĿ��;
	iHeight = ieY(iHeight);                     //�������ڵĸ߶�;
	if (iTop==null)
	iTop = (window.screen.availHeight-30-iHeight)/2;       //��ô��ڵĴ�ֱλ��;
	if (iLeft==null)
	iLeft = (window.screen.availWidth-10-iWidth)/2;           //��ô��ڵ�ˮƽλ��;
	//window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
	window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

/**
 * ȫѡ/��ѡ
 * @param obj ѡ���checkbox��,һ��Ϊthis
 * @param name ��ѡ�͸�ѡ������ƣ�name��
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
 * �б��
 * @param obj ѡ���checkbox��,һ��Ϊthis
 * @param name ��ѡ�͸�ѡ������ƣ�name��
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
 * �õ�IE�İ汾
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
 * ���������ڵĿ��
 * @param n IE7���
 * @return ���ص�ǰ������汾����Ҫ�Ŀ��
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
 * ���������ڵĸ߶�
 * @param n IE7�߶�
 * @return ���ص�ǰ������汾����Ҫ�ĸ߶�
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
//����Ϊ����ʹ�õ�js -=��ʼ=-
/**
 * ����ѡ�񷽷�
 * @param oList �б����
 * @param inputTxt ����input�Ķ���
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
 * ����input����̧��ʱ�����¼�
 * @param oList �б����
 * @param inputTxt ����input�Ķ���
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
 * ����input���̰���ʱ�����¼�
 * @param oList �б����
 * @param inputTxt ����input�Ķ���
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
 * �б������������ı�
 * @param oList �б����
 * @param inputTxt ����input�Ķ���
 */
function setText1(oList,inputTxt){
	var selIndex = 0;
	if (oList.selectedIndex>0){
		selIndex = oList.selectedIndex;
	}
	inputTxt.value = oList.options[selIndex].text;
}
/**
 * �б��м����ƶ�����
 * @param inputTxt ����input�Ķ���
 */
function moveFocus(inputTxt){
	if ((event.which && event.which==37) || (event.keyCode && event.keyCode==37)) {
		inputTxt.focus();
	}
}
//����Ϊ����ʹ�õ�js -=����=-
/**
 * ����ѡ����
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
	_S_("ѡ����Ϣ��...");
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
	_S_("ѡ���Ʒ��...");
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
 * DataMsg����
 */
function DataMsg(){
	this.array = new Array();
	//��ǰҳ
	this.page=0;
	//ÿҳ����������
	this.pageSize = 0;
	//һ������������
	this.pageTotal = 0;
	//һ������ҳ
	this.pageNum = 1;
	this.addData=function(data){
		this.array[this.array.length]=data;
	};
	/**
	 * �õ�һ��Data
	 * @param i ����
	 */
	this.getData=function(i){
		return this.array[i];
	};
	/**
	 * �õ���ǰҳ
	 */
	this.getPage=function(){
		return this.page;
	};
	/**
	 * ���õ�ǰҳ
	 * @param page ��ǰҳ
	 */
	this.setPage=function(page){
		this.page=page;
	};
	/**
	 * �õ�ÿҳ����������
	 */
	this.getPageSize=function(){
		return this.pageSize;
	};
	/**
	 * ����ÿҳ����������
	 * @param pageSize ÿҳ������
	 */
	this.setPageSize=function(pageSize){
		this.pageSize=pageSize;
	};
	/**
	 * �õ�������
	 */
	this.getPageTotal=function(){
		return this.pageTotal;
	};
	/**
	 * ����������
	 * @param pageTotal ������
	 */
	this.setPageTotal=function(pageTotal){
		this.pageTotal=pageTotal;
	};
	/**
	 * �õ�ҳ��һ������ҳ
	 */
	this.getPageNum=function(){
		return this.pageNum;
	};
	/**
	 * ����һ������ҳ
	 * @param pageNum ��ҳ��
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
 * Data����
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

	//�������
function clearValue(obj,obj1){
	document.getElementsByName(obj)[0].value="";
	document.getElementsByName(obj1)[0].value="";
}
/**
 * @author ����
 * @description
 * �����û�����ı���ǰ׺����ҳ��������ƥ������ֵ��������鲢���ء�
 * @param formName ��������(��Сд����)
 * @param prefix ��ǰ׺
 * @param defaultFormData ��Ҫ�����ӵ����ݵ�formData,���ڶ���prefix�����������ж�
 */
function _loadFormData(formName, prefix, defaultFormData) {
	var form;
	for (i=0; i<document.forms.length; i++) {
		if (document.forms[i].name == formName) {
			form = document.forms[i];
		}
	}
	if (!form) {
		alert("_loadFormData()����ʧ�ܣ�û���ҵ�formName��Ӧ��form");
		return;
	}

	var formData = {};
	if (defaultFormData) {
		/*
		 * �����defaultFormData����ô��defaultFormData���Զ�������formData��
		 */
		_apply(formData, defaultFormData);
	}

	var elements = form.elements;
	for (j=0; j<elements.length; j++) {
		if (elements[j].getAttribute("name").startsWith(prefix)) {
			/*
			 * �ҵ�ƥ��Ŀؼ������ؼ���ֵ����formData
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
 * @author ����
 * @description
 * ��config�������е����Կ�����object�ڡ�
 * @param o {object}object ���ԵĽ�����
 * @param c {object}config ���Ե���Դ
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
 * @author ����
 * @description
 * �Ƚ����������ǲ�����ͬ��
 * ��ʱ������array�����array��object��function���бȽϡ��������Щ�Ӽ��Ĵ��ڣ���Ĭ������array����ͬ��
 * ��ֻ�ܶ�һά���飬��������Ԫ��Ϊ��������͡�
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
 * @author ����
 * @description
 * �жϴ���Ĳ����Ƿ�Ϊ����
 * @param v Object
 */
function _isArray(v){
	return v && typeof v.pop == 'function';
}
/**
 * @author ����
 * @description
 * �ж�����object�����ǲ�����ȫһ����������object�ڵ����е�property��array����ͬ��ʱ���Ϊ��ͬһobject.�����������function.
 * @param o1
 * @param o2
 */
function _compareObject(o1, o2) {
	if (o1 && o2) {
		for (var p in o1) {
			if (typeof o1[p] == "function") {
				/*
				 * ����function
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
 * �������
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
 * ��ʾ����
 * @param obj Ҫ��ʾ���ݵĶ���
 * @param id Ҫ�洢ֵ��id
 * @param title ���ֵı���
 * @param code ���� ���helperCode.properties
 * @param showParent �Ƿ���ʾȫ����
 * @param params ��չ����
 * @param type �������� 0-��ѡ��1-��ѡ
 * @param sync ���ļ�����ʽ true-һ���Լ��أ�false-�첽����
 */
function _showHelper(id0,id,title,code,showParent,params,type,sync){
	var obj = document.getElementById(id0);
	var _v = document.getElementById(id);
	var values = _v.value;

	//var url = path + "helper/tree?";
	var url = path + "treeServlet?";//��ʾ���ֵ���ڸ�ΪtreeServlet by ��־�� at 20121207
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

				obj.title="˫���˴����ѡ�����ݣ�" + reValue["name"];
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
				obj.title="˫���˴����ѡ�����ݣ�" + n;
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
 * �õ�ָ���Ĵ���ֵ������
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

//��Date����չ���� Date ת��Ϊָ����ʽ��String
//��(M)����(d)��Сʱ(h)����(m)����(s)������(q) ������ 1-2 ��ռλ����
//��(y)������ 1-4 ��ռλ��������(S)ֻ���� 1 ��ռλ��(�� 1-3 λ������)
//���ӣ�
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
Date.prototype.Format = function(fmt) { //author: meizz
var o = {
	"M+": this.getMonth() + 1,
	//�·�
	"d+": this.getDate(),
	//��
	"h+": this.getHours(),
	//Сʱ
	"m+": this.getMinutes(),
	//��
	"s+": this.getSeconds(),
	//��
	"q+": Math.floor((this.getMonth() + 3) / 3),
	//����
	"S": this.getMilliseconds() //����
};
if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
for (var k in o) if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
return fmt;
};

function formatDate(datestring){
	var ds = datestring.split("-");
	return (new Date(ds[0],(parseInt(ds[1],10)-1),ds[2])).Format("yyyy��MM��dd��");
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
