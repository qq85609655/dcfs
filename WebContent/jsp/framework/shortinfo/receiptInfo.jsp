<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.util.UtilString"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	String compositor = (String) request.getAttribute("compositor");
	DataList dataList = (DataList) request.getAttribute("relist");
	Data data0 = dataList.getData(0);
	String sendId = "";
	if(data0!=null){
		sendId = data0.getString("ID");
	}
	String span = "<span onclick='_inputReturnValue(this);' style='cursor: hand;background-color: #e9f2fd;'>点击请输入回执内容</span>";
	if (compositor == null) {
		compositor = "";
	}
	String ordertype = (String) request.getAttribute("ordertype");
	if (ordertype == null) {
		ordertype = "";
	}
	DataList relist = (DataList) request.getAttribute("relist");
	String infocontent = "";
	if (relist.size() > 0) {
		infocontent = relist.getData(0).getString("CONTENT", "");
	}
%>
<BZ:html>
<BZ:head>
	<title>回执情况</title>
	<BZ:script isAjax="true" isList="true"/>
	<script type="text/javascript">
  
  function _add(){
    //window.showModalDialog("<%=path%>/usergroup/tosetgroup.action",null,"dialogWidth=500px;dialogHeight=300px");
  	//document.srcForm.submit();
  	document.srcForm.action=path+"usergroup/tosetgroup.action";
  	document.srcForm.submit();
  }
	function _close()
	{
	   window.close();
	}
	function _inputReturnValue(thisSpan){
		var td = thisSpan.parentNode;
		var tr = td.parentNode;
		recieverId = tr.id;
		td.innerHTML = "<div id='innerDiv'><input type='text' id='reciverReturnValue'/>&nbsp;&nbsp;<input type='button' value='保存' class='button_save' id='"+recieverId+"Save' onclick=AjaxAddReturnValue('"+recieverId+"') />&nbsp;<input type='button' value='取消' class='button_back' id='cancelId' onclick=_cancel(this) /></div>";
		thisSpan.style.display = "none";
	}
	function _cancel(cancelButton){
		var div =  cancelButton.parentNode;
		var td = div.parentNode;
		div.parentNode.removeChild(div);
		td.innerHTML = "<%=span %>";
	}
	function AjaxAddReturnValue(recieverId){
		var revertValue = document.getElementById("reciverReturnValue").value;
		if(revertValue==""){
			alert("请输入回执内容！");
			return ;
		}
		var data = getData("com.hx.framework.shortinfo.AjaxAddReturnValue","recieverId="+recieverId+"&revertValue="+revertValue);
		var tds = document.getElementById(recieverId).childNodes;
		tds[4].innerHTML = data.getString("CONTENT");
		tds[5].innerHTML = data.getString("RECEIPT_TIME");
	}
	
	function _saveReturnValue(recieverId){
		document.getElementById("ReceiverId").value = recieverId;
		document.getElementById("ReceiverContent").value = document.getElementById("reciverReturnValue").value;
		document.srcForm.action = path+"doneinfo/revert.action";
	}
	 function _onload(){
	  
	 }
</script>
	<style type="text/css">
.style1 {
	background-color: #FFFFFF;
	font-size: 12px;
	text-align: left;
	text-indent: 12px;
}

.style2 {
	background-color: #e9f2fd;
	font-size: 12px;
	text-align: right;
	height: 25px;
	width: 10%;
}

.style3 {
	background-color: #e9f2fd;
	font-size: 12px;
	text-align: center;
	height: 25px;
	font-weight: bold;
	border-top: solid 1;
	border-bottom: solid 1;
	border-right: solid 1;
}

.style4 {
	text-align: left;
	background-color: #FFFFFF;
	font-weight: bold;
}

.style20 {
	background-color: #FFFFFF;
	font-size: 12px;
	text-align: left;
	text-indent: 0px;
	height: 25px;
}
</style>
</BZ:head>
<BZ:body onload="_onload();">
	<BZ:form name="srcForm" method="post">
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<input type="hidden" name="sendId" value="<%=sendId %>"/>
		<input type="hidden" name="ReceiverId" id="ReceiverId" value=""/>
		<input type="hidden" name="ReceiverContent" id="ReceiverContent" value=""/>
		<div class="kuangjia">
			<div class="heading">
				回执情况列表
			</div>
			<table style="width: 100%; height: 25px;" class="" cellspacing="1">
				<tr>
					<td class="style2" style="width: 20%; text-align: right" nowrap>
						短信发送内容：
					</td>
					<td class="style1" style="width: 80%">
						<%=infocontent%>
					</td>
				</tr>

			</table>
			<div class="list">
			<BZ:table tableid="tableGrid" tableclass="tableGrid">
				<BZ:thead theadclass="titleBackGrey">
					<BZ:th name="序号" sortType="string" width="6%" sortplan="jsp"/>
					<BZ:th name="接收者(号码)" sortType="string" width="15%" sortplan="jsp"/>
					<BZ:th name="接收状态" sortType="string" width="14%" sortplan="jsp"/>
					<BZ:th name="接收时间" sortType="date" width="15%" sortplan="jsp"/>
					<BZ:th name="回执内容" sortType="string" width="35%" sortplan="jsp"/>
					<BZ:th name="回执时间" sortType="date" width="15%" sortplan="jsp"/>
				</BZ:thead>
				<BZ:tbody>
					<%
						for (int i = 0; i < dataList.size(); i++) {
										Data data = dataList.getData(i);
					%>
					<tr style="" class="style20" id="<%=data.getString("B_ID") %>">
						<td noselect="true"><%=i%></td>
						<td><%=data.getString("RECEIVENAME")%>(<%=data.getString("MOBILE")%>)</td>
						<td><%=data.getString("STATUS_CNAME")%></td>
						<td><%=data.getString("SEND_TIME")%></td>
						<td name="replyName"><%="".equals(UtilString.filterNull(data
											.getString("RECONTENT")))&&!"true".equals(request.getParameter("noReply")) ? span
									: data.getString("RECONTENT","")%></td>
						<td><%=UtilString.filterNull(data
											.getString("RECEIPT_TIME"))%></td>
					</tr>
					<%
						}
					%>
				</BZ:tbody>
			</BZ:table>
			<table border="0" cellpadding="0" cellspacing="0" class="operation">
				<tr>
					<td style="width: 100%;" align="right"><input type="button" class="button_delete" onclick="window.close();" value="关闭"/></td>
				</tr>
			</table>
			<br>
			<table border="0" cellpadding="0" cellspacing="0" class="tableGrid" style="color: blue">
				<tr>
					<td style="width: 16%;" align="right">&nbsp;</td>
					<td style="width: 80%;" align="left">&nbsp;</td>
				</tr>
				<tr>
					<td style="width: 100%;color: red;" align="left" colspan="2">短信发送过程：由短信平台先将短信发送到短信网关，短信网关再发送到用户手机，用户接收到短信后可进行回复（只支持移动用户回复短信）</td>
				</tr>
				<tr>
					<td style="width: 10%;" align="left" nowrap="nowrap">短信发送接收状态说明：</td>
					<td style="width: 80%;" align="left"></td>
				</tr>
				<tr>
					<td style="width: 10%;" align="right">待发送：</td>
					<td style="width: 80%;" align="left">短信还未发送到短信网关</td>
				</tr>
				<tr>
					<td style="width: 10%;" align="right">已送到网关：</td>
					<td style="width: 80%;" align="left">短信已送达短信网关，但短信网关还未受理</td>
				</tr>
				<tr>
					<td style="width: 10%;" align="right">发送到网关失败：</td>
					<td style="width: 80%;" align="left">短信未成功送达短信网关</td>
				</tr>
				<tr>
					<td style="width: 10%;" align="right">网关已受理：</td>
					<td style="width: 80%;" align="left">短信已送达短信网关，而且短信网关已处理</td>
				</tr>
				<tr>
					<td style="width: 10%;" align="right">手机接收成功：</td>
					<td style="width: 80%;" align="left">用户已成功接收到短信</td>
				</tr>
				<tr>
					<td style="width: 10%;" align="right">手机接收失败：</td>
					<td style="width: 80%;" align="left">短信网关已向用户手机发送短信，但用户手机接收失败</td>
				</tr>
			</table>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>
