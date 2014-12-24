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
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<cms:html>
<cms:infoShow infoId="<%=data!=null?data.getString(Article.ID):null %>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title><cms:artTitle /></title>
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

<!-- CMS点击、统计开始 -->
<script type="text/javascript">
	var path = "<%=path %>/";
</script>
<script type="text/javascript" src="<BZ:resourcePath />/js/ajax.js"></script>
<script src="<BZ:resourcePath />/js/framework.js" type="text/javascript"></script>
<!-- CMS点击、统计结束 -->

<!-- 图片点击 -->
<script src="<BZ:resourcePath />/js/breezeCommon.js" type="text/javascript"></script>

</head>
<body onload="initImages();clickcount('<%=data!=null?data.getString(Article.ID):null %>','<%=data!=null?data.getString(Article.CHANNEL_ID):null %>','<%=data!=null?data.getString(Article.TITLE):null %>');">

<div class="mainC">
	<!--top start-->
    <div class="cont_t"><a href="#" onclick="window.close();">关闭本页</a></div>
    <%-- <div class="cont_m"><img src="<BZ:resourcePath/>/main/images/cont_2.jpg" /></div> --%>
    <!--top end-->
    <!--content start-->
    <div class="cont_f">
    	<p class="cont_f_t" ><cms:artTitle /></p>
        <div class="cont_f_m">
        	<div class="left"><%-- 新闻来源：【<cms:artSource/>】 &nbsp;&nbsp; --%>
        	发布时间：【<cms:artCreateTime dateFormat="yyyy-MM-dd"/>】 <!-- 更新时间：<cms:artModifyTime/>-->
            	【内容字体：
				<font class="font_set" id="font_big" onclick="doZoom(this,'big');">大</font>
				<font class="font_set_sel" id="font_medium" onclick="doZoom(this,'medium');">中</font>
				<font class="font_set" id="font_smaller" onclick="doZoom(this,'smaller');">小</font>
		   		】
		   </div>
        </div>
        <div class="cont_f_f">
        	<span id="contentText" class="view_medium"><cms:artContent/></span>
        <P>
        	<strong id="artAtt">相关附件：</strong>
		  	<up:uploadList firstColWidth="20px" packageId="<%=data!=null?data.getString(Article.PACKAGE_ID):null %>" attTypeCode="CMS_ARTICLE_ATT" id="ART_ATT" name="ART_ATT"/>
        
        </P>
        </div>
        <div class="cont_f_fB">
        	<div class="left">责任编辑： <cms:artCreator/><!-- 审核通过日期（<cms:artAuditPassTime dateFormat="yyyy-MM-dd HH:mm:ss"/>） --></div>
            <div class="font_right"><span><a href="#" onclick="window.print()">打印本页</a></span></div>
            <div class="clr"></div>
        </div>
    </div>
    <!--content end-->
    <!--footerB start-->
    <!-- 
    <div class="footerB">
    	<div class="left">联系电话 ：010-64471805   64471305 　 Email：Webmaster@sp.sasac.gov.cn </div>
        <div class="right">管理维护：国资委监事会工作技术研究中心</div>
    </div>
     -->
    <div class="footer">
    	管理维护：监事会工作局（中心）  &nbsp;&nbsp;&nbsp;&nbsp; 电话：010-64471803/64471805<br />
          国资委监事会地址：北京市东城区安定门外大街56号(100011)<br/>
    </div>
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
	
</script>
</body>
</cms:infoShow>
</cms:html>