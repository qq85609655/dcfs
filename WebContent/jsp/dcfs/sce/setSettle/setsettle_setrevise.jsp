<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>


<BZ:html>
<BZ:head>
	<title>���á��������޲�������</title>
	<BZ:webScript edit="true" tree="false"/>
	<script>
	function _submit() {
		//ҳ���У��
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			document.srcForm.action = path + "sce/setSettle/saveSettleMonth.action";
			document.srcForm.submit();
			window.opener.open_tijiao();
		    window.close();
		}
	}
	
	</script>
</BZ:head>
<BZ:body property="modData">
	<BZ:form name="srcForm" method="post">
	<BZ:input prefix="R_" field="SETTLE_ID" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="�༭����">
			<table class="bz-edit-data-table" border="0" style="height:80px;">
				<tr><td style="text-align: center;">
				<font color="red">*</font>�������ޣ�&nbsp;<BZ:input field="SETTLE_MONTHS" id="R_SETTLE_MONTHS" prefix="R_" restriction="number" defaultValue="" notnull="�����밲������" /> ��
				</td></tr>
				<tr><td style="text-align: center;">
				<font color="red">*</font>�������ޣ�&nbsp;<BZ:input field="DEADLINE" id="R_DEADLINE" prefix="R_" restriction="number" defaultValue="" notnull="�����뽻������" /> ��
				</td></tr>
			</table>
			<br/>
			<br/>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="����" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="�ر�" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
