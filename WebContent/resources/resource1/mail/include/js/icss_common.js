
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
function executeRequest(path,actionName,actionMethod,postParameter,isAsynchronism){
    //�ж��Ƿ�ʹ�þֲ�ˢ��
    var isPartlyRefresh;
   
    var objXMLReq = getObjXMLReq();
    var strURL = "/" + path + "/" + actionName;
    currentActionName = actionName;
    
    var flag = false;
    if(actionMethod != null && actionMethod != ""){
        strURL += "?flag=" + actionMethod;
        flag = true;
    }
    //���Ӿֲ�ˢ�±�ʾ��
    if(flag) 
        strURL += "&isPartlyRefresh=true";
    else
        strURL += "?isPartlyRefresh=true";  
   
    if(postParameter == null) postParameter ="";
    if(isAsynchronism == null) isAsynchronism = false;
    objXMLReq.open("POST", strURL, isAsynchronism);
    objXMLReq.send(postParameter);
    var result;
    if(isAsynchronism==false){
	    if ( objXMLReq.status == 200 || objXMLReq.status == 304 ){
				result = objXMLReq.responseText ;
			}else
			{
				alert( '�ļ����ش���: ' + oXmlHttp.statusText + ' (' + oXmlHttp.status + ')' ) ;
			}
           /**
            if(result.indexOf(SESSION_TIMEOUT_TAG)>=0){
            	window.top.location = window.top.location;
            	throw new Error("SESSION_TIMEOUT");
            }     **/
            return result;
     }
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
