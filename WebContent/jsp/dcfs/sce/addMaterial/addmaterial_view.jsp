<%
/**   
 * @Title: addmaterial_view.jsp
 * @Description:  补充通知详细查看页面
 * @author panfeng   
 * @date 2014-9-15 上午11:01:46 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	Data adData = (Data)request.getAttribute("detaildata");
	String UPLOAD_IDS = adData.getString("UPLOAD_IDS","");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>补充通知详细查看页面</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource isImage="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<BZ:body property="detaildata" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;">
		<!-- 查看区域begin -->
		<div class="bz-edit clearfix" desc="查看区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>预批补充通知信息(SUPPLEMENTARY NOTICE INFORMATION)</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">通知人<br>NOTICE PERSON</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="SEND_USERNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">通知日期<br>Date of notification</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="NOTICE_DATE" defaultValue="" type="Date"/>
							</td>
							<td class="bz-edit-data-title" width="15%">通知部门<br>NOTICE DEPARTMENT</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="ADD_TYPE" defaultValue="" checkValue="1=Audit Department;2=Resettlement Department;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">通知内容<br>NOTICE CONTENT</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="NOTICE_CONTENT" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">回复日期<br>Date of reply</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEEDBACK_DATE" defaultValue="" type="Date"/>
							</td>
							<td class="bz-edit-data-title">补充状态<br>Supplement status</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="AA_STATUS" defaultValue="" checkValue="0=to be added;1=in process of adding;2=added"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">回复内容<br>REPLY CONTENT</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="ADD_CONTENT_EN" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">回复附件<br>REPLY MATERIAL</td>
							<td class="bz-edit-data-value" colspan="5">
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
				<input type="button" value="Close" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
			</div>
		</div>
		<!-- 按钮区 结束 -->
	</BZ:body>
</BZ:html>