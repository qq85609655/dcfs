<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>


<BZ:html>
<BZ:head>
	<title>�޸���ͣ����</title>
	<BZ:webScript edit="true" tree="false"/>
	<script>
	function _submit() {
		//ҳ���У��
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			document.srcForm.action = path + "ffs/pause/reviseDeadline.action";
			document.srcForm.submit();
			window.opener.mod_tijiao();
		    window.close();
		}
	}
	
	</script>
</BZ:head>

<BZ:body property="modData">
	<BZ:form name="srcForm" method="post">
	<BZ:input prefix="R_" field="AP_ID" type="hidden" defaultValue="" />
	<div class="bz-edit clearfix" desc="�༭����">
			<table class="bz-edit-data-table" border="0" style="height:80px;">
				<tr><td style="text-align: center;">
				��ͣ���ޣ�&nbsp;<BZ:input field="END_DATE" id="R_END_DATE" prefix="R_" type="date" dateExtend="maxDate:'%y-{%M+6}-%d'"/>
				</td></tr>
			</table>
			<br/>
			<br/>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="�ύ" class="btn btn-sm btn-primary" onclick="_submit();"/>&nbsp;
			<input type="button" value="�ر�" class="btn btn-sm btn-primary" onclick="javascript:window.close();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
