var selectValues = new Array();
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
	return executeRequest(pathRoot,"codeSelect","show",parameter);	
}
/**
 * ���Է���
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
 * �õ�XML��ʽ���ַ���
 * @param dataSource ����Դ������Constants�ĳ�������
 * @param className ʵ�ֽӿڵ�class
 * @param parameter <code>String</code>Ҫ���ݵĲ���
 * @return getXml������õ�xml
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
 * �õ�Data����
 * @param dataSource ����Դ������Constants�ĳ�������
 * @param className ʵ�ֽӿڵ�class
 * @param parameter <code>String</code>Ҫ���ݵĲ���
 * @return ���Data����
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
 * �õ�DataMsg����
 * @param dataSource ����Դ������Constants�ĳ�������
 * @param className ʵ�ֽӿڵ�class
 * @param parameter <code>String</code>Ҫ���ݵĲ���
 * @return ���DataMsg����
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
 * �õ�����ֵ
 * @param dataSource ����Դ������Constants�ĳ�������
 * @param className ʵ�ֽӿڵ�class
 * @param parameter <code>String</code>Ҫ���ݵĲ���
 * @return boolean���͵Ľ��
 */
function getBoolean(pathRoot,className,parameter){
	if (parameter==null){
		parameter="";
	}
	parameter="className=" + className + "&" + parameter;
	var xml = executeRequest(pathRoot,"ajaxbase",parameter);
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
/**
 * ����xml
 * @param xml xml��ʽ���ַ���
 * @return root����
 */
function loadXml(xml){
	var xmlDoc=new ActiveXObject("Microsoft.XMLDOM"); //����Document����
    xmlDoc.async="false"; //�����ĵ��첽����Ϊ��
    xmlDoc.loadXML(xml); //����XML��ʽ���ַ���
	return xmlDoc.documentElement;
}
/**
 * ��ýڵ������
 * @param node �ڵ�
 * @param key node�ڵ����������
 * @return node�ڵ��key���Ե�ֵ
 */
function getAttribute(node,key){
	return node.attributes.getNamedItem(key).nodeValue;
}



var SESSION_TIMEOUT_TAG = "<!-- THE NOTE OF SESSION-TIMEOUT FOR PARTREFRESH -->"; 
/**
*@description:      ͳһ�ľֲ�ˢ���������
*@param:            actionName        �����õ�action
*@param:            actionMethod      action�еķ���
*@param:            getParameter      ����get�������ݵĲ���
*@param:            postParameter     ����post�������ݵĲ���
*@param:            isSynch
*@return:           �ӷ��������ص��ַ���
*/
function executeRequest(path,actionName,postParameter){
    //�ж��Ƿ�ʹ�þֲ�ˢ��
    var isPartlyRefresh;
    var objXMLReq = getObjXMLReq();
    var strURL = path + "/servlet/common/" + actionName;
    if(postParameter == null) postParameter ="";
     //objXMLReq.open("POST", strURL+"?"+ postParameter, false);
    /*��ajax�ύ��ʽ�޸�Ϊpost-start*/
    objXMLReq.open("POST", strURL, false);
	objXMLReq.setrequestheader('cache-control','no-cache');  
	objXMLReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); 
	/*��ajax�ύ��ʽ�޸�Ϊpost-end*/
    objXMLReq.send(postParameter);
    var result;
    if ( objXMLReq.status == 200 || objXMLReq.status == 304 ){
			result = objXMLReq.responseText ;
		}else
		{
			alert( '�ļ����ش���: ' + objXMLReq.statusText + ' (' + objXMLReq.status + ')' ) ;
		}
          /**
           if(result.indexOf(SESSION_TIMEOUT_TAG)>=0){
           	window.top.location = window.top.location;
           	throw new Error("SESSION_TIMEOUT");
           }     **/
           return result;

}
//ȡ��XMLHttpRequest����,����AJAX����
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
