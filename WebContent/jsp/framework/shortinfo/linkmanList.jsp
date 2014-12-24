<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String path = request.getContextPath();
String compositor=(String)request.getAttribute("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getAttribute("ordertype");
if(ordertype==null){
	ordertype="";
}
DataList data = (DataList)request.getAttribute("linkmans");

DataList errdata = (DataList)request.getAttribute("ERR_DATA");
String errMsg = "";
if(errdata!=null){
	int len = errdata.size();
	for(int i=0;i<len;i++){
		if(i>0){
			errMsg  +=";";
		}
		errMsg  += (i+1) + ":" +(String)errdata.get(i);
	}
}
%>
<BZ:html>
<BZ:head>
<title></title>
<BZ:script isList="true" isDate="true" tree="true"/>
<script type="text/javascript">
<%
if (!"".equals(errMsg)){
	%>
	alert("<%=errMsg%>");
	<%
}
%>
	$(document).ready(function(){
		dyniframesize(['mainFrame']);
	});
	function _onload(){
	}

	function _add(){
		document.srcForm.action=path+"linkman/toadd.action";
		document.srcForm.submit();
	}

	function _update(){
		var sfdj=0;
		var ID="";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
			ID=document.getElementsByName('xuanze')[i].value;
			sfdj++;
			}
		}
		if(sfdj!="1"){
			alert('请选择一条数据');
		return;
		}else{
			document.srcForm.action=path+"linkman/toModify.action?ID="+ID;
			document.srcForm.submit();
		}
	}

	function _delete(){
		var sfdj=0;
		var uuid="";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
		uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
		sfdj++;
		}
	}
	if(sfdj=="0"){
	alert('请选择要删除的数据');
	return;
	}else{
	if(confirm('确认要删除选中信息吗?')){
	document.getElementById("LinkMan_IDS").value=uuid;
	document.srcForm.action=path+"linkman/delete.action";
	document.srcForm.submit();
	}else{
	return;
	}
	}
	}
	function _search()
	{
		document.srcForm.page.value=1;
		document.srcForm.action=path+"linkman/search.action?type=1";
		document.srcForm.page.value = 1;
		document.srcForm.submit();
		document.srcForm.action=path+"linkman/search.action?type=1";
	}
	function changeTab(obj){
		var as=document.getElementsByName("a0");
		var cont=getTrueNode(document.getElementById("cont"));
		for(var i=0;i<as.length;i++){
			if(obj==as[i]){
				as[i].className="aover";
				getTrueNode(as[i])[0].className="sover";
				cont[i].className="c1cur";

			}else{
				as[i].className="tabmenu";
				getTrueNode(as[i])[0].className="t1";
				cont[i].className="c1";
			}
		}
		//点击标签页后，触发时间写在这

	}
	//兼容火狐 用childNodes得到子节点时，空格回车它也默认算一个节点 要排除
	function getTrueNode(obj){
		var childs=obj.childNodes;
		var c=new Array();
		for(var i=0;i<childs.length;i++){
			if(childs[i].nodeType==1){
				c.push(childs[i]);
			}
		}
		return c;
	}
	function _keySearch(){
		var ev = window.event;
		if((ev.keyCode && ev.keyCode==13)){
			_search();
		}
	}

	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		//处理
		outerlist.location = "<BZ:url/>/linkman/outerlist.action?ORGAN_ID="+id;
	}
</script>
<link rel="stylesheet" type="text/css" href="<%=path %>/jsp/framework/shortinfo/css/kuangjia.css" />
</BZ:head>
<BZ:body>
<form name="srcForm" method="post">
	<div  id="tab">
		<div id="tabContent">
			<a class="aover" href="#dd" name="a0" id="a1" onClick="changeTab(this);">
				<div class="t1">
					其他人员
				</div>
			</a>
			<a class="tabmenu" href="#dd" name="a0"  id="ldps_tab" onClick="changeTab(this);">
				<div class="t1">
					联系人
				</div>
			</a>
		</div>

	</div>
	<div id="cont">
		<div class="c1cur" style="width:100%; padding:0px 0px 0px 0px">
			<table style="width:100%;">
				<tr>
					<td style="width:20%;" valign="top">
						<div class="kuangjia" style="margin: 0;">
						<div class="list">
							<!-- 组织机构树形 -->
							<div class="heading">选择部门</div>
								<BZ:tree type="0" property="linkmanTree"/>
							</div>
						</div>
					</td>
					<td style="width:80%;" valign="top">
						<iframe id="outerlist" name="outerlist" src="<BZ:url/>/linkman/outerlist.action" style="width: 100%;" frameborder="0" scrolling="no"></iframe>
					</td>
				</tr>
			</table>
		</div>
		<div class="c1" style="width:100%; padding:0px 0px 0px 0px;scroll:auto;">
				<div class="rightConer"></div>
				<iframe name="innerlist" id="innerlist"  src="<%=path %>/linkman/innerlist.action" width="100%" height="800px" scrolling="auto" frameborder="0"></iframe>
		</div>
	</div>
</form>
</BZ:body>
</BZ:html>
