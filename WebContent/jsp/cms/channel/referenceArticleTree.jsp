<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>��Ŀ��</title>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript" src="<BZ:url/>/resources/resource1/newindex/scripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
	function _ok(){
		alert();
		if(!_sel()){
			alert("��ѡ�����ݣ�");
			return;
		}
		window.returnValue=reValue;
		var appIds="";
		var sfdj=0;
		for(var i=0 ;i<reValue.length;i++){
			appIds=appIds + reValue[i]["value"]+"#";
			sfdj++;
		}

		if(sfdj=="0"){
			   alert('��ѡ��Ҫ����������Ŀ');
			   return;
		}else{
			if(confirm('ȷ��Ҫ������?')){
			  document.getElementById("TARGET_CHANNEL_IDS").value=appIds;
			  document.srcForm.action=path+"article/Article!referenceArticle.action";
			  document.srcForm.submit();
			  window.close();
			}else{
			  return;
			}
		}
	}

	function _back(){
		window.close();
	}
	function _onload1(){
		try{
			tree.expandAll();
		}catch(e){}
	}
	
	//�Զ�ѡ����ж�,ckboxҪ�Զ�ѡ��ı���pckbox �������ѡ���
	function _isSelAutoCheckBox(ckbox,pckbox){
		//�������true����ѡ���������false�������κβ���
		var id = ckbox.value;
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
			return false;
		}
		return true;
	}
	
	//���ѡ����ж�
	function _isSelCheckBox(o){
		var id = o.value;
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
			
			//��Ϊ����ѡ�����ģ�������Ҫ��ѡ��ָ�
			o.checked = !o.checked;
			//node��ID
			var nodeId = o.getAttribute("nodeId");
			//ѡ�������ID
			var value = o.value;
			//��ʾ�����ı���
			var title = o.getAttribute("desc");
			//������ѡ��Ҫ����false
			return false;
		}
		
		//����ѡ�񣬷���true����������һ����ѡ��
		return true;
	}
	</script>
</BZ:head>
<BZ:body onload="_onload1();">
	<BZ:form name="srcForm" method="post" action="">
		<div class="kuangjia">
		<!-- Ŀ����Ŀ -->
		<input id="TARGET_CHANNEL_IDS" name="TARGET_CHANNEL_IDS" type="hidden"/>
		<!-- ԭ��Ŀ -->
		<input id="CHANNEL_ID" name="CHANNEL_ID" type="hidden" value='<%=request.getAttribute("CHANNEL_ID")!=null?request.getAttribute("CHANNEL_ID"):"" %>'/>
		<!-- ���õ������ַ��� -->
		<input name="IDS" id="ARTICLE_IDS" type="hidden" value='<%=request.getAttribute("IDS")!=null?request.getAttribute("IDS"):"" %>'/>
		<div class="list">
		<table border="0" cellpadding="0" cellspacing="0" class="operation">
		<tr>
		<td style="padding-left:15px"></td>
		<td align="right" style="padding-right:10px;height:35px;">
		    <input type="button" class="button_add" value="ȷ��" onclick="_ok();">
		    <input type="button" value="�ر�" class="button_close" onclick="_back()"/>
		</td>
		</tr>
		</table>
		<div class="heading">ѡ��Ҫ����������Ŀ</div>
		<!-- Ӧ���� -->
		<table width="100%">
			<tr>
				<td><BZ:tree property="dataList" type="1"/></td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>