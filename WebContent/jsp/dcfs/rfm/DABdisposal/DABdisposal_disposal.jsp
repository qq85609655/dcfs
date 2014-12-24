<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>���Ĵ���ҳ��</title>
	<BZ:webScript list="true" edit="true" tree="false"/>
	<style>
	</style>
	<script>
	
	//���Ĵ����ύ
	function _submit() {
		//ҳ���У��
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			if (confirm("ȷ�����ø�������Ϣ��")) {
				document.srcForm.action = path + "rfm/DABdisposal/DABdisposalSave.action";
				document.srcForm.submit();
			}
		}
	}
	
	//����
	function _goback(){
		window.location.href=path+'rfm/DABdisposal/DABdisposalList.action';
	}
	
	
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;SYZZ;WJWZ;TWLX;TWCZFS_ALL" property="disposalData">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>���Ĵ���</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td colSpan=7 style="padding: 0;">
							<table class="table table-striped table-bordered dataTable" adsorb="both" init="true" >
								<thead>
									<tr style="background-color: rgb(180, 180, 249);">
										<th style="width: 5%; text-align: center;">
											<div class="sorting_disabled">���</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="FILE_NO">���ı��</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="REGISTER_DATE">��������</div></th>
										<th style="width: 7%; text-align: center;">
											<div class="sorting_disabled" id="COUNTRY_CODE">����</div></th>
										<th style="width: 14%; text-align: center;">
											<div class="sorting_disabled" id="ADOPT_ORG_ID">������֯</div></th>
										<th style="width: 13%; text-align: center;">
											<div class="sorting_disabled" id="MALE_NAME">��������</div></th>
										<th style="width: 13%; text-align: center;">
											<div class="sorting_disabled" id="FEMALE_NAME">Ů������</div></th>
										<th style="width: 8%; text-align: center;">
											<div class="sorting_disabled" id="FILE_TYPE">�ļ�����</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="APPLE_DATE">��������</div></th>
										<th style="width: 10%; text-align: center;">
											<div class="sorting_disabled" id="RETREAT_DATE">ȷ������</div></th>
									</tr>
								</thead>
								<tbody>
									<BZ:for property="List" fordata="fordata">
										<tr>
											<td class="center">
												<BZ:i/><BZ:input prefix="P_" field="AR_ID" type="hidden" property="fordata" />
												<BZ:input prefix="P_" field="AF_ID" type="hidden" property="fordata" /></td>
											<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
											<td class="center"><BZ:data field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/></td>
											<td><BZ:data field="COUNTRY_CODE" defaultValue="" codeName="GJSY" onlyValue="true"/></td>
											<td><BZ:data field="NAME_CN" defaultValue="" onlyValue="true"/></td>
											<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
											<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/></td>
											<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
											<td class="center"><BZ:data field="APPLE_DATE" defaultValue="" type="date" onlyValue="true"/></td>
											<td class="center"><BZ:data field="RETREAT_DATE" defaultValue="" type="date" onlyValue="true"/></td>
										</tr>
									</BZ:for>
								</tbody>
							</table>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="DUAL_USERNAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="R_" field="DUAL_USERID" type="hidden" defaultValue=""/>
							<BZ:input prefix="R_" field="DUAL_USERNAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">��������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="DUAL_DATE" defaultValue="" type="date" onlyValue="true"/>
							<BZ:input prefix="R_" field="DUAL_DATE" type="hidden" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
			<!-- �������� end -->
		</div>
	</div>
	</br>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="ȷ&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
