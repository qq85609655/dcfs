<%
/**   
 * @Title: DAB_PP_feedback_catalog.jsp
 * @Description: ������������������Ŀ¼������
 * @author xugy
 * @date 2014-11-4����10:16:22
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
Data data = (Data)request.getAttribute("data");

TokenProcessor processor=TokenProcessor.getInstance();
String token=processor.getToken(request);
%>
<BZ:html>
<BZ:head>
	<title>������������������Ŀ¼������</title>
	<BZ:webScript edit="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
//
function _print(){
	//ҳ���У��
	/* if (!runFormVerify(document.srcForm, false)) {
		return;
	} */
}
//
function _save(){
	//ҳ���У��
	/* if (!runFormVerify(document.srcForm, false)) {
		return;
	} */
	document.srcForm.action=path+"feedback/saveDABPPFeedbackCatalog.action";
	document.srcForm.submit();
}
//����
function _goback(){
	document.srcForm.action=path+"feedback/DABPPFeedbackAuditList.action";
	document.srcForm.submit();
}
</script>
<style type="text/css">
	#tab tr {
		height: 30px;
	}
	#tab tr td {
		border: 1px black solid;
	}
	.center {
		text-align: center;
	}
</style>
<BZ:body property="data" codeNames="WJLX;ETSFLX;">
<BZ:form name="srcForm" method="post" token="<%=token %>">
<BZ:input prefix="FI_" field="FEEDBACK_ID" defaultValue="" type="hidden"/>
	<div class="bz-edit clearfix" style="text-align: center;" desc="�༭����">
		<div style="text-align: center;"><b><font size="4">������������������Ŀ¼������</font></b></div>
	</div>
	<table style="width: 50%;margin-top: 10px;" align="center">
		<tr style="height: 30px;">
			<td style="width: 30%;">�����ţ�<BZ:dataValue field="ARCHIVE_NO" defaultValue="" /></td>
			<td style="text-align: right;">��������������<BZ:dataValue field="NAME" defaultValue="" /></td>
		</tr>
		<tr style="height: 30px;">
			<td>�ļ����ͣ�<BZ:dataValue field="FILE_TYPE" defaultValue="" codeName="WJLX"/></td>
			<td  style="text-align: right;">��ͯ��ݣ�<BZ:dataValue field="CHILD_IDENTITY" defaultValue="" codeName="ETSFLX"/></td>
		</tr>
	</table>
	<table style="width: 50%;margin-top: 10px;" align="center" id="tab">
		<colgroup>
			<col width="10%"/>
			<col width="75%"/>
			<col width="15%"/>
		</colgroup>
		<tr>
			<td class="center">���</td>
			<td class="center">�ļ�����</td>
			<td class="center">����</td>
		</tr>
		<tr>
			<td class="center">1</td>
			<td>��һ���������ú󱨸� </td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE1_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">2</td>
			<td>ʮ�����ϱ��������Լ�׫д�Ķ���</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE2_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">3</td>
			<td>��Ƭ</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE3_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td colspan="3">
				<table>
					<tr>
						<td style="border: 0;">�������ڣ�<BZ:input prefix="FI_" field="FILING_DATE1" defaultValue="" type="date"/></td>
						<td style="text-align: right;border: 0;">�����ˣ�<BZ:input prefix="FI_" field="FILING_USERNAME1" defaultValue=""/></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center">4</td>
			<td>�ڶ����������ú󱨸�</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE4_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">5</td>
			<td>ʮ�����ϱ��������Լ�׫д�Ķ���</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE5_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">6</td>
			<td>��Ƭ</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE6_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td colspan="3">
				<table>
					<tr>
						<td style="border: 0;">�������ڣ�<BZ:input prefix="FI_" field="FILING_DATE2" defaultValue="" type="date"/></td>
						<td style="text-align: right;border: 0;">�����ˣ�<BZ:input prefix="FI_" field="FILING_USERNAME2" defaultValue=""/></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center">7</td>
			<td>�������������ú󱨸�</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE7_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">8</td>
			<td>ʮ�����ϱ��������Լ�׫д�Ķ���</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE8_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">9</td>
			<td>��Ƭ</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE9_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td colspan="3">
				<table>
					<tr>
						<td style="border: 0;">�������ڣ�<BZ:input prefix="FI_" field="FILING_DATE3" defaultValue="" type="date" /></td>
						<td style="text-align: right;border: 0;">�����ˣ�<BZ:input prefix="FI_" field="FILING_USERNAME3" defaultValue=""/></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center">10</td>
			<td>���Ĵ��������ú󱨸�</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE10_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">11</td>
			<td>ʮ�����ϱ��������Լ�׫д�Ķ���</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE11_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">12</td>
			<td>��Ƭ</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE12_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td colspan="3">
				<table>
					<tr>
						<td style="border: 0;">�������ڣ�<BZ:input prefix="FI_" field="FILING_DATE4" defaultValue="" type="date" /></td>
						<td style="text-align: right;border: 0;">�����ˣ�<BZ:input prefix="FI_" field="FILING_USERNAME4" defaultValue="" /></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center">13</td>
			<td>������������ú󱨸�</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE13_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">14</td>
			<td>ʮ�����ϱ��������Լ�׫д�Ķ���</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE14_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">15</td>
			<td>��Ƭ</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE15_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td colspan="3">
				<table>
					<tr>
						<td style="border: 0;">�������ڣ�<BZ:input prefix="FI_" field="FILING_DATE5" defaultValue="" type="date" /></td>
						<td style="text-align: right;border: 0;">�����ˣ�<BZ:input prefix="FI_" field="FILING_USERNAME5" defaultValue="" /></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="center">16</td>
			<td>�������������ú󱨸�</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE16_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">17</td>
			<td>ʮ�����ϱ��������Լ�׫д�Ķ���</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE17_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td class="center">18</td>
			<td>��Ƭ</td>
			<td class="center"><BZ:input prefix="FI_" field="CATALOGUE2_FILE18_NUM" defaultValue="0" restriction="plusInt" style="width:25px;"/></td>
		</tr>
		<tr>
			<td colspan="3">
				<table>
					<tr>
						<td style="border: 0;">�������ڣ�<BZ:input prefix="FI_" field="FILING_DATE6" defaultValue="" type="date" /></td>
						<td style="text-align: right;border: 0;">�����ˣ�<BZ:input prefix="FI_" field="FILING_USERNAME6" defaultValue="" /></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="_print()" />
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_save()" />
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
