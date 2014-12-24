/**
 * �������
 * @param pageId ҳ���ʾ
 * @param catalogId �����ʾ
 */
function clickcount(pageId,catalogId,pageName){
	if(!pageName){
		pageName="";
	}
	
	var r=executeRequest("com.hx.framework.clickcount.ClickCountAjax","pageId="+pageId+"&pageName="+pageName+"&catalogId="+catalogId);
}
/**
 * e�ʵ����¼����
 */
function getEYouUrl(){
	var r=executeRequest("com.hx.framework.authenticate.sso.EYouMailSSOAjax");
	return r;
}
/**
 * �����¼  token
 */
function getSSOToken(){
	var r=executeRequest("com.hx.framework.authenticate.sso.SSOTokenAjax");
	return r;
}
/**
 * �˺��������
 * @param authType
 * @returns
*/
function getPwdPolicy(authType){
	var str=executeRequest("com.hx.framework.security.GetPasswordPolicyAjax","authType="+authType);
	if(str!="0"){
		//alert(str);
		var ss=str.split("@@@");
		return ss;
	}
	var aa= new Array(4);
	aa[0]='0';
	aa[1]='';
	aa[2]='';
	aa[3]='1234567890';
	
	return aa;
	//{'0','','','1234567890'};
}
/**
 * �ж��Ƿ���ڸ�Ӧ�õĵ�����
 * @param appName
 * @param deleteuuid
 * @returns
 */
function ResourceAppIsRepead(appName,deleteuuid){
	var r=executeRequest("com.hx.framework.resource.app.ResourceAppAjax","appName="+appName+"&deleteuuid="+deleteuuid);
	var root=loadXml(r);
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
	return false;
}

/**
 * ��ȡ��Ա��ϸ��Ϣ
 * deptType �����Ǵ˵ģ�������֯������Ϊ�գ����ȡֱ����֯
 */
function getPersonInfo(personId,deptType){
	if(typeof deptType == "undefined"){
		deptType="";
	}
	var r=executeRequest("com.hx.framework.sdkajax.PersonInfoAjax","personId="+personId+"&deptType="+deptType);
	if(""!=r){
		return eval('('+r+')');;
	}
	return new function(){};
}

/**
 * ��ȡ��ǰ��¼����ϸ��Ϣ
 * deptType �����Ǵ˵ģ�������֯������Ϊ�գ����ȡֱ����֯
 */
function getLoginPersonInfo(deptType){
	if(typeof deptType == "undefined"){
		deptType="";
	}
	
	var r=executeRequest("com.hx.framework.sdkajax.LoginPersonInfoAjax","deptType="+deptType);
	if(""!=r){
		return eval('('+r+')');;
	}
	return new function(){};
}

/**
 * ��ȡ������ϸ��Ϣ
 * deptIdΪ���ʱ���ö��ŷָ�������ֵҲ�Ǹ�array
 */
function getDeptInfo(deptId){
	//alert(personId);
	var r=executeRequest("com.hx.framework.sdkajax.DeptInfoAjax","deptId="+deptId);
	//alert(r);
	if(""!=r){
		return eval('('+r+')');;
	}
	return new function(){};
}
