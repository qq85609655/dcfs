<%
/**   
 * @Title: TwinsCI_detail.jsp
 * @Description: �鿴��ͯͬ����Ϣ
 * @author xugy
 * @date 2014-9-5����5:06:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
String CHILD_NOs = (String)request.getAttribute("CHILD_NOs");
%>
<BZ:html>
<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/common.js"/>
<BZ:head>
	<title>��ͯ��Ϣ�鿴</title>
	<BZ:webScript edit="true"/>
	<link href="<%=request.getContextPath() %>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/easytabs/jquery.easytabs.js"/>
</BZ:head>

<BZ:body codeNames="PROVINCE;ETXB;ETSFLX;">
<script>
$(document).ready(function() {
	dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
	$('#tab-container').easytabs();
});
//�رյ���ҳ
function _close(){
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
}
</script>
	<div style="margin-left: 10px;margin-top: 10px;">
		<input type="button" value="�ر�" class="btn btn-sm btn-primary" onclick="_close()" />
	</div>
	<iframe id="CIsFrame" name="CIsFrame" class="CIsFrame" frameborder=0 style="width: 100%;height: 465px;" src="<%=path%>/match/showCIsInfoInChildNo.action?CHILD_NOs=<%=CHILD_NOs%>"></iframe>
</BZ:body>
</BZ:html>
