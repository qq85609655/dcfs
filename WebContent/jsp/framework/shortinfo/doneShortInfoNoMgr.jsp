<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.hx.framework.shortinfo.vo.Sms_Send"%>
<%@page import="com.hx.framework.shortinfo.vo.Send_Receiver"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	DataList infolist = (DataList) request.getAttribute("infolist");
	String reValue = (String) request.getAttribute("reValue");
	Data data_ = (Data)request.getAttribute("data");
	if(data_ == null){
		data_ = new Data();
		request.setAttribute("data",data_);
	}
%>
<BZ:html>
<BZ:head>
	<title>已发信息</title>
	<BZ:script isList="true" isDate="true"/>
	<link href="<BZ:resourcePath />/main/css/wpage.css" rel="stylesheet" type="text/css" />
	<script>
	function tijiao()
	{
	document.srcForm.action=path+"doneinfo/send.action";
 	document.srcForm.submit();
 	document.srcForm.action = path+"doneinfo/searchNoMgr.action";
	}
	
	function _back(){
 	document.srcForm.action=path+"doneinfo/list.action";
 	document.srcForm.submit();
 	document.srcForm.action = path+"doneinfo/searchNoMgr.action";
	}
	
	function _toOther(i,sms_sendId){
		var v = document.getElementById('td'+i).innerHTML;
		document.getElementById("SEND_CONTENT0").value = v;
		document.srcForm.action = path + "/sendMessage/tosendOther.action?sms_sendId="+sms_sendId;
		document.srcForm.submit();
		document.srcForm.action = path+"doneinfo/searchNoMgr.action";
    }
    

    
    function _receipt(sendId,reply)
    {
    	if(reply!="无需回执"){
       		var v = window.showModalDialog("<%=path%>/doneinfo/toreceipt.action?sendId="+sendId+"&noReply=false",null,"dialogWidth=850px;dialogHeight=580px");
       	}else{
       		var v = window.showModalDialog("<%=path%>/doneinfo/toreceipt.action?sendId="+sendId+"&noReply=true",null,"dialogWidth=850px;dialogHeight=580px");
       	}
    }
    
    function _showNumber(id){
       <%
       		for(int i=0;i<infolist.size();i++){
       			Data data = infolist.getData(i);
       			String infoId = data.getString(Send_Receiver.ID);
       %>
		       if(id=='<%=infoId%>'){
		       		alert('<%=data.getString("ReceiveInfos")%>');
		       	}
       <%
       		}
       %>
    }
    
    function _search(){
    	document.srcForm.action = path+"doneinfo/searchNoMgr.action";
    	document.getElementById("SENDER_FLAG").value = "SENDER_FLAG";
    	document.srcForm.page.value = 1;
    	document.srcForm.submit();
    }
    
    function _send(){
    	document.srcForm.action = path+"sendMessage/tosend.action";
    	document.srcForm.submit();
    	document.srcForm.action = path+"doneinfo/searchNoMgr.action";
    }
    function _reSend(sendId){
    	if(confirm("确定重新发送吗？")){
    		document.srcForm.action = path+"sendMessage/resend.action?sendId="+sendId;
        	document.srcForm.submit();
        	document.srcForm.action = path+"doneinfo/searchNoMgr.action";
    	}
    }
    function _onload(){
    	if('<%=reValue%>'!='null'&&'<%=reValue%>'!=""){
    		alert('<%=reValue%>');
    	}
    	document.body.className = "bodyGround";
    }
  
</script>
</BZ:head>
<BZ:body onload="_onload();">
	<div class="mainShort">
		<!--bg start-->
		<div class="xxbg">
			&nbsp;
		</div>
		<!--bg end-->
		<div class="mainD">
		<BZ:form name="srcForm" method="post" action="/doneinfo/searchNoMgr.action">
			<input id="SENDER_FLAG" name="SENDER_FLAG" type="hidden" value='<%=request.getAttribute("SENDER_FLAG") %>'/>
			<div class="xx_T">
				
					<table border="0" cellspacing="0" cellpadding="0" width="979px">
						<tr>
							<td colspan="6" valign="middle" class="xx_Ttab1">
								查询条件
							</td>
						</tr>
						<tr>
							<td align="right" bgcolor="#F5F5F5" width="108">
								日期：
							</td>
							<td width="295" class="style2">
								<BZ:input field="START_TIME" prefix="Send_" defaultValue=""
									type="date" property="data"/>
								-
								<BZ:input field="END_TIME" prefix="Send_" defaultValue=""
									type="date" property="data"/>
							</td>
							<td align="right" bgcolor="#F5F5F5" width="108">
								接收者：
							</td>
							<td width="140">
								<BZ:input className="text_xx3" field="RECEIVENAME" prefix="Send_" defaultValue="" property="data"/>
							</td>
							<td align="right" bgcolor="#F5F5F5" width="108">
								回执：
							</td>
							<td>
								<BZ:select field="NEED_REPLY" prefix="Send_" formTitle="" property="data">
									<BZ:option value="-1">不限</BZ:option>
									<BZ:option value="1">需要</BZ:option>
									<BZ:option value="0">不需要</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td align="right" bgcolor="#F5F5F5">
								内容：
							</td>
							<td width="295" class="style2">
								<BZ:input className="text_xx2" field="CONTENT" prefix="Send_" defaultValue="" property="data"/>
							</td>
							<td colspan="4" align="right">
								<input type="button" class="xx_btn1" onclick="_search();">
								&nbsp;&nbsp;
								<input type="button" class="xx_btn2" onclick="_send();">
								&nbsp;&nbsp;
							</td>
						</tr>
					</table>
			</div>

			<div class="xx_F">
					<input type="hidden" value="" name="SEND_CONTENT0" id="SEND_CONTENT" />
					<%
						for (int i = 0; i < infolist.size(); i++) {
										Data info = infolist.getData(i);
					%>
					<div class="xx_Ftab">
						<table border="0" cellspacing="0" cellpadding="0" width="100%">
							<tr>
								<td colspan="8" valign="middle" bgcolor="#F4F4F4"
									style="padding-left: 15px;">
									<img
										src="<%=path%>/resources/resource1/main/images/xx_bg3.gif"
										onclick="_toOther('<%=i%>','<%=info.getString(Sms_Send.ID)%>')" />
									&nbsp;
									<a href="#"
										onclick="_toOther('<%=i%>','<%=info.getString(Sms_Send.ID)%>');return false"><strong>转发</strong>
									</a>&nbsp;&nbsp;
									<img
										src="<%=path%>/resources/resource1/main/images/xx_bg4.gif"
										onclick="_reSend('<%=info.getString(Sms_Send.ID)%>')" />
									&nbsp;
									<a href="javascript:void(0)"
										onclick="_reSend('<%=info.getString(Sms_Send.ID)%>');"><strong>再次发送</strong>
									</a>
								</td>
							</tr>
							<tr>
								<td align="right" bgcolor="#F5F5F5" width="81">
									发送时间：
								</td>
								<td width="135"><%=info.getString(Sms_Send.SEND_TIME)%></td>
								<td align="right" bgcolor="#F5F5F5" width="81" nowrap>
									发&nbsp;送&nbsp;者：
								</td>
								<td width="85"><%=info.getString(Sms_Send.SENDER_CNAME)%></td>
								<td align="right" bgcolor="#F5F5F5" width="81">
									发送状态：
								</td>
								<td width="105"><%=info.getString("STATUS_CNAME")%></td>
								<td align="right" bgcolor="#F5F5F5" width="130" nowrap>
									接收状态与回执：
								</td>
								<td align="left" bgcolor="#F5F5F5" width="130"
									style="cursor: pointer"
									onclick="_receipt('<%=info.getString(Sms_Send.ID)%>','<%=info.getString("REPLAY_INFO")%>')"
									title="点击查看/编辑回执信息">
									<strong><%=info.getString("REPLAY_INFO")%></strong>
								</td>
							</tr>
							<tr>
								<td align="right" bgcolor="#F5F5F5" width="81">
									接&nbsp;收&nbsp;者：
								</td>
								<td colspan="7" class="style4">
									<span style="cursor: pointer;" onclick=_showNumber('<%=info.getString(Send_Receiver.ID)%>'); ><%=info.getString("Receives")%></span>
								</td>
							</tr>
							<tr>
								<td align="right" bgcolor="#F5F5F5" width="81" nowrap>
									信息内容：
								</td>
								<td colspan="7" class="style4" id="td<%=i%>">
									<%=info.getString(Sms_Send.CONTENT)%></td>
							</tr>

						</table>
					</div>
					<%
						}
					%>
					<table width="100%">
						<tr>
							<td>
								<BZ:page form="srcForm" property="infolist" type="1" />
							</td>
						</tr>
					</table>
				
			</div>
			</BZ:form>
		</div>
	</div>
</BZ:body>
</BZ:html>