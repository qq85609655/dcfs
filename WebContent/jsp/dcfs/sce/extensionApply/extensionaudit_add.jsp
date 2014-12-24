<%
/**   
 * @Title: extensionaudit_add.jsp
 * @Description:  交文延期审核添加页
 * @author yangrt   
 * @date 2014-09-29
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
%>
<BZ:html>
	<BZ:head>
		<title>交文延期审核添加页</title>
		<BZ:webScript edit="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//公共功能，框架元素自适应
			});
			
			function _setShow(){
				$("#R_RESULT_NUM").val("");
				var result = $("#R_AUDIT_RESULT").find("option:selected").val();
				if(result == "1"){
					$("#selectNum").show();
					$("#R_RESULT_NUM").attr("disabled",false);
					$("#R_RESULT_NUM").attr("notnull","同意延时递交期限不能为空！");
				}else if(result == "2"){
					$("#selectNum").hide();
					$("#R_RESULT_NUM").attr("disabled",true);
					$("#R_RESULT_NUM").removeAttr("notnull");
				}
			}
			
			function _submit(){
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}else if(confirm("确定提交吗？")){
					$("#R_AUDIT_STATE").val($("#R_AUDIT_RESULT").val());
					document.srcForm.action = path + "sce/extensionapply/ExtensionAuditSave.action";
					document.srcForm.submit();
				}
			}
			function _goBack(){
				document.srcForm.action = path + "sce/extensionapply/ExtensionAuditList.action";
				document.srcForm.submit();
			}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="GJSY;ETXB;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" field="DEF_ID" prefix="R_" id="R_DEF_ID" defaultValue=""/>
		<BZ:input type="hidden" field="RI_ID" prefix="R_" id="R_RI_ID" defaultValue=""/>
		<BZ:input type="hidden" field="SUBMIT_DATE" prefix="R_" id="R_SUBMIT_DATE" defaultValue=""/>
		<BZ:input type="hidden" field="AUDIT_STATE" prefix="R_" id="R_AUDIT_STATE" defaultValue=""/>
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>交文延期申请信息</div>
				</div>
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">国家</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">收养组织</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">男收养人</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">女收养人</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">儿童姓名</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">性别</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">出生日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">申请日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="REQ_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">文件递交日期</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SUBMIT_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">申请原因</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="DEF_REASON" defaultValue="" onlyValue="true" style="width:96%;height:100px;"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>交文延期审核信息</div>
				</div>
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%"><font color="red">*</font>审核结果</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:select prefix="R_" field="AUDIT_RESULT" id="R_AUDIT_RESULT" formTitle="" defaultValue="" onchange="_setShow()" width="65%">
									<BZ:option value="1" selected="true">同意延期</BZ:option>
									<BZ:option value="2">不同意延期</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="20%"><font color="red" id="selectNum">*</font>同意延时递交书面文</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:select prefix="R_" field="RESULT_NUM" id="R_RESULT_NUM" formTitle="" defaultValue="" notnull="同意延时递交期限不能为空！" width="65%">
									<BZ:option value="">--请选择--</BZ:option>
									<BZ:option value="1">1个月</BZ:option>
									<BZ:option value="2">2个月</BZ:option>
									<BZ:option value="3">3个月</BZ:option>
									<BZ:option value="4">4个月</BZ:option>
									<BZ:option value="5">5个月</BZ:option>
									<BZ:option value="6">6个月</BZ:option>
									<BZ:option value="7">7个月</BZ:option>
									<BZ:option value="8">8个月</BZ:option>
									<BZ:option value="9">9个月</BZ:option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">审核意见</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input type="textarea" prefix="R_" field="AUDIT_CONTENT" id="R_AUDIT_CONTENT" defaultValue="" maxlength="500" style="width:96%;height:100px;"/>
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
				<input type="button" value="提 交" class="btn btn-sm btn-primary" onclick="_submit();"/>
				<input type="button" value="返 回" class="btn btn-sm btn-primary" onclick="_goBack();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		</BZ:form>
	</BZ:body>
</BZ:html>