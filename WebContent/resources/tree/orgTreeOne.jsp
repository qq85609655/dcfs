
<%@ page contentType="text/html; charset=GBK" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	String title = (String)request.getAttribute("TITLE");
	String isParent = (String)request.getAttribute("ISPARENT");
	if(isParent==null){
		isParent="false";
	}
%>
<html>
<BZ:head>
    <title><%=title%></title>
<BZ:script tree="true"/>
<script language="JavaScript">

function _ok(){
	if(reValue["value"]==null){
		if(!isSelNode){
			alert("请选择树中叶子节点的内容！");
		}else{
			alert("请选择内容！");
		}
		
		return;
	}
	window.returnValue=reValue;
	//alert("name=" + reValue["name"] + "\nvalue=" + reValue["value"]);
	self.close();
}
function _cancel(){
  	self.close();
}
</script>
<style>
.input_on{
padding:2px 8px 0pt 3px;
height:18px;
border:1px solid #999;
background-color:#FFFFCC;
}
.input_off{
padding:2px 8px 0pt 3px;
height:18px;
border:1px solid #CCC;
background-color:#FFF;
}
.input_move{
padding:2px 8px 0pt 3px;
height:18px;
border:1px solid #999;
background-color:#FFFFCC;
}
.input_out{
/*height:16px;默认高度*/
padding:2px 8px 0pt 3px;
height:18px;
border:1px solid #CCC;
background-color:#FFF;
}
/*form*/
ul.input_test{
margin:20px auto 0 auto;
width:500px;
list-style-type:none;
}
ul.input_test li{
width:500px;
height:22px;
margin-bottom:10px;
}
.input_test label{
float:left;
padding-right:10px;
width:100px;
line-height:22px;
text-align:right;
font-size:1.4em;
}
.input_test p{
float:left;
_margin-top:-1px;
}
.input_test span{
float:left;
padding-left:10px;
line-height:22px;
text-align:left;
font-size:1.2em;
color:#999;
}
.search{
font-size: 12px;
height:16px;
border:1px solid #999;
width:95%;
background-color: #FFFFCC;
}
A.MzTreeview
{
  font-size: 12px;
  padding-left: 5px;
  color:blue;
}
</style>
</BZ:head>
<body style="margin: 5px 5px 5px 5px" scroll=no>
<input type="hidden" value="<%=isParent%>" name="showParent">
<table style="width: 100%" height="100%" cellspacing="1" class="border-collapse: collapse">
	<tr>
		<td height="12px">
		<table style="width: 100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td nowrap="nowrap" align="right" valign="bottom">
				<input name="p" type="button" value="上一条" class="button_small" style="display:none" onclick="_previous();">
					<input name="n" type="button" value="下一条" class="button_small" style="display:none" onclick="_next();">
				<input style="width:120px;height:20px" id="search"
					class="input_out" name="search" type="text"
					onkeyup="_keySearch(this);"
					onfocus="this.className='input_on';this.onmouseout=''"
					onblur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};"
					onmousemove="this.className='input_move'"
					onmouseout="this.className='input_out'" />
					<input type="button" value="搜 索" class="button_small" onclick="_search(document.getElementById('search'));">
					
			</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="center" valign="bottom" width="100%">
				<span id="searchMsg"></span></td>
			</tr>
		</table>
		<hr>
		</td>
		</tr>
	<tr>
		<td valign="top" height="100%">
		<BZ:tree/>
		</td>
	</tr>
	<tr>
		<td height="30px">
		<hr>
<span style="width:100%;text-align: right" >
<table style="width: 100%"cellspacing="0">
<tr>
<td nowrap="nowrap" align="left">
<!-- <img src="<RO:resourceUrl/>/images/tree/collapse.gif" title="全部折叠" style="cursor: hand" onclick="tree.collapseAll();"> -->
<img src="<BZ:resourcePath/>/images/tree/expand.gif" title="全部展开" style="cursor: hand" onclick="tree.expandAll();">
</td>
<td nowrap="nowrap" align="right">
<input type="button" class="button_normal" value="确定" onclick="_ok();">&nbsp;
<input type="button" value="取消" class="button_normal" onclick="_cancel();">
</td>
</tr>
</table>
</span>		</td>
	</tr>
</table>


</body>
</html>


