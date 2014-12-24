<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<BZ:head>
<meta http-equiv="Content-Language" content="zh-cn" />
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>人员组织机构变更情况确认</title>
<BZ:script isEdit="true" isAjax="true" />
<style type="text/css">
table{
	width:400px;
	background-color:#CCCCCC;
	
}
td{
	height:22px;
	text-align:center;
	font-size:12px;
	background-color:#FFFFFF;

}
th{
	height:22px;
	font-size:12px;
	background-color:#FFFFFF;
}
div{
	height:22px;
	font-size:14px;
	font-weight:bold;
	text-align:center;
	width:400px;
	padding:8px 0px 0px 0px;
}
body{
	margin: 5px;
}
</style>
<script type="text/javascript">
function _load(){
	var obj = window.dialogArguments;
	var str = '<table cellspacing="1" style="width: 400px">';
	str+='<tr>';
	str+='<th style="width:80px;">姓名</th>';
	str+='<th style="width:120px; height: 22px;">原部门</th>';
	str+='<th style="width:120px;">更新部门</th>';
	str+='<th style="width:80px;">操作</th>';
	str+='</tr>';
	str+=obj.value;
	str+='</table>';
	document.getElementById("org").outerHTML=str;
}
function updateMe(o,id,oldid,orgid){
	var param = "id=" + id + "&orgid=" + orgid + "&oldid=" + oldid;
	var xml = getXml("com.hx.framework.shortinfo.AjaxChangeOrg",param);
	if (xml=="OK"){
		o.outerHTML="更新成功";
	}else{
		alert("更新失败");
	}
}
</script>
</BZ:head>
<body onload="_load();">
<div>
人员组织机构变更情况确认
</div>
<div id="org"></div>
</body>
</html>