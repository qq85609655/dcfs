<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	String path = request.getContextPath();
	Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
<title><%=data.getString(Article.TITLE) %></title>
<BZ:script isEdit="true" isDate="true"/>
<script type=text/javascript>
	//转换字号
	function doZoom(size){
		if(size==12){
			document.getElementById("contentText").style.fontSize = size + "px";
			document.getElementById("small").style.display = "";
			document.getElementById("small_span").style.color = "#999999"
			document.getElementById("middle").style.display = "none";
			document.getElementById("big").style.display = "none";
		}
		if(size==14){
			document.getElementById("contentText").style.fontSize = size + "px";
			document.getElementById("small").style.display = "none";
			document.getElementById("middle_span").style.color = "#999999"
			document.getElementById("middle").style.display = "";
			document.getElementById("big").style.display = "none";
		}
		if(size==16){
			document.getElementById("contentText").style.fontSize = size + "px";
			document.getElementById("small").style.display = "none";
			document.getElementById("big_span").style.color = "#999999"
			document.getElementById("middle").style.display = "none";
			document.getElementById("big").style.display = "";
		}
	}
</script>
</BZ:head>
<BZ:body property="data">
<table width="100%" border="0" align="center" bgcolor="#F5F5F5">
	  	<tr>
          <td height="10" bgcolor="#F5F5F5"></td>
        </tr>
        <tr>
          <td align="center" valign="bottom" bgcolor="#F5F5F5"><font color="#CB372C" size="+2"><strong><%=data.getString(Article.TITLE)!=null?data.getString(Article.TITLE):"" %></strong></font></td>
        </tr>
      </table>

	  <table width="100%" border="0" align="center">
        <tr>
          <td>
		        <table width="100%" border="0" align="center" style="color:#999999">
        <tr>
          <td align="left" valign="bottom" style="border-bottom:1px dotted #999999;color:#999999">
		 发布：<%=data.getString(Article.CREATE_TIME)!=null?data.getString(Article.CREATE_TIME):"" %> 更新：<%=data.getString(Article.MODIFY_TIME)!=null?data.getString(Article.MODIFY_TIME):"" %>	  </td>
		  <td align="right" valign="bottom" style="border-bottom:1px dotted #999999;color:#999999">
		  【内容字体：
			<span class=fontSize id="small" style="display:none">
				<a href="javascript:doZoom(16)">大</a>
				<a href="javascript:doZoom(14)">中</a>
				<span id="small_span">小</span>
			</span>
			<span class=fontSize id="middle">
				<a href="javascript:doZoom(16)">大</a>
				<span id="middle_span" style="color:#999999">中</span>
				<a href="javascript:doZoom(12)">小</a>
			</span>
			<span class=fontSize id="big" style="display:none;">
				<span id="big_span">大</span>
				<a href="javascript:doZoom(14)">中</a>
				<a href="javascript:doZoom(12)">小</a>
			</span>
		   】
		  </td>
		</tr>
      </table>
      
      <table width="100%" border="0" align="center">
        <tr align="center">
          <td align="left" valign="top">
		  	<span id="contentText" style="font-size:17px"><%=data.getString(Article.CONTENT)!=null?data.getString(Article.CONTENT):"" %></span>
		  	<br /><br />
		  	<strong>相关附件：</strong>
		  	<up:uploadList firstColWidth="20px" packageId="<%=data.getString(Article.PACKAGE_ID) %>" attTypeCode="CMS_ARTICLE_ATT" id="PACKAGE_ID" name="PACKAGE_ID"/>
        </tr>
      </table>
      
      <table width="100%" border="0" align="center">
        <tr>
          <td align="left" valign="bottom" style="border-top:1px dotted #999999;color:#999999">
		  新闻来源： <%=data.getString(Article.SOURCE)!=null?data.getString(Article.SOURCE):"" %></td>
		  <td align="right" valign="bottom" style="border-top:1px dotted #999999;color:#999999">
		  编辑者： <%=data.getString(Article.CREATOR)!=null?data.getString(Article.CREATOR):"" %>
		  </td>
        </tr>
      </table>
		  </td>
        </tr>
      </table>
</BZ:body>
</BZ:html>