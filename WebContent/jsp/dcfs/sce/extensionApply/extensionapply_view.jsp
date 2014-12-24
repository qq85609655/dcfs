<%
/**   
 * @Title: extensionapply_view.jsp
 * @Description:  交文延期申请查看页
 * @author yangrt   
 * @date 2014-09-29
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
	<BZ:head language="EN">
		<title>交文延期申请查看页</title>
		<BZ:webScript edit="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			});
			
			function _goBack(){
				document.srcForm.action = path + "sce/extensionapply/ExtensionApplyList.action";
				document.srcForm.submit();
			}
		</script>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<BZ:body property="data" codeNames="ETXB;">
		<BZ:form name="srcForm" method="post">
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>预批申请信息</div>
				</div>
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">男收养人<br>Adoptive father</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">女收养人<br>Adoptive mother</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">儿童姓名<br>Child name</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">性别<br>Sex</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<BZ:for property="childList" fordata="myData">
						<tr>
							<td class="bz-edit-data-title">儿童姓名<br>Child name</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME_PINYIN" property="myData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">性别<br>Sex</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" property="myData" codeName="ETXB" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" property="myData" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						</BZ:for>
						<tr>
							<td class="bz-edit-data-title">预批申请日期<br>Pre-approval application date</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PRE_REQ_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">预批通过日期<br>Pre-approved date</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PASS_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>交文延期申请(Application to extend submission deadline)</div>
				</div>
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">申请人<br>Applicant</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="REQ_USERNAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="20%">申请日期<br>Date of application</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="REQ_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">申请延期交文原因<br>Reason for extending submission</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="DEF_REASON" defaultValue="" onlyValue="true" style="height:100px;"/>
							</td>
						</tr>
					</table>
				</div>
				<!-- 内容区域 end -->
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>交文延期审核</div>
				</div>
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">原递交期限<br>Original submission deadline</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							
							<td class="bz-edit-data-title" width="20%">新递交期限<br>Extended submission deadline</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="REQ_SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">审核人<br>Reviewed by</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">审核日期<br>Review date</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="AUDIT_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">审核意见<br>Review conclusion</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="AUDIT_CONTENT" defaultValue="" onlyValue="true" style="height:100px;"/>
							</td>
						</tr>
					</table>
				</div>
				<!-- 内容区域 end -->
			</div>
		</div>
		<!-- 编辑区域end -->
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goBack();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		</BZ:form>
	</BZ:body>
</BZ:html>