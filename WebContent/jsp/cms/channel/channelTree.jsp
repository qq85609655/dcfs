<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>��Ŀ��</title>
	<BZ:script isList="true" tree="true" />
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
		
		//alert(parentId+":"+channelStyle+":"+name);
		if(channelStyle == outlinkkey){
			alert("��"+name+"��Ϊ���ⲿ���ӡ��������������Ŀ");
			return;
		}
		
		//����
		//parent.mainFrame.location = "<BZ:url/>/channel/Channel!queryChildren.action?<%=Channel.PARENT_ID%>="+id;
		childFrame.location = "<BZ:url/>/channel/Channel!queryChildren.action?<%=Channel.PARENT_ID%>="+id;
	}
	
	function reinitIframe(){
		var iframe = document.getElementById("childFrame");
		try{
			var bHeight = iframe.contentWindow.document.body.scrollHeight;
			var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
			var height = Math.max(bHeight, dHeight);
			iframe.height = height;
		}catch (ex){}
	}
	window.setInterval("reinitIframe()", 200);
	/* $(document).ready(function(){
		  dyniframesize([ 'mainFrame' ]);
	}); */
	</script>
</BZ:head>
<BZ:body>
	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		<tr>
			<td width="25%" valign="top">
				<BZ:form name="srcForm" method="post" action="channel/Channel!generateTreeForChannel.action">
				<!-- �޸���֯�����ı�־λ -->
				<input type="hidden" name="treeDispatcher" value="channelTree" />
				<div class="kuangjia">
					<div class="list">
						<div class="heading">ѡ����Ŀ</div>
						<!-- ��֯�������� -->
						<table width="100%">
							<tr>
								<td width="100%"><BZ:tree property="dataList" type="0" topName="��Ŀ��"/></td>
							</tr>
						</table>
					</div>
				</div>
				</BZ:form>
			</td>
			<td width="75%" valign="top">
				<iframe id="childFrame" name="childFrame" src="<BZ:url/>/channel/Channel!queryChildren.action?<%=Channel.PARENT_ID%>=0" style="width: 100%;" frameborder="0" scrolling="no"></iframe>
			</td>
		</tr>
	</table>
</BZ:body>
</BZ:html>