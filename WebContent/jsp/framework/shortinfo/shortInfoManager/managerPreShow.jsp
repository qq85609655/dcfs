<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="com.hx.framework.shortinfo.vo.Sms_Magzine"%>
<%@page import="com.hx.framework.shortinfo.vo.Sms_ShortInfo_Manager"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="com.hx.cms.util.CmsStringUtils"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	DataList dataList = (DataList)request.getAttribute("dataList");
	DataList magzineList = (DataList)request.getAttribute("magzineList");
	Data magzine_data = dataList.getData(0);
	String title = (String)request.getAttribute("title");
	
	DataList channelList = (DataList) request.getAttribute("channelList");// CMS栏目
%> 
<BZ:html>
<BZ:head> 
<meta http-equiv="Content-Type" content="text/html; charset=GBK" /> 
<title></title> 
<meta name="description" content="" /> 
<meta name="keywords" content="" /> 
<BZ:script isAjax="true"/>
<script src="<BZ:resourcePath />/js/framework.js" type="text/javascript"></script>
<link href="<BZ:resourcePath />/main/css/wpage.css" rel="stylesheet" type="text/css" /> 
<!--圆角JS start--> 
<script type="text/JavaScript" src="<BZ:resourcePath />/main/js/curvycorners.src.js"></script> 
<!--圆角JS end--> 
<style type="text/css">


.style1 {
	border-collapse: collapse;
	border-left-style: solid;
	border-left-width: 1px;
	border-right: 1px solid #C0C0C0;
	border-top-style: solid;
	border-top-width: 1px;
	border-bottom: 1px solid #C0C0C0;
}

.style2 {
	margin-bottom: 10px;
	padding: 8px 10px;
	font-size: 120%;
	height: 1em;
	line-height: 1;
	background: #f2f6f7;
	border-bottom: 1px solid #d6dde3;
	font-weight: bold;
	text-align: right;
}
.style3 {
	font-size:18px;
	font-weight: bold;
}
.style4 {
	letter-spacing:0.2em;
	line-height:1.5em;
	font-size:16px;
	font-family: 仿宋_GB2112;
}
.style5{
	letter-spacing:1px;
	line-height:1.5em;
	font-size: 14px;
	text-indent: 2em;
}
</style>
<script>
	function _getMagzine(id){
		document.getElementById('magzin_id').value=id;
		document.srcForm.action = '<%=path%>'+"/shortInfoManager/search.action";
		document.srcForm.submit();
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
//去除前后空格
String.prototype.trim=function(){
	return this.replace(/(^\s*)|(\s*$)/g, "");
}

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
</BZ:head> 
<BZ:body onload="_loadMenuStyle();"> 
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
            <div class="search2R">当前位置：<a href="#">首页</a>&nbsp;&gt;&nbsp;<%=title %></div> 
        </div> 
        <div class="search2F">&nbsp;</div> 
    </div> 
    <!--search end--> 
    <!--part1 start--> 
    <div class="mainB"> 
    	<div class="mainB_L"> 
        	<div class="mainB_Lt" id="daohang">  
            	<div><img src="<BZ:resourcePath />/main/images/part_bg4.gif" /></div>
            	
            	<!-- 栏目循环开始 -->
            	<%
					for(int i=0;i<magzineList.size();i++){
						Data magzine = magzineList.getData(i); 
				%>
				<div class="fblod" onclick="_clickMenu(this);" title="<%=magzine.getString(Sms_Magzine.TITLE) %>">
					<a style="text-decoration: none;" href="<BZ:url/>/shortInfoManager/search.action?magzin_id=<%=magzine.getString(Sms_Magzine.ID) %>">
						<%=CmsStringUtils.subString(magzine.getString(Sms_Magzine.TITLE),10,"...") %>
					</a>
				</div>
				<%
					}
				 %>
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
            	<div class="mainB_Lm_t"><a href="#">产业数据库</a></div> 
                <div class="tab_part"> 
                	<a href="#">煤炭</a><span>|</span><a href="#">石油</a><span>|</span><a href="#">钢铁</a> 
                    <a href="#">机械</a><span>|</span><a href="#">房地产</a><span>|</span><a href="#">电力</a> 
                    <a href="#">汽车</a><span>|</span><a href="#">石化</a><span>|</span><a href="#">交通</a> 
                    <a href="#">金融</a><span>|</span><a href="#">保险</a><span>|</span><a href="#">电子</a> 
                </div> 
            </div> 
            <div class="mainB_Lm"> 
            	<div class="mainB_Lm_t"><a href="#">法律法规</a></div> 
                <div class="tab_part2"> 
                	<ul> 
                    	<li><a href="#">国资委规章规范性文件</a></li> 
                        <li><a href="#">各地国资监管制度</a></li> 
                        <li><a href="#">财税法规库</a></li> 
                        <li><a href="#">国家法规数据库</a></li> 
                    </ul> 
                </div> 
            </div> 
             -->
        </div> 
        <div class="mainB_R"> 
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td style="width:54px;">
						<img src="<%=path %>/resources/resource1/main/images/menu_01.jpg" width="54" height="33" alt=""></td>
					<td background="<%=path %>/resources/resource1/main/images/menu_03.jpg" nowrap id="part_name_div" style="color:#FFF; letter-spacing:2px; text-align:center; font-weight:bold; color:#FFF; font-size: 14px;padding-top: 4px">
						<%=title!=null?title:"" %>
						</td>
					<td>
						<img src="<%=path %>/resources/resource1/main/images/menu_05.jpg" width="44" height="33" alt=""></td>
					<td background="<%=path %>/resources/resource1/main/images/menu_07.jpg" nowrap style="width:100%"></td>
					<td>
						<img src="<%=path %>/resources/resource1/main/images/menu_09.jpg" width="21" height="33" alt=""></td>
				</tr>
			</table> 
            <div class="mainB_Rf"> 
            	<div class="list_bjtj"> 
            	<form id="srcForm" name="srcForm" action="">
				<input name="magzin_id" type="hidden" value="" id="magzin_id"/>
                <table style="width: 100%">
								                <tr>
								                    <td align="center" class="style3"><%=magzine_data.getString(Sms_Magzine.TITLE) %></td>
								                </tr>
								                <tr>
								                    <td align="center" class="style4"><%=magzine_data.getString(Sms_Magzine.ISSUE) %></td>
								                </tr>
								                <tr>
								                    <td align="center" class="style4">(<%=magzine_data.getString(Sms_Magzine.ALL_ISSUE) %>)</td>
								                </tr>
								                <tr>
								                    <td align="right" style="font-size: 16px"><br><br>(<%=magzine_data.getDate(Sms_Magzine.PUBLISH_TIME) %>)</td>
								                </tr>
								                <tr>
								                	<td><hr /></td>
								                </tr>
								                <%
								                	for(int i=0;i<dataList.size();i++){
								                		Data data = dataList.getData(i); 
								                %>
								                <tr>
								                	<td class="style5"><%=i+1 %>、<%=data.getString(Sms_ShortInfo_Manager.CONTENT) %></td>
								                </tr>
								                <tr>
								                	<td>&nbsp;</td>
								                </tr>
								                <%
								                	} 
								                %>
											</table>
                </div>     
               <!-- page end--> 
            </div> 
        </div> 
    	<div class="clr"></div> 
    </div> 
    <!--part1 end--> 
    <!--footer start--> 
    <div class="footer"> 
    	地址：北京市东城区安外大街56号 邮编：100011<br /> 
        京ICP备 2039-03 版权所有：监事会工作局（中心）<br /> 
        E-Mail：Webmaster@sp.sasac.gov.cn
    </div> 
    <!--footer end--> 
</div> 
</BZ:body> 
</BZ:html>
<script type="text/javascript">
	clickcount("shortManager","shortInfo");
</script>