<%
/**   
 * @Title: AZB_record_confirm.jsp
 * @Description:撤销申请详细信息页面
 * @author lihf
 * @version V1.0   
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
	<title>撤销申请详细信息</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	//返回点发退回列表
	function _goback(){
		document.srcForm.action=path+"info/SYZZREQInfoList.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="ADOPTER_CHILDREN_SEX">
	<BZ:form name="srcForm" method="post">
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="一个编辑体">
			<div class="ui-state-default bz-edit-title" desc="标题">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>撤销预批信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">男方<br>Adoptive father</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="MALE_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">女方<br>Adoptive mother</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">姓名<br>Name</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">性别<br>Sex</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">出生日期<br>D.O.B</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="BIRTHDAY" type="date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">申请撤销日期<br>Date of application withdrawal </td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REVOKE_REQ_DATE" defaultValue="" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">撤销确认日期<br>Date of withdrawal confirmation</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REVOKE_CFM_DATE" type="date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">撤销状态<br>Withdrawal status</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REVOKE_STATE" defaultValue="" checkValue="0=to be confirmed;1=confirmed;"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
