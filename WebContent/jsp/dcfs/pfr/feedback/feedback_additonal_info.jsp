<%
/**   
 * @Title: feedback_additonal_info.jsp
 * @Description: 收养组织安置后报告审核
 * @author xugy
 * @date 2014-11-4下午3:17:23
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
	<title>安置后报告审核</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
</script>
<BZ:body property="data">
	<div class="ui-state-default bz-edit-title" desc="标题">
		<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
		<div>安置后报告补充信息</div>
	</div>
	<div class="bz-edit-data-content clearfix" desc="内容体">
		<table class="bz-edit-data-table" border="0">
			<tr>
				<td class="bz-edit-data-title" width="20%">补充原因</td>
				<td class="bz-edit-data-value" width="80%">
					<BZ:dataValue field="NOTICE_CONTENT" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">补充说明（中文）</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="ADD_CONTENT_CN" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">补充说明（应文）</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="ADD_CONTENT_EN" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">补充附件</td>
				<td class="bz-edit-data-value">
					<up:uploadList id="UPLOAD_IDS" attTypeCode="AR" packageId='<%=UPLOAD_IDS %>' />
				</td>
			</tr>
		</table>
	</div>
</BZ:body>
</BZ:html>
