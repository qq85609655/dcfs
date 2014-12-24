<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String CONFIRM_LEVEL = (String)request.getAttribute("CONFIRM_LEVEL");
	Data data = (Data)request.getAttribute("data"); 
	String affix=(String)data.getString("UPLOAD_IDS");
%>
<BZ:html>
	<BZ:head>
		<title>儿童材料信息补充页</title>
		<BZ:webScript edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<up:uploadResource/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);//公共功能，框架元素自适应	
		});
		//退材料确认（取消退材料操作）操作
		function _submit(obj){
			if(confirm('确定提交吗？')){
				document.srcForm.action = path+'cms/childreturn/saveConfirmResult.action?'+'result='+obj;
				document.srcForm.submit();
			}
		}
		
		//返回退材料确认列表页面
		function _goback(signal){
			if(signal=='2'){
				window.location.href=path+'cms/childreturn/returnListST.action';
			}else if(signal=='3'){
				window.location.href=path+'cms/childreturn/returnListZX.action';
			}
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;CHILD_TYPE;BCZL;TCLLX;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<input name="CONFIRM_LEVEL" id="CONFIRM_LEVEL" type="hidden" value="<%=CONFIRM_LEVEL%>"/>
		<BZ:input type="hidden" prefix="R_" field="CI_ID" id="R_CI_ID" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="AR_ID" id="R_AR_ID" defaultValue=""/>
		<!-- 隐藏区域end -->
		<br/>
		<!-- 编辑区域begin -->
		<div class="clearfix" style="margin-left: 11px;margin-right: 11px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" >
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>儿童信息</div>
				</div>
				<div class="bz-edit-data-content clearfix" >
					<table class="bz-edit-data-table" border="0" style="margin-bottom: 3px;">
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">福利院</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="WELFARE_NAME_CN" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">儿童姓名</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">性别</td>
							<td class="bz-edit-data-value" width="21%">
								<BZ:dataValue field="SEX" codeName="ETXB" onlyValue="true" defaultValue=""/>
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">出生日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">儿童类型</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CHILD_TYPE" codeName="CHILD_TYPE"  onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">病残种类</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" codeName="BCZL"  onlyValue="true" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="clearfix" style="margin-left: 11px;margin-right: 11px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>退材料信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix">
					<table class="bz-edit-data-table" border="0">
						<tr id="isapply_attach">
						    <td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">申请人</td>
							<td class="bz-edit-data-value" width="19%">
								<BZ:dataValue field="APPLE_PERSON_NAME" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">申请日期</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="APPLE_DATE" type="Date" onlyValue="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">退材料类型</td>
							<td class="bz-edit-data-value" width="21%">
							    <BZ:dataValue field="APPLE_TYPE" codeName="TCLLX"  onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr id="isapply_attach">
							<td class="bz-edit-data-title" style="text-align: left;padding-left: 6px">附件</td>
							<td class="bz-edit-data-value" colspan="5" >
                             <up:uploadList name="AFFIX" id="AFFIX" attTypeCode="CI" smallType="<%=AttConstants.CI_CLTW %>" 
							 packageId="<%=affix%>" secondColWidth="100%"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">退材料原因</td>
							<td class="bz-edit-data-value" colspan="5">
							    <BZ:dataValue  field="RETURN_REASON" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%" style="text-align: left;padding-left: 6px">备注</td>
							<td class="bz-edit-data-value" colspan="5">
							   <% if("2".equals(CONFIRM_LEVEL)){%>
								   <BZ:input prefix="R_" field="ST_CONFIRM_REMARK" id="R_ST_CONFIRM_REMARK" type="textarea" defaultValue="" maxlength="1000" style="width:80%;" />
							   <%}else if("3".equals(CONFIRM_LEVEL)){%>
							       <BZ:input prefix="R_" field="ZX_CONFIRM_REMARK" id="R_ZX_CONFIRM_REMARK" type="textarea" defaultValue="" maxlength="1000" style="width:80%;" />
							   <%}%>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 编辑区域end -->
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" >
				<input type="button" value="确认" class="btn btn-sm btn-primary" onclick="_submit(1);"/>
				<input type="button" value="取消退材料" class="btn btn-sm btn-primary" onclick="_submit(0);"/>
				<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback('<%=CONFIRM_LEVEL %>')"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		</BZ:form>
	</BZ:body>
</BZ:html>