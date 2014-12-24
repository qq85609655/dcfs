<%
/**   
 * @Title: AZB_reminder_detail.jsp
 * @Description: 安置部催办通知查看
 * @author xugy
 * @date 2014-9-14下午3:42:22
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data=(Data)request.getAttribute("data");
String MALE_NAME = data.getString("MALE_NAME", "");
String FEMALE_NAME = data.getString("FEMALE_NAME", "");
%>
<BZ:html>
<BZ:head>
	<title>催办通知查看</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
//关闭弹出页
function _close(){
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
}
</script>
<BZ:body property="data" codeNames="PROVINCE;">
<div>
	<table style="margin-top: 2cm;width: 21cm;" align="center">
		<tr>
			<td style="font-size: 24pt;text-align: center;">
				征求意见书反馈催办通知
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;padding-top: 0.2cm;line-height: 40px;">
				<span style="text-decoration: underline;"><BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/></span>收养组织：<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;我们已经于
				<span style="text-decoration: underline;">&nbsp;&nbsp;<BZ:dataValue field="ADVICE_NOTICE_DATE_CN" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;</span>寄发了
				<%
				if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
				%>
				<span style="text-decoration: underline;">&nbsp;&nbsp;<%=FEMALE_NAME %>&nbsp;&nbsp;</span>
				<%    
				}else if("".equals(FEMALE_NAME) && !"".equals(MALE_NAME)){
				%>
				<span style="text-decoration: underline;">&nbsp;&nbsp;<%=MALE_NAME %>&nbsp;&nbsp;</span>
				<%
				}else{
				%>
				<span style="text-decoration: underline;">&nbsp;&nbsp;<%=MALE_NAME %>&nbsp;&nbsp;</span>和
				<span style="text-decoration: underline;">&nbsp;&nbsp;<%=FEMALE_NAME %>&nbsp;&nbsp;</span>
				<%} %>
				收养
				<span style="text-decoration: underline;">
					&nbsp;&nbsp;<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE"/>
					（<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>）&nbsp;&nbsp;
				</span>儿童
				<span style="text-decoration: underline;">
					&nbsp;&nbsp;<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
					（<BZ:dataValue field="BIRTHDAY_CN" defaultValue="" onlyValue="true"/>出生）&nbsp;&nbsp;
				</span>的《征求收养人意见书》及《征求收养意见书》，至今已满2个月，为使儿童尽早进入家庭，请于
				<span style="text-decoration: underline;">
					&nbsp;&nbsp;<BZ:dataValue field="ADVICE_CLOSE_DATE_CN" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
				</span>（含当日）之前将该家庭的《征求收养人意见书》和《征求收养意见书》反馈到中国儿童福利和收养中心。逾期我们将为该儿童另行选配收养家庭。
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;padding-top: 0.5cm;text-align: right;line-height: 40px;">
				中国儿童福利和收养中心<br/>
				<BZ:dataValue field="ADVICE_REMINDER_DATE_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td style="font-size: 18pt;padding-top: 2cm;">
				Reminder for Letter of Seeking Confirmation Feedback<br/>
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;padding-top: 0.5cm;">
				<BZ:dataValue field="ADVICE_REMINDER_DATE_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;padding-top: 0.2cm;line-height: 40px;">
				<span style="text-decoration: underline;"><BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/></span>:<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;CCCWA sent to you on
				<span style="text-decoration: underline;">&nbsp;&nbsp;<BZ:dataValue field="ADVICE_NOTICE_DATE_EN" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;</span> 
				the Letter of Seeking Confirmation for 
				<%
				if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
				%>
				MRS.<span style="text-decoration: underline;">&nbsp;&nbsp;<%=FEMALE_NAME %>&nbsp;&nbsp;</span> 
				<%    
				}else if("".equals(FEMALE_NAME) && !"".equals(MALE_NAME)){
				%>
				MR.<span style="text-decoration: underline;">&nbsp;&nbsp;<%=MALE_NAME %>&nbsp;&nbsp;</span> 
				<%
				}else{
				%>
				MR.<span style="text-decoration: underline;">&nbsp;&nbsp;<%=MALE_NAME %>&nbsp;&nbsp;</span> & 
				MRS.<span style="text-decoration: underline;">&nbsp;&nbsp;<%=FEMALE_NAME %>&nbsp;&nbsp;</span> 
				<%} %>
				adopting 
				<span style="text-decoration: underline;">
					&nbsp;&nbsp;<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>&nbsp;(
					<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" isShowEN="true" codeName="PROVINCE"/>,
					<BZ:dataValue field="WELFARE_NAME_EN" defaultValue="" onlyValue="true"/>,
					DOB:<BZ:dataValue field="BIRTHDAY_EN" defaultValue="" onlyValue="true"/>)&nbsp;&nbsp;
				</span>.
				Now it has been two months. In order to help the child enter into the adoptive family in time, please send back the signed Letter of Seeking Confirmation before 
				<span style="text-decoration: underline;">&nbsp;&nbsp;<BZ:dataValue field="ADVICE_CLOSE_DATE_EN" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;</span>.
				CCCWA will rematch the child with another adoptive family after the deadline.
			</td>
		</tr>
		<tr>
			<td style="font-size: 16pt;padding-top: 0.5cm;text-align: right;line-height: 40px;">
				China Center for Children’s Welfare and Adoption
			</td>
		</tr>
	</table>
</div>
</BZ:body>
</BZ:html>
