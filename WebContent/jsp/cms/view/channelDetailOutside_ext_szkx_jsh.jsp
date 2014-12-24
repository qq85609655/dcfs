<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="org.jsh.law.vo.LawCode"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib prefix="cms" uri="/WEB-INF/taglib/cms"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up"%>
<%
	String path = request.getContextPath();
	Data parent = (Data)request.getAttribute("parent");
	Data currentChannel = (Data)request.getAttribute("currentChannel");
	String target = (String)request.getAttribute("target");
	
	DataList channelList = (DataList) request.getAttribute("channelList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<cms:html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=GBK" /> 
<title></title> 
<meta name="description" content="" /> 
<meta name="keywords" content="" /> 
<cms:script />
<link href="<BZ:resourcePath />/main/css/wpage.css" rel="stylesheet" type="text/css" /> 
<!--圆角JS start--> 
<script type="text/JavaScript" src="<BZ:resourcePath />/main/js/curvycorners.src.js"></script> 
<!--圆角JS end--> 

<script>
	<!--中经网菜单处理-->
	var h="750px";
	window.onload = function(){
		var target = "<%=target%>";
		var sty = document.getElementById("main_channel2").style;
		//数字快讯
		if(target == "szkx"){
			document.getElementById("currentLocation").innerHTML = "数字快讯";
			document.getElementById("main_channel2").style.display = "block";
			sty.height=h;
			document.getElementById("mainFrame_channel").src = "http://cei.56.org.cn/index/index/transformgzwnc.asp?default=1&threeblockcode=080102&blockcode=DBszkx_newdata&cedb=";
			document.getElementById("_szkx").className = "fblod_sel";
		}
		//宏观月报
		if(target == "hgyb"){
			document.getElementById("currentLocation").innerHTML = "宏观月报";
			document.getElementById("main_channel2").style.display = "block";
			sty.height=h;
			document.getElementById("mainFrame_channel").src = "http://cei.56.org.cn/index/index/transformgzwnc.asp?default=1&threeblockcode=080201&blockcode=DBhgyb_zh&cedb=1";
			document.getElementById("_hgyb").className = "fblod_sel";
		}
		//经济年鉴
		if(target == "jjnj"){
			document.getElementById("currentLocation").innerHTML = "经济年鉴";
			document.getElementById("main_channel2").style.display = "block";
			sty.height=h;
			document.getElementById("mainFrame_channel").src = "http://cei.56.org.cn/index/index/transformgzwnc.asp?default=1&threeblockcode=080502&blockcode=DBjjnj_gdp&cedb=1";
			document.getElementById("_jjnj").className = "fblod_sel";
		}
	}


	function _go(curNode){
		document.getElementById("currentLocation").innerHTML = curNode;
		document.getElementById("main_channel2").style.display = "block";
	}
	
	//选中显示样式
	function _doStyle(obj){
		var divF = document.getElementById("daohang");
		var divs = divF.getElementsByTagName("div");
		if(divs.length > 0){
			for(var i = 0; i < divs.length; i++){
				var _div = divs[i];
				if(_div.className == "fblod_sel"){
					_div.className = "fblod";
				}
			}
		}
		obj.className = "fblod_sel";
	}
	
	function back(){
		document.getElementById("main_channel2").style.display = "none";
	}
	
</script>

<!-- 二级页栏目树形结构开始 -->
<script language="javascript" type="text/javascript">
function w(vd)
{
  var ob=document.getElementById(vd);
  if(ob.style.display=="block" || ob.style.display=="")
  {
     ob.style.display="none";
     //var ob2=document.getElementById('s'+vd);
     //ob2.style.backgroundImage="url(images/npic_1.jpg)";
  }
  else
  {
    ob.style.display="block";
    //var ob2=document.getElementById('s'+vd);
    //ob2.style.backgroundImage="url(images/npic_2.jpg)";
  }
}
function k(vd)
{
  var ob=document.getElementById(vd);  
  if(ob.style.display=="block")
  {
     ob.style.display="none";
     //var ob2=document.getElementById('s'+vd);
     //ob2.style.backgroundImage="url(images/npic_1.jpg)";
  }
  else
  {
    ob.style.display="block";
    //var ob2=document.getElementById('s'+vd);
    //ob2.style.backgroundImage="url(images/npic_2.jpg)";
  }
}
</script>
<!-- 二级页栏目树形结构结束 -->

<!-- 全文检索开始 -->
<script type="text/javascript">
function submitSearchForm(){
	
	var cont = document.getElementById("CONTENT").value;
	if(cont == null || cont.length == 0 || cont.trim().length == 0){
		alert("检索内容不能为空!");
		return false;
	}

	document.searchForm.target = "frmright";
	document.searchForm.action = "<BZ:url/>/article/FullText.action";
	document.searchForm.submit();
	document.searchForm.target = "_self";
}
</script>
<!-- 全文检索结束 -->
</head> 
<body style="margin: 0"> 
<div class="main"> 
    <!--search start--> 
    <div class="search2"> 
    	<div class="search2T"> 
    		<!-- 检索开始 -->
    		<form id="searchForm" name="searchForm" action="<BZ:url/>/article/FullText.action" method="post">
            <div class="search_L search2L"> 
            	<input id="CONTENT" name="CONTENT" type="text" value="" class="text_search"/>
	        <select name="SEARCH_TYPE">
	        	<option value="1" selected="selected">全文检索</option>
	        	<option value="2">标题</option>
	        </select>
	        <!-- 所属栏目：默认所有栏目 -->
	        <select name="CHANNEL_ID">
	        	<option value="0" title="所有栏目">所有栏目</option>
	        	<%
	        		if(channelList != null){
	        			for(int i = 0; i < channelList.size(); i++){
	        			    Data data = channelList.getData(i);
	        			    if("0".equals(data.getString(Channel.PARENT_ID))){
	        			        for(int k = 0; k < channelList.size(); k++){
	        			            Data first = channelList.getData(k);
									if(data.getString(Channel.ID).equals(first.getString(Channel.PARENT_ID))){
										//第二级
										%>
										<option value="<%=first.getString(Channel.ID) %>" title="<%=first.getString(Channel.NAME) %>">&nbsp;├ <%=first.getString(Channel.NAME) %></option>
										<%
										for(int j = 0; j < channelList.size(); j++){
										    Data second = channelList.getData(j);
										    if(first.getString(Channel.ID).equals(second.getString(Channel.PARENT_ID))){
										        %>
										        <option value="<%=second.getString(Channel.ID) %>" title="<%=second.getString(Channel.NAME) %>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├ <%=second.getString(Channel.NAME) %></option>
										        <%
										        for(int m = 0; m < channelList.size(); m++){
										            Data third = channelList.getData(m);
										            //去掉不该显示的栏目下面的内容
										            if(second.getString(Channel.ID).equals(third.getString(Channel.PARENT_ID)) && !"263ad245-643d-4b19-85e4-bb92a6278553,e42a11c0-ca76-4175-bfbe-b55062151dee,e9288955-486a-4e10-8116-79f9bc23f910".contains(third.getString(Channel.PARENT_ID))){
										                //第四级
														%>
														<option value="<%=third.getString(Channel.ID) %>" title="<%=third.getString(Channel.NAME) %>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├ <%=third.getString(Channel.NAME) %></option>
														<%										                
										            }
										        }
										    }
										}
									}	        			            
	        			        }
	        			    }
	        			}
	        		}
				%>
	        </select>
        	<input type="button" value="搜 索" class="btn_search" onclick="submitSearchForm();"/>
            </div> 
            </form>
            <!-- 检索结束 -->
            <div class="search2R">当前位置：<a href="#">首页</a>&nbsp;&gt;&nbsp;<font id="currentLocation"></font></div> 
        </div> 
        <div class="search2F">&nbsp;</div> 
    </div> 
    <!--search end--> 
    <!--part1 start--> 
    <div class="mainB"> 
    	<div class="mainB_L"> 
        	<div class="mainB_Lt" id="daohang">
                <div><img src="<BZ:resourcePath />/main/images/part_bg4.gif" /></div>
                
                <div id="_szkx" class="fblod" onclick="_doStyle(this);"><a href="http://cei.56.org.cn/index/index/transformgzwnc.asp?default=1&threeblockcode=080102&blockcode=DBszkx_newdata&cedb=" style="text-decoration: none" target="mainFrame_channel" onclick="_go('数字快讯');">数字快讯</a></div>
                <div id="_hgyb" class="fblod" onclick="_doStyle(this);"><a href="http://cei.56.org.cn/index/index/transformgzwnc.asp?default=1&threeblockcode=080201&blockcode=DBhgyb_zh&cedb=1" style="text-decoration: none" target="mainFrame_channel" onclick="_go('宏观月报');">宏观月报</a></div>
                <div id="_jjnj" class="fblod" onclick="_doStyle(this);"><a href="http://cei.56.org.cn/index/index/transformgzwnc.asp?default=1&threeblockcode=080502&blockcode=DBjjnj_gdp&cedb=1" style="text-decoration: none" target="mainFrame_channel" onclick="_go('经济年鉴');">经济年鉴</a></div>
                
                <div><img src="<BZ:resourcePath />/main/images/part_bg6.gif" /></div>
            </div> 
            
        </div> 
        <div class="mainB_R" style="display: block" id="main_channel2">
        <iframe id="mainFrame_channel" name="mainFrame_channel" style="width:750px;height: 723px" frameborder="0" scrolling="no"></iframe>
        </div>
    	<div class="clr"></div> 
    </div> 
    <!--part1 end--> 
    <!--footer start--> 
    <div class="footer">
    	管理维护：监事会工作局（中心）  &nbsp;&nbsp;&nbsp;&nbsp; 电话：010-64471803/64471805<br />
          国资委监事会地址：北京市东城区安定门外大街56号(100011)<br/>
    </div>
    <!--footer end--> 
</div> 
</body>
</cms:html> 