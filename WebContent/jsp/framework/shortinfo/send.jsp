<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="hx.util.UtilString"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.shortinfo.vo.Sms_Magzine"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String SEND_CONTENT = (String)request.getAttribute("SEND_CONTENT");
String org_id = (String)request.getAttribute("org_id");
String orgName_personName = (String)request.getAttribute("orgName_personName");
DataList dataList = (DataList)request.getAttribute("dataList");
String replyNo = (String)request.getAttribute("replyNo");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<BZ:html>
<BZ:head>
<meta http-equiv="Content-Language" content="zh-cn" />
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>发送信息</title>
<link href="<BZ:resourcePath />/main/css/wpage.css" rel="stylesheet" type="text/css" /> 
<BZ:script isEdit="true" isDate="true" isAjax="true"/>
<script type="text/javascript" src="<%=path %>/jsp/framework/shortinfo/js/mSift.js"></script>
<script type="text/javascript">
function _select(){
	var returnValue = modalDialog("<%=path%>/sendMessage/getGroup.action",null,800,660);
	if (returnValue!=null&&returnValue!="&nbsp;"){
		document.getElementById("shoujian").innerHTML=document.getElementById("shoujian").innerHTML+returnValue;
	}
}

function _calc(o){
	var len = parseInt(o.value.length,10);
	var c = parseInt(len/70,10);
	var c1 = len%70;
	if (c1>0){
		c++;
	}
	var b = c*70;
	var a = len;
	if (b==0){
		b =70;
	}
	document.getElementById("a").innerText = a;
	document.getElementById("b").innerText = b;
	document.getElementById("c").innerText = c;
	_view();
}
function _view(){
    document.body.className = "bodyGround";
    
	<%-- if('GZJ09'=='<%=org_id %>'){
		document.getElementById("TD_IS_CLASS").style.display="block";
	} --%>
	
	var view = document.getElementById("view");
	var txt = document.getElementsByName("Send_CONTENT")[0].value;
	if (txt.length>87){
		txt = txt.substring(0,87) + "...";
	}
	view.innerHTML=txt;
	document.getElementsByName("Send_CONTENT")[0].focus();
}
function sel(o){
	var context = document.getElementsByName("Send_CONTENT")[0];
	var v = "<span id='replayId'>[请输入<%=replyNo%>+内容回复]</span>";
	var td = document.getElementById("view");
	var cv = context.value;
	var l = cv.indexOf(v);
	if (o.checked){
		document.getElementById("huizhi").innerHTML="需要回复<font color='red'>（仅移动用户可以回复）</font>,回复前缀为<%=replyNo%>";
		td.innerHTML = td.innerHTML+v;
		document.getElementById("Send_NEED_REPLY").value="1";
	}else{
		document.getElementById("huizhi").innerHTML="需要回复<font color='red'>（仅移动用户可以回复）</font>";
		var span = document.getElementById("replayId");
		span.parentNode.removeChild(span);
		document.getElementById("Send_NEED_REPLY").value="0";
	}
}

function sm(o){
	var context = document.getElementsByName("Send_CONTENT")[0];
	var v = "<%=orgName_personName%>";
	var cv = context.value;
	var l = cv.indexOf(v);
	if (o.checked){
		if(l<0){
			context.value+=v;
			document.getElementById("Send_NEED_SIGN").value = "1";
		}
	}else{
		if(l>0){
			context.value=cv.substring(0,l);
			context.value+=cv.substring(l+v.length);
		}else if(l==0){
			context.value=cv.substring(v.length);
		}
 		document.getElementById("Send_NEED_SIGN").value="0";
	}
	_view();
}


function che(o){
	if(o.checked){
		document.getElementById("magzine").style.display = "block";
		document.getElementById("Send_IS_CLASS").value = "1";
	}else{
		document.getElementById("magzine").style.display = "none";
		document.getElementById("Send_IS_CLASS").value = "0";
	}	
}

function _focus(o){
	if (o.value=="请输入手机号码，多个号码之间以逗号分隔"){
		o.value="";
	}
	o.className="style7";
}
function _blur(o){
	if (o.value==""){
		o.className="style8";
		o.value="请输入手机号码，多个号码之间以逗号分隔";
	}
	
}

function _deleteReciever(img){
	var span = img.parentNode;
	span.parentNode.removeChild(span);
}

function _deleteGroup(img){
	_deleteReciever(img);
}


function _saveDraft(v){
	var div = document.getElementById("shoujian");
	var mobileNumber = document.getElementById("mobileNumber").value;
	var extMobileNumber = document.getElementById("mobileNumbers").value;
	var spans = div.childNodes;
	var Send_CONTENT = document.getElementsByName("Send_CONTENT")[0].value;
	var o = document.getElementById("replay_CheckId");
	if(o.checked){
		var reply = "[请输入<%=replyNo%>+内容回复]";
		Send_CONTENT = Send_CONTENT + reply;
	}
	document.getElementsByName("Send_CONTENT")[0].value = Send_CONTENT;
	if (document.getElementsByName("Send_CONTENT")[0].innerText.length==0){
		alert("请输入短信内容");
		document.getElementsByName("Send_CONTENT")[0].focus();
		return;
	}
	if(spans.length>0||(document.getElementById("mobileNumbers").innerText.length!=0 && document.getElementById("mobileNumbers").innerText!="请输入手机号码，多个号码之间以逗号分隔")){
		var str = "";
		for(var i=0;i<spans.length;i++){	
			if(typeof(spans[i].abc)!=="undefined")
			str+=spans[i].abc+"#";
		}
		//alert('11');
		
		
		var str2 = "";
		var extMobileNums = extMobileNumber;
		if(extMobileNums != null && extMobileNums != ""){
			extMobileNums = extMobileNums.replaceByString("	",",");
			extMobileNums = extMobileNums.replaceByString("，",",");
			extMobileNums = extMobileNums.replaceByString("；",",");
			extMobileNums = extMobileNums.replaceByString(";",",");
			extMobileNums = extMobileNums.replaceByString("\r\n",",");
			var extArrs = extMobileNums.split(",");
			if(extArrs != null && extArrs.length > 0){
				for(var i = 0; i < extArrs.length; i++){
					var curNum = extArrs[i];
					if (curNum!="" && curNum.indexOf("请输入手机号码") < 0 && curNum.indexOf("多个号码之间以逗号分隔") < 0){
						if(!curNum.isMobileTelephone()){
							alert(curNum + " 不是手机号！");
							document.getElementById("mobileNumbers").focus();
							return;
						}
						str2 += "," + curNum + "," + curNum + ",,#";
					}
				}
				
				//白名单+权限验证 先验证白名单 在验证权限
				if (extMobileNums!="" && extMobileNums.indexOf("请输入手机号码") < 0 && extMobileNums.indexOf("多个号码之间以逗号分隔") < 0){
					var isRight = getStr("com.hx.framework.shortinfo.AjaxWhitelistAndPerviewCheck","mobiles="+extArrs);
					//alert(isRight);
					var rs = isRight.split("#");
					var type = rs[0];
					var errormobiles = rs[1];
					if(type == "1"){
						alert(errormobiles+" 手机号码不在系统白名单中，请联系管理员添加白名单。");
						return;
					}
					if(type == "2"){
						alert("您没有授权给 "+errormobiles+" 发送短信，请联系管理员。");
						return;
					}
				}
			}
		}
		
		if(v=='1'){
			if(!confirm('确定发送此信息吗？')){
				return;
			}
		}
		str += str2;
		document.getElementById("inceptPerson").value = str;
		document.srcForm.action = "<%=path%>/sendMessage/send.action?STATUS="+v;
		document.srcForm.submit();
	}else{
		alert("请选择接收人！");
	}
}

</script>
<style type="text/css">
span{
	display:inline-block;
}

td{
	font-size:12px;
}
.style1 {
	border: 1px solid #CCC;
	background-color: #C0C0C0;
}
.style2 {
	background-color: #EFEFEF;
	height:30px;
}
.u{
	cursor:pointer;
}
.style3 {
	text-align: right;
}
.style4 {
	border-style: none;
	border-width: 0;
}
.style5 {
	background-color: #EFEFEF;
}
.style7 {
	border-style: inherit;
	border-width: 1px;
	border-color: gray;
	background-color: #FFFFFF;
	width:90%;
	color:#000000;
}

.style8 {
	border-style: inherit;
	border-width: 1px;
	border-color: gray;
	background-color: #FFFFFF;
	width:90%;
	color:silver;
}


.style9 {
	background-image: url('<%=path%>/jsp/framework/shortinfo/images/bj.png');
}

</style>
</BZ:head>
<BZ:body onload="_view()">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="inceptPerson" id="inceptPerson" value=""/>
<table style="width: 100%;margin-top: 10px;" cellspacing="1" class="style1">
	<tr>
		<td class="xx_Ttab1" height="22px">
			发短信
		</td>
	</tr>
	<tr>
		<td class="style2" style="height:30px;">
		<table style="width:100%;height:30px;" class="style4">
			<tr>
				<td title="点击选择收件人或收件组" style="width:10%;height:30px;vertical-align:middle;cursor:pointer;border-right: 1px solid #CCC;" nowrap onclick="_select()">收&nbsp; 件&nbsp; 人：<br/><span style="color: red">(点击选择收<br/>件人或收件组)</span></td>
				<td bgcolor="#ffffff" width="90%"><div id="shoujian" style="height:80px;overflow:auto;"></div></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="style2" style="height:22px;">
		<table  class="style4" style="width:100%;height:22px;">
			<tr>
				<td style="width:10%;height:22px;vertical-align:middle;border-right: 1px solid #CCC;" title="请输入手机号码，多个号码之间以逗号分隔" nowrap>快捷输入：</td>
				<td>
					<input type="text" style="height:18px;" name="mobileNumber" id="mobileNumber" class="style8" value="请输入手机号码，多个号码之间以逗号分隔" onfocus="_focus(this)" onblur="_blur(this)" value="<%=request.getAttribute("quickInput")!=null?request.getAttribute("quickInput"):""  %>" />
					<script type="text/javascript">
						var oo=new mSift('oo',350);
						oo.Data=[<%=request.getAttribute("quickInput") %>];
						oo.Create(document.getElementById('mobileNumber'));
					</script>
				</td>
			</tr>
		</table>
		
		</td>
	</tr>
	<tr>
		<td class="style2" style="height:22px;">
		<table  class="style4" style="width:100%;height:22px;">
			<tr>
				<td style="width:10%;height:22px;vertical-align:middle;border-right: 1px solid #CCC;" title="请输入手机号码，多个号码之间以逗号分隔" nowrap>快捷发送：<br><span style="color: red">(直接输入<br>手机号发送)</span></td>
				<td>
					<textarea style="height:40px;" name="mobileNumbers" id="mobileNumbers" class="style8"  onfocus="_focus(this)" onblur="_blur(this)" ></textarea>
				</td>
			</tr>
		</table>
		
		</td>
	</tr>
	<tr>
		<td style="height: 161px" class="style2" valign="top">
		<table style="width: 100%" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<textarea style="width:99%;height:250px" onkeyup="_calc(this)" name="Send_CONTENT" rows="1" cols="20"><%=UtilString.filterNull(SEND_CONTENT) %></textarea>
				</td>
				<td style="vertical-align:top;width:245px" class="style9">
				<table style="width: 100%" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width: 27px">&nbsp;</td>
						<td style="width: 191px">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td style="width: 27px">&nbsp;</td>
						<td style="width: 191px;font-weight:bold;padding-top:15px; ">0223011233</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td style="width: 27px; height: 23px;"></td>
						<td style="width: 191px; height: 23px;"></td>
						<td style="height: 23px"></td>
					</tr>
					<tr>
						<td style="width: 27px">&nbsp;</td>
						<td style="width: 191px;font-size:12px;word-break:break-all;" id="view">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td style="width: 27px">&nbsp;</td>
						<td style="width: 191px">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
&nbsp;</td>
	</tr>
	<tr>
		<td class="style2">
		<table style="width: 100%" class="style5" border="0">
			<tr>
				<td nowrap="nowrap" style="width:150px;"><span id="a">0</span>/<span id="b">70</span>（字符）<span id="c">1</span>条短信息</td>
				<td nowrap="nowrap" class="style2" style="width:60px;">
					<input onclick="sm(this)" type="checkbox">
					<input type="hidden" name="Send_NEED_SIGN" value="0" id="Send_NEED_SIGN" />
					<span>署名</span>
				</td>
				<td nowrap="nowrap" class="style2" style="width:320px;">
					<input onclick="sel(this)" type="checkbox" id="replay_CheckId">
					<input type="hidden" name="Send_NEED_REPLY" value="0" id="Send_NEED_REPLY"/>
					<span id="huizhi">需要回复<font color="red">（仅移动用户可以回复）</font></span>
					<input type="hidden" value="<%=replyNo %>" name="Send_REPLY_NO">
				</td>
				<td nowrap="nowrap" class="style2" style="width:300px;display: none" id="TD_IS_CLASS">
					<span><input onclick="che(this)" type="checkbox"/>是否为短信课堂&nbsp;<select name="magzine_id" id="magzine" style="display: none">
						<%
							for(int i=0;i<dataList.size();i++){
								Data data = dataList.getData(i);
						 %><option value="<%=data.getString(Sms_Magzine.ID) %>"><%=data.getString(Sms_Magzine.ALL_ISSUE) %></option>
						 <%
						 	}
						  %></select>
					</span>
					<input type="hidden" name="Send_IS_CLASS" value="0" id="Send_IS_CLASS" />					
				</td>
				<td nowrap="nowrap" class="style3"><input type="button" onclick="_saveDraft(0);" value="保存为草稿" class="button_update">&nbsp;<input type="button" onclick="_saveDraft(1);" value="发送" class="button_add">&nbsp;<input onclick="_close()" type="button" value="关闭" class="button_delete">&nbsp;<input onclick="window.history.back();" type="button" class="button_back" value="返回"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</BZ:form>
</BZ:body>
</BZ:html>

