/**
 * ����Ajax�Ĳ�����
 */
var xmlhttp;

/**�ж�������汾**/
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
 * �õ�XMLHttpRequest����
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
    				alert("�����������֧��Ajax��������°汾�������");
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
	//pathΪȫ�ֵ������ĸ�
	if (xmlhttp != null) {
		var asyn = true;
		if (OnReadyStateChng == null) {
			asyn = false;
		}
		xmlhttp.open("POST", url, asyn);
		// ��һ������post�������͵�ʱ�����д��
		xmlhttp.setrequestheader('cache-control','no-cache');  
		xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
		// �ύ�Ĳ���
		var postParam = param;
		postParam = encodeURI(postParam);
		postParam = encodeURI(postParam);//2�α�����Ϊ�˽����������
		xmlhttp.send(postParam);
	}
}

/**
 * ִ��Ajax<br>
 * ���OnReadyStateChng���ݵ���null����ôֱ�ӷ���ֵ��<br>
 * �����һ����������ô��ִ�и÷���
 * 
 * @param className Ajax��̨ʵ�����ȫ����
 * @param param ����Ҫ�ύ�Ĳ���
 * @param OnReadyStateChng �ύ�󣬷��صĽ�������Ϊnull������ͬ���ύ��<br>
 * <b>OnReadyStateChng�������԰����������ӱ�д��</b><br>
 * //ʹ��ȫ�ֱ��� xmlhttp
 * function OnReadyStateChng()
{
    if (xmlhttp.readyState == 0)
    {
        document.getElementById("board").innerHTML = "��δ��ʼ��";
    }
    else if (xmlhttp.readyState == 1)
    {
        document.getElementById("board").innerHTML = "���ڼ���";
    }
    else if (xmlhttp.readyState == 2)
    {
        document.getElementById("board").innerHTML = "�������";
    }
    else if (xmlhttp.readyState == 3)
    {
        document.getElementById("board").innerHTML = "���ڴ���";
    }
    else if (xmlhttp.readyState == 4)
    {
        document.getElementById("board").innerHTML = xmlhttp.responseText; //�������
    }
    
}

 * @return �����ͬ���ύ�Ļ�����ô�ͷ������ݣ�����û�з���ֵ
 */
function executeRequest(className, param, OnReadyStateChng) {
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
		var asyn = true;
		if (OnReadyStateChng == null) {
			asyn = false;
		}
		xmlhttp.open("POST", url, asyn);
		//if (!asyn) {
		//	xmlhttp.onreadystatechange = OnReadyStateChng;
		//}
		// ��һ������post�������͵�ʱ�����д��
		if(isIE)
	    {
	    xmlhttp.setrequestheader('cache-control','no-cache');  
	    }
	    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
		// �ύ�Ĳ���
		var postParam = "className=" + className + "&" + param;
		postParam = encodeURI(postParam);
		postParam = encodeURI(postParam);//2�α�����Ϊ�˽����������
		xmlhttp.send(postParam);
		var result=null;
		// ���asynΪtrue����ôȡ��ֵ�����أ�����ִ��OnReadyStateChng����
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
					alert( '�ļ����ش���: ' + xmlhttp.statusText + ' (' + xmlhttp.status + ')' ) ;
				}
		  }
		}
		return result;
	}
}
/*********************************
 * ����Ϊ����������select�Ĵ���   *
 *********************************/
var selectValues = new Array();
//���뼯select���Ƶ�ǰ׺
var perfix_select="code_select_";
/**
 * select��onchange�¼�
 * @param o Ҫ���õ�select����
 */

function _code_change(o,id,base){
	var pid=o.value;
	_setSelect(o,id,pid,base);	
	
}
/**
 * ����select
 * @param o Ҫ���õ�select����
 */
function _setSelect(o,id,pid,base){
	var hiName = o.getAttribute("hiddenName");
	var nextName = o.getAttribute("next");
	//����ѡ�е�ֵ
	_setCodeName(hiName,o.value);
	if (nextName!=null){
		//�õ�option
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
 * ����option����
 * @param xml ��õ�����xml
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
		optionTxt.text = "��ѡ��";
		optionTxt.value = "";
		options[options.length]=optionTxt;
	}
	var xmlDoc=new ActiveXObject("Microsoft.XMLDOM"); //����Document����
    xmlDoc.async="false"; //�����ĵ��첽����Ϊ��
    xmlDoc.loadXML(xml); //����XML��ʽ���ַ���
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
 * ��������������ֵ
 * @param name Ҫ�������ݵ�����������
 * @param value Ҫ���õ����ݵ�ֵ
 */
function _setCodeName(name,value){
	document.getElementsByName(name)[0].value=value;
}
/**
 * ��ȡxml�����ַ���
 * @param o ����Ķ���
 */
function _code_xml(o,id,pid,base){
	var hiName = o.getAttribute("hiddenName");
	var select_obj = selectValues[hiName];
	var v = o.value;
	//���ѡ�����ǿ����ݣ��򷵻ؿ�����
	if (v == "" || v == null){
		return null;
	}else{
		v = perfix_select + v;
	}
	if (select_obj==null){
		//��ȡ���ݲ��洢������
		select_obj=new Array();
		
		select_obj[v]=_get_Xml(id,pid,base);
		selectValues[hiName]=select_obj;
	}else{
		var vv = select_obj[v];
		if (vv == null){
			//��ȡ���ݲ��洢������
			select_obj[v]=_get_Xml(id,pid,base);
			selectValues[hiName]=select_obj;
		}
	}
	var reXml = selectValues[hiName][v];
	return reXml;
}
/**
 * ��ȡ����������xml
 * @param id codeSortId
 * @param pid parentId
 * @param base �Ƿ��ǻ�������
 */
function _get_Xml(id,pid,base){
	xmlStr="";
	var parameter="id=" + id + "&pid=" + pid + "&base=" + base;
	return executeRequest("hx.code.AjaxCode",parameter);	
}
/**********************************************************************
 **** Ajax�л�ȡ���������ض���ķ��� ***********************************
 **********************************************************************/
/**
 * �õ�XML��ʽ���ַ���
 * @param className ʵ�ֽӿڵ�class
 * @param parameter <code>String</code>Ҫ���ݵĲ���
 * @return getXml������õ�xml
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
 * �õ�String����
 * @param className ʵ�ֽӿڵ�class
 * @param parameter <code>String</code>Ҫ���ݵĲ���
 * @return ���Data����
 */
function getStr(className,parameter){
	if (parameter==null){
		parameter="";
	}
	return executeRequest(className,parameter);
}
/**
 * �õ�Data����
 * @param className ʵ�ֽӿڵ�class
 * @param parameter <code>String</code>Ҫ���ݵĲ���
 * @return ���Data����
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
 * �õ�DataList����
 * @param className ʵ�ֽӿڵ�class
 * @param parameter <code>String</code>Ҫ���ݵĲ���
 * @return ���DataList����
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
 * ��ȡ���뼯��json
 * @param codesortIds��������뼯id�ö��ŷָ�
 * @returns json���� {codeSortId1:{code1Value:{code1},...},...}
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
 * �õ�����ֵ
 * @param className ʵ�ֽӿڵ�class
 * @param parameter <code>String</code>Ҫ���ݵĲ���
 * @return boolean���͵Ľ��
 */
function getBoolean(className,parameter){
	if (parameter==null){
		parameter="";
	}
	var xml = executeRequest(className,parameter);
	var root = loadXml(xml);
	if (root==null){
		alert("��ȡ����ʧ��");
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
		alert("��ȡ����ʧ��");
		return false;
	}
}
/**
 * ���������Ƿ��Ǵ���
 * @param root root����
 * @return true��ʾ�Ǵ���false��ʾ����ȷ����
 */
function isErrorRoot(root){
	var nodeName = root.nodeName;
	if (nodeName=="ERRORS"){
		var nodeList = root.childNodes;
    	var nodeSize = nodeList.length; 
    	var err = "��������ϵͳ����\n";
    	for(var i=0;i<nodeSize;i++){
    		if(i>0){
    			err+="\n";
    		}
    		var node = nodeList.item(i);
    		err += "\t" + (i+1) + "��" + node.text;
    	}
    	alert(err);
		return true;
	}else{
		return false;
	}
}
/**
 * ���������Ƿ��Ǵ���
 * @param xml xml��ʽ���ַ���
 * @return true��ʾ�Ǵ���false��ʾ����ȷ����
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
        return "MSIE";       //IE�����  
        
   }   
   if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){      
        return "Firefox";     //Firefox�����   
   }       
}   

/**
 * ����xml
 * @param xml xml��ʽ���ַ���
 * @return root����
 */
function loadXml(xml){
	var xmlDoc;
	if(isFirefox){
		var oParser = new DOMParser(); 
	    xmlDoc = oParser.parseFromString(xml,"text/xml");
	}else if(isIE){
		xmlDoc=new ActiveXObject("Microsoft.XMLDOM"); //����Document����
	    xmlDoc.async="false"; //�����ĵ��첽����Ϊ��
	    xmlDoc.loadXML(xml); //����XML��ʽ���ַ���	
	}else if(isChrome){
		xmlDoc=xmlHttp.responseXML;
	}else{
		xmlDoc=new ActiveXObject("Microsoft.XMLDOM"); //����Document����
	    xmlDoc.async="false"; //�����ĵ��첽����Ϊ��
	    xmlDoc.loadXML(xml); //����XML��ʽ���ַ���	
	}
	return xmlDoc.documentElement;
}
/**
 * ��ýڵ������
 * @param node �ڵ�
 * @param key node�ڵ����������
 * @return node�ڵ��key���Ե�ֵ
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
 * DataList����
 */
function DataList(){
	this.array = new Array();
	//��ǰҳ
	this.nowPage=0;
	//ÿҳ����������
	this.pageSize = 0;
	//һ������������
	this.dataTotal = 0;
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
	this.getNowPage=function(){
		return this.nowPage;
	};
	/**
	 * ���õ�ǰҳ
	 * @param page ��ǰҳ
	 */
	this.setNowPage=function(page){
		this.nowPage=page;
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
	this.getdataTotal=function(){
		return this.dataTotal;
	};
	/**
	 * ����������
	 * @param dataTotal ������
	 */
	this.setdataTotal=function(dataTotal){
		this.dataTotal=dataTotal;
	};
	/**
	 * �õ�ҳ��һ������ҳ
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
/**
 * ��֤���ǩ
 * @param width	ͼƬ���
 * @param height ͼƬ�߶�
 * @param strNum ��֤���ַ�����
 * @param codeType ��֤���ַ�����(wordnumber:��ĸ�����ֵ���ϣ�word:��ĸ��ϣ�number���������)
 * @param imgPath ��֤��ͼƬ·��(���Ӧ�ø�·����·��)
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
		alert("������ʵ����className������Ϊnull��");
	}
	if(param==null){
		param="";
	}
	xmlhttp = getXmlHttpRequest();
	//pathΪȫ�ֵ������ĸ�
	var url = path + "AjaxExecute1";
	if (xmlhttp != null) {
		var asyn = true;
		if (OnReadyStateChng == null) {
			asyn = false;
		}
		xmlhttp.open("POST", url, asyn);
		// ��һ������post�������͵�ʱ�����д��
		if(isIE)
	    {
	    xmlhttp.setrequestheader('cache-control','no-cache');  
	    }
	    xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
		// �ύ�Ĳ���
		var postParam = "className=" + className + "&" + param;
		postParam = encodeURI(postParam);
		postParam = encodeURI(postParam);//2�α�����Ϊ�˽����������
		xmlhttp.send(postParam);
		var result=null;
		// ���asynΪtrue����ôȡ��ֵ�����أ�����ִ��OnReadyStateChng����
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
					alert( '�ļ����ش���: ' + xmlhttp.statusText + ' (' + xmlhttp.status + ')' ) ;
				}
		  }
		}
		return result;
	}
}