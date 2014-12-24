<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	//���ƶ�����Ŀ
	String ids = (String)request.getAttribute(Channel.IDS);
	//������Ŀ
	String parentId = (String)request.getAttribute(Channel.PARENT_ID);
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
		
		//�ж��ⲿ���� ��ȡ��Ŀ����Ϣ������Ŀ����Ŀ��ʽ�����⡢��ͨ���ⲿ����
		var channelStyle;
		var parentId;
		var name;
		var outlinkkey = "<%=Channel.CHANNEL_STYLE_STATUS_OUTLINK %>";
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
		if(channelStyle == outlinkkey){
			alert("��"+name+"��Ϊ���ⲿ���ӡ������ܴ�������Ŀ");
			return;
		}
		
		
		//����
		if(confirm("ȷ��Ҫ�ƶ���")){
			document.getElementById("CHANNEL_ID").value=id;
			document.srcForm.submit();
			window.close();
		}
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="channel/Channel!changeChannel.action">
		<!-- ��֯��������Ա��ID -->
		<input type="hidden"  name="IDS" value='<%=ids != null ? ids : "" %>'/>
		<!-- ����ǰ��Ƶ��ID -->
		<input type="hidden" name="PARENT_ID" value='<%=parentId != null ? parentId : "" %>'/>
		<!-- �������Ƶ��ID -->
		<input name="CHANNEL_ID" id="CHANNEL_ID" type="hidden"/>
		<div class="kuangjia">
		<div class="list">
		<div class="heading">ѡ����Ŀ</div>
		<!-- ��֯�������� -->
		<table width="100%">
			<tr>
				<td><BZ:tree property="dataList" type="0" topName="��Ŀ��"/></td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>