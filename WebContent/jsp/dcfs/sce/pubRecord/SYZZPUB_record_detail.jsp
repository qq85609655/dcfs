<%
/**   
 * @Title: AZB_record_confirm.jsp
 * @Description:点发退回信息查看页面
 * @author lihf
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data d = (Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head language="EN">
	<title>点发退回查看(Check agency-specific files returned)</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
		function _guanbi(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="TXRTFBTHLX;">
	<BZ:form name="srcForm" method="post">
	<BZ:input type="hidden" field="PUB_ID" prefix="c_"/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="一个编辑体">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>点发退回查看(Check agency-specific files returned)</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%">退回时间<br>Return date</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="RETURN_DATE" type="date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="10%">退回类型<br>Return type</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="RETURN_TYPE" codeName="TXRTFBTHLX" isShowEN="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">退回状态<br>Return status</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="RETURN_STATE" checkValue="0=to be confirmed;1=confirmed;" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">退回原因<br>Reason for return</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="RETURN_REASON" defaultValue="" />
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title">备注<br>Remarks</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="PUB_REMARKS" defaultValue=""/>
							</td>
						</tr>
					</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="Close" class="btn btn-sm btn-primary" onclick="_guanbi();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
