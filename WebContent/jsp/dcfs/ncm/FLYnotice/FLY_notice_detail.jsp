<%
/**   
 * @Title: FLY_notice_detail.jsp
 * @Description: ����Ժ֪ͨ��鿴
 * @author xugy
 * @date 2014-11-19����6:02:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="java.util.List"%>
<%@page import="com.hx.upload.vo.Att"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
List<Att> list=(List)request.getAttribute("list");
int size = list.size();
String MI_ID = (String)request.getAttribute("MI_ID");//ƥ����ϢID

%>
<BZ:html>
<BZ:head>
	<title>����Ժ֪ͨ��鿴</title>
	<BZ:webScript edit="true" isAjax="true"/>
	<up:uploadResource cancelJquerySupport="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	var PDF = document.getElementsByName("pdf");
	if(PDF.length>0){
		for(var i=0;i<PDF.length;i++){
			PDF[i].setPageMode("none");
			PDF[i].setLayoutMode("DontCare");
			PDF[i].SetZoom(100);
			PDF[i].gotoFirstPage();
			PDF[i].setShowScrollbars(1);
			PDF[i].setShowToolbar(0);
		}
	}
});
//����
function _goback(){
	document.srcForm.action=path+"notice/FLYNoticeList.action";
	document.srcForm.submit();
}
//setTimeout(_goback(), 1000);
</script>
<BZ:body>
<BZ:form name="srcForm" method="post">
<input type="hidden" id="ids" name="ids" value=""/>
	<%
	if(list.size()>0){
	    for(int i=0;i<list.size();i++){
	        String ID = list.get(i).getId();
	%>
	<object classid="clsid:CA8A9780-280D-11CF-A24D-444553540000"  width="100%" height="600px" border="0" top="-10" class="pdf" name="pdf">    
		<param name="_Version" value="65539">
		<param name="_ExtentX" value="20108">
		<param name="_ExtentY" value="10866">
		<param name="_StockProps" value="0">
		<!-- ������ָ�����PDF�ĵ����ڵأ�����ڷ���webĿ¼ -->
		<param name="SRC" value='<up:attDownload attTypeCode="AF" attId='<%=ID %>'/>'>
	</object>
	<%
	    }
	}
	%>
	<!-- ��ť�� ��ʼ -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="��ť��">
			<input type="button" value="��&nbsp;&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- ��ť�� ���� -->
</BZ:form>
</BZ:body>
</BZ:html>
