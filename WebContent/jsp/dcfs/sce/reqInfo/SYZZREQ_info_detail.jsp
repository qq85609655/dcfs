<%
/**   
 * @Title: AZB_record_confirm.jsp
 * @Description:����������ϸ��Ϣҳ��
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
	<title>����������ϸ��Ϣ</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	//���ص㷢�˻��б�
	function _goback(){
		document.srcForm.action=path+"info/SYZZREQInfoList.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="ADOPTER_CHILDREN_SEX">
	<BZ:form name="srcForm" method="post">
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="һ���༭��">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>����Ԥ����Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">�з�<br>Adoptive father</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="MALE_NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">Ů��<br>Adoptive mother</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">����<br>Name</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="NAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">�Ա�<br>Sex</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��������<br>D.O.B</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="BIRTHDAY" type="date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">���볷������<br>Date of application withdrawal </td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REVOKE_REQ_DATE" defaultValue="" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">����ȷ������<br>Date of withdrawal confirmation</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REVOKE_CFM_DATE" type="date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">����״̬<br>Withdrawal status</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="REVOKE_STATE" defaultValue="" checkValue="0=to be confirmed;1=confirmed;"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
