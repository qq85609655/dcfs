<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<BZ:html>
<BZ:head>
	<title>Ʊ�ݽɷ���Ϣ�鿴</title>
	<BZ:webScript edit="true" tree="false"/>
	<script>
	/*function _goback(){
		window.history.go(-1);	
	}*/
</script>
</BZ:head>

<BZ:body codeNames="FYLB;JFFS" property="data">
	<BZ:form name="srcForm" method="post">
	
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>
					�ɷ�Ʊ����Ϣ
				</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="15%">�������</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="COST_TYPE" codeName="FYLB" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">Ӧ�ɽ��</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAID_SHOULD_NUM" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="15%">�ɷѷ�ʽ</td>
						<td class="bz-edit-data-value" width="18%">
							<BZ:dataValue field="PAID_WAY" codeName="JFFS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">Ʊ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAR_VALUE" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�ɷѱ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PAID_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�ɷ�Ʊ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BILL_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ɷ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="REG_DATE" defaultValue="" type="date" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title poptitle">�ɷѱ�ע</td>
						<td class="bz-edit-data-value" colspan="3">
							<BZ:dataValue field="REMARKS" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<br/>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<button class="btn btn-sm btn-primary" onclick="window.close();">�ر�</button>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
