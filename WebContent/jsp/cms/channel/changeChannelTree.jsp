<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>��Ŀ��</title>
	<base target="_self"/>
	<BZ:script isList="true" tree="true"/>
	<script type="text/javascript" src="<BZ:url/>/jsp/innerpublication/view/js/jquery.js"></script>
	<script type="text/javascript">
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		if(isSelNode || !tree.currentNode.hasChild){
			//�ж��Ƿ���Ҫ��ʾ�ϼ�������
			var show_parent = document.getElementsByName("showParent");
			var showName ="";
			if (show_parent!=null && show_parent.length>0){
				show_parent=show_parent[0];
				if (show_parent!=null){
					var showP = show_parent.value;
					if (showP.toUpperCase()=="TRUE"){
						showName=_show_all_name(tree.currentNode);
					}
				}
			}
			if (showName==""){
				showName=tree.currentNode.T;
			}
			
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
			alert("��"+name+"��Ϊ������Ŀ¼��������������");
			return;
		}
		
		//����
		if(confirm('ȷ��ѡ����Ŀ��?')){
			reValue["name"]=showName;
			reValue["value"]=id;
			//if(id.length>2){
			//	reValue["value"]=id.substring(2,id.length);//////////////////////////////ȥ��ǰ׺ 
			//}
			window.returnValue = reValue;
			window.close();
		}else{
		  return;
		}
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" target="_self">
		<div class="kuangjia">
		<div class="list">
		<!-- ��֯�������� -->
		<div class="heading">ѡ����Ŀ</div>
		<table width="100%">
			<tr>
				<td><BZ:tree property="dataList" type="0" iconPath="/images/tree_org/" /></td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>