<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.jsh.law.vo.LawCode"%>
<%@page import="org.jsh.publication.vo.Publication"%>
<%@ taglib prefix="cms" uri="/WEB-INF/taglib/cms"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up"%>
<%
	String path = request.getContextPath();
	DataList dataList = (DataList)request.getAttribute("dataList");
	DataList channelList = (DataList)request.getAttribute("channelList");
	
	//搜索指定指定的内容
	String content = (String)request.getAttribute(Article.CONTENT);
	//选中的栏目
	String selectChannelId = (String)request.getAttribute(Article.CHANNEL_ID);
	//全文检索类型
	String searchType = (String)request.getAttribute(Article.SEARCH_TYPE);
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
	//清空分页page的值
	document.getElementById("channelList_page").value = 1;
	document.getElementById("channelList").target = "frmright";
	document.getElementById("channelList").action = "<BZ:url/>/article/FullTextNei.action";
	document.getElementById("channelList").submit();
	document.getElementById("channelList").target = "_self";
}
</script>
<!-- 全文检索结束 -->
</head> 
<body style="margin: 0"> 
<div class="bodybg">
	<!--search start--> 
	<cms:form id="channelList" action="article/FullTextNei.action">
	<div class="header">
		    <div class="hdbot">
		            	<div class="hdbotL">
		                	<input type="text" name="CONTENT" id="CONTENT" value='<%=content!=null?content:"请输入关键字" %>' class="left" />
		                    <select name="SEARCH_TYPE" class="left">
					        	<option value="1" <%="1".equals(searchType)?"selected='selected'":"" %>>全文检索</option>
	        	                <option value="2" <%="2".equals(searchType)?"selected='selected'":"" %>>标题</option>
					        </select>
		                    <select name="CHANNEL_ID" class="left">
		                    	 <option value="0" <%="0".equals(selectChannelId)?"selected='selected'":"" %> title="所有栏目">所有栏目</option>
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
														<option <%=selectChannelId.equals(first.getString(Channel.ID))?"selected='selected'":"" %> value="<%=first.getString(Channel.ID) %>" title="<%=first.getString(Channel.NAME) %>">&nbsp;├ <%=first.getString(Channel.NAME) %></option>
														<%
														for(int j = 0; j < channelList.size(); j++){
														    Data second = channelList.getData(j);
														    if(first.getString(Channel.ID).equals(second.getString(Channel.PARENT_ID))){
														    	//第三级
														        %>
														        <option <%=selectChannelId.equals(second.getString(Channel.ID))?"selected='selected'":"" %> value="<%=second.getString(Channel.ID) %>" title="<%=second.getString(Channel.NAME) %>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├ <%=second.getString(Channel.NAME) %></option>
														        <%
														        for(int m = 0; m < channelList.size(); m++){
														            Data third = channelList.getData(m);
														            //去掉不该显示的栏目下面的内容
										            				if(second.getString(Channel.ID).equals(third.getString(Channel.PARENT_ID)) && !"ea8c8775-204c-4da2-bc25-69d919cd7b77,fb7b0d8f-acaa-4f50-be8a-ab08631fbb1c".contains(third.getString(Channel.PARENT_ID))){
														                //第四级
																		%>
																		<option <%=selectChannelId.equals(third.getString(Channel.ID))?"selected='selected'":"" %> value="<%=third.getString(Channel.ID) %>" title="<%=third.getString(Channel.NAME) %>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├ <%=third.getString(Channel.NAME) %></option>
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
		                <div class="hdbotR">当前位置：<a href="#">首页</a>&nbsp;&gt;&nbsp;全文检索</div>
		     </div>
	</div>
	<!--search end--> 
	<div class="main"> 
    <!--part1 start--> 
      
	    <div class="mainL">
             <div class="mainLt">
             	<div class="mainLtT">导航</div>
                 <div class="mainB_Lt" style="float:left;">
                     <div><img src="<BZ:resourcePath/>/nw/images/part_bg4.gif" /></div>  
		            	<div class="fblod">
		            		全文检索
		            	</div>
                     <div><img src="<BZ:resourcePath/>/nw/images/part_bg6.gif" /></div>
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
								全文检索</td>
							<td style="width:58px">
								<img src="<BZ:resourcePath/>/nw/images/menu_05.jpg" width="58" height="33" alt=""></td>
							<td style="background-image: url('<BZ:resourcePath/>/nw/images/menu_07.jpg');width:100%"></td>
							<td style="width:14px">
								<img src="<BZ:resourcePath/>/nw/images/menu_09.jpg" width="14" height="33" alt=""></td>
						</tr>
					</table>
	            </div> 
	            <div class="mainRb">
            	<div class="list_bjtj"> 
					<ul> 
                    <!-- 
                    <cms:infoList dataList="<%=dataList %>" type="page" forData="art">
					<%
						//Data art = (Data)pageContext.findAttribute("art");
					%>
					<li>
						<cms:infoTitle titleLength="40" link="true" href="article/Article!detailArt.action"/>
						<cms:infoPublishTime dateFormat="yyyy-MM-dd"/>
					</li>
					</cms:infoList>
					 -->
					<%
						if(dataList != null && dataList.size() > 0){
							for(int i = 0; i < dataList.size(); i++){
								Data data = dataList.getData(i);
								if("CMS".equals(data.getString("TYPE"))){
					%>
					<li>
						<a target="_blank" title="<%=data.getString(Article.TITLE) %>" href="<BZ:url/>/article/Article!detailArt.action?ID=<%=data.getString(Article.ID) %>"><%=data.getString(Article.TITLE) %></a>
						<%=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(data.getString(Article.CREATE_TIME))) %>
					</li>
					<%
								}
								
								if("LAW".equals(data.getString("TYPE"))){
					%>
					<li>
						<a target="_blank" title="<%=data.getString(LawCode.TITLE) %>" href="<BZ:url/>/law/detail.action?ID=<%=data.getString(LawCode.ID) %>"><%=data.getString(LawCode.TITLE) %></a>
						<%=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(data.getString(LawCode.CREATE_TIME))) %>
					</li>
					<%
								}
								
								if("PUBLICATION".equals(data.getString("TYPE"))){
					%>
					<li>
						<a target="_blank" title="<%=data.getString(Publication.TITLE) %>" href="<BZ:url/>/publication/Publication!detailLeft.action?ID=<%=data.getString(Publication.ID) %>"><%=data.getString(Publication.TITLE) %></a>
						<%=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd").parse(data.getString(Publication.CREATE_TIME))) %>
					</li>
					<%
								}
							}
						}
					%>
                    </ul> 
                    <div class="clr"></div> 
                </div> 
                <!-- page start--> 
                <cms:infoPage formId="channelList" dataList="<%=dataList %>">
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
              
               <!-- page end-->  
	             </div>
         </div> 
    </div>
    </cms:form> 
    <!--part1 end--> 
    <!--footer start--> 
    <BZ:tail />
    <!--footer end--> 
</div>
</body> 
</cms:html>