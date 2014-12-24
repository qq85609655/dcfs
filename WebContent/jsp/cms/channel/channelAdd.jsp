<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
%>
<BZ:html>
<BZ:head>
<title>添加页面</title>
<up:uploadResource/>
<BZ:script isEdit="true" isDate="true"/>
<link type="text/css" rel="stylesheet" href="<BZ:url/>/resource/style/base/form.css"/>
<script>
$(document).ready(function(){
	dyniframesize([ 'mainFrame','mainFrame' ]);
});
	function tijiao()
	{
	var name = document.getElementById("Channel_NAME").value.trim();
	if(name==""){
		alert("栏目名称不能为空，请填写！");
		return;
	}
	
	document.srcForm.action=path+"channel/Channel!add.action";
 	document.srcForm.submit();
	}
	function _back(){
	var ID = document.getElementById("PARENT_ID").value;
 	document.srcForm.action=path+"channel/Channel!queryChildren.action?PARENT_ID="+ID;
 	document.srcForm.submit();
	}
	
	function _changeOptionItems(value){
		if(value == '3'){
			document.getElementById("urlLink").style.display = "block";
			document.getElementById("linkTarget").style.display = "block";
		}else{
			document.getElementById("urlLink").style.display = "none";
			document.getElementById("linkTarget").style.display = "none";
		}
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<div class="heading">添加栏目</div>
<!-- 栏目ID -->
<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(Channel.PARENT_ID) %>"/>
<table class="contenttable">
<tr height="30px">
<td width="8%">
	<font style="vertical-align: middle;" color="red">*</font>
	栏目名称
</td>
<td width="20%"><BZ:input field="NAME" prefix="Channel_" id="Channel_NAME" type="String" defaultValue=""/></td>
<td width="8%">是否审核</td>
<td width="20%">
	<input type="radio" name="Channel_IS_AUTH" value="1" checked="checked">是
	<input type="radio" name="Channel_IS_AUTH" value="2">否
</td>
<!-- 
<td width="8%">栏目类型</td>
<td width="20%">
	<BZ:select field="TYPE_ID" prefix="Channel_" isCode="true" codeName="channelTypeList" formTitle="" className="rs-edit-select" />
</td>
 -->
<td width="5%"></td>
</tr>

<!-- 
<tr>
<td width="5%"></td>
<td width="10%">栏目模板</td>
<td width="20%">
	<BZ:select field="CHANNEL_TPL_ID" formTitle="" prefix="Channel_">
		<BZ:option value="1" selected="true">无</BZ:option>
	</BZ:select>
</td>
<td width="10%">文章模板</td>
<td width="20%">
	<BZ:select field="ARTICLE_TPL_ID" formTitle="" prefix="Channel_">
		<BZ:option value="1" selected="true">无</BZ:option>
	</BZ:select>
</td>
<td width="5%"></td>
</tr>
 
<tr height="30px">
<td></td>
<td>数据库表名称</td>
<td><BZ:input field="DB_TABLE_NAME" prefix="Channel_" defaultValue=""/></td>
<td>排序号</td>
<td><BZ:input field="SEQ_NUM" prefix="Channel_" defaultValue=""/></td>
<td></td>
</tr>
-->

<tr height="30px">
<td>排序号</td>
<td><BZ:input field="SEQ_NUM" prefix="Channel_" defaultValue=""/></td>
<td colspan="3"></td>
</tr>

<!-- 
<tr>
<td width="5%"></td>
<td width="10%">访问控制</td>
<td width="20%">
	<BZ:select field="VISIT_CONTROL" formTitle="" prefix="Channel_">
		<BZ:option value="1" selected="true">开放浏览</BZ:option>
		<BZ:option value="0">普通会员</BZ:option>
	</BZ:select>
</td>
<td width="10%">是否显示</td>
<td width="20%">
	<BZ:select field="IS_VISIBLE" formTitle="" prefix="Channel_">
		<BZ:option value="1" selected="true">是</BZ:option>
		<BZ:option value="0">否</BZ:option>
	</BZ:select>
</td>
<td width="5%"></td>
</tr>
 -->
	<!-- 
 
<tr>
<td></td>
<td>栏目样式</td>
<td colspan="4">
	<BZ:input field="CHANNEL_STYLE" prefix="Channel_" type="String" size="77%" defaultValue=""/>
	<BZ:select field="CHANNEL_STYLE" prefix="Channel_" formTitle="" onchange="_changeOptionItems(this.value);" className="rs-edit-select">
		<BZ:option value="1">普通栏目</BZ:option>
		<%-- <BZ:option value="2">虚拟栏目</BZ:option>
		<BZ:option value="3">外部链接</BZ:option> --%>
	</BZ:select>
</td>
</tr>
	 -->

<tr id="urlLink" style="display: none">
<td></td>
<td>外部链接</td>
<td colspan="4"><BZ:input field="URL_LINK" prefix="Channel_" type="String" size="77%" defaultValue=""/></td>
</tr>

<tr id="linkTarget" style="display: none">
<td></td>
<td>外部链接目标</td>
<td>
	<BZ:select field="LINK_TARGET" prefix="Channel_" formTitle="" width="150px">
		<BZ:option value="_blank">新窗口【_blank】</BZ:option>
		<BZ:option value="_self">当前窗口【_self】</BZ:option>
		<BZ:option value="_parent">父窗口【_parent】</BZ:option>
		<BZ:option value="_top">整个窗口【_top】</BZ:option>
		<BZ:option value="_frame">框架窗口【_frame】</BZ:option>
	</BZ:select>
</td>
<td>外部链接类型</td>
<td>
	<BZ:select field="URL_LINK_TYPE" prefix="Channel_" formTitle="" width="150px">
		<BZ:option value="1">系统内部链接</BZ:option>
		<BZ:option value="2">系统外部链接</BZ:option>
	</BZ:select>
</td>
<td></td>
</tr>

<%-- <tr>
<td></td>
<td>附件图标</td>
<td colspan="4">
	<up:uploadBody 
		attTypeCode="ATT_CHANNEL_ICON" 
		id="ATT_CHANNEL_ICON" 
		name="Channel_CHANNEL_ICON" 
		packageId=""
		queueStyle="border: solid 1px #CCCCCC;width:280px"
		selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:280px;"
		/>
</td>
</tr> --%>

<tr>
<td>说明</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="Channel_MEMO"></textarea></td>
</tr>

</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="reset" value="重置" class="button_reset" />&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>