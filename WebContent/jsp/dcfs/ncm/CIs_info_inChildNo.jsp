<%
/**   
 * @Title: CIs_info_inChildNo.jsp
 * @Description: ��ͯ��Ϣ�鿴
 * @author xugy
 * @date 2014-10-30����10:53:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
DataList CIdls = (DataList)request.getAttribute("CIdls");
%>
<BZ:html>
<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/common.js"/>
<BZ:head>
	<title>��ͯ��Ϣ�鿴</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource cancelJquerySupport="true"/>
	<link href="<%=request.getContextPath() %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>
<!-- <script type="text/javascript">
$(document).ready(function() {
	//dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
</script> -->
<BZ:body codeNames="PROVINCE;ETXB;ETSFLX;">
<script type="text/javascript">
$(document).ready(function() {
	//intoiframesize('CIsFrame');
	$('#tab-container').easytabs();
});
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
	                    	<td class="edit-data-title" style="text-align:center" colspan="5"><b>��ͯ������Ϣ</b></td>
	                    </tr>
						<tr>
							<td class="edit-data-title" width="13%">��ͯ���</td>
							<td class="edit-data-value" width="30%">
								<BZ:dataValue field="CHILD_NO" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
							<td class="edit-data-title" width="13%">��ͯ����</td>
							<td class="edit-data-value" width="30%">
								<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" checkValue="1=����;2=����;" property="mydata"/>
							</td>
							<td class="edit-data-value" width="14%" rowspan="5">
								<%
								String CI_ID = ((Data) pageContext.getAttribute("mydata")).getString("CI_ID");
								%>
								<img src='<up:attDownload attTypeCode="CI" packageId="<%=CI_ID%>" smallType="<%=AttConstants.CI_IMAGE %>"/>'></img>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">ʡ��</td>
							<td class="edit-data-value">
								<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE" property="mydata"/>
							</td>
							<td class="edit-data-title">����Ժ</td>
							<td class="edit-data-value">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">����</td>
							<td class="edit-data-value">
								<BZ:dataValue field="NAME" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
							<td class="edit-data-title">����ƴ��</td>
							<td class="edit-data-value">
								<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">�Ա�</td>
							<td class="edit-data-value">
								<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB" property="mydata"/>
							</td>
							<td class="edit-data-title">��������</td>
							<td class="edit-data-value">
								<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">�������</td>
							<td class="edit-data-value">
								<BZ:dataValue field="CHECKUP_DATE" defaultValue="" onlyValue="true" type="date" property="mydata"/>
							</td>
							<td class="edit-data-title">�Ƿ���ͬ��</td>
							<td class="edit-data-value">
								<BZ:dataValue field="IS_TWINS" defaultValue="" onlyValue="true" checkValue="0=��;1=��;" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">���֤��</td>
							<td class="edit-data-value">
								<BZ:dataValue field="ID_CARD" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
							<td class="edit-data-title">��ͯ���</td>
							<td class="edit-data-value" colspan="2">
								<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" onlyValue="true" codeName="ETSFLX" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">������</td>
							<td class="edit-data-value">
								<BZ:dataValue field="SENDER" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
							<td class="edit-data-title">�����˵�ַ</td>
							<td class="edit-data-value" colspan="2">
								<BZ:dataValue field="SENDER_ADDR" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��ʰ����</td>
							<td class="edit-data-value">
								<BZ:dataValue field="PICKUP_DATE" defaultValue="" onlyValue="true" type="date" property="mydata"/>
							</td>
							<td class="edit-data-title">��Ժ����</td>
							<td class="edit-data-value" colspan="2">
								<BZ:dataValue field="ENTER_DATE" defaultValue="" onlyValue="true" type="date" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��������</td>
							<td class="edit-data-value">
								<BZ:dataValue field="SEND_DATE" defaultValue="" onlyValue="true" type="date" property="mydata"/>
							</td>
							<td class="edit-data-title">�Ƿ񱨿�����</td>
							<td class="edit-data-value" colspan="2">
								<BZ:dataValue field="IS_ANNOUNCEMENT" defaultValue="" onlyValue="true" checkValue="0=��;1=��;" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��������</td>
							<td class="edit-data-value">
								<BZ:dataValue field="ANNOUNCEMENT_DATE" defaultValue="" onlyValue="true" type="date" property="mydata"/>
							</td>
							<td class="edit-data-title">��������</td>
							<td class="edit-data-value" colspan="2">
								<BZ:dataValue field="NEWS_NAME" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
						</tr>
						<tr>
							<td class="edit-data-title">��ע</td>
							<td class="edit-data-value" colspan="4">
								<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true" property="mydata"/>
							</td>
						</tr>
					</table>
                </div>
                <%
				i++;
				%>
			</BZ:for>
		</div>
	</div>
</BZ:form>
</BZ:body>
</BZ:html>
