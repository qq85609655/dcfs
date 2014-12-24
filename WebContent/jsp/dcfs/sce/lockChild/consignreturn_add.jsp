<%
/**   
 * @Title: consignreturn_add.jsp
 * @Description:  �˻�ԭ�����ҳ��
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
		<title>�˻�ԭ�����ҳ��</title>
		<BZ:webScript edit="true" isAjax="true"/>
		<script>
			function _submit(){
				var reason = $("#R_RETURN_REASON").val();
				if (reason == "") {
					alert("Reason for return cannot be empty��");
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
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>ί���˻�(Return agency-specific files)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%" style="line-height: 20px;">�˻�����<br>Return date</td>
							<td class="bz-edit-data-value" width="80%" style="line-height: 20px;">
								<BZ:dataValue field="RETURN_DATE" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<%-- <td class="bz-edit-data-title" width="20%" style="line-height: 20px;">�˻�����<br>Return Type</td>
							<td class="bz-edit-data-value" width="30%" style="line-height: 20px;">
								<BZ:dataValue field="RETURN_TYPE" checkValue="0=ϵͳ�ջ�;1=��֯�˻�;2=�����ջ�;" defaultValue="" onlyValue="true"/>
							</td> --%>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>�˻�ԭ��<br>Reason for return</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="RETURN_REASON" id="R_RETURN_REASON" type="textarea" defaultValue="" maxlength="1000" style="width:96%;height:100px;"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- �༭����end -->
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Submit" class="btn btn-sm btn-primary" onclick="_submit();"/>
				<input type="button" value="Cancel" class="btn btn-sm btn-primary" onclick="_goBack();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
	</BZ:body>
</BZ:html>