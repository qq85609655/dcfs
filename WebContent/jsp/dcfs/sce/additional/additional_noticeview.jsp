<%
/**   
 * @Title: additional_noticeview.jsp
 * @Description:  补充通知查看页面
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
		<title>补充通知详细查看页面</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource isImage="true"/>
	</BZ:head>
	<BZ:body property="detaildata" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;">
		<!-- 查看区域begin -->
		<div class="bz-edit clearfix" desc="查看区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>预批补充通知信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">通知人</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="SEND_USERNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">通知日期</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="NOTICE_DATE" defaultValue="" type="Date"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">是否修改</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="IS_MODIFY" defaultValue="" checkValue="0=否;1=是"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">通知内容</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="NOTICE_CONTENT" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">回复人</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEEDBACK_USERNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">回复日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEEDBACK_DATE" defaultValue="" type="Date"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">回复内容</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="ADD_CONTENT_EN" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">回复附件</td>
							<td class="bz-edit-data-value" colspan="3">
								<up:uploadList id="UPLOAD_IDS" firstColWidth="20px" attTypeCode="AF" packageId='<%=UPLOAD_IDS%>'/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 查看区域end -->
		<!-- 按钮区 开始 -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区" id="print1">
				<input type="button" value="关闭" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
			</div>
		</div>
		<!-- 按钮区 结束 -->
	</BZ:body>
</BZ:html>