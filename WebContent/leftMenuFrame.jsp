<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.util.*" %>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.appnavigation.vo.MenuVo"%>
<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.appnavigation.vo.NavigationVo"%>
<%@page import="com.hx.framework.portal.MenuRender"%>
<%
	String path = request.getContextPath();
	//UserInfo user = SessionInfo.getCurUser();
	UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);
	HashMap<String,List<MenuVo>> menus=user.getMenus();
	List<NavigationVo> navs=user.getNavList();
	String menuJson=MenuRender.getInstance().render(navs, menus);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Framework</title>
<link rel="stylesheet" href="<%=path %>/frame/css/common.css" type="text/css" />
<script  type="text/javascript">

var menuJson=<%=menuJson%>;
var list=menuJson.navList;
var preClassName="";

function list_sub_detail(Id,item){
	if(preClassName!=""){
		getObject(preClassName).className="left_back";
	}
	if(getObject(Id).className=="left_back"){
		getObject(Id).className="left_back_onclick";
		outlookbar.getbyitem(item);
		preClassName=Id;
	}
}

function getObject(objectId){
	if(document.getElementById&&document.getElementById(objectId)){
		return document.getElementById(objectId);
	}else if(document.all&&document.all(objectId)){
		return document.all(objectId);
	}else if(document.layers&&document.layers[objectId]){
		return document.layers[objectId];
	}else{
		return false;
	}
}

function outlook(){
	this.titlelist=new Array();
	this.itemlist=new Array();
	this.addtitle=addtitle;
	this.additem=additem;
	this.getbytitle=getbytitle;
	this.getbyitem=getbyitem;
	this.getdefaultnav=getdefaultnav;
}

function theitem(intitle,insort,inkey,inisdefault){
	this.sortname=insort;
	this.key=inkey;
	this.title=intitle;
	this.isdefault=inisdefault;
}

function addtitle(intitle,sortname,inisdefault){
	outlookbar.itemlist[outlookbar.titlelist.length]=new Array();
	outlookbar.titlelist[outlookbar.titlelist.length]=new theitem(intitle,sortname,0,inisdefault);
	return(outlookbar.titlelist.length-1);
}

function additem(intitle,parentid,inkey){
	if(parentid>=0&&parentid<=outlookbar.titlelist.length){
		insort="item_"+parentid;outlookbar.itemlist[parentid][outlookbar.itemlist[parentid].length]=new theitem(intitle,insort,inkey,0);
		return(outlookbar.itemlist[parentid].length-1);
	}else{
		additem=-1;
	}
}

function getdefaultnav(sortname){
	var output="";
	for(i=0;i<outlookbar.titlelist.length;i++){
		if(outlookbar.titlelist[i].isdefault==1&&outlookbar.titlelist[i].sortname==sortname){
			output+="<div class=list_tilte id=sub_sort_"+i+" onclick=\"hideorshow('sub_detail_"+i+"')\">";
			output+="<span>"+outlookbar.titlelist[i].title+"</span>";
			output+="</div>";
			output+="<div class=list_detail id=sub_detail_"+i+"><ul>";
			for(j=0;j<outlookbar.itemlist[i].length;j++){
				output+="<li id="+outlookbar.itemlist[i][j].sortname+j+" onclick=\"changeframe('"+outlookbar.itemlist[i][j].title+"','"+outlookbar.titlelist[i].title+"','"+outlookbar.itemlist[i][j].key+"')\"><a href=#>"+outlookbar.itemlist[i][j].title+"</a></li>";
			}

			output+="</ul></div>";
		}
	}

	getObject('right_main_nav').innerHTML=output;
}

function getbytitle(sortname){
	var output="<ul>";
	for(i=0;i<outlookbar.titlelist.length;i++){
		if(outlookbar.titlelist[i].sortname==sortname){
			output+="<li id=left_nav_"+i+" onclick=\"list_sub_detail(id,'"+outlookbar.titlelist[i].title+"')\" class=left_back>"+outlookbar.titlelist[i].title+"</li>";
		}
	}
	output+="</ul>";
	getObject('left_main_nav').innerHTML=output;
}

function getbyitem(item){
	var output="";
	for(i=0;i<outlookbar.titlelist.length;i++){
		if(outlookbar.titlelist[i].title==item){
			output="<div class=list_tilte id=sub_sort_"+i+" onclick=\"hideorshow('sub_detail_"+i+"')\">";
			output+="<span>"+outlookbar.titlelist[i].title+"</span>";
			output+="</div>";
			output+="<div class=list_detail id=sub_detail_"+i+" style='display:block;'><ul>";
			for(j=0;j<outlookbar.itemlist[i].length;j++){
				output+="<li id="+outlookbar.itemlist[i][j].sortname+"_"+j+" onclick=\"changeframe('"+outlookbar.itemlist[i][j].title+"','"+outlookbar.titlelist[i].title+"','"+outlookbar.itemlist[i][j].key+"')\"><a href=#>"+outlookbar.itemlist[i][j].title+"</a></li>";
			}
			output+="</ul></div>";
		}
	}
	getObject('right_main_nav').innerHTML=output;
}

function changeframe(item,sortname,src){
	if(item!=""&&sortname!=""){
		window.top.frames['mainFrame'].getObject('show_text').innerHTML=sortname+"&nbsp;&nbsp;<img src=images/slide.gif broder=0 />&nbsp;&nbsp;"+item;
	}
	if(src!=""){
		window.top.frames['manFrame'].location=src;
	}
}

var childMenu = new Array();
function hideorshow(){
	for(var i = 0 ; i < childMenu.length; i++){
		var div = document.getElementById("sub_detail_"+i+"");
		if(div.style.display == "block"){
			div.style.display = "none";
		}else{
			div.style.display = "block";
		}
	}
}

function clickTo(url){
	parent.manFrame.location=url;
}

function childrenMenu(nav_id, menu_id){

	var menuList;
	var curMenu;
	for(var i = 0; i < list.length; i++){
		var nav = list[i];
		if(nav_id == nav.id){
			menuList = nav.menuList;
			break;
		}
	}

	for(var i = 0; i < menuList.length; i++){
		var menu = menuList[i];
		if(menu.menu_id == menu_id){
			curMenu = menu;
			break;
		}
	}

	//循环得到curMenu的子菜单
	childMenu = new Array();
	var j = 0;
	for(var i = 0; i < menuList.length; i++){
		var menu = menuList[i];
		if(curMenu.menu_id == menu.parent_id){
			childMenu[j] = menu;
			j++;
		}
	}

	//输出到页面显示第三级菜单
	var leftNode = document.getElementById("left_main_nav");
	leftNode.innerHTML = "";
	leftNode.innerHTML = "<ul><li id='left_nav_1' onclick='list_sub_detail(ip,\"\")' class='left_back'>"+curMenu.menu_name+"</li></ul>";

	var rightNode = document.getElementById("right_main_nav");
	//先清空
	rightNode.innerHTML = "";
	var content = "";
	content = "<div class='list_tilte' id='sub_sort_1' onclick='hideorshow()'><span>"+curMenu.menu_name+"</span></div>";
	for(var i = 0 ; i < childMenu.length; i++){
		var cMenu = childMenu[i];
		content = content + "<div class='list_detail' id='sub_detail_"+i+"' style='display:block;'><ul><li><a href='JavaScript:void(0);' onclick='clickTo(\"<%=path%>/"+cMenu.menu_url+"\")'>"+cMenu.menu_name+"</a></li></ul></div>";
	}
	rightNode.innerHTML = content;
}

function logout(){
	parent.location="<%=path %>/auth/logout.action";
	//document.mform.submit();
}
</script>
</head>
<body>
<div id="left_content" >
	<form action="<%=path %>/auth/logout.action" id="mform" name="mform" method="post">
    	<div id="user_info">欢迎您，<strong><%=user.getPerson()!=null?user.getPerson().getcName():"" %></strong>
    	<br />
    	[<a href="JavaScript:void(0);" onclick="logout();">退出</a>]</div>
    </form>
	<div id="main_nav">
		<div id="left_main_nav"></div>
		<div id="right_main_nav"></div>
	</div>
</div>
</body>
</html>