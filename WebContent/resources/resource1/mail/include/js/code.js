var selectValues = new Array();
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
	return executeRequest(pathRoot,"codeSelect","show",parameter);	
}
/**
 * 测试方法
 */
function showarray(){
	var s = "";
	for(var i in selectValues){
		for(var j in selectValues[i]){
			s+="[" +  i+ "]--[" + j + "]:" +selectValues[i][j] + "\n";
		}
	}
	document.getElementById("ss").value=s+"\n\n\n----------------------\n" + xmlStr;
}
/**
 * 得到XML格式的字符串
 * @param dataSource 数据源，请用Constants的常量传递
 * @param className 实现接口的class
 * @param parameter <code>String</code>要传递的参数
 * @return getXml方法获得的xml
 */
function getXml(pathRoot,className,parameter){
	if (parameter==null){
		parameter="";
	}
	parameter="className=" + className + "&" + parameter;
	var xml = executeRequest(pathRoot,"ajaxbase",parameter);
	if(!isError(xml)){
		return xml;
	}else{
		return null;
	}
}
function getStr(pathRoot,className,parameter){
	if (parameter==null){
		parameter="";
	}
	parameter="className=" + className + "&" + parameter;
	return executeRequest(pathRoot,"ajaxbase",parameter);

}
/**
 * 得到Data对象
 * @param dataSource 数据源，请用Constants的常量传递
 * @param className 实现接口的class
 * @param parameter <code>String</code>要传递的参数
 * @return 获得Data对象
 */
function getData(pathRoot,className,parameter){
	if (parameter==null){
		parameter="";
	}
	parameter="className=" + className + "&" + parameter;
	var xml = executeRequest(pathRoot,"ajaxbase",parameter);
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
 * 得到DataMsg对象
 * @param dataSource 数据源，请用Constants的常量传递
 * @param className 实现接口的class
 * @param parameter <code>String</code>要传递的参数
 * @return 获得DataMsg对象
 */
function getDataMsg(pathRoot,className,parameter){
	if (parameter==null){
		parameter="";
	}
	parameter="className=" + className + "&" + parameter;
	var xml = executeRequest(pathRoot,"ajaxbase",parameter);
	var root = loadXml(xml);
	if (root==null){
		return null;
	}
	if(isErrorRoot(root)){
		return null;
	}	
	return setDataMsgForRoot(root);
}
function setDataMsgForRoot(root){
	var nodeList = root.childNodes;
    var nodeSize = nodeList.length; 
    var dataMsg = new DataMsg();
    dataMsg.setPageTotal(getAttribute(root,"pageTotal"));
    dataMsg.setPage(getAttribute(root,"page"));
    dataMsg.setPageSize(getAttribute(root,"pageSize"));
    dataMsg.setPageNum(getAttribute(root,"pageNum"));
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
		dataMsg.addData(d);
    }
    return dataMsg;
}
/**
 * 得到布尔值
 * @param dataSource 数据源，请用Constants的常量传递
 * @param className 实现接口的class
 * @param parameter <code>String</code>要传递的参数
 * @return boolean类型的结果
 */
function getBoolean(pathRoot,className,parameter){
	if (parameter==null){
		parameter="";
	}
	parameter="className=" + className + "&" + parameter;
	var xml = executeRequest(pathRoot,"ajaxbase",parameter);
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
/**
 * 加载xml
 * @param xml xml格式的字符串
 * @return root对象
 */
function loadXml(xml){
	var xmlDoc=new ActiveXObject("Microsoft.XMLDOM"); //创建Document对象
    xmlDoc.async="false"; //设置文档异步下载为否
    xmlDoc.loadXML(xml); //加载XML样式的字符串
	return xmlDoc.documentElement;
}
/**
 * 获得节点的属性
 * @param node 节点
 * @param key node节点的属性名称
 * @return node节点的key属性的值
 */
function getAttribute(node,key){
	return node.attributes.getNamedItem(key).nodeValue;
}



var SESSION_TIMEOUT_TAG = "<!-- THE NOTE OF SESSION-TIMEOUT FOR PARTREFRESH -->"; 
/**
*@description:      统一的局部刷新请求入口
*@param:            actionName        已配置的action
*@param:            actionMethod      action中的方法
*@param:            getParameter      利用get方法传递的参数
*@param:            postParameter     利用post方法传递的参数
*@param:            isSynch
*@return:           从服务器返回的字符串
*/
function executeRequest(path,actionName,postParameter){
    //判断是否使用局部刷新
    var isPartlyRefresh;
    var objXMLReq = getObjXMLReq();
    var strURL = path + "/servlet/common/" + actionName;
    if(postParameter == null) postParameter ="";
     //objXMLReq.open("POST", strURL+"?"+ postParameter, false);
    /*将ajax提交方式修改为post-start*/
    objXMLReq.open("POST", strURL, false);
	objXMLReq.setrequestheader('cache-control','no-cache');  
	objXMLReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); 
	/*将ajax提交方式修改为post-end*/
    objXMLReq.send(postParameter);
    var result;
    if ( objXMLReq.status == 200 || objXMLReq.status == 304 ){
			result = objXMLReq.responseText ;
		}else
		{
			alert( '文件加载错误: ' + objXMLReq.statusText + ' (' + objXMLReq.status + ')' ) ;
		}
          /**
           if(result.indexOf(SESSION_TIMEOUT_TAG)>=0){
           	window.top.location = window.top.location;
           	throw new Error("SESSION_TIMEOUT");
           }     **/
           return result;

}
//取得XMLHttpRequest对象,基于AJAX技术
function getObjXMLReq(){
    var objXMLReq;
    // IE5 for the mac claims to support window.ActiveXObject, but throws an error when it's used
    if (window.ActiveXObject && !(navigator.userAgent.indexOf('Mac') >= 0 && navigator.userAgent.indexOf("MSIE") >= 0)){
        objXMLReq = new ActiveXObject("Microsoft.XMLHTTP");
    }
    //for Mozilla and Safari etc.
    else if (window.XMLHttpRequest){
        objXMLReq = new XMLHttpRequest();
    }
    return objXMLReq;
}
