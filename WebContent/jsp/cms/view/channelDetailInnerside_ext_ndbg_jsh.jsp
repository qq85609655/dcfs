<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib prefix="cms" uri="/WEB-INF/taglib/cms"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up"%>
<%
	String path = request.getContextPath();
	Data parent = (Data)request.getAttribute("parent");
	Data currentChannel = (Data)request.getAttribute("currentChannel");
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
</head> 
<body style="margin: 0" onload="_loadMenuStyle();"> 
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
		                <div class="hdbotR">当前位置：<a href="#">首页</a>&nbsp;&gt;&nbsp;<%=currentChannel.getString(Channel.NAME) %></div>
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
		               <!-- 栏目循环开始 -->
		                <cms:channelList channelId="<%=parent.getString(Channel.ID) %>" forData="channel" orderName="SEQ_NUM" orderType="ASC" noStat="ea8c8775-204c-4da2-bc25-69d919cd7b77;fb7b0d8f-acaa-4f50-be8a-ab08631fbb1c">
		                <%
		                	Data channel = (Data) pageContext.findAttribute("channel");
		            		String childNum = channel.getString(Channel.CHILD_NUM);
		            		int cNum = 0;
		            		if(childNum != null && !"".equals(childNum)){
		            			cNum = Integer.valueOf(childNum);
		            		}
		            		//大于零表示有子栏目
		            		if(cNum > 0){
		            	%>
		            	<div class="fblod" cid="<%=channel.getString(Channel.ID) %>" onclick="_clickMenu(this);w('<%=channel.getString(Channel.ID) %>',this)" title="<cms:channelTitle/>"><cms:channelTitle titleLength="10"/></div>
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
		                    <div class="f" onclick="k('<%=child.getString(Channel.ID) %>')"><cms:channelTitle titleLength="8" link="true" href="channel/Channel!channelDetailInnersideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_ndbg" %>' target="_self"/></div>
		                    <div class="ps bgnone" id="<%=child.getString(Channel.ID) %>">
		                    	<cms:channelList channelId="<%=child.getString(Channel.ID) %>" orderName="SEQ_NUM" orderType="ASC">
		                        <div class="o">
		                        	<cms:channelTitle titleLength="8" link="true" href="channel/Channel!channelDetailInnersideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_ndbg" %>' target="_self"/>
		                        </div>
		                        </cms:channelList>
		                    </div>
		                    <%
		                    	}else{
		                    %>
		                    <div class="o">
		                    	<cms:channelTitle titleLength="8" link="true" href="channel/Channel!channelDetailInnersideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_ndbg" %>' target="_self"/>
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
		            		<cms:channelTitle titleLength="10" link="true" href="channel/Channel!channelDetailInnersideExt.action" params="PARENT_ID;sign" paramValues='<%=parent.getString(Channel.ID)+";ext_ndbg" %>' target="_self"/>
		            	</div>
		            	<%
		            		}
		            	%>
		                </cms:channelList>
                	 <!-- 栏目循环结束 -->
                     <div><img src="<BZ:resourcePath/>/nw/images/part_bg6.gif" /></div>
                     
		     <pre><center><a style="color:red;" href="<BZ:url/>/jsp/cms/AdobeReader/reader.exe">下载Adobe Reader阅读器</a></center>
<center>报告为PDF文件<br/>需要安装 AdobeReader来浏览</center></pre>
                 </div>
             </div>
	    </div>
        <div class="mainR">
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
	            <div class="mainRb">
	             <cms:form id="channelList" action="channel/Channel!channelDetailInnersideExt.action">
            	<div class="list_bjtj"> 
					<input name="ID" type="hidden" value="<%=currentChannel.getString(Channel.ID) %>"/>
					<input name="PARENT_ID" type="hidden" value="<%=parent.getString(Channel.ID) %>"/>
<input name="sign" type="hidden" value="ext_ndbg"/>
                    <ul> 
                    <cms:infoList channelId="<%=currentChannel.getString(Channel.ID) %>" type="page" forData="art" orderName="SEQ_NUM;CREATE_TIME" orderType="ASC;DESC">
					<%
						Data art = (Data)pageContext.findAttribute("art");

					%>
					<li><%
									if(!"6dfa8532-d069-4289-ac90-3cdbef60db26".equals(art.getString(Article.CHANNEL_ID))){
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
    </div> 
    <!--part1 end--> 
    <!--footer start--> 
    <BZ:tail />
    <!--footer end--> 
</div>
</body> 
</cms:html>