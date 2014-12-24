<%
/**   
 * @Title: DABRevokeArchive_add.jsp
 * @Description: ��������������
 * @author xugy
 * @date 2014-12-17����3:43:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");

String CI_ID = data.getString("CI_ID");//��ͯ����ID
String AF_ID = data.getString("AF_ID");//�������ļ�ID


TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>��������������</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//����
function _save(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"childInfoReturn/saveDABRevokeArchiveAdd.action";
	document.srcForm.submit();
}
//����
function _goback(){
	document.srcForm.action=path+"childInfoReturn/DABRevokeArchiveList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input type="hidden" prefix="F_" field="NAR_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="F_" field="CI_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="F_" field="AF_ID" defaultValue=""/>
<BZ:input type="hidden" prefix="F_" field="MI_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�����˼�ͥ��Ϣ</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showAFInfoFirst.action?AF_ID=<%=AF_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>��ͯ��Ϣ</div>
			</div>
			<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;" src="<%=path%>/match/showCIInfoFourth.action?CI_ID=<%=CI_ID%>"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>����ȷ����Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="15%">������</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="APPLY_USER" defaultValue="" onlyValue="true" />
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="APPLY_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����ԭ��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="APPLY_INFO" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ȷ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONFIRM_USER" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ȷ������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CONFIRM_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title"><font color="red">*</font>ȷ�Ͻ��</td>
						<td class="bz-edit-data-value">
							<BZ:select prefix="F_" field="CONFIRM_STATE" formTitle="ȷ�Ͻ��" defaultValue="" notnull="��ѡ��ȷ�Ͻ��">
								<BZ:option value="">--��ѡ��--</BZ:option>
								<BZ:option value="1">ͬ��</BZ:option>
								<BZ:option value="2">��ͬ��</BZ:option>
							</BZ:select>
						</td>
						<td class="bz-edit-data-title"></td>
						<td class="bz-edit-data-value"></td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ȷ��˵��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input type="textarea" prefix="F_" field="CONFIRM_INFO" defaultValue="" style="width:98%;height:60px;" maxlength="1000"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="ȷ&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
