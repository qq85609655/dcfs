<%
/**   
 * @Title: AZB_record_confirm.jsp
 * @Description:�㷢�˻���Ϣȷ��ҳ��
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
<BZ:head>
	<title>�㷢�˻���Ϣȷ��</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
</BZ:head>
<BZ:body property="data" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;DFLX;TXRTFBTHLX;GJSY;SYZZ;">
	<BZ:form name="srcForm" method="post">
	<BZ:input type="hidden" field="PUB_ID" prefix="c_"/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="һ���༭��">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�˻���Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">�˻���</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="RETURN_USERNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">�˻�����</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="RETURN_DATE" onlyValue="true" defaultValue="" type="date"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">ȷ����</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="RETURN_CFM_USERNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">ȷ������</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="RETURN_CFM_DATE" onlyValue="true" defaultValue="" type="date"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">�˻�ԭ��</td>
							<td class="bz-edit-data-value" width="85%" colspan="5">
								<BZ:dataValue field="RETURN_REASON" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
			</div>
		</div>
	</div>
	</BZ:form>
</BZ:body>
</BZ:html>
