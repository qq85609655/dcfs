<%
/**   
 * @Title: SYZZ_adoption_regis_detail.jsp
 * @Description: ������֯�����Ǽǲ鿴
 * @author xugy
 * @date 2014-11-8����6:03:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");

String CI_ID = data.getString("CI_ID");
String AF_ID = data.getString("AF_ID");
%>
<BZ:html>
<BZ:head language="EN">
	<title>������֯�����Ǽǲ鿴</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//����
function _goback(){
	document.srcForm.action=path+"adoptionRegis/SYZZAdoptionRegisList.action";
	document.srcForm.submit();
}

</script>
<BZ:body property="data" codeNames="PROVINCE;ETXB;ETSFLX;">
<BZ:form name="srcForm" method="post">
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>��ͯ��Ϣ(Child basic Inf.)</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">�뼮����</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="CHILD_NAME_EN" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%"></td>
						<td class="bz-edit-data-value" width="35%"></td>
					</tr>
				</table>
			</div>
			<iframe id="CIFrame" name="CIFrame" class="CIFrame" frameborder=0 style="width: 100%;height: 157px;" src="<%=path%>/match/showCIInfoSecond.action?CI_ID=<%=CI_ID%>&LANG=EN"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>��������Ϣ</div>
			</div>
			<iframe id="AFFrame" name="AFFrame" class="AFFrame" frameborder=0 style="width: 100%;height: 498px;" src="<%=path%>/match/showAFInfoSecond.action?AF_ID=<%=AF_ID%>&LANG=EN"></iframe>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�Ǽ���Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" id="tab">
					<tr>
						<td class="bz-edit-data-title" width="15%">�Ǽǻ���</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="ADREG_ORG_ID" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="15%">�Ǽ�֤��</td>
						<td class="bz-edit-data-value" width="35%">
							<BZ:dataValue field="ADREG_NO" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�Ǽ���</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_USERNAME" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title">�Ǽ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="ADREG_DATE" defaultValue="" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��ע<br>Remarks</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="CHILD_NAME_EN" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
