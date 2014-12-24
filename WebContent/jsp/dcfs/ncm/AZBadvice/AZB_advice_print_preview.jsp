<%
/**   
 * @Title: AZB_advice_print_preview.jsp
 * @Description: ���ò��������֪ͨ���ӡԤ��
 * @author xugy
 * @date 2014-11-11����2:49:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");

String ID = data.getString("ID");//����ID
String ATT_NAME = data.getString("ATT_NAME");//��������
String ATT_TYPE = data.getString("ATT_TYPE");//��������
%>
<BZ:html>
<BZ:head>
	<title>���ò��������֪ͨ���ӡԤ��</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	<up:uploadResource cancelJquerySupport="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	var PDF = document.getElementById("PDF");
	PDF.setPageMode("none");
	PDF.setLayoutMode("DontCare");
	PDF.SetZoom(100);
	PDF.gotoFirstPage();
	PDF.setShowScrollbars(1);
	PDF.setShowToolbar(0);
});

//����
function _print(){
	//ҳ���У��
	if (!runFormVerify(document.srcForm, false)) {
		return;
	}
	document.srcForm.action=path+"advice/AZBprint.action";
	document.srcForm.submit();
}
//����
function _goback(){
	document.srcForm.action=path+"advice/AZBAdviceList.action";
	document.srcForm.submit();
}
</script>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<BZ:input type="hidden" prefix="MI_" field="MI_ID" id="MI_MI_ID" defaultValue=""/>
	<div class="bz-edit clearfix" desc="�༭����">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<object id="PDF" classid="clsid:CA8A9780-280D-11CF-A24D-444553540000" width="100%" height="600px" border="0" top="-10" class="pdf" name="pdf">    
				<param name="setShowToolbar" value="false">
				<param name="_Version" value="65539">
				<param name="_ExtentX" value="20108">
				<param name="_ExtentY" value="10866">
				<param name="_StockProps" value="0">
				<!-- ������ָ�����PDF�ĵ����ڵأ�����ڷ���webĿ¼ -->
				<param name="SRC" value='<up:attDownload attTypeCode="AF" attId='<%=ID %>'/>'>
			</object>
			<%-- <object id="weboffice" height="700px" width='100%' classid='clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5' codebase='<%=path %>/Office/weboffice_pdf_v6.0.5.0.cab#Version=6,0,5,0'></object> --%>
			<div class="bz-edit-data-content clearfix" desc="������">
				<table class="bz-edit-data-table" border="0">
					<tr>
						<td class="bz-edit-data-title" width="20%"><font color="red">*</font>�������</td>
						<td class="bz-edit-data-value" width="80%">
							<BZ:input prefix="MI_" field="ADVICE_SIGN_DATE" id="MI_ADVICE_SIGN_DATE" defaultValue="" type="date" notnull="������ڲ���Ϊ��"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="_print()" />&nbsp;
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
