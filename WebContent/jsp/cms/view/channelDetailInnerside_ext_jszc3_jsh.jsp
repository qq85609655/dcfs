<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="org.jsh.template.vo.Tpl"%>
<%@page import="org.jsh.template.vo.CommTplType"%>
<%@page import="org.jsh.template.vo.TplType"%>
<%@page import="com.hx.upload.sdk.AttHelper"%>
<%@ taglib prefix="cms" uri="/WEB-INF/taglib/cms"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up"%>
<%
	String path = request.getContextPath();
	Data parent = (Data)request.getAttribute("parent");
	Data currentChannel = (Data)request.getAttribute("currentChannel");
	DataList commTplTypeList = (DataList)request.getAttribute("commTplTypeList");
	DataList tplTypeList = (DataList)request.getAttribute("tplTypeList");
	String target = (String)request.getAttribute("target");
	
	DataList channelList = (DataList)request.getAttribute("channelList"); //CMS栏目
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<cms:html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=GBK" /> 
<title></title> 
<meta name="description" content="" /> 
<meta name="keywords" content="" /> 
<cms:script />
<link href="<BZ:resourcePath/>/nw/css/npage.css" type="text/css" rel="stylesheet" />
<!--圆角JS start--> 
<script type="text/JavaScript" src="<BZ:resourcePath />/main/js/curvycorners.src.js"></script> 
<!--圆角JS end--> 

<script type="text/JavaScript">
	<!--技术支持-->
	window.onload = function(){
		var target = "<%=target%>";
		if(target == "cymb"){
			document.getElementById("currentLocation").innerHTML = "常用模板报告库";
			document.getElementById("main_channel").style.display = "none";
			document.getElementById("main_channel2").style.display = "block";
			//为0嵌入到后台，为-1搜索全部
			//document.getElementById("mainFrame_channel").src = "<BZ:url/>/tpl/CommTplType!query.action?<%=Tpl.MODULE_TYPE_ID%>=0";
			document.getElementById("mainFrame_channel").src = "<BZ:url/>/tpl/CommTplType!query.action?<%=Tpl.MODULE_TYPE_ID%>=-1";
			//处理菜单
			var div = document.getElementById("m_cymb");
			div.className="fblod_sel";
		}
		
		if(target == "wdmb"){
			document.getElementById("currentLocation").innerHTML = "我的模板";
			document.getElementById("main_channel").style.display = "none";
			document.getElementById("main_channel2").style.display = "block";
			document.getElementById("mainFrame_channel").src = "<BZ:url/>/tpl/Tpl!query.action?<%=Tpl.TYPE_ID%>=0";
			var div = document.getElementById("m_wdmb");
			div.className="fblod_sel";
		}
		_loadMenuStyle();
	};

	function _getMyTpl(){
		var str = document.getElementById("myTpl").style.display;
		if(str=="none"){
			document.getElementById("myTpl").style.display="block";
		}else{
			document.getElementById("myTpl").style.display="none";
		}
	}
	
	function _getofenDoTpl(){
		var str = document.getElementById("ofenDoTpl").style.display;
		if(str=="none"){
			document.getElementById("ofenDoTpl").style.display="block";
		}else{
			document.getElementById("ofenDoTpl").style.display="none";
		}
	}

	function _go(curNode){
		document.getElementById("currentLocation").innerHTML = curNode;
		document.getElementById("main_channel").style.display = "none";
		document.getElementById("main_channel2").style.display = "block";
	}
	
	function back(){
		document.getElementById("main_channel").style.display = "block";
		document.getElementById("main_channel2").style.display = "none";
	}
</script>

<!-- 二级页栏目树形结构开始 -->
<script language="javascript" type="text/javascript">
function w(vd,o)
{
	_removeMenuStyle(o);
  var ob=document.getElementById(vd);
  if(ob.style.display=="block" || ob.style.display=="")
  {
     ob.style.display="none";
     //var ob2=document.getElementById('s'+vd);
     //ob2.style.backgroundImage="url(images/npic_1.jpg)";
  }
  else
  {
	  o.className="fblod_sel";
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
function _selMe(o){
	_clearMenuStyle("sanji","o");
	o.className="sanji";
}
function _removeMenuStyle(o){
	var divs = document.getElementsByTagName("DIV");
	for(var i=0;i<divs.length;i++){
		if(divs[i].className=="fblod_sel"){
			divs[i].className="fblod";
		}
		if(o!=divs[i]){
			var cid = divs[i].getAttribute("cid");
			if(cid!=null){
				var c = document.getElementById(cid);
				if(c!=null){
					c.style.display="none";
				}
			}
		}
	}
}
function _loadMenuStyle(){
	var dh = document.getElementById("daohang");
	var u = document.location;
	var menus = dh.getElementsByTagName("A");
	var len = menus.length;
	for(var i=0;i<len;i++){
		var menu = menus[i];
		if(menu.tagName=="A"){
			var url = menu.href;
			if (u==url){
				var div = menu.parentNode;
				if (div.tagName=="DIV"){
					if(div.className=="fblod"){
						div.className="fblod_sel";
						break;
					}
					if (div.className=="o"){
						_clearMenuStyle("sanji","o");
						div.className="sanji";
						var ps = div.parentNode;
						if (ps.tagName=="DIV"){
							if(ps.className=="ps"){
								ps.style.display="block";
								var id = ps.id;
								var ddd = dh.getElementsByTagName("DIV");
								for(var j=0;j<ddd.length;j++){
									var cid = ddd[j].getAttribute("cid");
									if (cid==id){
										ddd[j].className="fblod_sel";
										break;
									}
								}
								break;
							}
						}
					}
					
				}
			}
		}
	}
}
function _clearMenuStyle(c,n){
	var dh = document.getElementById("daohang");
	var ddd = dh.getElementsByTagName("DIV");
	for(var j=0;j<ddd.length;j++){
		var d = ddd[j];
		if(d.className==c){
			d.className=n;
		}
	}
}
function _clickMenu(o){
	var a = o.getElementsByTagName("A");
	if(a!=null && a.length>0){
		a[0].click();
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
	document.searchForm.action = "<BZ:url/>/article/FullTextNei.action";
	document.searchForm.submit();
	document.searchForm.target = "_self";
}
</script>
<!-- 全文检索结束 -->

<!-- 下载点击统计开始 -->
<script type="text/javascript" src="<BZ:resourcePath />/main/js/jquery.js"></script>
<script type="text/javascript">
function downNum(id){
	$.ajax({
		type: "post",
		url: "<%=path%>/article/Article!statDownNum.action?ID="+id,
		data: "time=" + new Date().valueOf(),
		success:function(){}
	});
}
</script>
<!-- 下载点击统计结束 -->
</head> 
<body style="margin: 0"> 
<div class="bodybg">
	<!--search start--> 
	<div class="header">
	<form id="searchForm" name="searchForm" action="<BZ:url/>/article/FullTextNei.action" method="post">
		    <div class="hdbot">
		            	<div class="hdbotL">
		                	<input type="text" name="CONTENT" id ="CONTENT" value="请输入关键字" class="left" />
		                    <select name="SEARCH_TYPE" class="left">
					        	<option value="1" selected="selected">全文检索</option>
					        	<option value="2">标题</option>
					        </select>
		                    <select name="CHANNEL_ID" class="left">
		                    	<option title="所有栏目" value="0">所有栏目</option>
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
										            				if(second.getString(Channel.ID).equals(third.getString(Channel.PARENT_ID)) && !"ea8c8775-204c-4da2-bc25-69d919cd7b77,fb7b0d8f-acaa-4f50-be8a-ab08631fbb1c".contains(third.getString(Channel.PARENT_ID))){
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
		                    <a onclick="submitSearchForm();" style="cursor: pointer;"><img src="<BZ:resourcePath/>/nw/images/button_3.jpg" alt="" class="left" /></a>
		                </div>
		                <div class="hdbotR">当前位置：<a href="#">首页</a>&nbsp;&gt;&nbsp;<font id="currentLocation"><%=currentChannel!=null?currentChannel.getString(Channel.NAME):"" %></font></div>
		     </div>
		     </form>
	</div>
	<!--search end--> 
	<div class="main"> 
    <!--part1 start--> 
      
	    <div class="mainL">
             <div class="mainLt">
             	<div class="mainLtT">导航</div>
                 <div class="mainB_Lt" id="daohang" style="float:left;">
                     <div><img src="<BZ:resourcePath/>/nw/images/part_bg4.gif" /></div>  
                      <!-- 特殊：常用软件下载开始 -->
		                <cms:channelList channelId="<%=parent.getString(Channel.ID) %>" forData="channel" orderName="SEQ_NUM" orderType="ASC" noStat="263ad245-643d-4b19-85e4-bb92a6278553;e42a11c0-ca76-4175-bfbe-b55062151dee">
		                <%
		                	Data channel = (Data) pageContext.findAttribute("channel");
		                	
		                	if("cfd13847-1069-4773-b44b-bf8ac6e681a2".equals(channel.getString(Channel.ID))){
		                	
		            		String childNum = channel.getString(Channel.CHILD_NUM);
		            		int cNum = 0;
		            		if(childNum != null && !"".equals(childNum)){
		            			cNum = Integer.valueOf(childNum);
		            		}
		            		//大于零表示有子栏目
		            		if(cNum > 0){
		            	%>
		            	<div class="fblod"  cid="<%=channel.getString(Channel.ID) %>" onclick="_clickMenu(this);w('<%=channel.getString(Channel.ID) %>',this)" title="<cms:channelTitle/>"><cms:channelTitle titleLength="10"/></div>
		            	<div class="ps" id="<%=channel.getString(Channel.ID) %>" style='display:block;'>
		                	<cms:channelList channelId="<%=channel.getString(Channel.ID) %>" orderName="SEQ_NUM" orderType="ASC" forData="childChannel">
		                	<%
		                		Data child = (Data) pageContext.findAttribute("childChannel");
		                		String cNum_ = child.getString(Channel.CHILD_NUM);
			            		int cn = 0;
			            		if(cNum_ != null && !"".equals(cNum_)){
			            			cn = Integer.valueOf(cNum_);
			            		}
			            		//大于零表示有子栏目
			            		if(cn > 0){
		                	%>
		                    <div class="f" onclick="k('<%=child.getString(Channel.ID) %>')"><cms:channelTitle titleLength="8" link="true" href="channel/Channel!channelDetailInnersideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_jszc3" %>' target="_self"/></div>
		                    <div class="ps bgnone" id="<%=child.getString(Channel.ID) %>">
		                    	<cms:channelList channelId="<%=child.getString(Channel.ID) %>" orderName="SEQ_NUM" orderType="ASC">
		                        <div class="o">
		                        	<cms:channelTitle titleLength="8" link="true" href="channel/Channel!channelDetailInnersideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_jszc3" %>' target="_self"/>
		                        </div>
		                        </cms:channelList>
		                    </div>
		                    <%
		                    	}else{
		                    %>
		                    <div class="o">
		                    	<cms:channelTitle titleLength="8" link="true" href="channel/Channel!channelDetailInnersideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_jszc3" %>' target="_self"/>
		                    </div>
		                    <%
		                    	}
		                    %>
		                    </cms:channelList>
		                </div>
		            	<%
		            		}else{
		            	%>
		            	<div class="fblod" onclick="_clickMenu(this);">
		            		<cms:channelTitle titleLength="10" link="true" href="channel/Channel!channelDetailInnersideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_jszc3" %>' target="_self"/>
		            	</div>
		            	<%
		            			}
		            		}
		            	%>
		                </cms:channelList>
                      <!-- 特殊：常用软件下载结束 -->
                     	
                     
		               <!-- 栏目循环开始 -->
		                <cms:channelList channelId="<%=parent.getString(Channel.ID) %>" forData="channel" orderName="SEQ_NUM" orderType="ASC" noStat="263ad245-643d-4b19-85e4-bb92a6278553;e42a11c0-ca76-4175-bfbe-b55062151dee">
		                <%
		                	Data channel2 = (Data) pageContext.findAttribute("channel");
		                	
		                	if(!"cfd13847-1069-4773-b44b-bf8ac6e681a2".equals(channel2.getString(Channel.ID))){
		                	
		            		String childNum = channel2.getString(Channel.CHILD_NUM);
		            		int cNum = 0;
		            		if(childNum != null && !"".equals(childNum)){
		            			cNum = Integer.valueOf(childNum);
		            		}
		            		//大于零表示有子栏目
		            		if(cNum > 0){
		            	%>
		            	<div class="fblod" cid="<%=channel2.getString(Channel.ID) %>" onclick="_clickMenu(this);w('<%=channel2.getString(Channel.ID) %>',this)" title="<cms:channelTitle/>"><cms:channelTitle titleLength="10"/></div>
		            	<div class="ps" id="<%=channel2.getString(Channel.ID) %>" style='display:none;'>
		                	<cms:channelList channelId="<%=channel2.getString(Channel.ID) %>" orderName="SEQ_NUM" orderType="ASC" forData="childChannel">
		                	<%
		                		Data child = (Data) pageContext.findAttribute("childChannel");
		                		String cNum_ = child.getString(Channel.CHILD_NUM);
			            		int cn = 0;
			            		if(cNum_ != null && !"".equals(cNum_)){
			            			cn = Integer.valueOf(cNum_);
			            		}
			            		//大于零表示有子栏目
			            		if(cn > 0){
		                	%>
		                    <div class="f" onclick="k('<%=child.getString(Channel.ID) %>')"><cms:channelTitle titleLength="8" link="true" href="channel/Channel!channelDetailInnersideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_jszc2" %>' target="_self"/></div>
		                    <div class="ps bgnone" id="<%=child.getString(Channel.ID) %>">
		                    	<cms:channelList channelId="<%=child.getString(Channel.ID) %>" orderName="SEQ_NUM" orderType="ASC">
		                        <div class="o">
		                        	<cms:channelTitle titleLength="8" link="true" href="channel/Channel!channelDetailInnersideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_jszc2" %>' target="_self"/>
		                        </div>
		                        </cms:channelList>
		                    </div>
		                    <%
		                    	}else{
		                    %>
		                    <div class="o">
		                    	<cms:channelTitle titleLength="8" link="true" href="channel/Channel!channelDetailInnersideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_jszc2" %>' target="_self"/>
		                    </div>
		                    <%
		                    	}
		                    %>
		                    </cms:channelList>
		                </div>
		            	<%
		            		}else{
		            	%>
		            	<div class="fblod" onclick="_clickMenu(this);">
		            		<cms:channelTitle titleLength="10" link="true" href="channel/Channel!channelDetailInnersideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_jszc2" %>' target="_self"/>
		            	</div>
		            	<%
		            			}
		            		}
		            	%>
		                </cms:channelList>
                	 <!-- 栏目循环结束 -->
                	 <!-- 模板库开始 -->
				<div class="fblod" id="m_cymb" cid="ofenDoTpl" onclick="_clickMenu(this);w('ofenDoTpl',this)">常用报告模板库</div>
                	 	<%
                	    	if(commTplTypeList.size()>0){
                	    %>
	                	
	                	<div class="ps"  style='display:none;' id="ofenDoTpl">
	                	<%
	                			for(int i=0;i<commTplTypeList.size();i++){
	                	    		Data commTplType = commTplTypeList.getData(i);
	                	%>
				            <div class="o" onclick="_selMe(this);">
				            	<a href="<BZ:url/>/tpl/CommTplType!query.action?MODULE_TYPE_ID=<%=commTplType.getString(CommTplType.ID) %>" style="text-decoration: none" target="mainFrame_channel" onclick="_go('<%=commTplType.getString(CommTplType.NAME) %>');"><%=commTplType.getString(CommTplType.NAME) %></a>
				            </div>
			            <%
			            		}
			            %>
		                </div>
                        <%
                        	}
                        %>
	                	<div class="fblod" cid="myTpl" id="m_wdmb" onclick="_clickMenu(this);w('myTpl',this)" >我的模板</div>
	                	<div class="ps"  style='display:none;' id="myTpl">
	                		<div class="o" onclick="_selMe(this);">
	                			<a href="<BZ:url/>/tpl/TplType!queryChildren.action?<%=TplType.PARENT_ID%>=0" style="text-decoration: none" target="mainFrame_channel" onclick="_go('我的分类维护');">我的分类维护</a>
		                	</div>
		                	<div class="o" onclick="_selMe(this);">
		                		<a href="<BZ:url/>/tpl/Tpl!myRecommendQuery.action" style="text-decoration: none" target="mainFrame_channel" onclick="_go('我的推荐');">我的推荐</a>
		                	</div>
	                	<%
	                		if(tplTypeList.size()>0){
	                			for(int j=0;j<tplTypeList.size();j++){
	            					Data tplType = tplTypeList.getData(j);
	                	%>
			            	<div class="o" onclick="_selMe(this);">
			            		<a href="<BZ:url/>/tpl/Tpl!query.action?TYPE_ID=<%=tplType.getString(CommTplType.ID) %>" style="text-decoration: none" target="mainFrame_channel" onclick="_go('<%=tplType.getString(CommTplType.NAME) %>');"><%=tplType.getString(CommTplType.NAME) %></a>
			                </div>
			            <%
			            		}
			            	}
			           	%>
			            <!-- 模板库结束 -->
			            </div>
                     <div><img src="<BZ:resourcePath/>/nw/images/part_bg6.gif" /></div>
                 </div>
             </div>
	    </div>
        <div class="mainR" id="main_channel">
	            <div> 
	               <table width="100%" height="33" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td style="width:52px">
								<img src="<BZ:resourcePath/>/nw/images/menu_01.jpg" width="52" height="33" alt=""></td>
							<td style="background-image: url('<BZ:resourcePath/>/nw/images/menu_03.jpg')" nowrap class="mainRbt">
								<%=currentChannel.getString(Channel.NAME) %></td>
							<td style="width:58px">
								<img src="<BZ:resourcePath/>/nw/images/menu_05.jpg" width="58" height="33" alt=""></td>
							<td style="background-image: url('<BZ:resourcePath/>/nw/images/menu_07.jpg');width:100%"></td>
							<td style="width:14px">
								<img src="<BZ:resourcePath/>/nw/images/menu_09.jpg" width="14" height="33" alt=""></td>
						</tr>
					</table>
	            </div> 
	            <div class="mainB_Rf">
	             <cms:form id="channelList" action="channel/Channel!channelDetailInnersideExt.action">
            	<div class="list_sd"> 
					<input name="ID" type="hidden" value="<%=currentChannel.getString(Channel.ID) %>"/>
					<input name="PARENT_ID" type="hidden" value="<%=parent.getString(Channel.ID) %>"/>
<input name="sign" type="hidden" value="ext_jszc3"/>
                    <ul> 
                    <cms:infoList channelId="<%=currentChannel.getString(Channel.ID) %>" type="page" forData="art" orderName="SEQ_NUM;CREATE_TIME" orderType="ASC;DESC">
					<%
						Data article = (Data)pageContext.findAttribute("art");
						int i = article.getInt("i");
						if("a43cd452-f7ed-448c-830d-b847c224d687".equals(article.getString(Article.CHANNEL_ID)) && i == 0){
					%>
					<li>
                    	<h1 class="radius1">
                    		<a href="http://43.1.160.1:6868" target="_blank" title='金山毒霸'>
								金山毒霸
							</a>
                    	</h1>
                    	<div class="list_sdF">
                        	<div class="list_sdFL">
                            	<table border="0" cellspacing="0" cellpadding="0" width="100%" height="65">
                            		<tr>
                                    	<td align="center" valign="top"><a href='http://43.1.160.1:6868' target="_blank"><img width="36px" height="36px" src='<BZ:url/>/userfiles/images/jinshanduba.jpg'/></a></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="list_sdFM">
                            	<p>金山毒霸在线安装程序</p>
                            </div>
                            <div class="list_sdFR">
                            	
                                <a href="http://43.1.160.1:6868" target="_blank"><img src="<BZ:resourcePath />/nw/images/sd_btn2.gif" /></a>
                            </div>
                            <div class="clr"></div>
                        </div>
                    </li>
					<%
						}
					%>
	                <li>
                    	<h1 class="radius1">
                    		<table width="100%" boder="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="left"><a href="<BZ:url/>/article/Article!detailArt.action?ID=<%=article.getString(Article.ID) %>" target="_blank" title='<cms:infoTitle />'>
								<cms:infoTop src='<%=path + "/jsp/cms/images/top.gif" %>' width="15px" height="9px"/>
								<cms:infoTitle/>
								<cms:artSecurityInfo left="[" right="]" periodCodeName="SECURITY_XX" securityLevelCodeName="SECURITY_LEVEL"/>
							</a></td>
						<td align="right" style="padding-right:6px">下载次数: <%=article.getInt(Article.DOWN_NUM)%>次</td>
					</tr>
				</table>
                    	</h1>
                    	<div class="list_sdF">
                        	<div class="list_sdFL">
                            	<table border="0" cellspacing="0" cellpadding="0" width="100%" height="65">
                            		<tr>
                                    	<td align="center" valign="top"><a href='<up:attDownload packageId="<%=article.getString(Article.PACKAGE_ID) %>"/>' onclick="downNum('<%=article.getString(Article.ID) %>');"><img width="36px" height="36px" src='<cms:infoAttIcon attTypeCode="CMS_ARTICLE_ATT_ICON"/>'/></a></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="list_sdFM">
                            	<p><cms:infoSummary filter="false"/></p>
                            </div>
                            <div class="list_sdFR">
                            	<%
                            		boolean isHas = AttHelper.hasAttsByPackageId(article.getString(Article.ATT_DESC));
                            		if(isHas){
                            	%>
                            	<a href='<up:attDownload packageId="<%=article.getString(Article.ATT_DESC) %>"/>'><img src="<BZ:resourcePath />/main/images/sd_btn1.gif" /></a>
                            	<%
                            		}
                            	%>
                                <a href='<up:attDownload packageId="<%=article.getString(Article.PACKAGE_ID) %>"/>' onclick="downNum('<%=article.getString(Article.ID) %>');"><img src="<BZ:resourcePath />/nw/images/sd_btn2.gif" /></a>
                            </div>
                            <div class="clr"></div>
                        </div>
                    </li>
					</cms:infoList>
                    </ul> 
                    <div class="clr"></div> 
                </div> 
                <!-- page start--> 
                <cms:infoPage formId="channelList" channelId="<%=currentChannel.getString(Channel.ID) %>">
                <div class="page">
                	共&nbsp;<cms:totalSize/>条&nbsp;
                    <a style="cursor: pointer;" onclick="<cms:pageHead/>">首页</a> 
                    <a style="cursor: pointer;" onclick="<cms:pagePrevious/>">上一页</a>
                    <a style="cursor: pointer;" onclick="<cms:pageNext/>">下一页</a>
                    <a style="cursor: pointer;" onclick="<cms:pageTail/>">尾页</a>
                    &nbsp;转到第<input type="text" id="gotoPage" value="<cms:page/>" size="3" />/<cms:pageTotal/>页
                    &nbsp;<input type="button" value="提交" onclick="_pageGoto('channelList','',document.getElementById('gotoPage').value,<cms:pageTotal/>)"/>
                </div> 
                </cms:infoPage>
              </cms:form>
               <!-- page end-->  
	             </div>
         </div>
         <div class="mainB_R" style="display: none" id="main_channel2">
        <iframe id="mainFrame_channel" name="mainFrame_channel" style="width:740px;height: 700px" frameborder="0"></iframe>
        </div>
    </div> 
    <!--part1 end--> 
    <!--footer start--> 
    <BZ:tail />
    <!--footer end--> 
</div>
</body> 
</cms:html>