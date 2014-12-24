<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.appnavigation.vo.MenuVo"%>
<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.common.SkinUtil"%>
<%@page import="com.hx.framework.appnavigation.vo.NavigationVo"%>
<%@page import="com.hx.framework.portal.MenuRender"%>
<%@page import="com.hx.framework.sdk.*"%>
<%@page import="com.hx.framework.sdk.OrganHelper"%>
<%@page import="hx.code.UtilCode"%>

<%
UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);

%>


<BZ:html>
<BZ:head>
<base target="_SELF"/>

<title>修改皮肤</title>
<BZ:script isEdit="true"  />
<style>
input{
	width:90%;
	border: 1px solid #6699FF;
}
</style>
<script>

function _tijiao(){
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"skin/Skin!skinModify.action";
 	document.srcForm.submit();
 	if(_check(document.srcForm)){
 		document.srcForm.submit();
 		alert("皮肤修改成功!刷新或者重新登录后生效!");
 		window.close();
 	}
}

</script>
</BZ:head>
<BZ:body codeNames="SKIN" >
<BZ:form name="srcForm" method="post"  >
<BZ:input field="ACCOUNT_ID" type="hidden"  property="data" prefix="S_" defaultValue="" />
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="kuangjia">

<div class="heading">皮肤修改</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="45%">皮肤:</td>
<td width="45%"><BZ:select field="RESOURCETYPE" formTitle="" prefix="P_" isCode="true" codeName="SKIN" property="data" /></td>
<td width="5%"></td>
</tr>
<tr>


</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0"  align="center" width="60%">
<tr>
<td><input type="button" value="保存" class="button_add" onclick="_tijiao()"/></td>
<td><input type="button" value="关闭" class="button_back" onclick="window.close()"/></td> 
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>