/**
 * 点击计数
 * @param pageId 页面标示
 * @param catalogId 分类标示
 */
function clickcount(pageId,catalogId,pageName){
	if(!pageName){
		pageName="";
	}
	
	var r=executeRequest("com.hx.framework.clickcount.ClickCountAjax","pageId="+pageId+"&pageName="+pageName+"&catalogId="+catalogId);
}
/**
 * e邮单点登录参数
 */
function getEYouUrl(){
	var r=executeRequest("com.hx.framework.authenticate.sso.EYouMailSSOAjax");
	return r;
}
/**
 * 单点登录  token
 */
function getSSOToken(){
	var r=executeRequest("com.hx.framework.authenticate.sso.SSOTokenAjax");
	return r;
}
/**
 * 账号密码策略
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
 * 判断是否存在该应用的导航栏
 * @param appName
 * @param deleteuuid
 * @returns
 */
function ResourceAppIsRepead(appName,deleteuuid){
	var r=executeRequest("com.hx.framework.resource.app.ResourceAppAjax","appName="+appName+"&deleteuuid="+deleteuuid);
	var root=loadXml(r);
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
	return false;
}

/**
 * 获取人员详细信息
 * deptType 类型是此的，所属组织机构，为空，则获取直属组织
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
 * 获取当前登录人详细信息
 * deptType 类型是此的，所属组织机构，为空，则获取直属组织
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
 * 获取部门详细信息
 * deptId为多个时，用逗号分隔，返回值也是个array
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
