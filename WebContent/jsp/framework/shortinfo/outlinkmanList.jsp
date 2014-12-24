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
<BZ:script isList="true" isDate="true"/>
<script type="text/javascript">
<%
if (!"".equals(errMsg)){
	%>
	alert("<%=errMsg%>");
	<%
}
%>
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
			alert('��ѡ��һ������');
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
	alert('��ѡ��Ҫɾ��������');
	return;
	}else{
	if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')){
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
		document.srcForm.action=path+"linkman/search2.action?type=1";
		document.srcForm.submit();
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
		//�����ǩҳ�󣬴���ʱ��д����

	}
	//���ݻ�� ��childNodes�õ��ӽڵ�ʱ���ո�س���ҲĬ����һ���ڵ� Ҫ�ų�
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

	function checkedPerson(){
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				var che = document.getElementsByName('xuanze')[i];
				var id = che.value+"@"+"1";

				var pname = che.getAttribute("pname");
				var dname = che.getAttribute("dname");
				var tel = che.getAttribute("tel");

				var value = pname+"["+dname+"]"+"("+tel+")";
				//���option
				var select = parent.document.getElementById("d2");
				var option=document.createElement("OPTION");
					option.value=id;
					option.text=value;
					select.add(option);
			}
		}
	}

	var xx = "xuanze";
</script>
<link rel="stylesheet" type="text/css" href="<%=path %>/jsp/framework/shortinfo/css/kuangjia.css" />
</BZ:head>
<BZ:body onload="_onload()">
<form name="srcForm" method="post" action="<%=request.getContextPath() %>/linkman/search2.action?type=1">
<div class="kuangjia">
				<div class="heading">��ѯ����</div>
				<div  class="chaxun">
				<table class="chaxuntj">
				<tr>
				<td width="10%" style="text-align: right;">������</td>
				<td width="20%"><BZ:input field="CNAME" property="search" prefix="SEARCH_" defaultValue="" onkeyup="_keySearch();"/></td>
				<td width="10%">���ţ�</td>
				<td width="20%"><BZ:input field="ORGNAME" property="search" prefix="SEARCH_" defaultValue="" onkeyup="_keySearch();"/></td>
				<td width="10%">�ֻ��ţ�</td>
				<td width="20%"><BZ:input field="MOBILE" property="search" prefix="SEARCH_" defaultValue="" onkeyup="_keySearch();"/></td>
				<td width="10%"><input type="button" value="��ѯ" class="button_search" onclick="_search()"/></td>
				</tr>
				</table>
				</div>
				<input id="LinkMan_IDS" name="IDS" type="hidden"/>
				<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
				<input type="hidden" name="compositor" value="<%=compositor%>"/>
				<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
				<!--  -->
				<div class="list">
				<div class="heading">��ϵ���б�</div>
				<table border="0" cellpadding="0" cellspacing="0" class="operation">
				<tr>
				<td style="padding-left:15px"></td>
				<td align="right" style="height:35px;">
				<img alt="���ѡ���û�" src="<BZ:resourcePath/>/main/images/send_user.png" style="cursor: pointer;" onclick="checkedPerson();">
				</td>
				</tr>
				</table>
				<BZ:table tableid="tableGrid" tableclass="tableGrid">
				<BZ:thead theadclass="titleBackGrey">
				<BZ:th name="<input type='checkbox'  name='quanxuan' id='quanxuan' onclick='_selectAll(this,xx);'/>" sortType="none" width="7%"/>
				<BZ:th name="���" sortType="string" width="8%" sortplan="jsp"/>
				<BZ:th name="����" sortType="string" width="30%" sortplan="database" sortfield="CNAME"/>
				<BZ:th name="����" sortType="string" width="30%" sortplan="database" sortfield="ORGNAME"/>
				<BZ:th name="�绰" sortType="string" width="25%" sortplan="database" sortfield="MOBILE"/>
				</BZ:thead>
				<BZ:tbody>
				<BZ:for property="linkmans" >
				<tr>
				<td noselect="true"><input pname='<BZ:data field="CNAME" defaultValue="" onlyValue="true"/>' dname='<BZ:data field="ORGNAME" defaultValue="" onlyValue="true"/>' tel='<BZ:data field="MOBILE" defaultValue="" onlyValue="true"/>' name="xuanze" type="checkbox" value="<BZ:data field="ID" onlyValue="true"/>"></td>
				<td><BZ:i></BZ:i></td>
				<td><BZ:data field="CNAME" defaultValue="" onlyValue="true"/></td>
				<td><BZ:data field="ORGNAME" defaultValue="" onlyValue="true"/></td>
				<td><BZ:data field="MOBILE" defaultValue="" onlyValue="true"/></td>
				</tr>
				</BZ:for>
				</BZ:tbody>
				</BZ:table>
				<table border="0" cellpadding="0" cellspacing="0" class="operation">
				<tr>
				<td colspan="2"><BZ:page form="srcForm" property="linkmans"/></td>
				</tr>
				</table>
				</div>
				</div>
				<br/>
</form>

</BZ:body>
</BZ:html>
