<%
/**   
 * @Title: overageremind_ciview.jsp
 * @Description: �鿴��ͯͬ����Ϣ
 * @author panfeng
 * @date 2014-9-16����4:19:28 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
DataList CIdls = (DataList)request.getAttribute("CIdls");
%>
<BZ:html>
<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/common.js"/>
<BZ:head>
	<title>��ͯͬ����Ϣ�鿴</title>
	<BZ:webScript edit="true"/>
	<link href="<%=request.getContextPath() %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>

<BZ:body codeNames="PROVINCE;ETXB;ETSFLX;SYS_CI_NAME;CHILD_TYPE">
<script>
$(document).ready(function() {
	$('#tabs').tabs();
});
//�رյ���ҳ
function _close(){
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	$('#tab-container').easytabs();
}
</script>
<BZ:form name="srcForm" method="post">
	<div id="tab-container" class='tab-container'>
		<%
		if(CIdls.size()>1){
		%>
		<ul class="etabs">
			<%
			for(int i=0;i<CIdls.size();i++){
			    Data d = CIdls.getData(i);
			    String NAME = d.getString("NAME");
			%>
		   <li class="tab"><a href="#tab<%=i+1 %>"><%=NAME %></a></li>
		   <%} %>
		</ul>
		<%} %>
		<div class='panel-container'>
			<%
			int i=0;
			%>
			<BZ:for property="CIdls" fordata="mydata">
			<div id="tab<%=i+1 %>">
				<table class="specialtable">
					<tr>
                    	<td class="edit-data-title" style="text-align:center"><b>��ͯ������Ϣ</b></td>
                    </tr>
                    <tr>
                   		<td>
                   			<table class="specialtable">
                   				<tr>
									<td class="edit-data-title">ʡ��</td>
									<td class="edit-data-value">
										<BZ:dataValue field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" property="mydata" onlyValue="true"/>
									</td>
									<td class="edit-data-title">����Ժ</td>
									<td class="edit-data-value" colspan="2">
										<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" property="mydata" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title" width="14%">����</td>
									<td class="edit-data-value" width="30%">
										<BZ:dataValue field="NAME" defaultValue="" property="mydata" onlyValue="true"/>
									</td>
									<td class="edit-data-title" width="14%">�Ա�</td>
									<td class="edit-data-value" width="30%">
										<BZ:dataValue field="SEX" defaultValue="" codeName="ETXB" property="mydata" onlyValue="true"/>
									</td>
									<td class="edit-data-value" width="12%" rowspan="4">
										<BZ:dataValue field="PHOTO_CARD" defaultValue="" property="mydata"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��������</td>
									<td class="edit-data-value">
										<BZ:dataValue field="BIRTHDAY" defaultValue="" type="date" property="mydata" onlyValue="true"/>
									</td>
									<td class="edit-data-title">�������</td>
									<td class="edit-data-value">
										<BZ:dataValue field="CHECKUP_DATE" defaultValue="" type="date" property="mydata" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">ͬ��</td>
									<td class="edit-data-value">
										<%
										String IS_TWINS = ((Data) pageContext.getAttribute("mydata")).getString("IS_TWINS","");
										if("0".equals(IS_TWINS)){
										%>
										��
										<%
										}
										if("1".equals(IS_TWINS)){
										%>
										<BZ:dataValue field="TWINS_IDS" codeName="SYS_CI_NAME" defaultValue="" property="mydata" onlyValue="true"/>
										<%} %>
									</td>
									<td class="edit-data-title">��ͯ���</td>
									<td class="edit-data-value">
										<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX" property="mydata" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">������</td>
									<td class="edit-data-value">
										<BZ:dataValue field="SENDER" defaultValue="" property="mydata" onlyValue="true"/>
									</td>
									<td class="edit-data-title">�����˵�ַ</td>
									<td class="edit-data-value">
										<BZ:dataValue field="SENDER_ADDR" defaultValue="" property="mydata" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��ͯ������</td>
									<td class="edit-data-value">
										<BZ:dataValue field="" defaultValue="" property="mydata" onlyValue="true"/>
									</td>
									<td class="edit-data-title">��ʰ����</td>
									<td class="edit-data-value" colspan="2">
										<BZ:dataValue field="PICKUP_DATE" defaultValue="" type="date" property="mydata" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��Ժ����</td>
									<td class="edit-data-value">
										<BZ:dataValue field="ENTER_DATE" defaultValue="" type="date" property="mydata" onlyValue="true"/>
									</td>
									<td class="edit-data-title">��������</td>
									<td class="edit-data-value" colspan="2">
										<BZ:dataValue field="SEND_DATE" defaultValue="" type="date" property="mydata" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="edit-data-title">��ע</td>
									<td class="edit-data-value" colspan="4">
										<BZ:dataValue field="REMARKS" defaultValue="" property="mydata" onlyValue="true"/>
									</td>
								</tr>
                   			</table>
                   		</td>
                   	</tr>
				</table>
			</div>
			<%
			i++;
			%>
			</BZ:for>
			<div style="text-align:center; margin-top: 10px;">
				<input type="button" value="�ر�" class="btn btn-sm btn-primary" onclick="_close()" />
			</div>
		</div>
	</div>
</BZ:form>
</BZ:body>
</BZ:html>
