<%
/**   
 * @Title: recordStateConfirm.jsp
 * @Description:组织备案申请信息页面
 * @author lihf
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
	<title>审核信息</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	function _submit(){
		if(confirm("确定提交吗？")){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			document.srcForm.action=path+"mkr/organSupp/organRecordStateSubmit.action";
			document.srcForm.submit();
		}
	}
	
	//返回组织机构备案列表
	function _goback(){
		document.srcForm.action=path+"mkr/organSupp/organRecordStateList.action";
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
				<div>审核信息</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">组织名称</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:dataValue field="CNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">国家</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:dataValue field="COUNTRY_NAME" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">英文名称</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:dataValue field="ENNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">机构代码</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:dataValue field="ORG_CODE" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">审核人</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:input field="RECORD_NAME" defaultValue="" prefix="MKR_" readonly="true"/>
								<BZ:input type="hidden" field="ADOPT_ORG_ID" defaultValue="" prefix="MKR_"/>
								<BZ:input type="hidden" field="RECORD_USERID" defaultValue="" prefix="MKR_"/>
							</td>
							<td class="bz-edit-data-title" width="15%">审核日期</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:input field="RECORD_DATE" defaultValue="" prefix="MKR_" type="date"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">审核意见</td>
							<td class="bz-edit-data-value" colspan="3">
								<textarea name="MKR_AUDIT_OPINION" rows="2" cols="85%"><%=data.getString("AUDIT_OPINION")!=null&&!"".equals(data.getString("AUDIT_OPINION"))?data.getString("AUDIT_OPINION"):"" %></textarea>	
							</td>
						</tr>
					</table>
			</div>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="_submit();"/>
			<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
