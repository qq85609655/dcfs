<%
/**   
 * @Title: SYZZ_PP_feedback_reminder_detail.jsp
 * @Description: ���ú�������߽�֪ͨ
 * @author xugy
 * @date 2014-12-5����11:13:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
Data data = (Data)request.getAttribute("data");
String MALE_NAME = data.getString("MALE_NAME", "");
String FEMALE_NAME = data.getString("FEMALE_NAME", "");
%>
<BZ:html>
<BZ:head language="EN">
	<title>���ú�������߽�֪ͨ</title>
	<BZ:webScript edit="true" />
	<link href="<%=request.getContextPath()%>/resource/style/base/print.css" rel="stylesheet" type="text/css" media="print"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/jquery.jqprint.js"></script>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
function _print(){
	$("#PrintArea").jqprint(); 
}
//����
function _goback(){
	document.srcForm.action=path+"feedback/SYZZPPFeedbackReminderList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<div id="PrintArea">
	<table style="margin-top: 2cm;width: 17cm;" align="center">
		<tr>
			<td style="font-size: 24pt;text-align: center;">
				���ú󱨸�߽�֪ͨ
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;padding-top: 1cm;line-height: 40px;">
				<span style="text-decoration: underline;"><BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/></span>������֯��<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;����֯������ͥ
				<%
				if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
				%>
				<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<%=FEMALE_NAME %>&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<%    
				}else if("".equals(FEMALE_NAME) && !"".equals(MALE_NAME)){
				%>
				<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<%=MALE_NAME %>&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<%
				}else{
				%>
				<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<%=MALE_NAME %>&nbsp;&nbsp;&nbsp;&nbsp;</span>��
				<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<%=FEMALE_NAME %>&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<%} %>
				�������й���ͯ<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;&nbsp;&nbsp;</span>
				��δ�ݽ���<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<BZ:dataValue field="NUM" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;&nbsp;&nbsp;</span>
				�ΰ��ú󱨸棬������ʮ�����򵵰������ݽ����ú󱨸棬��������ԭ���ܰ�ʱ�ݽ����棬�뼰ʱ���й���ͯ�������������ĵ���������������˵����
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;padding-top: 0.5cm;text-align: right;line-height: 40px;">
				�й���ͯ��������������<br/>
				��������<br/>
				<BZ:dataValue field="REMINDERS_DATE_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td style="font-size: 24pt;padding-top: 2cm;">
				Post-placement report reminder<br/>
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;padding-top: 0.5cm;">
				<BZ:dataValue field="REMINDERS_DATE_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;padding-top: 1cm;line-height: 40px;">
				<span style="text-decoration: underline;"><BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/></span>:<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<%
				if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
				%>
				<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;MRS. <%=FEMALE_NAME %>&nbsp;&nbsp;&nbsp;&nbsp;</span>,
				<%    
				}else if("".equals(FEMALE_NAME) && !"".equals(MALE_NAME)){
				%>
				<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;MR. <%=MALE_NAME %>&nbsp;&nbsp;&nbsp;&nbsp;</span>,
				<%
				}else{
				%>
				<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;MR. <%=MALE_NAME %>&nbsp;&nbsp;&nbsp;&nbsp;</span> & 
				<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;MRS. <%=FEMALE_NAME %>&nbsp;&nbsp;&nbsp;&nbsp;</span>,
				<%} %>
				who have adopted <span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;&nbsp;&nbsp;</span> 
				through your agency,have not submitted the 
				<span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<BZ:dataValue field="NUM" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;&nbsp;&nbsp;</span> 
				report. Please submit the report within 30 days. If the report cannot be submitted due to certain reason, please provide a written statement in time.
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;padding-top: 0.5cm;text-align: right;line-height: 40px;">
				Archive Management Department<br/>
				CCCWA
			</td>
		</tr>
	</table>
</div>
<div class="bz-action-frame">
	<div class="bz-action-edit" desc="��ť��">
		<input type="button" value="Print" class="btn btn-sm btn-primary" onclick="_print()" />&nbsp;
		<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback()" />
	</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>