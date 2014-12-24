<%
/**   
 * @Title: AZBREQ_info_show.jsp
 * @Description:Ԥ�������鿴ҳ��
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
	<title>����������Ϣ</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	//����Ԥ�������б�
	function _goback(){
		document.srcForm.action=path+"info/AZBREQInfoList.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;DFLX;TXRTFBTHLX;GJSY">
	<BZ:form name="srcForm" method="post">
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="һ���༭��">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>����������Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">����</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">������֯</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="ADOPT_ORG_NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="MALE_NAME"  defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">Ů������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="FEMALE_NAME" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">ʡ��</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">����Ժ</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="WELFARE_NAME_CN" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">����</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">�Ա�</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="15%">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" type="date" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="REVOKE_REQ_DATE" type="date" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">����״̬</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REVOKE_STATE" checkValue="0=��ȷ��;1=��ȷ��;" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���볷��ԭ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="REVOKE_REASON" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">ȷ����</td>
						<td class="bz-edit-data-value" width="20%">
							<BZ:dataValue field="REVOKE_CFM_USERNAME"  defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">ȷ������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REVOKE_CFM_DATE" type="date" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
