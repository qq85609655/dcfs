<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.shortinfo.vo.Sms_ShortInfo_Manager"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
 %>
<BZ:html>
<BZ:head>
	<title>分类树</title>
	<BZ:script isList="true" tree="true" isDate="true"/>
	<script type="text/javascript">
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		//处理
		parent.mainFrame.location = "<%=request.getContextPath() %>/shortInfoManager/list.action?<%=Sms_ShortInfo_Manager.MAGZINE_ID %>="+id;
	}	
	</script>
<link href="<%=path %>/resources/resource1/style/style.css" rel="stylesheet" type="text/css" />
</BZ:head>
<body style="margin: 0px; background-color: #F0F2F7">
<table>
	<tr>
	<td id="hiddenTd" valign="top">
	<BZ:form name="srcForm" method="post" action="law/generateTree.action">
		<!-- 修改组织机构的标志位 -->
		<input type="hidden" name="treeDispatcher" value="partTree" />
		<div class="heading">选择期号标题</div>
		<!-- 组织机构树形 -->
		<table style="width: 100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td nowrap="nowrap" align="left" valign="bottom">
				<input style="width:120px;height:20px" id="search"
					class="input_out" name="search" type="text"
					onkeyup="_keySearch(this);"
					onfocus="this.className='input_on';this.onmouseout=''"
					onblur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};"
					onmousemove="this.className='input_move'"
					onmouseout="this.className='input_out'" />
					<input type="button" value="定 位" class="button_small" onclick="_search(document.getElementById('search'));">
			</td>
			</tr>
			<tr>
				<td nowrap="nowrap" align="left" valign="bottom" width="100%">
				<span id="searchMsg"></span><input name="p" type="button" value="上一条" class="button_small" style="display:none" onclick="_previous();">
				<input name="n" type="button" value="下一条" class="button_small" style="display:none" onclick="_next();"></td>
			</tr>
		</table>
		<table width="100%">
			<tr>
				<td width="100%"><BZ:tree property="dataList" type="0"/></td>
			</tr>
		</table>
	</BZ:form>
	</tr>
</table>
</body>
</BZ:html>