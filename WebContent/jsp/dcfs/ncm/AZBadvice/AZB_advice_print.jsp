<%
/**   
 * @Title: AZB_advice_print.jsp
 * @Description: ���ò����������ӡ
 * @author xugy
 * @date 2014-11-12����5:49:15
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

String MI_ID = data.getString("MI_ID");//ƥ����ϢID

%>
<BZ:html>
<BZ:head>
	<title>���ò��������֪ͨ���ӡ</title>
	<BZ:webScript edit="true" isAjax="true"/>
	<up:uploadResource cancelJquerySupport="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	
	//dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
});
var MI_ID = "<%=MI_ID%>";
//����
function _print(){
	var PDF = document.getElementById("PDF");
	//PDF.printWithDialog();
	PDF.printAll();
	
	var printPlus = getStr("com.dcfs.ncm.AjaxPlusPrintNum", "MI_ID="+MI_ID+"&BIZ_TYPE=1");
	if(printPlus == "1"){
		setTimeout("_goback()", 7000);
	}
}
//����
function _goback(){
	document.srcForm.action=path+"advice/AZBAdviceList.action";
	document.srcForm.submit();
}
//setTimeout(_goback(), 1000);
</script>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
	<div style="font-size:14px;height:100%;vertical-align: middle;text-align: center"><img src="<%=request.getContextPath()%>/resource/images/loading1.gif"/>���ڴ�ӡ�����Ժ�...</div>
	<object id="PDF" classid="clsid:CA8A9780-280D-11CF-A24D-444553540000"  width="100%" height="0px" border="0" top="-10" class="pdf" name="pdf">    
		<param name="_Version" value="65539">
		<param name="_ExtentX" value="20108">
		<param name="_ExtentY" value="10866">
		<param name="_StockProps" value="0">
		<!-- ������ָ�����PDF�ĵ����ڵأ�����ڷ���webĿ¼ -->
		<param name="SRC" value='<up:attDownload attTypeCode="AF" attId='<%=ID %>'/>'>
	</object>
	<!-- ��ť�� ��ʼ -->
	<!-- <div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;ӡ" class="btn btn-sm btn-primary" onclick="_print()" />
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div> -->
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
<script type="text/javascript">
setTimeout("_print()", 3000);
//setTimeout("_goback()", 7000);
</script>
</BZ:html>
