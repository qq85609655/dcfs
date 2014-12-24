<%
/**   
 * @Title: AZB_record_confirm.jsp
 * @Description:填写申请撤销原因页面
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
<BZ:head>
	<title>填写申请撤销原因</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
		document.srcForm.action="";
	});
	
	function _submit(){
		if(confirm("Are you sure you want to submit?")){
			//页面表单校验
			document.srcForm.action=path+"info/SYZZREQInfoAddReason.action";
			document.srcForm.submit();
		}
	}
	
	//返回点发退回列表
	function _goback(){
		document.srcForm.action=path+"info/SYZZREQInfoApplicatList.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data">
	<BZ:form name="srcForm" method="post">
	<BZ:input type="hidden" field="RI_ID" prefix="S_"/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="一个编辑体">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>申请撤销(Withdrawal application)</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="25%">申请撤销日期<br>Date of application withdrawal</td>
							<td class="bz-edit-data-value" width="25%">
								<BZ:dataValue field="REVOKE_REQ_DATE" type="date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="25%">申请撤销人<br>Withdrawal applied by</td>
							<td class="bz-edit-data-value" width="25%">
								<BZ:dataValue field="REVOKE_REQ_USERNAME" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="25%">申请撤销原因<br>Reason for withdrawal</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input prefix="S_" field="REVOKE_REASON" id="S_REVOKE_REASON" defaultValue="" style="width:700px;height:80px;" maxlength="" />
								<BZ:input prefix="S_" field="REVOKE_REQ_DATE" id="S_REVOKE_REQ_DATE" defaultValue="" type="hidden" maxlength="" />
								<BZ:input prefix="S_" field="REVOKE_REQ_USERNAME" id="S_REVOKE_REQ_USERNAME" defaultValue="" type="hidden" maxlength="" />
								<BZ:input prefix="S_" field="REVOKE_REQ_USERID" id="S_REVOKE_REQ_USERID" defaultValue="" type="hidden" maxlength="" />
							</td>
						</tr>
					</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit();"/>
			<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
