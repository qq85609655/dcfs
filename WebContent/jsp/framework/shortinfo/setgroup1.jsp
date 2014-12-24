<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
DataList orglist = (DataList)request.getAttribute("orglist");
DataList posilist = (DataList)request.getAttribute("posilist");
String group_type = (String)request.getAttribute("GROUP_TYPE");
%>
<BZ:html>
<BZ:head>
<title>设置分组</title>
<base target = "_self">
<BZ:script isDate="true" isEdit="true" tree="true"/>
<script src="<BZ:resourcePath/>/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
function _c(v){
	if(v==1){// from whilelist
		document.getElementById("innerLinkman").style.display = "none";
		document.getElementById("outerLinkman").style.display = "block";
		document.getElementById("su_1").checked=true;
		document.getElementById("su_2").checked=false;
		document.getElementById("type").value="1";
	}else{
		document.getElementById("innerLinkman").style.display = "block";
		document.getElementById("outerLinkman").style.display = "none";
		document.getElementById("su_1").checked=false;
		document.getElementById("su_2").checked=true;
		document.getElementById("type").value="2";
	}
}
function ajaxOrg(id){
		var node = $("#d1");
		$.ajax({
			type: "post",//请求方式
					url: "<%=path %>/usergroup/ajaxOrg.action?ID="+id,
					data: "time=" + new Date().valueOf(),
					dataType: "json",
					success: function(rs){
					var arrs = rs.json;
					node.empty();
					var res = "";
					if(arrs.length > 0){
						$.each(arrs,function(i,obj){
							res += "<option value='"+obj.ID+"'>"+obj.NAME+"</option>";
								//d1.options.add(new Option(people  + "(13800138000)","13800138000"));

						});
					node.append(res);
				}
				}
		});
	}
function ajaxPos(id){
		var node = $("#d1");
		$.ajax({
			type: "post",//请求方式
					url: "<%=path %>/usergroup/ajaxPos.action?ID="+id,
					data: "time=" + new Date().valueOf(),
					dataType: "json",
					success: function(rs){
					var arrs = rs.json;
					node.empty();
					var res = "";
					if(arrs.length > 0){
						$.each(arrs,function(i,obj){
							res += "<option value='"+obj.ID+"'>"+obj.NAME+"</option>";

						});
					node.append(res);
				}
				}
		});
	}

function ajaxLink(){
		var node = $("#d1");
		$.ajax({
			type: "post",//请求方式
					url: "<%=path %>/usergroup/ajaxLink.action",
					data: "time=" + new Date().valueOf(),
					dataType: "json",
					success: function(rs){
					var arrs = rs.json;
					node.empty();
					var res = "";
					if(arrs.length > 0){
						$.each(arrs,function(i,obj){
							res += "<option value='"+obj.ID+"'>"+obj.NAME+"</option>";

						});
					node.append(res);
				}
				}
		});
	}

function _selectAll(){
		var d1 = document.getElementById("d1");
		var d2 = document.getElementById("d2");
	var l = d1.options.length;
	for(var i=0;i<l;i++){
		var option = d1.options[i];
		//if (option.selected){
			d2.options.add(new Option(option.text,option.value));
		//}
	}
	for(l--;l>=0;l--){
		var option = d1.options[l];
		//if (option.selected){
			d1.options.remove(l);
		//}
	}

}
function _selectp(){
		var d1 = document.getElementById("d1");
		var d2 = document.getElementById("d2");
	var l = d1.options.length;
	for(var i=0;i<l;i++){
		var option = d1.options[i];
		if (option.selected){
			d2.options.add(new Option(option.text,option.value));
		}
	}
	for(l--;l>=0;l--){
		var option = d1.options[l];
		if (option.selected){
			d1.options.remove(l);
		}
	}
	//var option = d1.options[d1.options.selected].text;
	//alert(option);
}
function _removep(){
		var d2 = document.getElementById("d2");
	var l = d2.options.length;
	for(l--;l>=0;l--){
		var option = d2.options[l];
		if (option.selected){
			d2.options.remove(l);
		}
	}

}
function _clearp(){
		var d2 = document.getElementById("d2");
	var l = d2.options.length;
	for(l--;l>=0;l--){
		var option = d2.options[l];
		//if (option.selected){
			d2.options.remove(l);
		//}
	}

}
function _ok1()
{

	var val = document.getElementById("egroupName").value;
	val = val.trim();
	if(val == null || val == "" || val.length == 0){
		alert("请输入群组名称!");
		document.getElementById("egroupName").focus();
		return false;
	}

		var d2 = document.getElementById("d2");

		if(d2.length == 0){
			alert("请选择群组人员!");
			return false;
		}

		var ps ="";
		for(var i=0;i<d2.length;i++)
		{
		var val = d2.options[i].value;
		if(i == (d2.length - 1)){
			ps+=val;
		}else{
			ps+=val+",";
		}
		}
		document.getElementById("ids").value=ps;
		document.srcForm.action=path+"usergroup/add.action";
	document.srcForm.submit();
	window.returnValue="1";
	window.close();
}

function L(id,selNode){
	reValue = new Array();
	if(!selNode || selNode=="false"){
		isSelNode=false;
	}
	//处理
	childFrame.location="<%=request.getContextPath() %>/usergroup/personList1.action?<%=OrganPerson.ORG_ID%>="+id;
}

</script>
<style type="text/css">
.style1 {
	font-size:12px;
	text-align:center;
	height:25px;
	font-weight:bold;
	}
.style2{
	text-align: center;
}
.style3 {
	font-size: 12px;
	text-align: right;
	text-indent: 12px;
	height: 25px;
}

</style>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post" target="groupIframe">
<iframe name="groupIframe"  width="0"   height="0"  frameborder="0"   style="display:none">
</iframe>
<input type="hidden" name="IDS" id="ids"/>
<input type="hidden" name="Type" id="type" value="2"/>
<input type="hidden" name="GROUP_TYPE" value="<%=group_type %>"/>

<div class="kuangjia">
<div class="heading">添加群组</div>
<table class="contenttable" width="500px" align="center">
	<tr>
		<td class="style1" style="width:20%;text-align:right"  nowrap>群组名称：</td>
		<td style="width:80%"><input id="egroupName" type="text" style="width:300px;" name="egroupName"></td>
	</tr>
	<tr>
		<td nowrap colspan="2">
		<table style="width: 100%" cellspacing="1" align="center">
			<tr>
				<td class="style1" style="width:78%;">待选择人员</td>
				<td class="style1" style="width:22%;">已选择人员</td>
			</tr>
			<tr>
				<td nowrap class="style1" valign="top">
				<div style="display:none;">
				<input type="radio" name="su_" onClick="_c(1)" id="su_1" value="1" >其他联系人
				<input type="radio" name="su_" onClick="_c(2)" id="su_2" value="2" checked>联系人
				</div>
				<table id="innerLinkman" style="width: 100%;height: 100%;display: block;">
					<tr>
						<td style="width: 200px;height: 600px;padding-bottom: 25px;" valign="top">
							<BZ:tree property="organList" type="0" iconPath="/images/tree_org/" topName="请选择"/>
						</td>
						<td valign="top">
							<iframe id="childFrame" name="childFrame" src="<BZ:url/>/usergroup/personList1.action" style="width: 100%;height: 600px; overflow-x: hidden; overflow-y: auto;" frameborder="0"></iframe>
						</td>
					</tr>
				</table>
				<table id="outerLinkman" style="width: 100%;height: 100%;display: none;">
					<tr>
						<td width="100%">
							<iframe id="childFrame2" name="childFrame2" src="<BZ:url/>/usergroup/outLinkman.action" style="width: 100%;height: 600px;overflow-x: hidden; overflow-y: auto;" frameborder="0"></iframe>
						</td>
					</tr>
				</table>
				</td>
				<td align="right">
					<input type="button" value="清空" class="button_delete" onClick="_clearp()">
					<select style="width:100%; height: 96%;" multiple="true" name="d2" id="d2" ondblclick="_removep()"></select>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="style3" nowrap colspan="2">
		<input type="button" value="保 存" class="button_save" onClick="_ok1();">&nbsp;&nbsp;
		<!--
		<input type="reset" value="重置" class="button_reset" />&nbsp;&nbsp;
		<input type="button" value="返回" class="button_back" onclick="_back()"/> &nbsp;&nbsp;
		-->
		<input type="button" value="取 消" class="button_close" onclick="window.close();">
		</td>
	</tr>
	</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>
