<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String ids = (String)request.getAttribute(Article.IDS);
	String channelId = (String)request.getAttribute(Article.CHANNEL_ID);
%>
<BZ:html>
<BZ:head>
	<title>Ƶ����</title>
	<base target="_self"/>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript" src="<BZ:url/>/jsp/innerpublication/view/js/jquery.js"></script>
	<script type="text/javascript">
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		
		//��ȡ��Ŀ����Ϣ������Ŀ����Ŀ��ʽ�����⡢��ͨ���ⲿ����
		var channelStyle;
		var parentId;
		var name;
		//����Ŀ¼  �����ж��ⲿ���ӣ���Ϊ�˴��������
		var virsual = "<%=Channel.CHANNEL_STYLE_STATUS_VIRTUAL %>"; 
		$.ajax({
			type: "post",//����ʽ
			url: "<BZ:url/>/channel/Channel!ajaxStyleValue.action?ID="+id,
			data: "time=" + new Date().valueOf(),
			async : false,
			dataType: "json",
			success: function(rs){
				name = rs.name;
				parentId = rs.parentId;
				channelStyle = rs.channelStyle;
			}
		});
		
		if(channelStyle == virsual){
			alert("��"+name+"��Ϊ������Ŀ¼���������������");
			return;
		}
		
		//����
		if(confirm("ȷ��Ҫ�ƶ���")){
			document.getElementById("CHANNEL_ID").value=id;
			document.srcForm.submit();
			window.returnValue="yesa";
			window.close();
		}
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="article/Article!changeChannel.action">
		<!-- ��֯��������Ա��ID -->
		<input type="hidden"  name="IDS" value='<%=ids != null ? ids : "" %>'/>
		<!-- ����ǰ��Ƶ��ID -->
		<input type="hidden" name="Article_CHANNEL_ID" value='<%=channelId != null ? channelId : "" %>'/>
		<!-- �������Ƶ��ID -->
		<input name="CHANNEL_ID" id="CHANNEL_ID" type="hidden"/>
		<div class="kuangjia">
		<div class="list">
		<div class="heading">ѡ����Ŀ</div>
		<!-- ��֯�������� -->
		<table width="100%">
			<tr>
				<td><BZ:tree property="dataList" type="0"/></td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>