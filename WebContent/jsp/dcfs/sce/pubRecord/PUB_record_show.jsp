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
	<script>
	//���ص㷢�˻��б�
	function _goback(){
		document.srcForm.action=path+"record/PUBRecordList.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data" codeNames="PROVINCE;ADOPTER_CHILDREN_SEX;BCZL;DFLX;TXRTFBTHLX;GJSY;">
	<BZ:form name="srcForm" method="post">
	<BZ:input type="hidden" field="PUB_ID" prefix="c_"/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="һ���༭��">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�㷢��Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">ʡ��</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">����Ժ</td>
							<td class="bz-edit-data-value" width="15%">
								<BZ:dataValue field="WELFARE_NAME_CN" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">����</td>
							<td class="bz-edit-data-value" width="20%">
								<BZ:dataValue field="NAME" onlyValue="true" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�Ա�</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SEX" defaultValue="" codeName="ADOPTER_CHILDREN_SEX"/>
							</td>
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="BIRTHDAY" defaultValue="" type="date" />
							</td>
							<td class="bz-edit-data-title">�ر��ע</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SPECIAL_FOCUS" defaultValue="" checkValue="0=��;1=��;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SN_TYPE" defaultValue="" codeName="BCZL"/>
							</td>
							<td class="bz-edit-data-title">����</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="IS_PLAN" defaultValue="" checkValue="0=no;1=yes;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">�������</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="DISEASE_CN" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">����</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="COUNTRY_COD" defaultValue="" codeName="GJSY"/>
							</td>
							<td class="bz-edit-data-title">������֯</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CNAME" defaultValue="" />
							</td>
							<td class="bz-edit-data-title">�㷢����</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_MOD" defaultValue=""  codeName="DFLX"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="SETTLE_DATE" type="date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title">�״η�������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_FIRSTDATE" defaultValue="" type="date" />
							</td>
							<td class="bz-edit-data-title">ĩ�η�������</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="PUB_LASTDATE" defaultValue=""  type="date"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">������</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="PUBLISHER_NAME" defaultValue=""/>
							</td>
						</tr>
					</table>
			</div>
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
								<BZ:dataValue field="RETURN_REASON" defaultValue="" />
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
