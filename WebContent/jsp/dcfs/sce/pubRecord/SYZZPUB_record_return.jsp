<%
/**   
 * @Title: SYZZPUB_record_return.jsp
 * @Description:收养组织委托退回页面
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
	<title>收养组织填写委托退回原因</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	function _submit(){
		if(confirm("Are you sure you want to submit?")){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			document.srcForm.action=path+"record/SYZZPUBRecordAddReason.action";
			document.srcForm.submit();
		}
	}
	
	//返回点发退回列表
	function _goback(){
		document.srcForm.action=path+"record/SYZZPUBRecordList.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="TXRTFBTHLX;">
	<BZ:form name="srcForm" method="post">
	<BZ:input type="hidden" field="PUB_ID" prefix="S_"/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="一个编辑体">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>委托退回(Return agency-specific files)</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">退回时间<br>Return date</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:dataValue field="RETURN_DATE" type="date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">退回类型<br>Return type</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:dataValue field="RETURN_TYPE"  defaultValue="" codeName="TXRTFBTHLX" isShowEN="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">退回原因<br>Reason for return</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input prefix="S_" field="RETURN_REASON" id="S_RETURN_REASON" defaultValue="" style="width:700px;height:40px;" maxlength="" />
								<BZ:input prefix="S_" field="RETURN_DATE" id="S_RETURN_DATE" defaultValue="" type="hidden" maxlength="" />
								<BZ:input prefix="S_" field="RETURN_TYPE" id="S_RETURN_TYPE" defaultValue="" type="hidden" maxlength="" />
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
