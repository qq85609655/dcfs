<%
/**   
 * @Title: adoption_regis_cancel.jsp
 * @Description: �����Ǽ�ע��
 * @author xugy
 * @date 2014-11-3����8:05:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");

String CI_ID = data.getString("CI_ID");
String AF_ID = data.getString("AF_ID");

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>�����Ǽ�ע��</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//����
function _submit(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	if (confirm('ȷ��ע���Ǽǣ�')) {
		document.srcForm.action=path+"adoptionRegis/saveAdoptionRegisCancel.action";
		document.srcForm.submit();
		
	}
}
//����
function _goback(){
	document.srcForm.action=path+"adoptionRegis/adoptionRegisCancelList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="ETXB;ETSFLX;GJSY;">
<BZ:form name="srcForm" method="post" token="<%=token %>"s>
<BZ:input type="hidden" prefix="MI_" field="MI_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="CI_" field="CI_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="AF_" field="AF_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>����������Ϣ</div>
			</div>
			<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;height: 157px;" src="<%=path%>/match/showCIInfoThird.action?CI_ID=<%=CI_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>��������Ϣ</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;height: 313px;" src="<%=path%>/match/showAFInfoThird.action?AF_ID=<%=AF_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����Ǽ���Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="20%">�Ǽ�֤��</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="ADREG_NO" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="MI_" field="ADREG_NO" defaultValue="" type="hidden"/>
						</td>
						<td class="bz-edit-data-title" width="20%">�����������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="CHILD_NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ǽ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�Ǽ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����Ǽ�ע����Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>ע��ԭ��</td>
						<td class="bz-edit-data-value" width="80%">
							<BZ:input prefix="MI_" field="ADREG_INVALID_REASON" type="textarea" defaultValue="" style="width:98%;height:60px;" formTitle="��Ч�Ǽ�ԭ��" notnull="��Ч�Ǽ�ԭ����Ϊ��"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>��ͥ������������</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="MI_" field="ADREG_DEAL_TYPE" defaultValue="" formTitle="��ͥ������������">
								<BZ:option value="0">������������</BZ:option>
								<BZ:option value="1">��ͥ�˳�����</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע</td>
						<td class="bz-edit-data-value">
							<BZ:input prefix="MI_" field="ADREG_REMARKS" type="textarea" defaultValue="" style="width:98%;height:60px;" formTitle="��ע"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="ȷ&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
