<%
/**   
 * @Title: recordStateConfirm.jsp
 * @Description:��֯����������Ϣҳ��
 * @author lihf
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
	<title>�����Ϣ</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<script>
	function _submit(){
		if(confirm("ȷ���ύ��")){
			//ҳ���У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			document.srcForm.action=path+"mkr/organSupp/organRecordStateSubmit.action";
			document.srcForm.submit();
		}
	}
	
	//������֯���������б�
	function _goback(){
		document.srcForm.action=path+"mkr/organSupp/organRecordStateList.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body property="data">
	<BZ:form name="srcForm" method="post">
	<BZ:input type="hidden" field="RI_ID" prefix="S_"/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper" desc="һ���༭��">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">��֯����</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:dataValue field="CNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">����</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:dataValue field="COUNTRY_NAME" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">Ӣ������</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:dataValue field="ENNAME" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="15%">��������</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:dataValue field="ORG_CODE" defaultValue=""/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">�����</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:input field="RECORD_NAME" defaultValue="" prefix="MKR_" readonly="true"/>
								<BZ:input type="hidden" field="ADOPT_ORG_ID" defaultValue="" prefix="MKR_"/>
								<BZ:input type="hidden" field="RECORD_USERID" defaultValue="" prefix="MKR_"/>
							</td>
							<td class="bz-edit-data-title" width="15%">�������</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:input field="RECORD_DATE" defaultValue="" prefix="MKR_" type="date"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">������</td>
							<td class="bz-edit-data-value" colspan="3">
								<textarea name="MKR_AUDIT_OPINION" rows="2" cols="85%"><%=data.getString("AUDIT_OPINION")!=null&&!"".equals(data.getString("AUDIT_OPINION"))?data.getString("AUDIT_OPINION"):"" %></textarea>	
							</td>
						</tr>
					</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit();"/>
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
