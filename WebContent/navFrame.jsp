<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.hx.framework.common.Constants" %>
<%@ page import="com.hx.framework.authenticate.*" %>
<%@ page import="com.hx.framework.appnavigation.vo.*" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	String path = request.getContextPath();
	UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);
	List<NavigationVo> navs=user.getNavList();
%>

<BZ:html>
<BZ:head>
<title>Framework</title>
<link rel="stylesheet" href="<%=path %>/frame/css/common.css" type="text/css" />
<BZ:script isList="true"/>	
<script src="<BZ:resourcePath/>/js/ajax.js"></script>
<script src="<BZ:resourcePath/>/js/breezeCommon.js"></script>
<script src="<BZ:resourcePath/>/js/framework.js"></script>
<script type="text/javascript">
//var path="http://localhost/<%=path%>";

function changePassword(){
	var url = "<BZ:url/>/jsp/framework/person/password.jsp";
	var dialogWidth="320";
	var dialogHeight="220";
	window.showModalDialog(url,null,"dialogWidth:" + dialogWidth + "px; dialogHeight:" + dialogHeight + "px; help:no; status:0");
}
<%
String flag = (String)session.getAttribute("CHANGE_PASSWORD");
if (user.isDefaultPwd() && flag==null){
	session.setAttribute("CHANGE_PASSWORD","1");
%>
alert("您没有修改初始密码，请马上修改密码。");
changePassword();
<%
}
%>
function eyou(){
	var ll=getEYouUrl();
	//alert(ll);
	window.open(ll);
}
function goYQ(){
	var ll=getSSOToken();
	alert(ll);
	window.open("http://172.16.22.96:8181/cemisup/login/login.jspx?TOKEN="+ll);
	//window.top.location="http://192.16.22.96:8181/cemisup/login/login.jspx?TOKEN="+ll;
}

</script>

</BZ:head>
<BZ:body>
<div class="header_content">
     <div class="logo">
     	<!-- <img src="<%=path %>/frame/images/man_logo.jpg" alt="后台管理" /> -->
     </div>
	 <div class="right_nav">
		<div class="text_right">
		<ul class="nav_return">
			<li>
				<input type=button name="test" value="中央企业综合管理系统" onclick="goYQ();"/>
				<input type=button name="test" value="eyou单点登录测试" onclick="eyou();"/>
				<input type=button name="test" value="修改密码" onclick="changePassword();"/>
				<img src="<%=path %>/frame/images/return.gif" width="13" height="21" />
				&nbsp;返回 [ 
				<%
					if(navs != null && navs.size() > 0){
					    for(int i = 0; i < navs.size(); i++){
					        NavigationVo navigationVo = (NavigationVo)navs.get(i);
					        if(i != (navs.size() - 1)){
				%>
								<a href="#"><%=navigationVo.getNav_name() %></a> | 
				<%
					        }else{
				%>
								<a href="#"><%=navigationVo.getNav_name() %></a> ]
				<%
					        }
					    }
					}
				%>
			</li>
		</ul>
		</div>
	 </div>
</div>
</BZ:body>
</BZ:html>