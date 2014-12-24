<%@page import="com.hx.upload.datasource.vo.Data"%>
<%@page import="com.hx.upload.datasource.vo.DataList"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.upload.datasource.DiskpathManager"%>
<%@page import="com.hx.upload.datasource.DatasourceManager"%>
<%@page import="com.hx.upload.vo.AttType"%>
<%
	String path = request.getContextPath();
	DataList dataList = (DataList)request.getAttribute("dataList");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>附件类型管理</title>
<link rel="stylesheet" type="text/css" href="<%=path %>/uploadComponent/admin/skin/css/base.css">
<script type="text/javascript" src="<%=path %>/uploadComponent/admin/js/public.js"></script>
<script language="javascript">


//获得选中文件的文件名
function getCheckboxItem()
{
	var allSel="";
	if(document.form2.id.value) return document.form2.id.value;
	for(i=0;i<document.form2.id.length;i++)
	{
		if(document.form2.id[i].checked)
		{
			if(allSel=="")
				allSel=document.form2.id[i].value;
			else
				allSel=allSel+"`"+document.form2.id[i].value;
		}
	}
	return allSel;
}

//获得选中其中一个的id
function getOneItem()
{
	var allSel="";
	if(document.form2.id.value) return document.form2.id.value;
	for(i=0;i<document.form2.id.length;i++)
	{
		if(document.form2.id[i].checked)
		{
				allSel = document.form2.id[i].value;
				break;
		}
	}
	return allSel;
}
</script>
</head>
<body leftmargin="8" topmargin="8" background='<%=path %>/uploadComponent/admin/skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
<tr>
 <td height="26" background="<%=path %>/uploadComponent/admin/skin/images/newlinebg3.gif">
  <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td align="right">
    <input type='button' class="coolbg np" onClick="add_att_type_dialog('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>')" value='添加附件类型' />
    <input type='button' class="coolbg np" onClick="opra_datasource_dialog('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>')" value='数据源管理' />
    <input type='button' class='coolbg np' onClick="opra_disk_path_dialog('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>')" value='磁盘路径管理' />
    <input type='button' class='coolbg np' onClick="rebuildTable('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>')" value='重建数据库表' />
    <input type='button' class='coolbg np' onClick="flashDownload('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>')" value='Flash插件下载' />
 </td>
 </tr>
</table>
</td>
</tr>
</table>
  
<!--  内容列表   -->
<form name="form2">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="14" background="<%=path %>/uploadComponent/admin/skin/images/tbg.gif">&nbsp;附件类型列表&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22">
	<td>序号</td>
	<td>序号</td>
	<td>类型名称</td>
	<td>附件类型代码</td>
	<td>存储类型</td>
	<td>附件大小</td>
	<td>附件模式</td>
	<td>附件格式</td>
	<td>磁盘路径</td>
	<td>分类周期</td>
	<td>附件表名</td>
	<!-- 
	<td>模块名称</td>
	<td>应用名称</td>
	 -->
	<td>操作</td>
</tr>

<%
	if(dataList != null && dataList.size() > 0){
		for(int i = 0 ; i < dataList.size(); i++){
			Data data = dataList.getData(i);
%>

<tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#E7E7E7';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22" >
	<td><input name="id" type="checkbox" id="id" value="<%=data.getString(AttType.CODE) %>" class="np"></td>
	<td><%=i+1 %></td>
	<td><%=data.getString(AttType.ATT_TYPE_NAME) %></td>
	<td><%=data.getString(AttType.CODE) %></td>
	<td><%=1 == data.getInt(AttType.STORE_TYPE)?"磁盘":"数据库"%></td>
	<td><%=data.getInt(AttType.ATT_SIZE) %>MB</td>
	<td><%=1 == data.getInt(AttType.ATT_MORE)?"单附件":"多附件" %></td>
	<td><%=data.getString(AttType.ATT_FORMAT) %></td>
	<td>
		<%
			if(1 == data.getInt(AttType.STORE_TYPE)){
		%>
		<%=DiskpathManager.getDiskPath() + data.getString(AttType.ENTITY_NAME) + "/" %>
		<%
			}
		%>
	</td>
	<td>
		<%
			/* if(1 == data.getInt(AttType.STORE_TYPE)){
				if(1 == data.getInt(AttType.FILE_SORT_WEEK)){
					out.println("按日");
				}
				if(2 == data.getInt(AttType.FILE_SORT_WEEK)){
					out.println("按月");
				}
				if(3 == data.getInt(AttType.FILE_SORT_WEEK)){
					out.println("按年");
				}
			} */
		%>
		<%=data.getString(AttType.FILE_SORT_WEEK) %>
	</td>
	<td><%=data.getString(AttType.ENTITY_NAME) %></td>
	<!-- 
	<td><%-- <%=data.getString(AttType.MOD_NAME,"") %> --%></td>
	<td><%-- <%=data.getString(AttType.APP_NAME,"") %> --%></td>
	 -->
	<td>
		<a href="JavaScript:void(0);" style="text-decoration: none;" onclick="mod_att_type_dialog('<%=path %>','<%=data.getString(AttType.CODE) %>','<%=DatasourceManager.getRequestPrefix() %>');">修改</a>
	 | 
	 	<a href="JavaScript:void(0);" style="text-decoration: none;" onclick="del_att_type('<%=path %>','<%=data.getString(AttType.CODE) %>','<%=DatasourceManager.getRequestPrefix() %>');">删除</a>
	</td>
</tr>

<%
		}
	}else{
%>
<tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22" >
	<td colspan="14" style="color: red;font-weight: bold;">无附件类型信息；如果与实际不相符合，请查看数据源管理的设置！</td>
</tr>
<%
	}
%>
<!-- 屏蔽 
<tr bgcolor="#FAFAF1">
<td height="28" colspan="14">
	&nbsp;
	<a href="javascript:selAll()" class="coolbg">全选</a>
	<a href="javascript:noSelAll()" class="coolbg">取消</a>
	<a href="javascript:void(0);" onclick="deleteBatch('<%=request.getContextPath() %>','<%=DatasourceManager.getRequestPrefix() %>')" class="coolbg">&nbsp;全部删除&nbsp;</a>
	<a href="javascript:updateArc(0)" class="coolbg">&nbsp;更新&nbsp;</a>
	<a href="javascript:checkArc(0)" class="coolbg">&nbsp;审核&nbsp;</a>
	<a href="javascript:adArc(0)" class="coolbg">&nbsp;推荐&nbsp;</a>
	<a href="javascript:moveArc(0)" class="coolbg">&nbsp;移动&nbsp;</a>
</td>
</tr>
-->

<!--翻页代码 -->
<tr align="right" bgcolor="#EEF4EA">
	<td height="36" colspan="14" align="center">
		<!--翻页代码 -->
	</td>
</tr>
</table>

</form>
</body>
</html>