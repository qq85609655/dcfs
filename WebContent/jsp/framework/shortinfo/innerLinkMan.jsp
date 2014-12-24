<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	String compositor = (String) request.getAttribute("compositor");
	if (compositor == null) {
		compositor = "";
	}
	String ordertype = (String) request.getAttribute("ordertype");
	if (ordertype == null) {
		ordertype = "";
	}
	DataList data = (DataList) request.getAttribute("linkmans");
%>
<BZ:html>
<BZ:head>
	<title></title>
	<BZ:script isList="true" isDate="true" isAjax="true" />
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['innerlist','mainFrame']);
	});
	function _onload(){

	}
	function _search()
	{
		document.srcForm.target = "_self";
		document.srcForm.action=path+"linkman/search.action?type=2";
		document.srcForm.submit();

	}
	function AjaxAddValue(idd){
	// alert(document.getElementById("t_"+idd).value);
		var mobile = document.getElementById("t_"+idd).value;
		mobile=mobile.trim();
		if (mobile!=""){
			if (!mobile.isMobileTelephone()){
				alert("手机号不正确");
				return;
			}
		}
	var r = executeRequest("com.hx.framework.shortinfo.AjaxModifyMobile","person_id="+idd+"&mobile="+mobile);
	//alert(r);
	if("true"==r){
		alert("保存成功！");
		document.getElementById("t_"+idd).ovalue=document.getElementById("t_"+idd).value;
		document.getElementById("btn1_"+idd).style.display="none";
		document.getElementById("btn2_"+idd).style.display="none";
		document.getElementById("btn3_"+idd).style.display="none";
	}else{
		alert("保存失败，请重试！");
	}
	}
	function chgBtn(idd,dis){
		if(dis!='none' ||( dis=='none' && (document.getElementById("t_"+idd).value==document.getElementById("t_"+idd).ovalue))){
			document.getElementById("btn1_"+idd).style.display=dis;
			document.getElementById("btn2_"+idd).style.display=dis;
			document.getElementById("btn3_"+idd).style.display=dis;
		}
	}
	function _cancel(idd){
		var input = document.getElementById("t_"+idd);
		input.value=document.getElementById("t_"+idd).ovalue;
		_setColor(input);
		document.getElementById("btn1_"+idd).style.display="none";
		document.getElementById("btn2_"+idd).style.display="none";
		document.getElementById("btn3_"+idd).style.display="none";
	}
	function _jinggao(idd){
		var input = document.getElementById("t_"+idd);
		//input.value=document.getElementById("t_"+idd).ovalue;
		_setColor(input,okColor);
		document.getElementById("btn1_"+idd).style.display="none";
		document.getElementById("btn2_"+idd).style.display="none";
		document.getElementById("btn3_"+idd).style.display="none";
	}
	/**
	 * 批量保存电话号码
	 */
	function _saveAll(){
			//获取所有人的ID以及对应的tel
			var trs = document.getElementsByTagName("tbody")[1].childNodes;
		var ids = "";
		var tels = "";
		for(var i=0;i<trs.length;i++){
			var id = trs[i].id+"#";
			ids = ids+id;

			var tds = trs[i].childNodes;
			var telTd = tds[3];
			var tel = telTd.getElementsByTagName("input")[0].value;
			if(tel==""){
				tel=" ";
			}
			tel = tel+"#";
			tels = tels + tel;
		}
		document.getElementById("personIds").value=ids;
		document.getElementById("personTels").value=tels;
		document.srcForm.action = path+ "linkman/saveAllTel.action";
		document.srcForm.submit();
	}

function _checkSelfData(dataList,nDatas,errData){
	var len = dataList.length;
	for(var i=0;i<len;i++){
		var ok=false;
		for(var j=(i+1);j<len;j++){
			if (j<len){
				if(dataList[j].atrim()==dataList[i].atrim()){
					errData[errData.length]=dataList[j];
					ok=true;
				}
			}
		}
		if(!ok){
			nDatas[nDatas.length]=dataList[i];
		}
	}
	return nDatas;
}

var okColor="#00CC00";
var warnColor="#FF0000";
	function _setColor(o,color,nn){
		if (o.style.backgroundColor!=color){
			o.setAttribute("oldColor",color);
		}
		if (color=="" || color==null){
			var c=o.getAttribute("oldColor");
			if (c!=null){
				color=c;
			}else{
				color="#FFFFFF";
			}
		}
		o.style.backgroundColor=color;
		var tr = o.parentNode.parentNode.parentNode;
		tr.style.backgroundColor=color;
		if(nn!=null){
			var tb = document.getElementById("tableGrid");
			tb.moveRow(tr.rowIndex,nn);
		}
	}


	/**
	 *批量导入电话号码
	 *
	 */
	function _import(){
			var reValue = modalDialog("<%=path%>/jsp/framework/shortinfo/importInner.jsp",null,400,500);
			if(reValue==null || reValue==""){
				return;
			}
		//要导入的数据中，重复的内容
		var errData = new Array();
		reValue = reValue.replaceByString("	",",");
		reValue = reValue.replaceByString("\t",",");
		reValue = reValue.replaceByString("，",",");
		reValue = reValue.replaceByString("；",",");
		reValue = reValue.replaceByString(";",",");

	var a = reValue.split("\r\n");
	var newa = new Array();
	newa = _checkSelfData(a,newa,errData);
	var errArray = new Array();

		var len = newa.length;
			//alert("数据长度：" + len);
			//定义二维数组,拿到excel返回值之后赋给arr1,如arr1[0]["name"]="张三",arr1[0]["tel"]="13284768722"
			var arr1 = new Array();
			for(var i=0;i<len;i++){
					if(newa[i].atrim()!=""){
					var b = newa[i].split(",");
					var tel;
					var n;
					var orgName;
					if (b.length<3){
						if(b.length<2){
							alert("导入数据格式错误，请重输入");
							//return;
						}
						tel = b[1];
						n = b[0].atrim();
						orgName = "";
					}else{
						tel = b[2];
						n = b[1].atrim();
						orgName = b[0].atrim();
					}
					var t = new Array();
					t["name"] = n;
					t["tel"] = tel;
					t["orgName"] = orgName;
					if(tel.isMobileTelephone()){
							arr1[arr1.length]=t;
					}else{
						errArray[errArray.length] = t;
					}
				}
			}
			//获取页面所有输入电话号码的input的放入到telInputs//获取页面上所有人名字,存放在names数组中
			var telInputs = new Array();
			var inputs = document.getElementById("tableGrid").getElementsByTagName("input");
			for(var i=0;i<inputs.length;i++){
		var input = inputs[i];
		var tel = input.getAttribute("tel");
		var ovalue = input.getAttribute("ovalue");
		var value = input.value;
		var cname = input.getAttribute("cname");
		//这是为了增加机构处理的
		var orgOld = input.getAttribute("orgName");
		var orgOldId = input.getAttribute("orgid");
		var uid = input.getAttribute("uid");
				if(tel=="true"){
				var tels = new Array();
				tels["PERSON_NAME"]=cname.atrim();
				tels["OVALUE"]=ovalue;
				tels["VALUE"]=value;
				tels["ORGOLD"]=orgOld;
				tels["ORGOLDID"]=orgOldId;
				tels["UID"]=uid;
				tels["obj"]=input;
					telInputs[telInputs.length] = tels;
				}
			}
			var okArray = new Array();
			var warnArray = new Array();
			var noneArray = new Array();
		//综上两步,telInputs存了所有的人和电话号码
		//将所有页面上的名字与导入的人名一一对比;如果找到相同人名，那么将导入人名的tel放入页面人名对应的input里面
		var len_1 = arr1.length;
		//增加部门不一致的提示，提示更新部门
		var org_user = new Array();
		for(var i=0;i<len_1;i++){
			var name = arr1[i]["name"];
		//新的组织名称
		var norg = arr1[i]["orgName"];
			var oo = new Array();
			for(var j=0;j<telInputs.length;j++){
				var o = new Array();
				var iname = telInputs[j]["PERSON_NAME"];
				if(name==iname){
					//目前的组织名称
					var oorg = telInputs[j]["ORGOLD"];
					var oorgId = telInputs[j]["ORGOLDID"];
					var uid = telInputs[j]["UID"];
					//部门发生变化
					if (norg!=oorg){
						var orgEdit = new Array();
						orgEdit["uuid"]=uid;
						orgEdit["name"]=name;
						orgEdit["newOrg"]=norg;
						orgEdit["oldOrg"]=oorg;
						orgEdit["oldOrgId"]=oorgId;
						var org_id = orgs[norg];
						if (org_id!=null){
							orgEdit["newOrgId"]=orgs[norg];
						}
						if (norg!=null && norg!=""){
							org_user[org_user.length]=orgEdit;
						}
					}
					o["in"]=telInputs[j];
					o["out"]=arr1[i];
					oo[oo.length]=o;
				}
			}
			//如果oo的长度超过了1，那么就是有重复的,如果oo长度为0，就是没有对应的，如果为1，就是就是正常的
			if(oo.length==1){
				okArray[okArray.length]=oo;
			}
			if(oo.length==0){
				noneArray[noneArray.length]=arr1[i];
			}
			if(oo.length>1){
				warnArray[warnArray.length]=oo;
			}
		}
		//alert("警告的数据：" + warnArray.length + "\n正确的数据：" + okArray.length+ "\n忽略的数据：" + noneArray.length);
		//进行更新电话号码

		var nn=1;
		for(var i=0;i<warnArray.length;i++){
			var one = warnArray[i];
			for(var j=0;j<one.length;j++){
				var o = one[j]["in"]["obj"];
				var out = one[j]["out"];
				var tel = out["tel"];
				o.value=tel;
				_setColor(o,warnColor,nn);
			nn++;
			}
		}
		for(var i=0;i<okArray.length;i++){
			var one = okArray[i];
			for(var j=0;j<one.length;j++){
				var o = one[j]["in"]["obj"];
				var out = one[j]["out"];
				var tel = out["tel"];
				o.value=tel;
				_setColor(o,okColor,nn);
				nn++;
			}
		}
		/**for(var i=0;i<noneArray.length;i++){
			var one = noneArray[i];
			var n = one["name"];
			var t = one["tel"];
			alert(n+ "=" + t);
		}*/
		_loadMessage(warnArray,okArray,noneArray,errArray,org_user);
	}
	function _loadMessage(warnArray,okArray,noneArray,errArray,org_user){
		var str ="<table style=\"width: 280px;\" class=\"tip\"><tr><td class=\"title\">成功匹配";
		str+=okArray.length;
		str+="个手机号码。</td></tr>";
		if(noneArray.length>0){
			str+="<tr><td class=\"title\">以下人员无法对应，请手工对应：</td></tr><tr><td class=\"msg\">";
			for(var i=0;i<noneArray.length;i++){
				var one = noneArray[i];
				var n = one["name"];
				var t = one["tel"];
				str+="<table><tr><td class=\"t\">"+n+ ":</td><td><input type=\"text\" value=\"" + t + "\"></td></tr></table>";
			}
			str+="</td></tr>";
		}
		if(errArray.length>0){
			str+="<tr><td class=\"title\">以下人员的手机号不符合要求，请解决：</td></tr><tr><td class=\"msg\">";
			for(var i=0;i<errArray.length;i++){
				var one = errArray[i];
				var n = one["name"];
				var t = one["tel"];
				str+="<table><tr><td class=\"t\">"+n+ ":</td><td><input type=\"text\" value=\"" + t + "\"></td></tr></table>";
			}
			str+="</td></tr>";
		}
		if(warnArray.length>0){
			str+="<tr><td class=\"title\">以下人员名称有冲突，请解决：</td></tr><tr><td class=\"msg\">";
			for(var i=0;i<warnArray.length;i++){
				var one = warnArray[i];
				var n = one[0]["out"]["name"];
				var t = one[0]["out"]["tel"];
				str+="<table><tr><td class=\"t\">"+n+ ":</td><td><input type=\"text\" value=\"" + t + "\"></td></tr></table>";
			}
			str+="</td></tr>";
		}
		str+="<tr><td><center><button onclick=\"window.close();\">关闭提示</button></center>";
		str+="</td></tr></table>";

		var obj=document.getElementById("tipMsgObj");
		obj.value=str;
		modelessDialog("<BZ:url/>/jsp/framework/shortinfo/tip.htm",obj,300,500);
	//输出组织变更提示，并一个个更新数据库，弹出一个新的页面来提示组织变化
	outputOrgs(org_user);
	}
	function outputOrgs(org_user){
		var len = org_user.length;
		if (len<=0){
			return;
		}
		var str="";
		for(var i=0;i<len;i++){
		var org = org_user[i];
		var id = org["uuid"];
		var name = org["name"];
		var norg = org["newOrg"];
		var old = org["oldOrg"];
		var oldid = org["oldOrgId"];
		var orgid = org["newOrgId"];
		str+="<tr>";
		str +="<td>" + name + "</td>";
		str +="<td>" + old + "</td>";
		str +="<td>" + norg + "</td>";
		if (orgid==null){
			str +="<td title=\"新部门无法匹配，请到人员管理中人工更新\">无法匹配部门</td>";
		}else{
			str +="<td><input type=\"button\" value=\"更新\" onclick=\"updateMe(this,'" + id + "','" + oldid + "','" + orgid + "');\"></td>";
		}
		str+="</tr>";
		}

		var obj=document.getElementById("tipOrgObj");
		obj.value=str;
		modelessDialog("<BZ:url/>/jsp/framework/shortinfo/org.jsp",obj,420,500);
	}
	function _keySearch(){
		var ev = window.event;
		if((ev.keyCode && ev.keyCode==13)){
			_search();
		}
	}
	var orgs = new Array();
<%
	DataList dl = (DataList) request.getAttribute("linksInner");
	for (int i = 0; i < dl.size(); i++) {
		Data dd = dl.getData(i);
%>
	orgs["<%=dd.getString("ORG_NAME")%>"]="<%=dd.getString("ORG_ID")%>";

<%
	}
%>
</script>
<style type="text/css">
.tip {
	border-left-style: solid;
	border-left-width: 1px;
	border-right: 1px solid #C0C0C0;
	border-top-style: solid;
	border-top-width: 1px;
	border-bottom: 1px solid #C0C0C0;
	background-color: #FFFFFF;
	font-size:14px;
}
</style>

</BZ:head>
<BZ:body onload="_onload()">
<textarea id="tipMsgObj" style="display:none"></textarea>
<textarea id="tipOrgObj" style="display:none"></textarea>
<DIV id=tip style='left:500px;POSITION:absolute;TOP:18px;display:none'></div>
	<form name="srcForm" method="post"
		action="<%=request.getContextPath()%>/linkman/innerlist.action">
		<input type="hidden" name="personIds" id="personIds" value="" />
		<input type="hidden" name="personTels" id="personTels" value="" />
		<div class="kuangjia" style="margin: 0;">
		<div class="heading">
			查询条件
		</div>
		<div class="chaxun">
			<table class="chaxuntj">
				<tr>
				<td width="10%" style="text-align: right;">部门：</td>
				<td width="20%"><BZ:input field="ORGNAME" property="search" prefix="SEARCH_" defaultValue="" onkeyup="_keySearch();"/></td>
				<td width="10%" style="text-align: right;">姓名：</td>
				<td width="20%"><BZ:input field="CNAME" property="search" prefix="SEARCH_" defaultValue="" onkeyup="_keySearch();"/></td>
				<td width="10%" style="text-align: right;">手机号：</td>
				<td width="20%"><BZ:input field="MOBILE" property="search" prefix="SEARCH_" defaultValue="" onkeyup="_keySearch();"/></td>
				<td width="10%"><input type="button" value="查询" class="button_search" onclick="_search()"/></td>
				</tr>
			</table>
		</div>
		<input id="LinkMan_IDS" name="IDS" type="hidden" />
		<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
		<input type="hidden" name="compositor" value="<%=compositor%>" />
		<input type="hidden" name="ordertype" value="<%=ordertype%>" />

		<div class="list">
			<div class="heading" style="border-top: 1px a3bae0 solid;">
				<span style="text-align: left; width: 20%">联系人列表</span><span
					style="text-align: right; width: 80%;"><input type="button"
						value="导入" class="button_add" onclick="_import();" />&nbsp;&nbsp;<input
						type="button" value="保存" class="button_save" onclick="_saveAll();" />
				</span>
			</div>
			<BZ:table tableid="tableGrid" tableclass="tableGrid">
				<BZ:thead theadclass="titleBackGrey">
					<BZ:th name="序号" width="5%" sortType="none" sortplan="jsp" />
					<BZ:th name="部门" width="30%" sortType="string" sortplan="jsp" />
					<BZ:th name="姓名" width="20%" sortType="string" sortplan="jsp" />
					<BZ:th name="手机号" width="45%" sortType="string" sortplan="jsp" />
				</BZ:thead>
				<BZ:tbody>

					<%
						String txt = "";
										DataList dataList = (DataList) request
												.getAttribute("linksInner");
										for (int i = 0; i < dataList.size(); i++) {
											Data dd = dataList.getData(i);
					%>
					<tr style="" class="style20" id="<%=dd.getString("ID")%>">
						<td noselect="true"><%=i + 1%></td>
						<td><%=dd.getString("ORG_NAME", "")%></td>
						<td><%=dd.getString("PERSON_NAME")%></td>
						<td>
							<div id='innerDiv'>
								<input type='text' tel="true" uid="<%=dd.getString("ID")%>" orgid="<%=dd.getString("ORG_ID")%>" orgName='<%=dd.getString("ORG_NAME", "")%>' cname='<%=dd.getString("PERSON_NAME")%>' id='t_<%=dd.getString("ID")%>'
									value='<%=dd.getString("MOBILE", "")%>'
									ovalue='<%=dd.getString("MOBILE", "")%>'
									onclick="chgBtn('<%=dd.getString("ID")%>','')"
									onblur="chgBtn('<%=dd.getString("ID")%>','none')" />
								&nbsp;&nbsp;
								<input type='button' value='保存' class='button_save'
									id='btn1_<%=dd.getString("ID")%>'
									onclick="AjaxAddValue('<%=dd.getString("ID")%>')"
									style="display: none; " />
								&nbsp;
								<input type='button' value='恢复' class='button_back'
									id='btn2_<%=dd.getString("ID")%>'
									onclick="_cancel('<%=dd.getString("ID")%>')"
									style="display: none" />
								<input type='button' value='解除警告' class='button_back'
									id='btn3_<%=dd.getString("ID")%>'
									onclick="_jinggao('<%=dd.getString("ID")%>')"
									style="display: none" />
							</div>
						</td>
					</tr>
					<%
						}
					%>

				</BZ:tbody>
			</BZ:table>
			<table border="0" cellpadding="0" cellspacing="0" class="operation">
			<tr>
			<td colspan="2"><BZ:page form="srcForm" property="linksInner"/></td>
			</tr>
			</table>
		</div>
		</div>
	</form>
</BZ:body>
</BZ:html>
