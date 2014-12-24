<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<BZ:html>
<BZ:head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-cache, no-store, max-age=0" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>���ݿ��ʼ��<BZ:url/></title>
<script type="text/javascript"  src="<BZ:url/>/resource/js/jquery-1.9.1.min.js"></script>
<style type="text/css">
body{
margin: 0;
font-size: 14px;
}
div{
	padding: 5px;
	margin-left:auto;
	margin-right:auto;
	font-size: 14px;
	text-align: left;
}
.header input{
	
}
.header button{
	width:50px;
	height:50px;
}
#showSate{
border-bottom:1px solid #00C;
}
span{
	cursor: pointer;
}
</style>
<script type="text/javascript">

//�����������е�����
$(document).ready(function(){
	var elementHeight = document.documentElement.clientHeight;
	$("#showSate").height(elementHeight-90);
});
//���ڱ仯ʱ�Ĵ���
$(window).resize(function(){
	var elementHeight = document.documentElement.clientHeight;
	$("#showSate").height(elementHeight-90);
});

function sel(id){
	var ch = document.getElementById(id);
	if (ch.checked){
		ch.checked=false;
	}else{
		ch.checked=true;
	}
}
</script>
</BZ:head>
<body>
<div class="header">
<BZ:form name="setup" action="/setup/rundb.action" target="showSate">
���ݿ�<select name="dbtype" >
<option value="mysql">mysql</option>
</select>
<input type="checkbox" value="1" id="drop" name="drop" checked><span onclick="sel('drop');">ɾ�����ݱ�</span>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="checkbox" value="1" id="create" name="create" checked><span onclick="sel('create');">�������ݱ�</span>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="checkbox" value="1" id="init" name="init" checked><span onclick="sel('init');">��ʼ������</span>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="checkbox" value="1" id="fk" name="fk" ><span onclick="sel('fk');">�������</span>&nbsp;&nbsp;&nbsp;&nbsp;
<button type="submit">��ʼ</button>&nbsp;&nbsp;&nbsp;&nbsp;
</BZ:form>
</div>
<hr>
<div id="stats">
<iframe name="showSate" id="showSate" style="width:100%;height:400px;border: 0px"></iframe>
</div>
</body>
</BZ:html>