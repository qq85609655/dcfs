<%
/**   
 * @Title: AZB_record_confirm.jsp
 * @Description:�㷢�˻���Ϣ�鿴ҳ��
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
	<title>�㷢�˻ز鿴(Check agency-specific files returned)</title>
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
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="һ���༭��">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�㷢�˻ز鿴(Check agency-specific files returned)</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="10%">�˻�ʱ��<br>Return date</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="RETURN_DATE" type="date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="10%">�˻�����<br>Return type</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="RETURN_TYPE" codeName="TXRTFBTHLX" isShowEN="true" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">�˻�״̬<br>Return status</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="RETURN_STATE" checkValue="0=to be confirmed;1=confirmed;" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�˻�ԭ��<br>Reason for return</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="RETURN_REASON" defaultValue="" />
							</td>
							
						</tr>
						<tr>
							<td class="bz-edit-data-title">��ע<br>Remarks</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="PUB_REMARKS" defaultValue=""/>
							</td>
						</tr>
					</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="Close" class="btn btn-sm btn-primary" onclick="_guanbi();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
