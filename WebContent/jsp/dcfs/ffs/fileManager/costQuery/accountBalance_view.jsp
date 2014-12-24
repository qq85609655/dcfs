<%
/**   
 * @Title: accountBalance_view.jsp
 * @Description:  缴费单明细查看
 * @author yangrt   
 * @date 2014-09-01 17:01:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
	<BZ:head language="EN">
		<title>缴费单明细查看</title>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		//返回列表页
		function _goback(){
			window.location.href=path+'ffs/filemanager/AccountBalanceList.action';
		}
	</script>
	<BZ:body property="data" codeNames="WJLX;">
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="查看区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>缴费单明细(Payment bill details)</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">缴费编号<br>Bill number</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="PAID_NO" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">操作类型<br>Type</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="OPP_TYPE" checkValue="0=transfer money to;1=transfer money from;" defaultValue="" />
							</td>
							<td class="bz-edit-data-title" width="15%">账单金额<br>Amount</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="SUM" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">操作人<br>Operator</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="OPP_USERNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">操作日期<br>Date</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="OPP_DATE" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">缴费票号<br>Payment ticket</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="BILL_NO" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">备注<br>Remarks</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="REMARKS" defaultValue=""/>
							</td>
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