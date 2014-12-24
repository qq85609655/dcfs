<%
/**   
 * @Title: consignreturn_add.jsp
 * @Description:  退回原因添加页面
 * @author yangrt   
 * @date 2014-09-16 20:01:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String pub_id = (String)request.getAttribute("PUB_ID");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>退回原因添加页面</title>
		<BZ:webScript edit="true" isAjax="true"/>
		<script>
			function _submit(){
				var reason = $("#R_RETURN_REASON").val();
				if (reason == "") {
					alert("Reason for return cannot be empty！");
					return;
				}else{
					var flag = getStr('com.dcfs.sce.lockChild.SaveReasonAjax','PUB_ID=<%=pub_id %>&RETURN_REASON=' + reason);
					/* document.srcForm.action = path + "sce/lockchild/ConsignReturnSave.action";
					document.srcForm.submit(); */
					if(flag == "true"){
						_goBack();
					}else{
						return;
					}
				}
			}
			
			function _goBack(){
				window.opener._search();
				window.close();
			}
		</script>
	</BZ:head>
	<BZ:body property="data">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<BZ:input type="hidden" prefix="R_" field="PUB_ID" id="R_PUB_ID" defaultValue=""/>
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>委托退回(Return agency-specific files)</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%" style="line-height: 20px;">退回日期<br>Return date</td>
							<td class="bz-edit-data-value" width="80%" style="line-height: 20px;">
								<BZ:dataValue field="RETURN_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<%-- <td class="bz-edit-data-title" width="20%" style="line-height: 20px;">退回类型<br>Return Type</td>
							<td class="bz-edit-data-value" width="30%" style="line-height: 20px;">
								<BZ:dataValue field="RETURN_TYPE" checkValue="0=系统收回;1=组织退回;2=中心收回;" defaultValue="" onlyValue="true"/>
							</td> --%>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>退回原因<br>Reason for return</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="RETURN_REASON" id="R_RETURN_REASON" type="textarea" defaultValue="" maxlength="1000" style="width:96%;height:100px;"/>
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
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit();"/>
				<input type="button" value="Cancel" class="btn btn-sm btn-primary" onclick="_goBack();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
		</BZ:form>
	</BZ:body>
</BZ:html>