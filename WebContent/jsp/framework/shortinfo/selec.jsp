<!-- LIZB 2011-12-02 -->
<%@ page language="java" pageEncoding="gbk"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.shortinfo.vo.Sms_Contact_Group"%>
<%@page import="com.hx.framework.shortinfo.SMSConstants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String path = request.getContextPath();
DataList groups = (DataList)request.getAttribute("sms_groups");
%>

<BZ:html>

<BZ:head>
<meta http-equiv="Content-Language" content="zh-cn" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>选择接收人</title>
<BZ:script isAjax="true" />
<script type="text/javascript">


function _load(){
	var tds = document.getElementsByTagName("TD");
	for(var i=0;i<tds.length;i++){
		var td = tds[i];
		if (td.className=="style2"){
			td.onmouseover = function (){
				this.style.backgroundColor='#CCFFFF';
			};
			td.onmouseout = function (){
				this.style.backgroundColor='#FFFFFF';
			};
		}
	}
}
function _getLoadingCode(){
	return "<table style=\"width: 100%;height:35px;border-collapse: collapse;border:0px;\" cellspacing=\"1\" ><tr><td nowrap >正在获取组内人员信息，请稍候......</td></tr></table>";
}
var retRevalue = "";

function _getDataPerson(o){
	var revalue = "";
	var n=0;
	var input = o;
	if (input.checked){
		if (n>0){
			revalue+="；";
		}
		if (input.name.substring(1,2)=="_"){
			var ins = document.getElementsByName("pu_" + input.name.substring(2));
			var inputCheck;
			var inputChilds; 
			var spanTitle;
			if(typeof(ppp)!=="undefined"){
				inputChilds = ppp.childNodes;
				inputCheck = inputChilds[0];
				spanTitle = inputCheck.title;
			}else{
				spanTitle = "";
			}
			var s = "<span class=\"u\" id=\""+input.id+"\" abc=\""+input.id+"\" title=\""+spanTitle+"\"";
			for(var j=0;j<ins.length;j++){
				if (j>0){
					s+="；";
				}
				s+=ins[j].value;
			}
			s+="><img src=\"<%=path%>/jsp/framework/shortinfo/images/users.gif\">[" + input.value + "]&nbsp;<img src=\"<%=path%>/resources/resource1/images/stop.png\" title='删除' style='cursor:hand;height:10px' onclick='_deleteGroup(this);'></span>";
			revalue+=s;
		}else{
			var length=(input.title).length;
			var s ="<span id=\""+input.title+"\" class=\"u\" title=\""+input.id+"\" name=\"spanName\" abc=\"" + input.value + "\"><img src=\"<%=path%>/jsp/framework/shortinfo/images/user.gif\" height=\"20px\">" + input.title + "&nbsp;<img src=\"<%=path%>/resources/resource1/images/stop.png\" title='删除' style='cursor:hand;height:10px' onclick='_deleteReciever(this);'></span>";
			revalue = s;
			//判断对象是否存在,如果不存在则循环结束
			/*
			var span = document.getElementById(input.title);
			if(span==null)
				break;
			*/
		}
		n++;
	}
	return revalue;
}
function _getData(ppp){
	var inputs = null;
	if(ppp) {
		inputs=ppp.getElementsByTagName("input");
	}
	else {
		inputs= document.getElementsByTagName("input");
	}

	var revalue = "";
	var n=0;
	for(var i=0;i<inputs.length;i++){
		var input = inputs[i];
		if (input.checked){
			if (n>0){
				revalue+="；";
			}
			if (input.name.substring(1,2)=="_"){
				var ins = document.getElementsByName("pu_" + input.name.substring(2));
				var inputCheck;
				var inputChilds; 
				var spanTitle;
				if(typeof(ppp)!=="undefined"){
					inputChilds = ppp.childNodes;
					inputCheck = inputChilds[0];
					spanTitle = inputCheck.title;
				}else{
					spanTitle = "";
				}
				var s = "<span class=\"u\" id=\""+input.id+"\" abc=\""+input.id+"\" title=\""+spanTitle+"\"";
				for(var j=0;j<ins.length;j++){
					if (j>0){
						s+="；";
					}
					s+=ins[j].value;
				}
				s+="><img src=\"<%=path%>/jsp/framework/shortinfo/images/users.gif\">[" + input.value + "]&nbsp;<img src=\"<%=path%>/resources/resource1/images/stop.png\" title='删除' style='cursor:hand;height:10px' onclick='_deleteGroup(this);'></span>";
				revalue+=s;
			}else{
				var length=(input.title).length;
				var s ="<span id=\""+input.title+"\" class=\"u\" title=\""+input.id+"\" name=\"spanName\" abc=\"" + input.value + "\"><img src=\"<%=path%>/jsp/framework/shortinfo/images/user.gif\" height=\"20px\">" + input.title + "&nbsp;<img src=\"<%=path%>/resources/resource1/images/stop.png\" title='删除' style='cursor:hand;height:10px' onclick='_deleteReciever(this);'></span>";
				revalue = s;
				//判断对象是否存在,如果不存在则循环结束
				/*
				var span = document.getElementById(input.title);
				if(span==null)
					break;
				*/
			}
			n++;
		}
	}
	return revalue;
}

function _deleteReciever(img){
	var span = img.parentNode;
	var s = span.id;
	var ids = s.split("(");
	var checkbox = document.getElementById(ids[0]);
	checkbox.checked = false;
	span.parentNode.removeChild(span);
}

function _deleteGroup(img){
	var span = img.parentNode;
	var id = span.id;
	var groupTable = document.getElementById('groupTable');
	var checkboxs = groupTable.getElementsByTagName('input');
	var checklen = checkboxs.length; 
	for(var i=0;i<checklen;i++){
		var checkId = checkboxs[i].id;
		if(id==checkId){
			checkboxs[i].checked=false;
			checkboxs[i].parentNode.style.backgroundColor="#FFFFFF";
		}
	}
	span.parentNode.removeChild(span);
}

function _onload(){
	var checkbox = document.getElementById('52a11d1d-5344-4146-a38f-99dcd8ffa0da');
	//alert(checkbox.value);
}

function _add(){
	window.returnValue =document.getElementById("ss").innerHTML;
	window.close();
}

function _close(){
	window.returnValue =null;
	window.close();
}

function _del(msg){
	window.confirm("[" + msg + "]即将被删除，点击“确认”删除该分组，点击“取消”不删除该分组。");
}

function sel(o){
	var n = o.name;
	var num = n.substring(2);
	var renName = "pu_"+num;
	var rens = document.getElementsByName(renName);
	if (o.checked==true){
		for(var i=0;i<rens.length;i++){
			rens[i].checked=true;
		}
		o.parentNode.style.backgroundColor="#CCCCDF";
	}else{
		for(var i=0;i<rens.length;i++){
			rens[i].checked=false;
		}
		o.parentNode.style.backgroundColor="#FFFFFF";
	}
	var sss= _getData(o.parentNode);
	if(o.checked==true){
		document.getElementById("ss").innerHTML =sss+document.getElementById("ss").innerHTML;
	}
	else{
		var span = document.getElementById(o.id);
		span.parentNode.removeChild(span);
	}
	if(sss!=""){
		 document.getElementById("addGroup").disabled=false;
	}else{
		document.getElementById("addGroup").disabled=true;
	}
}

function ajaxGetPersonInfo(id){
	var tbody = document.getElementById('listBody');
	while(tbody.hasChildNodes()){
		tbody.removeChild(tbody.firstChild);
	}
	var ttr = tbody.insertRow(0);
	var tTD=ttr.insertCell(0);		
	tTD.align = "center";
	tTD.setAttribute("colspan",4);
	tTD.innerHTML=_getLoadingCode();
	
	setTimeout("ajaxGetPersonInfo1('" + id + "');",100);
}
function ajaxGetPersonInfo1(id){
	
	var tbody = document.getElementById('listBody');
	var dataList = getDataList("com.hx.framework.shortinfo.AjaxGetPerson","id="+id);
	var len = dataList.size();
	while(tbody.hasChildNodes()){
		tbody.removeChild(tbody.firstChild);
	}
	var spans = document.getElementById("ss").childNodes;
	for(var i=0;i<len;i++){
		var data = dataList.getData(i);
		var newTR = tbody.insertRow(i);
		newTR.id = "SignItem" + i;
		newTR.className = "style20";
		//添加选择框
		var newNameTD=newTR.insertCell(0);		
		newNameTD.align = "center";
		newNameTD.className="style52";
		for(var j=0;j<spans.length;j++){
			var inputValue = data.getString("PERSON_ID")+","+data.getString("CNAME")+","+data.getString("MOBILE")+","+data.getString("GROUPID")+","+"1";
			var innerValue = data.getString("CNAME")+"("+data.getString("MOBILE")+")";
			var equalValue = "";
			if(typeof(spans[j].id)!=='undefined'){
				equalValue = spans[j].id;
			}
			if(innerValue==equalValue){
				newNameTD.innerHTML = "<input type='checkbox' listTag='"+data.getString("GROUPID")+"' name=\""+data.getString("GROUPID")+"\" id=\""+data.getString("CNAME")+"\" onclick=_c(this) title='"+data.getString("CNAME")+"("+data.getString("MOBILE")+")' value=\""+inputValue+"\" checked=checked>";
				break;
			}else{
				newNameTD.innerHTML = "<input type='checkbox' listTag='"+data.getString("GROUPID")+"' name=\""+data.getString("GROUPID")+"\" id=\""+data.getString("CNAME")+"\" onclick=_c(this) title='"+data.getString("CNAME")+"("+data.getString("MOBILE")+")' value=\""+inputValue+"\" />";
			}
		}
		//添加姓名
		var newNameTD=newTR.insertCell(1);		
		newNameTD.align = "center";
		newNameTD.innerHTML = data.getString("CNAME")+"&nbsp;";
		newNameTD.className="style52";
		
		//添加手机号
		var newNameTD=newTR.insertCell(2);		
		newNameTD.align = "center";
		newNameTD.innerHTML = data.getString("MOBILE")+"&nbsp;";
		newNameTD.className="style52";
		
		//添加部门
		var newNameTD=newTR.insertCell(3);		
		newNameTD.align = "center";
		newNameTD.innerHTML = data.getString("ORG_NAME")+"&nbsp;";
		newNameTD.className="style52";
		
		//添加职位
		//var newNameTD=newTR.insertCell(4);		
		//newNameTD.align = "center";
		//newNameTD.innerHTML = data.getString("POST")+"&nbsp;";
		//newNameTD.className="style52";
	}		
}

function AjaxSerachPersons(){
	var name = document.getElementById("searchValue").value;
	var dataList = getDataList("com.hx.framework.shortinfo.AjaxSearchPersons","name="+name);
	var len = dataList.size();
	var searchTd = document.getElementById("searchTd");
	while(searchTd.hasChildNodes()){
		searchTd.removeChild(searchTd.firstChild);
	}
	var spans = document.getElementById("ss").childNodes;
	for(var i=0;i<len;i++){
		var data = dataList.getData(i);
		var inputValue = data.getString("PERSON_ID")+","+data.getString("CNAME")+","+data.getString("MOBILE")+",002,1";
		searchTd.innerHTML+="<input type='checkbox' listTag='"+data.getString("GROUPID")+"' name='"+data.getString("GROUPID")+"' id='"+data.getString("CNAME")+"' onclick=_c(this) title='"+data.getString("CNAME")+"("+data.getString("MOBILE")+")' value="+inputValue+">"+data.getString("CNAME")+"("+data.getString("MOBILE")+")"; 
	}
}

function _c(v){
	var inputTitle = v.title;
	if(v.checked==true){
		if(inputTitle.length<12){
			alert("此用户没有手机号码，不能发送短信!");
			v.checked=false;
		}else{		
			document.getElementById("ss").innerHTML = document.getElementById("ss").innerHTML+_getDataPerson(v);
		}
	}
	else{
		//alert("input.id="+v.id)
		var input = document.getElementById(v.title);
		//alert(v.title+"#####"+document.getElementById("ss").innerHTML);
		if(input != null){
			input.parentNode.removeChild(input);
		}
	}
}

function _selectAll(o,name){
	var inputs = document.getElementsByTagName("input");
	for(var i=0;i<inputs.length;i++){
		var input = inputs[i];
		var listT_ = input.getAttribute("listTag");
		if (listT_ != null && listT_ != ""){
			input.checked=o.checked;
			_c(input);
		}
	}
}
function _keySearch(){
	var ev = window.event;
	if((ev.keyCode && ev.keyCode==13)){
		AjaxSerachPersons();
	}
}
</script>

<style type="text/css">
.style1 {
	background-color:silver;
}
.style2 {
	background-color: #FFFFFF;
	font-size:12px;
	text-align:left;
	text-indent:12px;
	height:25px;
}
.style20 {
	background-color: #FFFFFF;
	font-size:12px;
	text-align:left;
	text-indent:0px;
	height:25px;
}
	
	.xuhao {
	background-color: #FFFFFF;
	font-size:12px;
	text-align:center;
	height:25px;
	}

.style3 {
	background-color:#F5F5F5;
	font-size:12px;
	text-align:center;
	height:22px;
	font-weight:bold;
	vertical-align: middle;
	}
.style5 {
	background-color: #F5F5F5;
	font-size: 12px;
	text-align: left;
	height: 25px;
	font-weight: bold;
}
.style50 {
	background-color: #F5F5F5;
	font-size: 12px;
	text-align: left;
	height: 25px;
}

.style8 {
	text-align: right;
}
.style9 {
	background-color: #CCFFFF;
	font-size: 12px;
	text-align: left;
	font-weight: bold;
}
.style10 {
	border-style: solid;
	border-color: #EFEFEF;
}
.style11 {
	background-color: #EFEFEF;
}
span{
	display:inline-block;
}

.style51 {
	border-width: 0;
	background-color: #F5F5F5;
		font-size: 12px;
		text-align: left;
		font-weight: bold;
}
.style52 {
	border-right: 1px solid #CCC;
	border-bottom: 1px solid #CCC;
}


</style>
</BZ:head>

<BZ:body onload="_onload();"> 
<div style="text-align: center">
<table style="width: 100%;height:67px;border: 1px solid #CCC;" class="style11" cellspacing="0" cellpadding="0">
<tr>
	<td class="style51;" nowrap style="width:10%; vertical-align:middle; height: 25px;border: 1px solid #CCC;">
	&nbsp;选择接收人（组）:</td>
	<td id="ss" style="width:90%;background-color: #ffffff;border: 1px solid #CCC;" style="text-align:left">&nbsp;</td>
	<td style="align:right;"><input id="addGroup" type="hidden" value="存为人员组" onClick="_add2()" disabled ></td>
</tr>
<tr>
<td style="height:98px;vertical-align:top;width: 100%;" align="center" class="style10" colspan="3">
	<div style="overflow:auto;width:100%;height:100%;background-color:#F3F3F3">
		<table style="width: 99%" cellspacing="1" class="style1">
		<tr>
		<td class="style5" style="width: 10%;height: 80px;" nowrap>快速查找人员：</td>
		<td class="style5" style="width: 15%;" nowrap>
		<input style="width: 101px" name="searchValue" id ="searchValue" onkeyup="_keySearch();" value=""> <input type="button" value="搜索" onClick="AjaxSerachPersons();" style="height: 20px"></td>
		<td class="style2" style="width:75%;vertical-align: top;" id="searchTd">
			
		</td>
		</tr>
		</table> 
	</div>
</td>
</tr>
</table>

<table  style="width: 100%" class="style1" cellspacing="1" id="groupTable">
<tr>
	<td class="style2"  width="50%;" valign="top">
		<div>
			<table style="width: 99%" class="style1" cellspacing="1">
				<tr>
					<td class="style3"  style="height: 25px;text-align: left;" >自定义组</td>
				</tr>
					<%
						for(int i=0;i<groups.size();i++){
							Data group = groups.getData(i);
							if(group.getString(Sms_Contact_Group.GROUP_TYPE).equals(SMSConstants.GROUP_PERSONAL)){
							%>
							<tr style='width:20%;height=30px; cursor: hand;' onclick="ajaxGetPersonInfo('<%=group.getString(Sms_Contact_Group.ID) %>');">
								<td class="style20" style="height: 30px;align:left;">
									<input type="checkbox" onclick="sel(this)" name="s_0" value="<%=group.getString(Sms_Contact_Group.GROUPNAME) %>" id="<%=group.getString(Sms_Contact_Group.ID) %>" title="<%=group.getString("TITLE") %>"><%=group.getString(Sms_Contact_Group.GROUPNAME,"") %>&nbsp;<%=group.getString("COUNT","") %><br>
								</td>
							</tr>
							<%
							}
						}
					%>
					
			</table>
			<hr style="width:99%">
			<table style="width: 99%" class="style1" id="liebiao" cellspacing="1">
				<tr>
					<td class="style3"  style="height: 25px;text-align: left;">公&nbsp; 共&nbsp; 组</td>
				</tr>
				<%
						for(int i=0;i<groups.size();i++){
							Data group = groups.getData(i);
							if(group.getString(Sms_Contact_Group.GROUP_TYPE).equals(SMSConstants.GROUP_COMMONALITY)){
							%>
							<tr class='style20' style='width:20%;height=30px; cursor: hand;' onclick="ajaxGetPersonInfo('<%=group.getString(Sms_Contact_Group.ID) %>');"><td>
								<input type="checkbox" onclick="sel(this)" name="p_<%=i %>" value="<%=group.getString(Sms_Contact_Group.GROUPNAME) %>" id="<%=group.getString(Sms_Contact_Group.ID) %>" title="<%=group.getString("TITLE") %>"><%=group.getString(Sms_Contact_Group.GROUPNAME,"") %>&nbsp;<%=group.getString("COUNT","") %><br>
							</td></tr>
							<%
							}
						}
					%>
			</table>
		</div>
	</td>
	
	<td class="style2"  style="width:50%;height:400px;vertical-align:top" >		
		<div  id="disPeople" style="overflow:auto;width:100%;height:500px;border:1">
			<table style="width: 100%" cellspacing="0" cellpadding="0" class="style20" id="listTab">
			<thead id="listHead">
				<tr>
					<td class='style3' style='width:20%;height=30px;border-bottom: 1px solid #CCC;border-right: 1px solid #CCC;padding-top: 5px;vertical-align: middle;' nowrap=>
						<input type="checkbox" name="selectAllCheck_" onclick="_selectAll(this,'input');"/>选择
					</td>
					<td class='style3' style='width:20%;height=30px;border-bottom: 1px solid #CCC;border-right: 1px solid #CCC;'>姓名</td>
					<td class='style3' style='width:30%;height=30px;border-bottom: 1px solid #CCC;border-right: 1px solid #CCC;'>手机号</td>
					<td class='style3' style='width:30%;height=30px;border-bottom: 1px solid #CCC;border-right: 1px solid #CCC;'>部门</td>
				</tr>
			</thead>
			<tbody id="listBody">
				
			</tbody>
			</table>
		</div>
		
	</td>

</tr>
</table>

<table style="width: 100%" class="style1"  cellspacing="1">
	<tr>
	<td  class="style3" >
	<input class="add" value="确定" type="button" onClick="_add();" name="ok">&nbsp;
	<input class="add" value="取消" type="button" onClick="_close()" name="ok1">
	</td>
	</tr>
</table>
</div>
</BZ:body>
</BZ:html>
