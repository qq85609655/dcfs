<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head language="EN">
	<title>��ˮ�Ŵ�ӡ</title>
	<BZ:webScript edit="true" tree="false"/>
	<script>
	//-----  �����Ǵ�ӡ�������  ----------
	window.onbeforeprint=beforePrint;
	window.onafterprint=afterPrint;
	//��ӡ֮ǰ���ز����ӡ��������Ϣ
	function beforePrint()
	{
		print1.style.display='none';
	}
	//��ӡ֮�����ص�����Ϣ����ʾ����
	function afterPrint()
	{
		print1.style.display='';
	}
	//��ӡ����
	function _print()
	{
	    window.print();
	}
	</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;">
	<BZ:form name="srcForm" method="post">
	<BZ:for property="printShow">
		<div class="bz-edit clearfix" desc="�༭����" style="height: 310px;">
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0" style="width: 500px;height: 290px;" align="center">
					<tr>
						<td class="bz-edit-data-title" width="40%">Serial No.</td>
						<td class="bz-edit-data-value" width="60%">
							<BZ:data field="AF_SEQ_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">Country</td>
						<td class="bz-edit-data-value">
							<BZ:data field="COUNTRY_EN" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">Agency (CN)</td>
						<td class="bz-edit-data-value">
							<BZ:data field="NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">Adoptive father</td>
						<td class="bz-edit-data-value">
							<BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">Adoptive mother</td>
						<td class="bz-edit-data-value">
							<BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">Document type</td>
						<td class="bz-edit-data-value">
							<BZ:data field="FILE_TYPE" codeName="WJLX" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">Pre-approved Date</td>
						<td class="bz-edit-data-value">
							<BZ:data field="PASS_DATE" defaultValue="" type="Date" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">Pre-lock Child's Name</td>
						<td class="bz-edit-data-value">
							<BZ:data field="NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</BZ:for>
	<br/>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��" id="print1">
			<input type="button" value="Print" class="btn btn-sm btn-primary" onclick="beforePrint();_print();afterPrint();"/>
		</div>
	</div>
	<!-- ��ť�� ���� -->
	</BZ:form>
</BZ:body>
</BZ:html>
