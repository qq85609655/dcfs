<%
/**   
 * @Title: BGS_notice_print_mod.jsp
 * @Description: �칫�Ҵ�ӡ�޸�
 * @author xugy
 * @date 2014-9-16����2:40:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@page import="com.dcfs.common.atttype.AttConstants"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
//Data data=(Data)request.getAttribute("data");


TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>�칫�Ҵ�ӡ�޸�</title>
	<BZ:webScript edit="true" tree="true" isAjax="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//���沢��ӡ
function _saveAndPrint(){
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"notice/saveAndPrint.action";
	document.srcForm.submit();
}
//Ԥ��
function _printPreview(){
	var MI_ID = document.getElementById("MI_MI_ID").value;
	var smallType1 = "<%=AttConstants.LHSYZNTZS%>";
	var data1 = getData("com.dcfs.ncm.AjaxGetAttInfo","MI_ID="+MI_ID+"&smallType="+smallType1);
	var ID1 = data1.getString("ID");
	var ATT_NAME1 = data1.getString("ATT_NAME");
	var ATT_TYPE1 = data1.getString("ATT_TYPE");
	window.open(path + "/jsp/dcfs/common/pdfView.jsp?name="+ATT_NAME1+"&attId="+ID1+"&attTypeCode=AR&type="+ATT_TYPE1);
	
	var smallType2 = "<%=AttConstants.SWSYTZ%>";
	var data2 = getData("com.dcfs.ncm.AjaxGetAttInfo","MI_ID="+MI_ID+"&smallType="+smallType2);
	var ID2 = data2.getString("ID");
	var ATT_NAME2 = data2.getString("ATT_NAME");
	var ATT_TYPE2 = data2.getString("ATT_TYPE");
	window.open(path + "/jsp/dcfs/common/pdfView.jsp?name="+ATT_NAME2+"&attId="+ID2+"&attTypeCode=AR&type="+ATT_TYPE2);
}

//����
function _goback(){
	document.srcForm.action=path+"notice/BGSNoticePrintList.action";
	document.srcForm.submit();
}
</script>
<BZ:body property="data" codeNames="ETXB;WJLX;PROVINCE;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input type="hidden" prefix="MI_" field="MI_ID" id="MI_MI_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>֪ͨ��ժҪ��Ϣ</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%">���ı��</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="FILE_NO" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title" width="20%">��������</td>
						<td class="bz-edit-data-value" width="30%">
							<BZ:dataValue field="REGISTER_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">������֯</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�з�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">Ů��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ļ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="FILE_TYPE" defaultValue="" onlyValue="true" codeName="WJLX"/>
						</td>
						<td class="bz-edit-data-title">��ͯ����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="CHILD_TYPE" defaultValue="" onlyValue="true" checkValue="1=������ͯ;2=�����ͯ;"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ʡ��</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE"/>
						</td>
						<td class="bz-edit-data-title">����Ժ</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
						</td>
						<td class="bz-edit-data-title">�Ա�</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">��������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SIGN_SUBMIT_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">ǩ������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="SIGN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">�������</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NOTICE_SIGN_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title">�ķ�����</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NOTICE_DATE" defaultValue="" onlyValue="true" type="date"/>
						</td>
						<td class="bz-edit-data-title">�ķ�״̬</td>
						<td class="bz-edit-data-value">
							<BZ:dataValue field="NOTICE_STATE" defaultValue="" onlyValue="true" checkValue="0=δ�ķ�;1=�Ѽķ�;"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-state-default bz-edit-title" desc="����">
				<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
				<div>�޸��������</div>
			</div>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>�������</td>
						<td class="bz-edit-data-value" width="80%">
							<BZ:input prefix="MI_" field="NOTICE_SIGN_DATE" defaultValue="" type="date" notnull="������ڲ���Ϊ��"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="���沢��ӡ" class="btn btn-sm btn-primary" onclick="_saveAndPrint()" />
			<input type="button" value="Ԥ&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_printPreview()" />
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
