<%
/**   
 * @Title: feedback_additonal_info.jsp
 * @Description: ������֯���ú󱨸����
 * @author xugy
 * @date 2014-11-4����3:17:23
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
String UPLOAD_IDS = data.getString("UPLOAD_IDS");
%>
<BZ:html>
<BZ:head>
	<title>���ú󱨸����</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
</script>
<BZ:body property="data">
	<div class="ui-state-default bz-edit-title" desc="����">
		<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
		<div>���ú󱨸油����Ϣ</div>
	</div>
	<div class="bz-edit-data-content clearfix" desc="������">
		<table class="bz-edit-data-table" border="0">
			<tr>
				<td class="bz-edit-data-title" width="20%">����ԭ��</td>
				<td class="bz-edit-data-value" width="80%">
					<BZ:dataValue field="NOTICE_CONTENT" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">����˵�������ģ�</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="ADD_CONTENT_CN" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">����˵����Ӧ�ģ�</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="ADD_CONTENT_EN" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">���丽��</td>
				<td class="bz-edit-data-value">
					<up:uploadList id="UPLOAD_IDS" attTypeCode="AR" packageId='<%=UPLOAD_IDS %>' />
				</td>
			</tr>
		</table>
	</div>
</BZ:body>
</BZ:html>
