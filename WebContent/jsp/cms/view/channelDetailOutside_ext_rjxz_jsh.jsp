<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.article.vo.Article"%>
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
	function back(){
		document.getElementById("main_channel").style.display = "block";
		document.getElementById("main_channel2").style.display = "none";
	}
	
	function reinitIframe(){
		var iframe = document.getElementById("mainFrame_channel");
		try{
			iframe.height = iframe.contentWindow.document.documentElement.scrollHeight;
		}catch (ex){}
	}
	//window.setInterval("reinitIframe()", 200);
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
function k(vd,o)
{
  _removeMenuStyle2(vd);
  var ob=document.getElementById(vd);  
  if(ob.style.display=="block")
  {
  o.className="f";
     ob.style.display="none";
     //vd.className = "o";
     //var ob2=document.getElementById('s'+vd);
     //ob2.style.backgroundImage="url(images/npic_1.jpg)";
  }
  else
  {
	o.className="o";
    ob.style.display="block";
    //var ob2=document.getElementById('s'+vd);
    //ob2.style.backgroundImage="url(images/npic_2.jpg)";
  }
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
function _removeMenuStyle2(o){
	var divs = document.getElementsByTagName("DIV");
	for(var i=0;i<divs.length;i++){
		if(divs[i].className=="sanjif"){
			divs[i].className="f";
		}
		if(o!=divs[i] && divs[i].className=="f"){
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
	var u = document.location.href;
	var menus = dh.getElementsByTagName("A");
	var len = menus.length;
	for(var i=0;i<len;i++){
		var menu = menus[i];
		if(menu.tagName=="A"){
			var url = menu.href;
			var url1 = menu.getAttribute("linkHref");
			if (u==url || u.indexOf(url1) > 0){
				_clickType(menu);
				if(u.indexOf(url1) > 0){
					menu.click();
				}
				var div = menu.parentNode;
				if (div.tagName=="DIV"){
					if(div.className=="fblod"){
						div.className="fblod_sel";
						break;
					}
					if (div.className=="o"){
						_clearMenuStyle("sanji","o");
						div.className="sanji";
						i=0;
						_recursionCheck(div,dh);
					}
					if (div.className=="f"){
						_clearMenuStyle("sanjif","f");
						div.className="sanjif";
						i=0;
						_recursionCheck(div,dh);
					}
					if (div.className=="s"){
						_clearMenuStyle("ss","s");
						div.className="ss";
						var pobj = div.parentNode;
						i=0;
						_recursionCheck(div,dh);
					}
				}
			}
		}
	}
}

//递归栏目是否选中
var i=0;
function _recursionCheck(div,dh){
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
		}else if(ps.className=="ps bgnone"){
			ps.style.display="block";
			var id = ps.id;
			var ddd = dh.getElementsByTagName("DIV");
			for(var j=0;j<ddd.length;j++){
				var cid = ddd[j].getAttribute("cid");
				if (cid==id){
					ddd[j].className="o";
					break;
				}
			}
			i++;
			if(i<10){
				_recursionCheck(ps,dh);
			}
		}else{
			i++;
			if(i<10){
				_recursionCheck(ps,dh);
			}
		}
	}else{
		i++;
		if(i<10){
			_recursionCheck(ps,dh);
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
	_removeMenuStyle(o);
	o.className="fblod_sel";
	var a = o.getElementsByTagName("A");
	if(a!=null && a.length>0){
		a[0].click();
	}
}
function _clickType(o){
	var target = o.target;
	try{
		var mid = document.getElementById("main_channel2");
		var mcn = document.getElementById("main_content");
		if (target=="_frame"){
			mid.style.display="block";
			mcn.style.display="none";
		}else{
			mid.style.display="none";
			mcn.style.display="block";
		}
	}
	catch(err){}
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
<body style="margin: 0" onload="_loadMenuStyle();"> 
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
            <div class="search2R">当前位置：<a href="#">首页</a>&nbsp;&gt;&nbsp;<%=currentChannel!=null?currentChannel.getString(Channel.NAME):"" %></div> 
        </div> 
        <div class="search2F">&nbsp;</div> 
    </div> 
    <!--search end--> 
    <!--part1 start--> 
    <div class="mainB"> 
    	<div class="mainB_L"> 
        	<div class="mainB_Lt" id="daohang">
                <div><img src="<BZ:resourcePath />/main/images/part_bg4.gif" /></div>
                		<!-- 特殊：常用软件下载开始 -->
		                <cms:channelList channelId="<%=parent.getString(Channel.ID) %>" forData="channel" orderName="SEQ_NUM" orderType="ASC" noStat="263ad245-643d-4b19-85e4-bb92a6278553;e42a11c0-ca76-4175-bfbe-b55062151dee">
		                <%
		                	Data channel = (Data) pageContext.findAttribute("channel");
		                
		                	if("a1b4d497-bc47-4cbd-83de-716867601746".equals(channel.getString(Channel.ID))){
		                
		            		String childNum = channel.getString(Channel.CHILD_NUM);
		            		int cNum = 0;
		            		if(childNum != null && !"".equals(childNum)){
		            			cNum = Integer.valueOf(childNum);
		            		}
		            		//大于零表示有子栏目
		            		if(cNum > 0){
		            	%>
		            	<div class="fblod" cid="<%=channel.getString(Channel.ID) %>" onclick="_clickMenu(this);w('<%=channel.getString(Channel.ID) %>',this)" title="<cms:channelTitle />"><cms:channelTitle titleLength="10"/></div>
		            	<div class="ps" id="<%=channel.getString(Channel.ID) %>" style='display:none;'>
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
		                    <div class="f" cid="<%=child.getString(Channel.ID) %>" onclick="k('<%=child.getString(Channel.ID) %>',this)">
		                    	<cms:channelTitle total="true" onclick="_clickType(this);" runChannelStyle="true" titleLength="8" link="true" href="channel/Channel!channelDetailOutsideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_rjxz2" %>' target="_self"/>
		                    </div>
		                    <div class="ps bgnone" id="<%=child.getString(Channel.ID) %>">
		                    	<cms:channelList channelId="<%=child.getString(Channel.ID) %>" orderName="SEQ_NUM" orderType="ASC">
		                        <div class="s">
		                        	<cms:channelTitle onclick="_clickType(this);" runChannelStyle="true" titleLength="8" link="true" href="channel/Channel!channelDetailOutsideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_rjxz2" %>' target="_self"/>
		                        </div>
		                        </cms:channelList>
		                    </div>
		                    <%
		                    	}else{
		                    %>
		                    <div class="o">
		                    	<cms:channelTitle total="true" onclick="_clickType(this);" runChannelStyle="true" titleLength="8" link="true" href="channel/Channel!channelDetailOutsideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_rjxz2" %>' target="_self"/>
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
		            		<cms:channelTitle onclick="_clickType(this);" runChannelStyle="true" titleLength="8" link="true" href="channel/Channel!channelDetailOutsideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_rjxz2" %>' target="_self"/>
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
		                	
		                	if(!"a1b4d497-bc47-4cbd-83de-716867601746".equals(channel2.getString(Channel.ID))){
		                	
		                	String childNum = channel2.getString(Channel.CHILD_NUM);
			            	int cNum = 0;
		            		if(childNum != null && !"".equals(childNum)){
		            			cNum = Integer.valueOf(childNum);
		            		}
		            		//大于零表示有子栏目
		            		if(cNum > 0){
		            	%>
		            	<div class="fblod" cid="<%=channel2.getString(Channel.ID) %>" onclick="_clickMenu(this);w('<%=channel2.getString(Channel.ID) %>',this)" title="<cms:channelTitle />"><cms:channelTitle titleLength="10"/></div>
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
		                    <div class="f" cid="<%=child.getString(Channel.ID) %>" onclick="k('<%=child.getString(Channel.ID) %>',this)">
		                    	<cms:channelTitle total="true" onclick="_clickType(this);" runChannelStyle="true" titleLength="8" link="true" href="channel/Channel!channelDetailOutsideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_rjxz" %>' target="_self"/>
		                    </div>
		                    <div class="ps bgnone" id="<%=child.getString(Channel.ID) %>">
		                    	<cms:channelList channelId="<%=child.getString(Channel.ID) %>" orderName="SEQ_NUM" orderType="ASC">
		                        <div class="S">
		                        	<cms:channelTitle onclick="_clickType(this);" runChannelStyle="true" titleLength="8" link="true" href="channel/Channel!channelDetailOutsideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_rjxz" %>' target="_self"/>
		                        </div>
		                        </cms:channelList>
		                    </div>
		                    <%
		                    	}else{
		                    %>
		                    <div class="o">
		                    	<cms:channelTitle total="true" onclick="_clickType(this);" runChannelStyle="true" titleLength="8" link="true" href="channel/Channel!channelDetailOutsideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_rjxz" %>' target="_self"/>
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
		            		<cms:channelTitle onclick="_clickType(this);" runChannelStyle="true" titleLength="10" link="true" href="channel/Channel!channelDetailOutsideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_rjxz" %>' target="_self"/>
		            	</div>
		            	<%
		            			}
		            		}
		            	%>
		                </cms:channelList>
                	 	<!-- 栏目循环结束 -->
                
                <div><img src="<BZ:resourcePath />/main/images/part_bg6.gif" /></div>
                <!-- 
                <div class="mainB_Lt_f radius1">
                	<span class="spanL_part">menu</span>
                    <span class="spanR_part"><img src="<BZ:resourcePath />/main/images/dot_7.gif" /></span>
                </div>
                -->
            </div> 
            <!-- 
            <div class="mainB_Lm"> 
            	<div class="mainB_Lm_t"><a href="http://202.106.90.12:81/" target="_blank">产业数据库</a></div> 
                <div class="tab_part"> 
                	<a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=mt" target="_blank">煤炭</a><span>|</span><a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=sy" target="_blank">石油</a><span>|</span><a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=gt" target="_blank">钢铁</a>
                    <a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=jx" target="_blank">机械</a><span>|</span><a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=fdc" target="_blank">房地产</a><span>|</span><a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=dl" target="_blank">电力</a>
                    <a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=qc" target="_blank">汽车</a><span>|</span><a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=sh" target="_blank">石化</a><span>|</span><a href="http://202.106.90.12:81/aspx/Subject.aspx?NodeURL=jt" target="_blank">交通</a>
                </div> 
            </div> 
            <div class="mainB_Lm"> 
            	<div class="mainB_Lm_t"><a href="<BZ:url/>/law/list.action?PART_ID=1" target="_self">法律法规</a></div> 
                <div class="tab_part2"> 
                	<ul> 
                    	<li><a href="<BZ:url/>/law/preGenerateTree.action?<%=LawCode.PART_ID%>=94cc08a0-19db-4a39-b38b-94ab7c1cbe83" target="_self">国资委规章规范性文件</a></li> 
                        <li><a href="<BZ:url/>/law/preGenerateTree.action?<%=LawCode.PART_ID%>=b478cd2b-52dc-4627-b368-944c0cd8e682" target="_self">各地国资监管制度</a></li> 
                        <li><a href="<BZ:url/>/law/preGenerateTree.action?<%=LawCode.PART_ID%>=6ca9aa3a-e6be-48ff-9389-59727bc96594" target="_self">财税法规库</a></li> 
                        <li><a href="<BZ:url/>/law/preGenerateTree.action?<%=LawCode.PART_ID%>=1" target="_self">国家法规数据库</a></li> 
                    </ul> 
                </div> 
            </div>
             -->
        </div> 
        <div class="mainB_R" id="main_channel">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td style="width:54px;">
						<img src="<%=path %>/resources/resource1/main/images/menu_01.jpg" width="54" height="33" alt=""></td>
					<td background="<%=path %>/resources/resource1/main/images/menu_03.jpg" nowrap id="part_name_div" style="color:#FFF; letter-spacing:2px; text-align:center; font-weight:bold; color:#FFF; font-size: 14px;padding-top: 4px">
						<%=currentChannel!=null?currentChannel.getString(Channel.NAME):"" %>
						</td>
					<td>
						<img src="<%=path %>/resources/resource1/main/images/menu_05.jpg" width="44" height="33" alt=""></td>
					<td background="<%=path %>/resources/resource1/main/images/menu_07.jpg" nowrap style="width:100%"></td>
					<td>
						<img src="<%=path %>/resources/resource1/main/images/menu_09.jpg" width="21" height="33" alt=""></td>
				</tr>
			</table> 
            <div class="mainB_Rf"> 
            <cms:form id="channelList" action="channel/Channel!channelDetailOutsideExt.action">
            	<div class="list_bjtj"> 
					<input name="ID" type="hidden" value="<%=currentChannel.getString(Channel.ID) %>"/>
					<input name="PARENT_ID" type="hidden" value="<%=parent.getString(Channel.ID) %>"/>
					<input name="sign" type="hidden" value="ext_xxzb"/>
                    <ul> 
                    <cms:infoList channelId="<%=currentChannel.getString(Channel.ID) %>" type="page" forData="art" orderName="SEQ_NUM;CREATE_TIME" orderType="ASC;DESC">
					<%
						Data art = (Data)pageContext.findAttribute("art");
					%>
					<li>		<%
									if(!"d3136df1-e0ff-403d-a732-800f5d261bde".equals(art.getString(Article.CHANNEL_ID))){
								%>
								<a href="<BZ:url/>/article/Article!detailArt.action?ID=<%=art.getString(Article.ID) %>" target="_blank" title='<cms:infoTitle />'>
									<cms:infoTop src='<%=path + "/jsp/cms/images/top.gif" %>' width="15px" height="9px"/>
									<cms:infoTitle titleLength="40" />
								</a>
								<%
									}else{
								%>
								<a href='<up:attDownload packageId="<%=art.getString(Article.PACKAGE_ID) %>"/>'>
									<cms:infoTitle titleLength="40"/>
								</a><%
									}
								%><cms:infoPublishTime dateFormat="yyyy-MM-dd"/>
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
        <!-- 
        <div class="mainB_R" style="display: none" id="main_channel2">
        <iframe id="mainFrame_channel" name="mainFrame_channel" style="width:750px;height: 700px" frameborder="0" scrolling="no"></iframe>
        </div>
         -->
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