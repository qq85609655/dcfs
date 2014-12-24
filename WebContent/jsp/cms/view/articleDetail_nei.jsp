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
<!--Բ��JS start-->
<script type="text/JavaScript" src="<BZ:resourcePath/>/main/js/curvycorners.src.js"></script>
<!--Բ��JS end-->
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

<!-- CMS�����ͳ�ƿ�ʼ -->
<script type="text/javascript">
	var path = "<%=path %>/";
</script>
<script type="text/javascript" src="<BZ:resourcePath />/js/ajax.js"></script>
<script src="<BZ:resourcePath />/js/framework.js" type="text/javascript"></script>
<!-- CMS�����ͳ�ƽ��� -->

<script type="text/javascript">
	function printArt(){
		var rs = getStr("org.jsh.law.AjaxPrintLog",'TITLE=<%=data.getString(Article.TITLE,"") %>&ACT_MODULE=CMS����&SEC_LEVEL=<%=data.getInt(Article.SECURITY_LEVEL) %>&ACT=��ӡ');
		window.print();
	}
</script>

<!-- ͼƬ��� -->
<script src="<BZ:resourcePath />/js/breezeCommon.js" type="text/javascript"></script>

</head>
<body onload="initImages();clickcount('<%=data!=null?data.getString(Article.ID):null %>','<%=data!=null?data.getString(Article.CHANNEL_ID):null %>','<%=data!=null?data.getString(Article.TITLE):null %>');">

<div class="mainC">
	<!--top start-->
    <div class="cont_t"><a href="#" onclick="window.close();">�رձ�ҳ</a></div>
    <div class="cont_m"><img src="<BZ:resourcePath/>/main/images/banner_xx.jpg" /></div>
    <!--top end-->
    <!--content start-->
    <div class="cont_f">
    	<p class="cont_mj"><cms:artSecurityInfo periodCodeName="SECURITY_XX" securityLevelCodeName="SECURITY_LEVEL"/></p>
    	<p class="cont_f_t" ><cms:artTitle /></p>
        <div class="cont_f_m">
        	<div class="left">������Դ����<cms:artSource/>�� &nbsp;&nbsp;����ʱ�䣺��<cms:artCreateTime dateFormat="yyyy-MM-dd"/>�� <!-- ����ʱ�䣺<cms:artModifyTime/>--></div>
            <div class="font_right">���������壺
				<font class="font_set" id="font_big" onclick="doZoom(this,'big');">��</font>
				<font class="font_set_sel" id="font_medium" onclick="doZoom(this,'medium');">��</font>
				<font class="font_set" id="font_smaller" onclick="doZoom(this,'smaller');">С</font>
		   ��</div>
        </div>
        <div class="cont_f_f">
        	<span id="contentText" class="view_medium"><cms:artContent/></span>
        <P>
        	<strong id="artAtt">��ظ�����</strong>
		  	<up:uploadList firstColWidth="20px" packageId="<%=data!=null?data.getString(Article.PACKAGE_ID):null %>" attTypeCode="CMS_ARTICLE_ATT" id="ART_ATT" name="ART_ATT"/>
        
        </P>
        </div>
        <div class="cont_f_fB">
        	<div class="left">���α༭�� <cms:artCreator/></div>
            <div class="clr"></div>
        </div>
    </div>
    <!--content end-->
    <!--footerB start-->
     <BZ:taildetail/>
    <!--footerB end-->
</div>

<!-- �ж��Ƿ�����ظ��� -->
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