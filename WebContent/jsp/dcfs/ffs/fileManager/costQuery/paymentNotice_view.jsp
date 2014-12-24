<%
/**   
 * @Title: paymentNotice_view.jsp
 * @Description:  催缴通知信息查看
 * @author yangrt   
 * @date 2014-8-29 10:20:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String upload_id = (String)request.getAttribute("UPLOAD_ID");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>催缴通知信息查看</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);
			});
			//返回列表页
			function _goback(){
				window.location.href=path+'ffs/filemanager/PaymentNoticeList.action';
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="FYLB;">
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="查看区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>催缴通知信息(Payment reminder information)</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">催缴编号<br>Reminder number</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="PAID_NO" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">费用类别<br>Payment type</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="COST_TYPE" codeName="FYLB" isShowEN="true" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">应缴金额<br>Amount payable</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">正常儿童数量<br>Number of normal children</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHILD_NUM" defaultValue=""/>
							</td>
							
							<td class="bz-edit-data-title">特需儿童数量<br>Number of special needs children</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="S_CHILD_NUM" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">缴费内容<br>Payment content</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="PAID_CONTENT" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">附件<br>Attachment</td>
							<td class="bz-edit-data-value" colspan="5">
								<up:uploadList attTypeCode="OTHER" id="R_ATTACHMENT" packageId="<%=upload_id %>" smallType="<%=AttConstants.FAW_JFPJ %>"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">备注<br>Remarks</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="REMARKS" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">通知人<br>Notice people</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NOTICE_USERNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">通知日期<br>Date of notification</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NOTICE_DATE" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 编辑区域end -->
		<!-- 按钮区域Start -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
	</BZ:body>
</BZ:html>