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
	<title>���ά��ҳ��</title>
	<BZ:webScript edit="true" tree="false"/>
	<style>
	</style>
	<script>
	
	//�鿴�ɷѵ�
	function _billShow(paid_no){
		window.open(path + "fam/completeCost/billShow.action?PAID_NO=" + paid_no,"window","width=950,height=300,top=160,left=200,scrollbars=yes");
	}
	
	//���ά���ύ
	function _submit() {
		//ҳ���У��
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			if (confirm("ȷ���ύ�������Ϣ��")) {
				document.srcForm.action = path + "fam/completeCost/completeCostSave.action";
				document.srcForm.submit();
			}
		}
	}
	
	//����
	function _goback(){
		window.location.href=path+'fam/completeCost/completeCostList.action';
	}
	
	
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;" property="data">
	<BZ:form name="srcForm" method="post" token="<%=token %>">
	<BZ:input prefix="P_" field="AF_ID" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�ļ���Ʊ����Ϣ</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">���ı��</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�ļ�����</td>
						<td class="bz-edit-data-value" width="19%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
						</td>
						<td class="bz-edit-data-title">������֯</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">Ӧ�ɽ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AF_COST" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">Ů������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�ɷѱ��</td>
						<td class="bz-edit-data-value">
							<a href="#" onclick="_billShow('<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>');return false;" title="����鿴��Ʊ�ݽɷ���Ϣ"><BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<!-- �������� end -->
		</div>
	</div>
	<br>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					���ά����Ϣ
				</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title poptitle">���ԭ��</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:input field="AF_COST_CLEAR_REASON" id="P_AF_COST_CLEAR_REASON" type="textarea" prefix="P_" formTitle="���ԭ��" maxlength="1000" style="width:80%" defaultValue=""/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="20%">������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="AF_COST_CLEAR_USERNAME" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="P_" field="AF_COST_CLEAR_USERNAME" type="hidden" defaultValue=""/>
						</td>
						<td class="bz-edit-data-title" width="20%">��������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="AF_COST_CLEAR_DATE" type="date" defaultValue="" onlyValue="true"/>
							<BZ:input prefix="P_" field="AF_COST_CLEAR_DATE" type="hidden" defaultValue=""/>
						</td>
					</tr>
				</table>
			</div>
			<!-- �������� end -->
		</div>
	</div>
	<br/>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
