<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.util.*" %>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.appnavigation.vo.MenuVo"%>
<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.common.SkinUtil"%>
<%@page import="com.hx.framework.appnavigation.vo.NavigationVo"%>
<%@page import="com.hx.framework.portal.MenuRender"%>
<%@page import="com.hx.framework.sdk.*"%>
<%@page import="com.hx.framework.sdk.OrganHelper"%>
<%@page import="hx.code.UtilCode"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>

<%
	//UserInfo user = SessionInfo.getCurUser();
	UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);
	HashMap<String,List<MenuVo>> menus=user.getMenus();
	List<NavigationVo> navs=user.getNavList();
	String menuJson=MenuRender.getInstance().render(navs, menus);
	List<MenuVo> menu=menus.get(user.getCurAppNavId());

	String secid=user.getPerson().getSecretLevel();
	if(secid==null || secid.trim().equals("")){
		secid="0";
	}
	String secName=UtilCode.getCodeName("SECURITY_LEVEL_P",secid);
	if(secName!=null && !secName.trim().equals("")){
		secName="["+secName+"]";
	}else{
		secName="";
	}
	secName="";
	String skinpath="/resources/resources1";
	String serviceAddress = "192.168.123.15";
	String flag = (String)session.getAttribute("CHANGE_PASSWORD");
%>

<%
	String homePage=request.getContextPath()+"/home.jsp";

	if(!PersonHelper.isPersonHasResource(user.getPerson().getPersonId(),"homepage")){
		if(user.getCurOrgan()!=null){
		if(user.getCurOrgan().getOrgType()==9) {//收养组织
			homePage=request.getContextPath()+"/index_syzz.jsp";
		}else{
			homePage=request.getContextPath()+"/jsp/dcfs/homePage/homePage_zx.jsp";
		}
		}else{
			homePage=request.getContextPath()+"/blank.jsp";
		}
			
		//if(user.getAdmin()!=null){
		//}else{
		//	homePage=request.getContextPath()+"/blank2.jsp";
		//}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<base target="mainFrame" />
<title>孤残儿童涉外安置信息系统</title>
<link href="<BZ:resourcePath/>/newindex/styles/base/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="<BZ:resourcePath/>/newindex/styles/base/breeze2_index.css" rel="stylesheet" type="text/css" />
<link href="<BZ:resourcePath/>/newindex/styles/base/page.css" rel="stylesheet" type="text/css" />
<link href="<BZ:resourcePath/>/newindex/styles/base/icons.css" rel="stylesheet" type="text/css" />
<link href="<BZ:resourcePath/>/newindex/styles/base/jquery-ui-1.10.3.full.min.css" rel="stylesheet" type="text/css" />
<!--[if lte IE 7]>
<style>
.content { margin-right: -1px; }
ul.nav a { zoom: 1; }
</style>
<![endif]-->
<script src="<BZ:resourcePath/>/newindex/scripts/jquery-1.9.1.min.js"></script>
<script src="<BZ:resourcePath/>/newindex/scripts/jquery-ui-1.10.3.min.js"></script>
<script src="<BZ:resourcePath/>/newindex/scripts/breeze.index.js"></script>
<script type="text/javascript">

var curAppId="<%=user.getCurAppId()%>";
var curNavId="<%=user.getCurAppNavId()%>";
var menuJson=<%=menuJson%>;
var navList=menuJson.navList;
function _changeskin(){
	var url = "<BZ:url/>/skin/Skin!getSkinFrame.action";
	var dialogWidth="320";
	var dialogHeight="220";
	window.showModalDialog(url,"","dialogWidth:" + dialogWidth + "px; dialogHeight:" + dialogHeight + "px; help:no; status:0");

}
function selfModify(){
	var url = "<BZ:url/>/person/Person!getSelf.action";
	var dialogWidth="720";
	var dialogHeight="250";
	window.showModalDialog(url,"","dialogWidth:" + dialogWidth + "px; dialogHeight:" + dialogHeight + "px; help:no; status:0");
}

function changePassword(isEn){
	
	var url = "<BZ:url/>/jsp/framework/person/password.jsp";
	if(isEn==true){
		url = "<BZ:url/>/jsp/framework/person/password_en.jsp";
	}
	
	var dialogWidth="320";
	var dialogHeight="220";
	window.showModalDialog(url,null,"dialogWidth:" + dialogWidth + "px; dialogHeight:" + dialogHeight + "px; help:no; status:0");
}

function changeNav(nav_id){
	try{
		setCurAppId(nav_id);
	}catch(e){}
	var menuList;
	//得到导航数据
	for(var i = 0; i < navList.length; i++){
		var nav = navList[i];
		if(nav_id == nav.id){
			menuList = nav.menuList;
			break;
		}
	}
	var nav = document.getElementById("nav");
	var menuStr="<li class=\"active\" ><a href=\"<%=homePage%>\"><span class=\"icon-dashboard icon\"></span><span class=\"menu-text\"> 首页  </span></a></li>";
	for(var i = 0; i < menuList.length; i++){
		var menuVo=menuList[i];
		//alert(menuVo.menu_name);
		var subMenu=new Array();
		var entry="";
		var is_module_yes = false;

		for(var j=0;j<menuList.length;j++){
			if(menuList[j].parent_id==menuVo.menu_id){
				subMenu.push(menuList[j]);
				if("1"==menuList[j].is_module_entry){
					entry=menuList[j].menu_url;
					is_module_yes = true;
				}
			}
		}

		//没有模块入口时使用菜单本身url
		if(!is_module_yes){
			entry = menuVo.menu_url;
		}

		if(entry==""){
			entry="";
		}

		if("0"==menuVo.parent_id && subMenu.length>0){ //一级菜单
			var menuI="<li>";
			menuI+="<a title=\""+menuVo.menu_name+"\" class=\"dropdown-toggle\" href=\"<BZ:url/>/"+entry+"\"><span class=\"icon-desktop icon\"></span><span class=\"menu-text\"> "+menuVo.menu_name+" </span><b class=\"arrow icon-angle-down\"></b></a>";
			if(subMenu.length>0){
				menuI+="<ul class=\"submenu\">";
				for(var j=0;j<subMenu.length;j++){
					menuI+="<li><a title=\""+subMenu[j].menu_name+"\" id='" + subMenu[j].menu_id + "' href=\"<BZ:url/>/" + subMenu[j].menu_url +"\" target=\"mainFrame\" ><span class=\"icon-double-angle-right\">&raquo;</span>" + subMenu[j].menu_name + "</a></li>";
				}
				menuI+="</ul>";
			}
			menuI+="</li>";
			menuStr+=menuI;
		}
	}
	nav.innerHTML=menuStr;
}
function logout(){
	window.top.location="<BZ:url/>/auth/logout.action";
}
</script>
</head>
<body>
	<div class="container">
		<div id="navbar" class="navbar navbar-default">
			<div id="navbar-container" class="navbar-container">
				<div id="logo" class="navbar-header pull-left">
					<a class="navbar-brand" href="javascript:void(0);"><small><span class="icon-leaf"></span><img src="<BZ:resourcePath />/newindex/styles/base/images/logo.png" alt="" /></small> </a>
				</div>
				<!-- /.navbar-header -->
				<div role="navigation" class="navbar-header pull-right">
					<ul class="nav ace-nav">
						<!--
						<li class="grey">
							<a href="javascript:void(0);" class="dropdown-toggle">
								<span class="icon-tasks"></span>
								<span class="badge badge-grey"><%=navs.size() %></span>
							</a>
							<ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header"><span class="icon-ok"></span><%=navs.size() %>个子系统</li>
								<%for(int k=0;k<navs.size();k++){ %>
									<li class=<%=(navs.get(k).getId()).equals(MenuHelper.getNavigationByAppId(user.getCurAppId()).getId())?"active":"" %>>
										<a onclick="changeNav('<%=navs.get(k).getId()%>')" href="javascript:void(0);">
											<div class="clearfix">
												<span class="pull-left"><%=navs.get(k).getNav_name() %></span>
											</div>
										</a>
									</li>
								<%} %>
							</ul>
						</li>
						<li class="light-blue"><a class="dropdown-toggle" href="javascript:void(0);" data-toggle="dropdown"> <span class="user-info">
							<div>[<%= user.getCurOrgan()==null?"":user.getCurOrgan().getcName()%>]</div><%=user.getPerson().getcName() %>
							</span></a>
							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li><a onclick="selfModify();" target="_SELF" style="cursor: pointer;">
									<span class="icon icon-user"></span> 个人资料
								</a></li>
								<li><a onclick="changePassword()" target="_SELF" href="javascript:void(0);">
									<span class="icon icon-lock"></span> 修改密码
								</a></li>
								<li><a onclick="_changeskin();" target="_SELF" href="javascript:void(0);">
									<span class="icon icon-screen"></span> 修改皮肤
								</a></li>
								<li class="divider"></li>
								<li><a onclick="logout();return false;" target="_SELF" href="javascript:void(0);">
									<span class="icon icon-off"></span> 退出登录
								</a></li>
							</ul>
						</li>
						-->
					</ul>
					<!-- div id="language">
						<ul>
							<li>英文</li>
							<li>中文</li>
						</ul>
					</div-->
					<div id="username">
						<%
						String orgName = "";
						String personName = "";
						String home = "首页";
						String logOut = "退出登录";
						String chgPsswd = "修改密码";
						String selfInfo = "个人资料";
						String isEn = "false";
						if(user.getCurOrgan()!=null){							
							if(user.getCurOrgan().getOrgType()==9) {
								orgName = user.getCurOrgan().getEnName();
								personName = user.getPerson().getEnName();
								home = "Home page";
								logOut="Log out";
								chgPsswd = "Change password";
								selfInfo = "Personal information";
								isEn = "true";
							}else{
								orgName = user.getCurOrgan().getCName();	
								personName = user.getPerson().getCName();
							}
						}
						%>
						[<%= orgName%>]<%=personName %>
					</div>
					<div id="userinfo">
						<ul>
							<li><a onclick="logout();" target="_SELF"><%= logOut%></font></li>
							<li><a onclick="changePassword(<%=isEn %>);" target="_SELF"><%= chgPsswd%></a></li>
							<li><a onclick="selfModify();" target="_SELF"><%=selfInfo %></a></li>
						</ul>
					</div>
					<!-- /.ace-nav -->
				</div>
				<!-- /.navbar-header -->
			</div>
			<!-- /.container -->
		</div>
		<div id="main-container" class="main-container">
			<div class="lt"></div>
			<div class="rt"></div>
			<div class="main-container-inner">
				<div id="sidebar" class="sidebar">
					<!--
					<div class="sidebar-shortcuts" id="sidebar-shortcuts" style="height: 41px;">
					</div>
					-->
					<ul id="nav" class="nav nav-list">
						<!--
						<li class="active"><a class="front-menu" href="<%=homePage%>">
							<span class="icon-dashboard icon"></span>
							<span class="menu-text">首页 </span>
						</a></li>
						-->
						<%
						if(menu != null && menu.size() > 0){
							String cname = user.getPerson().getcName();
							for(int i = 0; i < menu.size(); i++){
								MenuVo menuVo = (MenuVo)menu.get(i);
								List<MenuVo> subMenu=new ArrayList<MenuVo>();
								String entry=null;
								boolean childMenuModuleYes = false; //子菜单是否有模块入口

								for(int j=0;j<menu.size();j++){
									if(menu.get(j).getParent_id().equals(menuVo.getMenu_id())){
										subMenu.add(menu.get(j));
										if(Constants.IS_MODULE_ENTRY_YES.equals(menu.get(j).getIs_module_entry())){
											entry=menu.get(j).getMenu_url();
											childMenuModuleYes = true;
										}
									}
								}

								//没有模块入口即触发顶级模块的url
								if(!childMenuModuleYes){
									entry = menuVo.getMenu_url();
								}

								if(entry==null || entry.trim().equals("")){
									entry="#";//building.html
								}
								if("0".equals(menuVo.getParent_id()) && (subMenu.size()>0)){//一级菜单
						%>
						<li><a title="<%=menuVo.getMenu_name() %>" id="<%=menuVo.getMenu_id() %>" href="<BZ:url/>/<%=entry %>" class="dropdown-toggle">
								<span class="icon-desktop icon"></span>
								<span class="menu-text"> <%=menuVo.getMenu_name() %> </span>
								<b class="arrow icon-angle-down"></b>
							</a>
							<% if(subMenu.size()>0){//二级菜单  %>
							<ul class="submenu">
								<%
								for(int k=0;k<subMenu.size();k++){
									String url=subMenu.get(k).getMenu_url();
									String urlPrefix=user.getNavUrlPrefix(subMenu.get(k).getMenu_id());
									String target="_blank";
									if(!"2".equals(subMenu.get(k).getMenu_type())){
										if(urlPrefix!=null){
											url=urlPrefix+"/"+url;
										}else{
											url=request.getContextPath()+"/"+url;
										}
										target="mainFrame";
									}
								%>
								<li><a title="<%=subMenu.get(k).getMenu_name() %>" href="<%=url %>" target="<%=target %>" id="<%=subMenu.get(k).getMenu_id() %>">
									<span class="icon-double-angle-right"></span> <%=subMenu.get(k).getMenu_name() %>
								</a></li>
								<%} %>
							</ul>
							<% } %>
						</li>
						<% 		} %>
						<% 	} %>
						<% } %>
					</ul>
					<div class="sidebar-collapse" id="sidebar-collapse">
						<span class="icon-double-angle icon-double-angle-left"></span>
					</div>
				</div>
				<div id="main-content">
					<div class="breadcrumbs" id="breadcrumbs">
						<ul class="breadcrumb">
							<li class="home-icon"><a href="<%=homePage%>"><%=home %></a></li>
						</ul>
					</div>
					<div class="page-content">
						<%-- <iframe class="mainFrame" marginheight="0" marginwidth="0" frameborder="0" style="width: 100%; overflow: hidden;"
							src="<%=homePage%>" id="mainFrame" name="mainFrame"></iframe> --%>
						<iframe class="mainFrame" marginheight="0" marginwidth="0" frameborder="0" style="width: 100%;height:800px"
							src="<%=homePage%>" id="mainFrame" name="mainFrame"></iframe>
					</div>
				</div>
				<!-- end .content -->
			</div>
		</div>
	</div>
	<!-- end .container -->
</body>
</html>
