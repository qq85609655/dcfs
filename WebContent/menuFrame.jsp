<%@page import="com.hx.framework.portal.MenuRender"%>
<%@page import="com.hx.framework.appnavigation.vo.NavigationVo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.appnavigation.vo.MenuVo"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.hx.framework.common.Constants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	
	//System.out.println(Thread.currentThread().getName());

	String path = request.getContextPath();
	//UserInfo user=SessionInfo.getCurUser();
	UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);
	//System.out.println(user);
	HashMap<String,List<MenuVo>> menus=user.getMenus();
	List<NavigationVo> navs=user.getNavList();
	List<MenuVo> menu=menus.get(user.getCurAppNavId());
	String menuJson=MenuRender.getInstance().render(navs, menus);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="<%=path %>/frame/css/common.css" type="text/css" />
<title>导航</title>
<script type="text/javascript">
var menuJson=<%=menuJson%>;
var list=menuJson.navList;
var preClassName = "man_nav_1";
function list_sub_nav(id,menu_id){
   var childNode = document.getElementById("sub_info");
   childNode.innerHTML="";
   var content = "&nbsp;&nbsp;|&nbsp;";
   <%
   		if(menu != null && menu.size() > 0){
   			for(int i = 0 ; i < menu.size(); i ++){
   			    MenuVo menuVo = (MenuVo)menu.get(i);
   %>
   				if(menu_id == '<%=menuVo.getParent_id() %>'){
   					content = content + "<span id='show_text'><a href='javascript:void(0);' onclick='childrenMenu(\"<%=menuVo.getNav_id() %>\",\"<%=menuVo.getMenu_id() %>\")' target='manFrame'><%=menuVo.getMenu_name() %></a></span>&nbsp;|&nbsp;";
   	   	   		}
   <%
   	   		}
   		}
   %>
   childNode.innerHTML = content;
}

function showInnerText(Id){
	var showText = "对不起没有信息！";
	switch(switchId){
	    case 1:
		   showText =  "";
		   break;
	    case 2:
		   showText =  "system setting!";
		   break;
	    case 3:
		   showText =  "User Manage";
		   break;		   
	    case 4:
		   showText =  "Chanage Manage";
		   break;	
	    case 5:
		   showText =  "Ad AND news!";
		   break;		   		   
	}
}
 //获取对象属性兼容方法
 function getObject(objectId) {
    if(document.getElementById && document.getElementById(objectId)) {
	// W3C DOM
	return document.getElementById(objectId);
    } else if (document.all && document.all(objectId)) {
	// MSIE 4 DOM
	return document.all(objectId);
    } else if (document.layers && document.layers[objectId]) {
	// NN 4 DOM.. note: this won't find nested layers
	return document.layers[objectId];
    } else {
	return false;
    }
}

function childrenMenu(nav_id, menu_id){
	var menuList;
	for(var i = 0; i < list.length; i++){
		var nav = list[i];
		if(nav_id == nav.id){
			menuList = nav.menuList;
			break;
		}
	}

	for(var i = 0; i < menuList.length; i++){
		var menu = menuList[i];
		if(menu.menu_id != menu_id){
			continue;
		}

		//判断是否是模块,是模块没有url 
		if(menu.is_left== '1'){//     is_module_entry 
			//传递到左边frame
			parent.leftFrame.childrenMenu(nav_id, menu_id);
			//显示左边栏
			if(parent.myFrame.cols != "199,7,*"){
				parent.myFrame.cols="199,7,*";
				parent.midFrame.document.getElementById("ImgArrow").src="<%=path %>/frame/images/switch_left.gif";
			}
			//本地跳转
			parent.manFrame.location="<%=path%>/"+menu.menu_url;
			//清空左边框内容
			//parent.leftFrame.document.getElementById("left_main_nav").innerHTML="";
			//parent.leftFrame.document.getElementById("right_main_nav").innerHTML="";
			//隐藏左边栏
			if(parent.myFrame.cols!="0,7,*"){
				parent.myFrame.cols="0,7,*"
				parent.midFrame.document.getElementById("ImgArrow").src="<%=path %>/frame/images/switch_right.gif";
			}
		}else{
			//本地跳转
			parent.manFrame.location="<%=path%>/"+menu.menu_url;
			//清空左边框内容
			parent.leftFrame.document.getElementById("left_main_nav").innerHTML="";
			parent.leftFrame.document.getElementById("right_main_nav").innerHTML="";
			//隐藏左边栏
			if(parent.myFrame.cols!="0,7,*"){
				parent.myFrame.cols="0,7,*"
				parent.midFrame.document.getElementById("ImgArrow").src="<%=path %>/frame/images/switch_right.gif";
			}
		}
	}
}

function mOver(obj){
	obj.className="bg_image_on";
}

function mOut(obj){
	var style = obj.className;
	if(style == "bg_image_on"){
		obj.className="bg_image_back";
	}
}

function mDown(id,obj){
	var node = document.getElementById(id);
	var div = document.getElementsByTagName("li");
	for(var i = 0; i < div.length; i++){
		if(div[i].id.substring(0,3) == "man"){
			div[i].className = "bg_image_back";
		}
	}
	obj.className = "bg_image_out";
}
</script>
</head>
<body>
<div id="nav">
    <ul>
    <%
    	if(menu != null && menu.size() > 0){
    	    for(int i = 0; i < menu.size(); i++){
    	        MenuVo menuVo = (MenuVo)menu.get(i);
    	        if("0".equals(menuVo.getParent_id())){
    	            
   	%>
   				<li id="man_nav_<%=(i+1) %>" onmousedown='mDown("main_nav_<%=(i+1) %>",this)' onmouseover="mOver(this)" onmouseout="mOut(this)" onclick="list_sub_nav('man_nav_<%=(i+1) %>','<%=menuVo.getMenu_id() %>')"  class="bg_image"><%=menuVo.getMenu_name() %></li>
   	<%
    	        }
    	    }
    	}
    %>
    </ul>
</div>
<div id="sub_info">
&nbsp;&nbsp;|&nbsp;
<%
	if(menu != null && menu.size() > 0){
	    MenuVo menuVo = (MenuVo)menu.get(0);
	    for(int i = 0 ; i < menu.size(); i++){
	        MenuVo child = (MenuVo)menu.get(i);
	      	/*不是模块入口，才是菜单*/
	        if(child.getParent_id().equals(menuVo.getMenu_id())){
%>
			<span id="show_text"><a href="javascript:void(0);" onclick="childrenMenu('<%=child.getNav_id() %>','<%=child.getMenu_id() %>');" target="manFrame"><%=child.getMenu_name() %></a></span>
			&nbsp;
			|
			&nbsp;
<%
	        }
	    }
	}
%>
</div>

</body>
</html>
