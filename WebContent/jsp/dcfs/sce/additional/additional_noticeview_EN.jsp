<%
/**   
 * @Title: additional_noticeview_CN.jsp
 * @Description:  预批补充查询查看页面（补充通知/英文）
 * @author panfeng   
 * @date 2014-9-12 上午10:11:28 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String UPLOAD_IDS = (String)request.getAttribute("UPLOAD_IDS");
%>
<BZ:html>
	<BZ:head>
		<title>预批补充查询查看页面（补充通知）</title>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
	</script>
</BZ:html>
<BZ:body property="noticedata">
	<!-- 查看区域begin -->
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- 标题区域 begin -->
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>补充通知信息</div>
			</div>
			<!-- 标题区域 end -->
			<!-- 内容区域 begin -->
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">通知人<br>notify the person</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="SEND_USERNAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">补充通知日期<br>date of notification</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="NOTICE_DATE" defaultValue="" type="Date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">是否修改<br>whether to modify</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="IS_MODIFY" defaultValue="" checkValue="0=No;1=Yes"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">通知内容<br>notification content</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NOTICE_CONTENT" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">回复人<br>reply person</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEEDBACK_USERNAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">回复日期<br>reply date</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEEDBACK_DATE" defaultValue="" type="Date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">回复内容<br>reply content</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADD_CONTENT_EN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">回复附件<br>reply attachment</td>
						<td class="bz-edit-data-value" colspan="3">
							<up:uploadList id="UPLOAD_IDS" firstColWidth="20px" attTypeCode="AF" packageId='<%=UPLOAD_IDS%>'/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 查看区域end -->
</BZ:body>