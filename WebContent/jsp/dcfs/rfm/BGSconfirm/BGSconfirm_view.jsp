<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<BZ:html>
<BZ:head>
	<title>������ϸ��Ϣ�鿴ҳ��</title>
	<BZ:webScript edit="true" tree="false"/>
	<style>
	</style>
	<script>
	
	
</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;WJWZ;TWLX;TWCZFS_ALL" property="showdata">
	<BZ:form name="srcForm" method="post">
	<BZ:input prefix="R_" field="AF_ID" type="hidden" defaultValue="" />
	<BZ:input prefix="R_" field="FAMILY_TYPE" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="�鿴����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�ļ�������Ϣ</div>
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
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">Ů������</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" defaultValue="" onlyValue="true" />
						</td>
						<td class="bz-edit-data-title">������֯</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
			<!-- �������� end -->
		</div>
	</div>
	<br>
	<div class="bz-edit clearfix" desc="�鿴����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<!-- �������� begin -->
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					���ļ�¼��Ϣ
				</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_PERSON_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_DATE" type="date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="APPLE_TYPE" defaultValue="" codeName="TWLX" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">���Ĵ��÷�ʽ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="HANDLE_TYPE" defaultValue="" codeName="TWCZFS_ALL" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DUAL_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="DUAL_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETURN_STATE" defaultValue="" checkValue="0=��ȷ��;1=��ȷ��;2=������;3=�Ѵ���;9=ȡ������" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ȷ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PERSON_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">ȷ������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="RETREAT_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title poptitle">����ԭ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="RETURN_REASON" defaultValue="" onlyValue="true"/>
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
			<input type="button" value="��&nbsp;��" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
