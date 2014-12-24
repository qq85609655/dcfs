<%@page import="com.hx.upload.datasource.DatasourceManager"%>
<%@page import="com.hx.upload.vo.AttType"%>
<%@page import="com.hx.upload.vo.Att"%>
<%@page import="com.hx.upload.datasource.vo.Data"%>
<%@page import="com.hx.upload.datasource.vo.DataList"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	DataList dataList = (DataList)request.getAttribute("dataList");
	DataList attTypes = (DataList)request.getAttribute("attTypes");
	String attTypeCode = (String)request.getAttribute("ATT_TYPE_CODE");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>附件类型管理</title>
<link rel="stylesheet" type="text/css" href="<%=path %>/uploadComponent/admin/skin/css/base.css">
<script language="javascript">
function selAll()
{
	for(i=0;i<document.getElementsByName("xuanze").length;i++)
	{
		if(!document.getElementsByName("xuanze")[i].checked)
		{
			document.getElementsByName("xuanze")[i].checked=true;
		}
	}
}

function noSelAll()
{
	for(i=0;i<document.getElementsByName("xuanze").length;i++)
	{
		if(document.getElementsByName("xuanze")[i].checked)
		{
			document.getElementsByName("xuanze")[i].checked=false;
		}
	}
}

function _delete(){
	  var sfdj=0;
	   var uuid="";
	   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	   if(document.getElementsByName('xuanze')[i].checked){
	   uuid=uuid+document.getElementsByName('xuanze')[i].value+"@";
	   sfdj++;
	   }
	  }
	  if(sfdj=="0"){
	   alert('请选择要删除的数据');
	   return;
	  }else{
	  if(confirm('确认要删除选中信息吗?')){
	  var code = document.getElementById("code").value;
	  code = encodeURI(encodeURI(code));
	  window.location.href = "<%=path %>/att/Att.<%=DatasourceManager.getRequestPrefix() %>?param=delBatchAtts&ATTS_IDS="+uuid+"&ATT_TYPE_CODE="+code;
	  }else{
	  return;
	  }
	  }
}

//保存附件类型对话框
function add_att_type_dialog(){
	window.showModalDialog("add_att_type.jsp",this,"dialogWidth=800px;dialogHeight=230px;scroll=no");
}

//数据源管理对话框
function opra_datasource_dialog(){
	window.showModalDialog("opra_datasource.jsp",this,"dialogWidth=800px;dialogHeight=250px;scroll=no");
}

//磁盘管理对话框
function opra_disk_path_dialog(){
	window.showModalDialog("opra_disk_path.jsp",this,"dialogWidth=800px;dialogHeight=120px;scroll=no");
}

//修改附件类型对话框
function mod_att_type_dialog(id){
	window.showModalDialog("mod_att_type.jsp?id="+id,this,"dialogWidth=800px;dialogHeight=230px;scroll=no");
}

function changeAttType(obj){
	var code = obj.value;
	code = encodeURI(encodeURI(code));
	document.getElementById("ATT_TYPE_CODE").value = code;
	window.location.href = "<%=path %>/att/Att.<%=DatasourceManager.getRequestPrefix() %>?param=queryAtts&ATT_TYPE_CODE="+code;
}

function delAtt(id,typeId){
	window.location.href = "<%=path %>/att/Att.<%=DatasourceManager.getRequestPrefix() %>?param=delAtt&ID="+id+"&ATT_TYPE_ID="+typeId;
}
</script>
</head>
<body leftmargin="8" topmargin="8" background='<%=path %>/uploadComponent/admin/skin/images/allbg.gif'>

<!--  搜索表单  
<form name='form3' action='' method='get'>
<input type='hidden' name='dopost' value='' />
<table width='98%'  border='0' cellpadding='1' cellspacing='1' bgcolor='#CBD8AC' align="center" style="margin-top:8px">
  <tr bgcolor='#EEF4EA'>
    <td background='<%=path %>/uploadComponent/admin/skin/images/wbg.gif' align="left">
      <table border='0' cellpadding='0' cellspacing='0'>
        <tr>
          <td width='90' align='center'>搜索条件：</td>
          <td width='160'>
          <select name='cid' style='width:150'>
          <option value='0'>选择类型...</option>
          	<option value='1'>名称</option>
          </select>
        </td>
        <td width='70'>
          关键字：
        </td>
        <td width='160'>
          	<input type='text' name='keyword' value='' style='width:150px' />
        </td>
        <td width='110'>
    		<select name='orderby' style='width:80px'>
            <option value='id'>排序...</option>
            <option value='pubdate'>发布时间</option>
      	</select>
        </td>
        <td>
          <input name="imageField" type="image" src="<%=path %>/uploadComponent/admin/skin/images/frame/search.gif" width="45" height="20" border="0" class="np" />
        </td>
       </tr>
      </table>
    </td>
  </tr>
</table>
</form>
<br>
-->

<!--  快速转换位置按钮  -->
<input id="ATT_TYPE_CODE" type="hidden" value='<%=request.getAttribute("ATT_TYPE_CODE")!=null?request.getAttribute("ATT_TYPE_CODE"):"" %>' name="ATT_TYPE_CODE">
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
<tr>
 <td height="26" background="<%=path %>/uploadComponent/admin/skin/images/newlinebg3.gif">
  <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td align="left" style="padding-left: 5px;">
  <select id="code" name="code" onchange="changeAttType(this);">
	<option value="">全部附件</option>
	<%
		if(attTypes != null && attTypes.size() > 0){
		    for(int i = 0; i < attTypes.size(); i++){
		        Data data = attTypes.getData(i);
	%>
	<option <%=data.getString(AttType.CODE).equals(attTypeCode)?"selected='selected'":"" %> value="<%=data.getString(AttType.CODE) %>"><%=data.getString(AttType.ATT_TYPE_NAME) %></option>
	<%
		    }
		}
	%>
  </select>
  </td>
  <td align="right" style="display: none;">
    <input type='button' class="coolbg np" onClick="add_att_type_dialog()" value='按日统计' />
    <input type='button' class="coolbg np" onClick="opra_datasource_dialog()" value='按月统计' />
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<!--  内容列表   -->
<form name="form2">
<input type="hidden" id="ATTS_IDS" name="ATTS_IDS" value=""/>
<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="<%=path %>/uploadComponent/admin/skin/images/tbg.gif">&nbsp;附件列表&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22">
	<td>选中</td>
	<td>序号</td>
	<td>附件名称</td>
	<td>附件大小(Byte)</td>
	<td>附件路径</td>
	<td>磁盘中附件名</td>
	<td>上传日期</td>
	<td>状态</td>
	<td>所属附件类型</td>
	<td>存储类型</td>
	<td>操作</td>
</tr>
<%
	if(dataList != null && dataList.size() > 0){
	    for(int i = 0; i < dataList.size(); i++){
	        Data data = dataList.getData(i);
%>
<tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22" >
	<td><input name="xuanze" type="checkbox" id="xuanze" value='<%=data.getString(Att.ID)+"!"+data.getString(Att.ATT_TYPE_ID,"") %>' class="np"></td>
	<td><%=i+1 %></td>
	<td><%=data.getString(Att.ATT_NAME,"") %></td>
	<td><%=data.getString(Att.ATT_SIZE) %> Byte</td>
	<td><%=data.getString(Att.FILESYSTEM_PATH,"") %></td>
	<td><%=data.getString(Att.RANDOM_NAME,"") %></td>
	<td><%=data.getString(Att.CREATE_TIME) %></td>
	<td><%="1".equals(data.getString(Att.STATUS))?"暂存":"发布" %></td>
	<td><%=data.getString(AttType.ATT_TYPE_NAME,"") %></td>
	<td><%="1".equals(data.getString(AttType.STORE_TYPE))?"磁盘":"数据库" %></td>
	<td><a href="JavaScript:delAtt('<%=data.getString(Att.ID) %>','<%=data.getString(Att.ATT_TYPE_ID) %>');" style="text-decoration: none;">删除</a></td>
</tr>
<%
	    }
	}else{
%>
<tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22" >
	<td colspan="14" style="color: red;font-weight: bold;">无附件信息；如果与实际不相符合，请查看数据源管理的设置！</td>
</tr>
<%
	}
%>

<!--翻页代码 -->
<tr align="right" bgcolor="#EEF4EA">
	<td height="36" colspan="12" align="left">
		<!--翻页代码 -->
		&nbsp;
		<a href="javascript:selAll()" class="coolbg">全选</a>
		<a href="javascript:noSelAll()" class="coolbg">取消</a>
		<a href="javascript:_delete()" class="coolbg">&nbsp;全部删除&nbsp;</a>
		<!-- 屏蔽 
		<a href="javascript:updateArc(0)" class="coolbg">&nbsp;更新&nbsp;</a>
		<a href="javascript:checkArc(0)" class="coolbg">&nbsp;审核&nbsp;</a>
		<a href="javascript:adArc(0)" class="coolbg">&nbsp;推荐&nbsp;</a>
		<a href="javascript:moveArc(0)" class="coolbg">&nbsp;移动&nbsp;</a>
		-->
	</td>
</tr>
</table>

</form>
</body>
</html>