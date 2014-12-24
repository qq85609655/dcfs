
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
function executeRequest(path,actionName,actionMethod,postParameter,isAsynchronism){
    //判断是否使用局部刷新
    var isPartlyRefresh;
   
    var objXMLReq = getObjXMLReq();
    var strURL = "/" + path + "/" + actionName;
    currentActionName = actionName;
    
    var flag = false;
    if(actionMethod != null && actionMethod != ""){
        strURL += "?flag=" + actionMethod;
        flag = true;
    }
    //增加局部刷新标示符
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
				alert( '文件加载错误: ' + oXmlHttp.statusText + ' (' + oXmlHttp.status + ')' ) ;
			}
           /**
            if(result.indexOf(SESSION_TIMEOUT_TAG)>=0){
            	window.top.location = window.top.location;
            	throw new Error("SESSION_TIMEOUT");
            }     **/
            return result;
     }
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
