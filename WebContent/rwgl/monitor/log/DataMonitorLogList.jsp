<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.icss.pangu.db.*"%>
<%@ page import="com.icss.pangu.util.string.StringUtil"%>
<%@ page import="base.task.base.conf.SystemConfig"%>
<%
try {
    String contextPath = request.getContextPath();
	PageDBBean pageDBBean = (PageDBBean) request.getAttribute("pageDBBean");
	DBResult dbResult = pageDBBean.getSelectDBResult();
	int nPageRows = pageDBBean.getEachPageRows();		//��ҳ��ʾ������

	String subDataName = (String) request.getAttribute("subDataName");
	String msgType = (String) request.getAttribute("msgType");
	String runState = (String) request.getAttribute("runState");
	String sendNodeCode = (String) request.getAttribute("sendNodeCode");
	String recvNodeCode = (String) request.getAttribute("recvNodeCode");
	
	String TIME1 = (String)request.getAttribute("TIME1");
	if (TIME1.length() >= 10) {
		TIME1 = TIME1.substring(0, 10);
    }
    String TIME2 = (String)request.getAttribute("TIME2");
    if (TIME2.length() >= 10) {
		TIME2 = TIME2.substring(0, 10);
    }
    
	String navigation = "���ݽ���ƽ̨ -&gt; ��־��ѯͳ�� -&gt; ���ݽ��������־��ѯ";
	if(!SystemConfig.getString("monitor.log.DataMonitorLog").trim().equals(""))
		navigation = new String(SystemConfig.getString("monitor.log.DataMonitorLog").getBytes("iso8859-1"),"GBK");
%>

<!-- Header begin -->
<%@ include file="/eii/include/jsp/stmadc_header.jsp"%>
<!-- Header end -->
<META HTTP-EQUIV=Content-Type CONTENT="text/html; charset=gb2312">
<!-- �������� begin -->
<SCRIPT LANGUAGE="JavaScript" src="<%= contextPath %>/eii/include/js/jcommon.js"></SCRIPT>
<script LANGUAGE="javascript" SRC="<%= contextPath %>/eii/include/js/calendar.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function _submit() {
	var sForm = document.frmSub;
	if(sForm.TIME1.value != "") {
		if (!_compareTwoDateForString(sForm.TIME1.value, _getCurrentDate(0))) {
			alert("��ʼ���ڲ����ڵ�ǰ����֮��");
			sForm.TIME1.focus();
			return;
		}
	}
	if(sForm.TIME2.value != "") {
		if (!_compareTwoDateForString(sForm.TIME2.value, _getCurrentDate(0))) {
			alert("��ֹ���ڲ����ڵ�ǰ����֮��");
			sForm.TIME2.focus();
			return;
		}
	}
	if (sForm.TIME1.value != "" && sForm.TIME2.value != "") {
		if (!_compareTwoDateForString(sForm.TIME1.value, sForm.TIME2.value)) {
			alert("���ڷ�Χѡ��Ӧ�ð����Ⱥ�˳����д��");
			sForm.TIME1.focus();
			return;
		}
	}
	sForm.action = "<%= contextPath %>/base/eii/monitor/log/DataMonitorLogListServlet";
	sForm.submit();
}


function _goPage(_page) {
	var sForm = document.frmSub;
	sForm.currentPage.value = _page;
	sForm.action = "<%= contextPath %>/base/eii/monitor/log/DataMonitorLogListServlet";
	sForm.submit();
	return;
}

function _jumpPage() {
	var totalPage = <%= pageDBBean.getPages() %>;
	var sForm = document.frmSub;
	if ( !is_positiveInt(sForm.pageNum.value) ) {
		doCritCode(sForm.pageNum,1,MSG_ERROR_PAGE_NUM);
		return;
	}
	if ( (sForm.pageNum.value-1) > (totalPage-1) ) {
		doCritCode(sForm.pageNum,1,MSG_OVER_PAGE_NUM);
		return;
	}
	sForm.currentPage.value = sForm.pageNum.value;
	sForm.action = "<%= contextPath %>/base/eii/monitor/log/DataMonitorLogListServlet";
	sForm.submit();
	return;
}

function _return() {
	window.location.href = "<%= contextPath %>/eii/jsp/homepage.jsp";
}

//-->
</SCRIPT>

<form name="frmSub" method="post">

	<!-- ������ start -->
	<input type=hidden name="currentPage" value="1">
	<!-- ������ end -->

	<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
		<tr height="450">
			<td align="center" valign="top">
			
				<table align="center" width="100%" border="0" cellpadding="3" cellspacing="1">
					<tr>
						<td align="center">
						
							<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#EFEFEF">
								<tr height="20">
									<td width="87%">
										<img src="<%=contextPath%>/eii/images/niu-1.jpg" width="9" height="9">��ǰλ�ã�<%=navigation%>
									</td>
									<td width="4%" align="right">
										
									</td>
									<td width="9%">
										
									</td>
								</tr>
							</table>
							
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr height="9">
									<td></td>
								</tr>
							</table>
						
							<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="9C9C9C">
								<tr bgcolor="#EAEAEA" height="22">
									<td colspan="2">
										<font color="4A4A4A">&nbsp;�� ��ѯ���� </font>
									</td>
								</tr>
								<tr align="center" bgcolor="#FFFFFF" height="30">
									<td width="84%" align="center">
									
										<table border="0" width="100%" cellspacing="5" cellpadding="0">
											<tr>
												<td width="18%" align="right">�����������ƣ�</td>
												<td width="26%">
													<input type="text" name="subDataName" size="25" class="inputtxt" value="<%= subDataName %>">
												</td>
												<td width="18%" align="right">��&nbsp;&nbsp;�ڣ�</td>
												<td width="38%">
													<input name="TIME1" type="text" class="inputtxt" size="10" value="<%= TIME1 %>" readonly>
													<img src="<%= contextPath %>/eii/images/time12.gif" style="cursor:hand;" alt="�������������˵�"
														onClick="document.frmSub.TIME1.value=showCalendar(document.frmSub.TIME1.value,650,200)">
													��
													<input name="TIME2" type="text" class="inputtxt" size="10" value="<%= TIME2 %>" readonly>
													<img src="<%= contextPath %>/eii/images/time12.gif" style="cursor:hand;" alt="�������������˵�"
														onClick="document.frmSub.TIME2.value=showCalendar(document.frmSub.TIME2.value,650,200)">
												</td>
											</tr>
											
											<tr>
												<td align="right">���Ͷ˽ڵ���룺</td>
												<td>
													<input type="text" name="sendNodeCode" size="25" class="inputtxt" value="<%= sendNodeCode %>">
												</td>
												<td align="right">���ն˽ڵ���룺</td>
												<td>
													<input type="text" name="recvNodeCode" size="25" class="inputtxt" value="<%= recvNodeCode %>">
												</td>
											</tr>
											
											
											<tr>
												<td align="right">�ļ����ͣ�</td>
												<td>
													<select name="msgType" >
														<option value="" <% if(msgType.equals("")) out.print("selected"); %>>ȫ���ļ�����</option>
														<option value="01" <% if(msgType.equals("01")) out.print("selected"); %>>�ṹ�ļ���01��</option>
														<option value="03" <% if(msgType.equals("03")) out.print("selected"); %>>�����ļ���03��</option>
														<option value="05" <% if(msgType.equals("05")) out.print("selected"); %>>ɾ���ļ���05��</option>
													</select>
												</td>
												<td align="right">���н����</td>
												<td>
													<select name="runState" >
														<option value="" <% if(runState.equals("")) out.print("selected"); %>>ȫ�����н��</option>
														<option value="1" <% if(runState.equals("1")) out.print("selected"); %>>�ɹ�</option>
														<option value="2" <% if(runState.equals("2")) out.print("selected"); %>>ʧ��</option>
														<option value="3" <% if(runState.equals("3")) out.print("selected"); %>>�쳣</option>
													</select>
												</td>
											</tr>
										</table>
										
									</td>
									<td width="16%">
										<input type=button name="button3" value="�� ѯ" class="inputbutton" style="cursor:hand" onclick="_submit()">
									</td>
								</tr>
							</table>
							
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr height="9">
									<td></td>
								</tr>
							</table>
							
							<DIV class="div" style="overflow-x:scroll; width:781; margin:0px; BORDER-BOTTOM: #9C9C9C 1px solid;">
								
								<table width="3200" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="9C9C9C">
									<tr bgcolor="EAEAEA">
										<td width="2%" align="center" nowrap>
											���
										</td>
										<td width="8%" align="center" nowrap>
											������������
										</td>
										<td width="2%" align="center" nowrap>
											�ļ�����
										</td>
										<td width="5%" align="center" nowrap>
											��ʼʱ��
										</td>
										<td width="5%" align="center" nowrap>
											����ʱ��
										</td>
										<td width="2%" align="center" nowrap>
											���н��
										</td>
										<td width="6%" align="center" nowrap>
											���ͽڵ����
										</td>
										<td width="6%" align="center" nowrap>
											���սڵ����
										</td>
										<td width="5%" align="center" nowrap>
											����ʱ��
										</td>
										<td width="21%" align="center" nowrap>
											�ļ�����
										</td>
										<td width="8%" align="center" nowrap>
											�������
										</td>
										<td width="3%" align="center" nowrap>
											�ܼ�¼��
										</td>
										<td width="3%" align="center" nowrap>
											��ǰ��¼��
										</td>
										<td width="24%" align="center" nowrap>
											�����Ϣ
										</td>
									</tr>
									<%
									int baseCount = (pageDBBean.getCurrentPage()-1)*pageDBBean.getEachPageRows()+1;
									int nCount = 0 ;
									for(int i=0 ;i<dbResult.getRows(); i++) {
										String ID = dbResult.getString(i, "ID");
										String MSG_TYPE = dbResult.getString(i, "MSG_TYPE");
										String SUB_DATA_ID = dbResult.getString(i, "SUB_DATA_ID");
										String SUBDATA_NAME = dbResult.getString(i, "SUBDATA_NAME");
										String JOB_LOG_ID = dbResult.getString(i, "JOB_LOG_ID");
										String SEND_NODE_CODE = dbResult.getString(i, "SEND_NODE_CODE");
										String RECV_NODE_CODE = dbResult.getString(i, "RECV_NODE_CODE");
										String FILE_NAME = dbResult.getString(i, "FILE_NAME");
										String TAB_NAME = dbResult.getString(i, "TAB_NAME");
										String ALL_ROWS = dbResult.getString(i, "ALL_ROWS");
										String CURR_ROWS = dbResult.getString(i, "CURR_ROWS");
										String SEND_TIME = dbResult.getString(i, "SEND_TIME");
										String START_TIME = dbResult.getString(i, "START_TIME");
										String END_TIME = dbResult.getString(i, "END_TIME");
										String RUN_STATE = dbResult.getString(i, "RUN_STATE");
										String RUN_MSG = dbResult.getString(i, "RUN_MSG");
										
										
										if ("1".equals(RUN_STATE)) {
											RUN_STATE = "�ɹ�";
										} else if ("2".equals(RUN_STATE)) {
											RUN_STATE = "ʧ��";
										} else if ("3".equals(RUN_STATE)) {
											RUN_STATE = "�쳣";
										} else {
											RUN_STATE = "��������";
										}
									%>
									<tr bgcolor="#FFFFFF">
										<td align="center"><%= baseCount+i %></td>
										<td><%= SUBDATA_NAME %></td>
										<td align="center"><%= MSG_TYPE %></td>
										<td align="center"><%= START_TIME.substring(0, 19) %></td>
										<td align="center"><%= END_TIME.substring(0, 19) %></td>
										<td align="center"><%= RUN_STATE %></td>
										<td><%= SEND_NODE_CODE %></td>
										<td><%= RECV_NODE_CODE %></td>
										<td align="center"><%= SEND_TIME.substring(0, 19) %></td>
										<td><%= FILE_NAME %></td>
										<td><%= TAB_NAME %></td>
										<td align="right"><%= ALL_ROWS %></td>
										<td align="right"><%= CURR_ROWS %></td>
										<td>&nbsp;<%= StringUtil.HTMLEncode(RUN_MSG) %></td>
									</tr>
									<%
										nCount ++;
									}
									if(nCount < nPageRows){	//������������ȱ�ҳ�����٣����հ���
										for(int i=nCount; i<nPageRows; i++) {
									%>
									<tr bgcolor="#FFFFFF">
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<%
										}
									}
									%>
								</table>
								
							</DIV>
							
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>
									
										<table border="0" align="right" cellpadding="3" cellspacing="0">
											<tr>
									<%
									if (pageDBBean.isFirstPage()) {
									%>
												<td width="53">
													<img src="<%= contextPath %>/eii/images/pageone2.gif" width="53" height="17">
												</td>
												<td width="53">
													<img src="<%= contextPath %>/eii/images/pageup2.gif" width="53" height="17">
												</td>
									<%
									} else {
									%>
												<td width="53">
													<img src="<%= contextPath %>/eii/images/pageone.gif" width="53" height="17"
														onClick="JavaScript:_goPage(1)" style="cursor:hand">
												</td>
												<td width="53">
													<img src="<%= contextPath %>/eii/images/pageup.gif" width="53" height="17"
														onClick="JavaScript:_goPage(<%= pageDBBean.getCurrentPage() - 1 %>)" style="cursor:hand">
												</td>
									<%
									}
									if (pageDBBean.isLastPage()) {
									%>
												<td width="53">
													<img src="<%= contextPath %>/eii/images/pagedown2.gif" width="53" height="17">
												</td>
												<td width="53">
													<img src="<%= contextPath %>/eii/images/pageend2.gif" width="53" height="17">
												</td>
									<%
									} else {
									%>
												<td width="53">
													<img src="<%= contextPath %>/eii/images/pagedown.gif" width="53" height="17"
														onClick="JavaScript:_goPage(<%= pageDBBean.getCurrentPage() + 1 %>)" style="cursor:hand">
												</td>
												<td width="53">
													<img src="<%= contextPath %>/eii/images/pageend.gif" width="53" height="17"
														onClick="JavaScript:_goPage(<%= pageDBBean.getPages() %>)" style="cursor:hand">
												</td>
									<% 
									}
									if ( pageDBBean.getPages()==0 || pageDBBean.getPages()==1 ) {
									%>
												<td width="36">
													<input name="pageNum" type="text" class="inputtxt" size="6" readonly>
												</td>
												<td width="53">
													<img src="<%= contextPath %>/eii/images/pagejump2.gif" width="53" height="17">
												</td>
									<%
									} else {
									%>
												<td width="36">
													<input name="pageNum" type="text" class="inputtxt" size="6">
												</td>
												<td width="53">
													<img src="<%= contextPath %>/eii/images/pagejump.gif" width="53" height="17"
														onclick="JavaScript:_jumpPage()" style="cursor:hand">
												</td>
									<%
									}
									%>
												<td>
													<%= pageDBBean.getCurrentPage() %>
													/
													<%= pageDBBean.getPages() %>
													ҳ&nbsp;��
													<%= pageDBBean.getRows() %>
													��
												</td>
											</tr>
										</table>
										
									</td>
								</tr>
							</table>
							
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr height="15">
									<td>&nbsp;</td>
								</tr>
							</table>
							
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr align="center">
									<td>&nbsp;</td>
								</tr>
							</table>
						
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr height="15">
									<td></td>
								</tr>
							</table>
							
						</td>
					</tr>
				</table>
				
			</td>
		</tr>
	</table>
	
</form>
<!-- �������� end -->

<!-- Tail begin -->
<%@ include file="/eii/include/jsp/stmadc_tail.jsp"%>
<!-- Tail end -->
<%
} catch(Exception e) {
	out.println(e);
}
%>
