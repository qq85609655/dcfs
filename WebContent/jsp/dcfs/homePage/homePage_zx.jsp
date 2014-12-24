<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.authenticate.sso.SSOConfig"%>
<%@page import="com.hx.framework.common.ClientIPGetter"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	String path = request.getContextPath();
%>
<html>
<BZ:head>
<title>��ҳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<BZ:webScript isAjax="true"/>
<link href="<BZ:resourcePath/>/newindex/styles/base/front.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function(){
	dyniframesize(['mainFrame']);
	_notice();
});
//֪ͨ����
function _notice(){
	$.ajax({
		url: path+"AjaxExecute?className=com.dcfs.homePage.AjaxNotice",
		type: 'POST',
		dataType: 'json',
		success: function(dataList){
		}
	});
	
	$.ajax({
		url: path+"AjaxExecute?className=com.dcfs.homePage.AjaxNotice",
		type: 'POST',
		dataType: 'json',
		success: function(dataList){
			if(dataList.length>0){
				for(var i=0;i<dataList.length;i++){
					var data=dataList[i];
					var title = data.TITLE;
					var url = path+"article/receiptAdd.action?ID="+data.ID;
					$("#notice").append('<li><a class="title" href="'+url+'">'+title+'</a></li>');
				}
			}
		}
	});
}

</script>
</BZ:head>
<body>
	<div class="front-blocks">
		<div class="leftbar">
			<div class="blockbox tzgg">
				<div class="blockhead">
					<div class="blocktitle"><span class="tzggico">֪ͨ����</span></div>
					<a href="<BZ:url/>/article/receiptList.action" class="more">����...</a>
				</div>
				<div class="blocklist">
					<ul id="notice">
						
					</ul>
				</div>
			</div>
			<div class="blockbox zlxz">
				<div class="blockhead">
					<div class="blocktitle"><span class="zlxzico">��������</span></div>
					<a href="#" class="more">����...</a>
				</div>
				<div class="blocklist">
					<ul>
						<li><a class="title" href="#">��ͯ��Ϣ�ɼ���</a><span class="date">����</span></li>
						<li><a class="title" href="#">��ͯ��Ϣ�ɼ���</a><span class="date">����</span></li>
						<li><a class="title" href="#">��ͯ��Ϣ�ɼ���</a><span class="date">����</span></li>
						<li><a class="title" href="#">��ͯ��Ϣ�ɼ���</a><span class="date">����</span></li>
						<li><a class="title" href="#">��ͯ��Ϣ�ɼ���</a><span class="date">����</span></li>
						<li><a class="title" href="#">��ͯ��Ϣ�ɼ���</a><span class="date">����</span></li>
						<li><a class="title" href="#">��ͯ��Ϣ�ɼ���</a><span class="date">����</span></li>
						<li><a class="title" href="#">��ͯ��Ϣ�ɼ���</a><span class="date">����</span></li>
						<li><a class="title" href="#">��ͯ��Ϣ�ɼ���</a><span class="date">����</span></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="rightbar">
			<div class="blockbox dbsw">
				<div class="blockhead">
					<div class="blocktitle"><span class="zlxzico">��������</span></div>
				</div>
				<div class="blocklist clearfix">
					<ul>
						<!-- �����쵼 -->
						<li><a>ǩ������</a></li>
						<!-- �칫�� -->
						<li><a>���ĵǼǴ���</a></li>
						<li><a>�쵼ǩ������</a></li>
						<li><a>�ļ������ļ�¼</a></li>
						<li><a>����ӡ</a></li>
						<!-- ��˲� -->
						<li><a>�ļ����մ���</a></li>
						<li><a>�ļ���˴���</a></li>
						<li><a>Ԥ����˴���</a></li>
						<li><a>����ȷ�ϴ���</a></li>
						<li><a>�ļ������ѷ���</a></li>
						<li><a>Ԥ�������ѷ���</a></li>
						<li><a>������</a></li>
						<!-- ���ò� -->
						<li><a>���Ͻ��գ�ʡ��-���ò�������</a></li>
						<li><a>���빫˾���Ͻ��մ���</a></li>
						<li><a>��ͯ������˴���</a></li>
						<li><a>ƥ����˴���</a></li>
						<li><a>�㷢�˻�ȷ�ϴ���</a></li>
						<li><a>����������˴���</a></li>
						<li><a>��������ȷ�ϴ���</a></li>
						<li><a>���Ͻ��գ�������-���ò�������</a></li>
						<li><a>������</a></li>
						<!-- ������ -->
						<li><a>�ļ����մ���</a></li>
						<li><a>��ͯ���Ͻ��մ���</a></li>
						<li><a>֪ͨ�鸱����ӡ</a></li>
						<li><a>������գ�������֯-������������</a></li>
						<li><a>������˴���</a></li>
						<li><a>������գ���֮��-������������</a></li>
						<li><a>���鵵</a></li>
						<!-- ���� -->
						<li><a>������</a></li>
						<li><a>��ȷ�Ϸ����</a></li>
						<li><a>��ȷ����Ϣ��</a></li>
						<!-- ��֮�� -->
						<li><a>�ļ����մ���</a></li>
						<li><a>�ļ��������</a></li>
						<li><a>�ļ��ط�����</a></li>
						<li><a>�ļ���������</a></li>
						<li><a>Ԥ���������</a></li>
						<li><a>Ԥ����������</a></li>
						<li><a>���淭�����</a></li>
						<li><a>����ȷ�ϴ���</a></li>
						<li><a>�ӿ췭�����</a></li>
						<li><a>������</a></li>
						<!-- ���빫˾ -->
						<li><a>���Ͻ��մ���</a></li>
						<li><a>���Ϸ������</a></li>
						<li><a>���ϲ�������</a></li>
						<!-- ʡ�� -->
						<li><a>��ͯ������˴���</a></li>
						<li><a>��ͯ���ϲ������</a></li>
						<li><a>���Ǽ�</a></li>
						<li><a>����ԤԼȷ�ϴ���</a></li>
						<li><a>������</a></li>
						<!-- ����Ժ -->
						<li><a>��ͯ���ϲ������</a></li>
						<li><a>���Ǽ�</a></li>
						<li><a>������</a></li>
					</ul>
				</div>
			</div>
			<div class="blockbox tzgg">
				<div class="blockhead">
					<div class="blocktitle"><span class="zcckico">���߲鿴</span></div>
					<a href="#" class="more">����...</a>
				</div>
				<div class="blocklist">
					<ul>
						<li><a class="title" href="#">�и��������������ù²ж�ͯ�������������и��������������ù²ж�ͯ</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">�и��������������ù²ж�ͯ�������������и��������������ù²ж�ͯ</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">�и��������������ù²ж�ͯ�������������и��������������ù²ж�ͯ</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">�и��������������ù²ж�ͯ�������������и��������������ù²ж�ͯ</a><span class="date">[ 8-25 ]</span></li>
					</ul>
				</div>
			</div>
			<div class="blockbox tzgg">
				<div class="blockhead">
					<div class="blocktitle"><span class="tzggico">����������</span></div>
					<a href="#" class="more">����...</a>
				</div>
				<div class="blocklist">
					<ul>
						<li><a class="title" href="#">�и��������������ù²ж�ͯ�������������и��������������ù²ж�ͯ</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">�и��������������ù²ж�ͯ�������������и��������������ù²ж�ͯ</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">�и��������������ù²ж�ͯ�������������и��������������ù²ж�ͯ</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">�и��������������ù²ж�ͯ�������������и��������������ù²ж�ͯ</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">�и��������������ù²ж�ͯ�������������и��������������ù²ж�ͯ</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">�и��������������ù²ж�ͯ�������������и��������������ù²ж�ͯ</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">�и��������������ù²ж�ͯ�������������и��������������ù²ж�ͯ</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">�и��������������ù²ж�ͯ�������������и��������������ù²ж�ͯ</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">�и��������������ù²ж�ͯ�������������и��������������ù²ж�ͯ</a><span class="date">[ 8-25 ]</span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>