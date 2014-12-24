/**
 * 关于Ajax的操作类
 */
var xmlhttp;

/**判断浏览器版本**/
var ua = navigator.userAgent.toLowerCase();
var isStrict = document.compatMode == "CSS1Compat",
isOpera = ua.indexOf("opera") > -1,
isChrome = ua.indexOf("chrome") > -1,
isSafari = !isChrome && (/webkit|khtml/).test(ua),
isSafari3 = isSafari && ua.indexOf('webkit/5') != -1,
isIE = !isOpera && ua.indexOf("msie") > -1,
isIE7 = !isOpera && ua.indexOf("msie 7") > -1,
isIE8 = !isOpera && ua.indexOf("msie 8") > -1,
isGecko = !isSafari && !isChrome && ua.indexOf("gecko") > -1,
isGecko3 = isGecko && ua.indexOf("rv:1.9") > -1,
isBorderBox = isIE && !isStrict,
isWindows = (ua.indexOf("windows") != -1 || ua.indexOf("win32") != -1),
isMac = (ua.indexOf("macintosh") != -1 || ua.indexOf("mac os x") != -1),
isAir = (ua.indexOf("adobeair") != -1),
isLinux = (ua.indexOf("linux") != -1),
isFirefox=(ua.indexOf("firefox") != -1),
isSecure = window.location.href.toLowerCase().indexOf("https") === 0;
/**
 * 得到XMLHttpRequest对象
 * 
 * @return
 */
function getXmlHttpRequest() {
	var xmlHttp;
	 // IE5 for the mac claims to support window.ActiveXObject, but throws an error when it's used
    if (window.ActiveXObject && !(navigator.userAgent.indexOf('Mac') >= 0 && navigator.userAgent.indexOf("MSIE") >= 0)){
    	try {
    		// IE 6+
    		xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
    	} catch (e) {
    		try {
    			// Firefox, Opera 8.0+, Safari
    			xmlHttp = new XMLHttpRequest();
    		} catch (e) {
    			try {
    				// IE 5.5+
    				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    			} catch (e) {
    				alert("您的浏览器不支持Ajax，请更换新版本的浏览器");
    				return null;
    			}
    		}
    	}
    }else if (window.XMLHttpRequest){
    	xmlHttp = new XMLHttpRequest();
    }
	return xmlHttp;
}

function runAction(url, param, OnReadyStateChng) {
	if(param==null){
		param="";
	}
	xmlhttp = getXmlHttpRequest();
	//path为全局的上下文根
	if (xmlhttp != null) {
		var asyn = true;
		if (OnReadyStateChng == null) {
			asyn = false;
		}
		xmlhttp.open("POST", url, asyn);
		// 这一句是用post方法发送的时候必须写的
		xmlhttp.setrequestheader('cache-control','no-cache');  
		xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
		// 提交的参数
		var postParam = param;
		postParam = encodeURI(postParam);
		postParam = encodeURI(postParam);//2次编码是为了解决乱码问题
		xmlhttp.send(postParam);
	}
}

/**
 * 执行Ajax<br>
 * 如果OnReadyStateChng传递的是null，那么直接返回值；<br>
 * 如果是一个方法，那么就执行该方法
 * 
 * @param className Ajax后台实现类的全名称
 * @param param 所有要提交的参数
 * @param OnReadyStateChng 提交后，返回的结果，如果为null，则是同步提交。<br>
 * <b>OnReadyStateChng方法可以按照以下例子编写：</b><br>
 * //使用全局变量 xmlhttp
 * function OnReadyStateChng()
{
    if (xmlhttp.readyState == 0)
    {
        document.getElementById("board").innerHTML = "尚未初始化";
    }
    else if (xmlhttp.readyState == 1)
    {
        document.getElementById("board").innerHTML = "正在加载";
    }
    else if (xmlhttp.readyState == 2)
    {
        document.getElementById("board").innerHTML = "加载完毕";
    }
    else if (xmlhttp.readyState == 3)
    {
        document.getElementById("board").innerHTML = "正在处理";
    }
    else if (xmlhttp.readyState == 4)
    {
        document.getElementById("board").innerHTML = xmlhttp.responseText; //处理完毕
    }
    
}

 * @return 如果是同步提交的话，那么就返回内容，否则没有返回值
 */
function executeRequest(className, param, OnReadyStateChng) {
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
		var asyn = true;
		if (OnReadyStateChng == null) {
			asyn = false;
		}
		xmlhttp.open("POST", url, asyn);
		//if (!asyn) {
		//	xmlhttp.onreadystatechange = OnReadyStateChng;
		//}
		// 这一句是用post方法发送的时候必须写的
		if(isIE)
	    {
	    xmlhttp.setrequestheader('cache-control','no-cache');  
	    }
	    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
		// 提交的参数
		var postParam = "className=" + className + "&" + param;
		postParam = encodeURI(postParam);
		postParam = encodeURI(postParam);//2次编码是为了解决乱码问题
		xmlhttp.send(postParam);
		var result=null;
		// 如果asyn为true，那么取出值来返回，否则执行OnReadyStateChng方法
		if (!asyn) {
			if(isFirefox)
		    {
		    	if(xmlhttp.status == 200 && xmlhttp.readyState == 4)
		    		{
		    		result = xmlhttp.responseText;
		    		}
		    }else{
		    if ( xmlhttp.status == 200 || xmlhttp.status == 304 ){
					result = xmlhttp.responseText ;
				}else
				{
					alert( '文件加载错误: ' + xmlhttp.statusText + ' (' + xmlhttp.status + ')' ) ;
				}
		  }
		}
		return result;
	}
}
/*********************************
 * 以下为三级联动的select的代码   *
 *********************************/
var selectValues = new Array();
//代码集select名称的前缀
var perfix_select="code_select_";
/**
 * select的onchange事件
 * @param o 要设置的select对象
 */

function _code_change(o,id,base){
	var pid=o.value;
	_setSelect(o,id,pid,base);	
	
}
/**
 * 设置select
 * @param o 要设置的select对象
 */
function _setSelect(o,id,pid,base){
	var hiName = o.getAttribute("hiddenName");
	var nextName = o.getAttribute("next");
	//设置选中的值
	_setCodeName(hiName,o.value);
	if (nextName!=null){
		//得到option
		var options = _setOption(_code_xml(o,id,pid,base));
		var o1=document.getElementsByName(nextName)[0];
		o1.options.length=0;
		var oi=options.length;
		for(var i=0;i<oi;i++){
			o1.add(options[i]);
		}
		_setSelect(o1);
	}

}
/**
 * 设置option对象
 * @param xml 获得的数据xml
 */
function _setOption(xml){
	var options = new Array();
	var optionTxt = document.createElement("OPTION");
	if(xml==null){
		optionTxt.text = "---";
		optionTxt.value = "";
		options[options.length]=optionTxt;
		return options;
	}else{
		optionTxt.text = "请选择";
		optionTxt.value = "";
		options[options.length]=optionTxt;
	}
	var xmlDoc=new ActiveXObject("Microsoft.XMLDOM"); //创建Document对象
    xmlDoc.async="false"; //设置文档异步下载为否
    xmlDoc.loadXML(xml); //加载XML样式的字符串
	var codesDoc=xmlDoc.documentElement;
	var nodeList = codesDoc.childNodes;
    var nodeSize = nodeList.length; 
    for(var i=0;i<nodeSize;i++){
    	var code = nodeList.item(i);
    	var value = code.attributes.getNamedItem("value").nodeValue;
		var desc = code.text;
		var option = document.createElement("OPTION");
		option.text = desc;
		option.value = value;
		options[options.length]=option;
    }
    return options;
}
/**
 * 设置隐藏域代码的值
 * @param name 要设置数据的隐藏域名字
 * @param value 要设置的数据的值
 */
function _setCodeName(name,value){
	document.getElementsByName(name)[0].value=value;
}
/**
 * 获取xml描述字符串
 * @param o 点击的对象
 */
function _code_xml(o,id,pid,base){
	var hiName = o.getAttribute("hiddenName");
	var select_obj = selectValues[hiName];
	var v = o.value;
	//如果选择了是空数据，则返回空数据
	if (v == "" || v == null){
		return null;
	}else{
		v = perfix_select + v;
	}
	if (select_obj==null){
		//获取数据并存储至对象
		select_obj=new Array();
		
		select_obj[v]=_get_Xml(id,pid,base);
		selectValues[hiName]=select_obj;
	}else{
		var vv = select_obj[v];
		if (vv == null){
			//获取数据并存储至对象
			select_obj[v]=_get_Xml(id,pid,base);
			selectValues[hiName]=select_obj;
		}
	}
	var reXml = selectValues[hiName][v];
	return reXml;
}
/**
 * 获取符合条件的xml
 * @param id codeSortId
 * @param pid parentId
 * @param base 是否是基础代码
 */
function _get_Xml(id,pid,base){
	xmlStr="";
	var parameter="id=" + id + "&pid=" + pid + "&base=" + base;
	return executeRequest("hx.code.AjaxCode",parameter);	
}
/**********************************************************************
 **** Ajax中获取服务器返回对象的方法 ***********************************
 **********************************************************************/
/**
 * 得到XML格式的字符串
 * @param className 实现接口的class
 * @param parameter <code>String</code>要传递的参数
 * @return getXml方法获得的xml
 */
function getXml(className,parameter){
	if (parameter==null){
		parameter="";
	}
	var xml = executeRequest(className,parameter);
	if(!isError(xml)){
		return xml;
	}else{
		return null;
	}
}
/**
 * 得到String对象
 * @param className 实现接口的class
 * @param parameter <code>String</code>要传递的参数
 * @return 获得Data对象
 */
function getStr(className,parameter){
	if (parameter==null){
		parameter="";
	}
	return executeRequest(className,parameter);
}
/**
 * 得到Data对象
 * @param className 实现接口的class
 * @param parameter <code>String</code>要传递的参数
 * @return 获得Data对象
 */
function getData(className,parameter){
	if (parameter==null){
		parameter="";
	}
	var xml = executeRequest(className,parameter);
	var root = loadXml(xml);
	if (root==null){
		return null;
	}
	if(isErrorRoot(root)){
		return null;
	}
	var nodeList = root.childNodes;
    var nodeSize = nodeList.length; 
    var data = new Data();
	for(var i=0;i<nodeSize;i++){
    	var code = nodeList.item(i);
		var desc = code.text;
		var name = code.nodeName;
		data.add(name,desc);
    }
    return data;
}
/**
 * 得到DataList对象
 * @param className 实现接口的class
 * @param parameter <code>String</code>要传递的参数
 * @return 获得DataList对象
 */
function getDataList(className,parameter,OnReadyStateChng){
	if (parameter==null){
		parameter="";
	}
	var xml = executeRequest(className,parameter,OnReadyStateChng);
	if(OnReadyStateChng!=null){
		return;
	}
	var root = loadXml(xml);
	if (root==null){
		return null;
	}
	if(isErrorRoot(root)){
		return null;
	}
	 if(getOs()!="Firefox")
	    {
		 return setDataListForRoot(root);
	    }else{
	     return setDataListForRoot_FF(root);	
	    }
	
}

/**
 * 获取代码集，json
 * @param codesortIds，多个代码集id用逗号分隔
 * @returns json对象 {codeSortId1:{code1Value:{code1},...},...}
 */
function getCode(codesortIds){
	var s=executeRequest("hx.code.AjaxCode","codeSortId="+codesortIds);
	if(s!=""){
		return eval('('+s+')');
	}else{
		return new function(){};
	}
}

function setDataListForRoot_FF(root){
	var nodeList = root.childNodes;
    var nodeSize = nodeList.length; 
    var dataList = new DataList();
    dataList.setdataTotal(getAttribute(root,"dataTotal"));
    dataList.setNowPage(getAttribute(root,"page"));
    dataList.setPageSize(getAttribute(root,"pageTotal"));
    var firenodeList = root.children;
	for(var i =0; i<firenodeList.length;i++)
		{
		    var len=firenodeList[i].children.length;
			var d = new Data();
			  for(var j=0;j<len;j++)
		     {
			     var name= firenodeList[i].children[j].localName;
			     var desc= firenodeList[i].children[j].firstChild.wholeText;
		    	d.add(name,desc);
		     }
			  dataList.addData(d);
	}
    return dataList;
}

function setDataListForRoot(root){
	var nodeList = root.childNodes;
    var nodeSize = nodeList.length; 
    var dataList = new DataList();
    dataList.setdataTotal(getAttribute(root,"dataTotal"));
    dataList.setNowPage(getAttribute(root,"page"));
    dataList.setPageSize(getAttribute(root,"pageTotal"));
    for(var i=0;i<nodeSize;i++){
    	var data = nodeList.item(i);
    	var fields=data.childNodes;
    	var flength = fields.length;
    	var d = new Data();
    	for(var j=0;j<flength;j++){
    		var code = fields.item(j);
			var desc = code.text;
			var name = code.nodeName;
			d.add(name,desc);
		}
    	dataList.addData(d);
    }
    return dataList;
}
/**
 * 得到布尔值
 * @param className 实现接口的class
 * @param parameter <code>String</code>要传递的参数
 * @return boolean类型的结果
 */
function getBoolean(className,parameter){
	if (parameter==null){
		parameter="";
	}
	var xml = executeRequest(className,parameter);
	var root = loadXml(xml);
	if (root==null){
		alert("获取数据失败");
		return null;
	}
	//<boolean value="true"></boolean>
	if(isErrorRoot(root)){
		return false;
	}
	var b = getAttribute(root,"value");
	if (b=="true"){
		return true;
	}else if (b=="false"){
		return false;
	}else{
		alert("获取数据失败");
		return false;
	}
}
/**
 * 分析数据是否是错误
 * @param root root对象
 * @return true表示是错误，false表示是正确数据
 */
function isErrorRoot(root){
	var nodeName = root.nodeName;
	if (nodeName=="ERRORS"){
		var nodeList = root.childNodes;
    	var nodeSize = nodeList.length; 
    	var err = "发生以下系统错误：\n";
    	for(var i=0;i<nodeSize;i++){
    		if(i>0){
    			err+="\n";
    		}
    		var node = nodeList.item(i);
    		err += "\t" + (i+1) + "、" + node.text;
    	}
    	alert(err);
		return true;
	}else{
		return false;
	}
}
/**
 * 分析数据是否是错误
 * @param xml xml格式的字符串
 * @return true表示是错误，false表示是正确数据
 */
function isError(xml){
	var root = loadXml(xml);
	if (root==null){
		return false;
	}
	return isErrorRoot(root);
}
//<ERRORS><ERROR></ERROR><ERROR></ERROR></ERRORS>

function getOs()      
{      
   var OsObject = "";      
   if(navigator.userAgent.indexOf("MSIE")>0) {  
        return "MSIE";       //IE浏览器  
        
   }   
   if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){      
        return "Firefox";     //Firefox浏览器   
   }       
}   

/**
 * 加载xml
 * @param xml xml格式的字符串
 * @return root对象
 */
function loadXml(xml){
	var xmlDoc;
	if(isFirefox){
		var oParser = new DOMParser(); 
	    xmlDoc = oParser.parseFromString(xml,"text/xml");
	}else if(isIE){
		xmlDoc=new ActiveXObject("Microsoft.XMLDOM"); //创建Document对象
	    xmlDoc.async="false"; //设置文档异步下载为否
	    xmlDoc.loadXML(xml); //加载XML样式的字符串	
	}else if(isChrome){
		xmlDoc=xmlHttp.responseXML;
	}else{
		xmlDoc=new ActiveXObject("Microsoft.XMLDOM"); //创建Document对象
	    xmlDoc.async="false"; //设置文档异步下载为否
	    xmlDoc.loadXML(xml); //加载XML样式的字符串	
	}
	return xmlDoc.documentElement;
}
/**
 * 获得节点的属性
 * @param node 节点
 * @param key node节点的属性名称
 * @return node节点的key属性的值
 */
function getAttribute(node,key){
	var n = node.attributes.getNamedItem(key);
	if (n!=null){
		return n.nodeValue;
	}else{
		return null;
	}
	
}
/**
 * DataList对象
 */
function DataList(){
	this.array = new Array();
	//当前页
	this.nowPage=0;
	//每页多少条数据
	this.pageSize = 0;
	//一共多少条数据
	this.dataTotal = 0;
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
	this.getNowPage=function(){
		return this.nowPage;
	};
	/**
	 * 设置当前页
	 * @param page 当前页
	 */
	this.setNowPage=function(page){
		this.nowPage=page;
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
	this.getdataTotal=function(){
		return this.dataTotal;
	};
	/**
	 * 设置总数据
	 * @param dataTotal 总数据
	 */
	this.setdataTotal=function(dataTotal){
		this.dataTotal=dataTotal;
	};
	/**
	 * 得到页面一共多少页
	 */
	this.getPageNum=function(){
		var num = this.dataTotal/this.pageSize;
		if(this.dataTotal%this.pageSize>0){
			num++;
		}
		return num;
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
/**
 * 验证码标签
 * @param width	图片宽度
 * @param height 图片高度
 * @param strNum 验证码字符个数
 * @param codeType 验证码字符类型(wordnumber:字母和数字的组合；word:字母组合；number：数字组合)
 * @param imgPath 验证码图片路径(相对应用根路径的路径)
 * @return
 */
function getValiCode(width,height,strNum,codeType,imgPath){
	var code ="";
	var filename ="";
	filename = exeRequest("com.hx.framework.authenticate.RefreshCodeAjax","imgWidth="+width+"&imgHeight="+height+"&strNum="+strNum+"&codeType="+codeType);
	var codeImg = document.getElementById("codeImg");
	codeImg.src=imgPath+"/"+filename;
}
function exeRequest(className, param, OnReadyStateChng) {
	if (className==null){
		alert("参数“实现类className”不能为null。");
	}
	if(param==null){
		param="";
	}
	xmlhttp = getXmlHttpRequest();
	//path为全局的上下文根
	var url = path + "AjaxExecute1";
	if (xmlhttp != null) {
		var asyn = true;
		if (OnReadyStateChng == null) {
			asyn = false;
		}
		xmlhttp.open("POST", url, asyn);
		// 这一句是用post方法发送的时候必须写的
		if(isIE)
	    {
	    xmlhttp.setrequestheader('cache-control','no-cache');  
	    }
	    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
		// 提交的参数
		var postParam = "className=" + className + "&" + param;
		postParam = encodeURI(postParam);
		postParam = encodeURI(postParam);//2次编码是为了解决乱码问题
		xmlhttp.send(postParam);
		var result=null;
		// 如果asyn为true，那么取出值来返回，否则执行OnReadyStateChng方法
		if (!asyn) {
			if(isFirefox)
		    {
		    	if(xmlhttp.status == 200 && xmlhttp.readyState == 4)
		    		{
		    		result = xmlhttp.responseText;
		    		}
		    }else{
		    if ( xmlhttp.status == 200 || xmlhttp.status == 304 ){
					result = xmlhttp.responseText ;
				}else
				{
					alert( '文件加载错误: ' + xmlhttp.statusText + ' (' + xmlhttp.status + ')' ) ;
				}
		  }
		}
		return result;
	}
}