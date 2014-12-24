<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<BZ:html>
<BZ:head language="EN">
	<title>�ļ���ͣ��Ϣ�鿴ҳ��</title>
	<BZ:webScript edit="true" tree="false"/>
	<style>
		.base .bz-edit-data-title{
			line-height:20px;
		}
	</style>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;SYZZ;WJWZ;WJQJZT_ZX" property="data">
	<div class="bz-edit clearfix" desc="�༭����">
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
						<td class="bz-edit-data-title" width="15%">���ı��<br>Log-in No.</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��������<br>Log-in date</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" type="Date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�ļ�����<br>Document type</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="FILE_TYPE" codeName="WJLX" isShowEN="true" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������<br>Adoptive father</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">Ů������<br>Adoptive mother</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�ļ�λ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AF_POSITION" codeName="WJWZ" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����<br>Country</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CODE" codeName="GJSY" isShowEN="true" defaultValue="" onlyValue="true" />
						</td>
						<td class="bz-edit-data-title">������֯<br>Agency</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�ļ�״̬<br>File status</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="AF_GLOBAL_STATE" codeName="WJQJZT_ZX" isShowEN="true" defaultValue="" onlyValue="true"/>
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
					�ļ���ͣ��Ϣ
				</div>
			</div>
			<!-- �������� end -->
			<!-- �������� begin -->
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">��ͣ����</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAUSE_UNITNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��ͣ��</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAUSE_USERNAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">��ͣ����<br>Suspension date</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAUSE_DATE" type="date" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="15%">��ͣ����</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="END_DATE" type="date" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title poptitle">��ͣԭ��</td>
						<td class="bz-edit-data-value" colspan="5">
							<BZ:dataValue field="PAUSE_REASON" defaultValue="" onlyValue="true"/>
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
			<input type="button" value="Close" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:body>
</BZ:html>
