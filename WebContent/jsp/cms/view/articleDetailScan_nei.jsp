<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.util.*" %>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.appnavigation.vo.MenuVo"%>
<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.common.SkinUtil"%>
<%@page import="com.hx.framework.appnavigation.vo.NavigationVo"%>
<%@page import="com.hx.framework.portal.MenuRender"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/cms" prefix="cms" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up"%>
<%
	String path = request.getContextPath();
	String skinpath=SkinUtil.getSkinPath(path);
	Data data = (Data)request.getAttribute("data");
	//UserInfo user = SessionInfo.getCurUser();
	UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);
	HashMap<String,List<MenuVo>> menus=user.getMenus();
	List<NavigationVo> navs=user.getNavList();
	String menuJson=MenuRender.getInstance().render(navs, menus);
	List<MenuVo> menu=menus.get(user.getCurAppNavId());
	
	//标题
	String title = data.getString(Article.TITLE,"");
	if(title != null && !"".equals(title)){
		title = title.replaceAll("\n","<br/>");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<BZ:head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title><%=title %></title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<link href="<BZ:resourcePath/>/style/cms_content.css" type="text/css" rel="stylesheet" />
<!--圆角JS start-->
<script type="text/JavaScript" src="<BZ:resourcePath/>/main/js/curvycorners.src.js"></script>
<!--圆角JS end-->
<up:uploadResource/>
<style media=print type="text/css">   
   .noprint{display:none}   
</style>
<script type="text/javascript">
function doZoom(o,exp){
	var big = document.getElementById("font_big");
	var medium = document.getElementById("font_medium");
	var smaller = document.getElementById("font_smaller");
	big.className="font_set";
	medium.className="font_set";
	smaller.className="font_set";
	o.className="font_set_sel";
	var context = document.getElementById("contentText");
	
	context.className="view_"+exp; 
}
</script>
</BZ:head>
<body>
<div class="mainC">
	<!--top start-->
    <div class="cont_t"><a href="#" onclick="window.close();">关闭本页</a></div>
    <div class="cont_m"><img src="<BZ:resourcePath/>/main/images/banner_xx.jpg" /></div>
    <!--top end-->
    <!--content start-->
    <div class="cont_f">
    	<p class="cont_mj"><%=data.getString("SECURITY_LEVEL_DESC","") %></p>
    	<p class="cont_f_t" ><%=title %></p>
        <div class="cont_f_m">
        	<div class="left">新闻来源：<%=data.getString(Article.SOURCE,"") %> &nbsp;&nbsp;发布时间：<%=data.getString(Article.CREATE_TIME,"") %> <!-- 更新时间：<cms:artModifyTime/>--></div>
            <div class="font_right">【内容字体：
				<font class="font_set" id="font_big" onclick="doZoom(this,'big');">大</font>
				<font class="font_set_sel" id="font_medium" onclick="doZoom(this,'medium');">中</font>
				<font class="font_set" id="font_smaller" onclick="doZoom(this,'smaller');">小</font>
		   】</div>
        </div>
        <div class="cont_f_f">
        	<span id="contentText" class="view_medium"><%=data.getString(Article.CONTENT,"") %></span>
        <P>
        	<strong id="artAtt">相关附件：</strong>
		  	<up:uploadList firstColWidth="20px" packageId="<%=data!=null?data.getString(Article.PACKAGE_ID):null %>" attTypeCode="CMS_ARTICLE_ATT" id="ART_ATT" name="ART_ATT"/>
        
        </P>
        </div>
        <div class="cont_f_fB">
        	<div class="left">责任编辑：<%=data.getString(Article.CREATOR,"") %></div>
            <div class="clr"></div>
        </div>
    </div>
    <!--content end-->
    <!--footerB start-->
     <BZ:taildetail/>
    <!--footerB end-->
</div>

<!-- 判断是否有相关附件 -->
<script type="text/javascript">
	var len = document.getElementById("infoTable"+"ART_ATT").rows.length;
	if(len > 0){
		document.getElementById("artAtt").style.display = "block";
	}else{
		document.getElementById("artAtt").style.display = "none";
	}
	var creator = document.getElementById("creator").innerHTML.length;
	if(creator>1)
	{
	    document.getElementById("zrbj").style.display="block"
	}else{
	     document.getElementById("zrbj").style.display="none"
	}
	
	var auditTime = document.getElementById("auditTime").innerHTML.length;
	if(auditTime>1)
	{
	    document.getElementById("shsj").style.display="block"
	}else{
	     document.getElementById("shsj").style.display="none"
	}
	
</script>
</body>
</html>