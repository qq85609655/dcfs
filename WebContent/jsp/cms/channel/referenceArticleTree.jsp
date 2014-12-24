<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>栏目树</title>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript" src="<BZ:url/>/resources/resource1/newindex/scripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
	function _ok(){
		alert();
		if(!_sel()){
			alert("请选择内容！");
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
			   alert('请选择要发布到的栏目');
			   return;
		}else{
			if(confirm('确认要发布吗?')){
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
	
	//自动选择的判断,ckbox要自动选择的本身，pckbox 本来点击选择的
	function _isSelAutoCheckBox(ckbox,pckbox){
		//如果返回true，则选择，如果返回false，则不作任何操作
		var id = ckbox.value;
		//获取栏目的信息：父栏目、栏目样式：虚拟、普通、外部链接
		var channelStyle;
		var parentId;
		var name;
		//虚拟目录  无需判断外部链接，因为此处不会出现
		var virsual = "<%=Channel.CHANNEL_STYLE_STATUS_VIRTUAL %>"; 
		$.ajax({
			type: "post",//请求方式
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
			alert("【"+name+"】为【虚拟目录】，不能添加内容");
			return false;
		}
		return true;
	}
	
	//点击选择的判断
	function _isSelCheckBox(o){
		var id = o.value;
		//获取栏目的信息：父栏目、栏目样式：虚拟、普通、外部链接
		var channelStyle;
		var parentId;
		var name;
		//虚拟目录  无需判断外部链接，因为此处不会出现
		var virsual = "<%=Channel.CHANNEL_STYLE_STATUS_VIRTUAL %>"; 
		$.ajax({
			type: "post",//请求方式
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
			alert("【"+name+"】为【虚拟目录】，不能添加内容");
			
			//因为是在选择后处理的，所以需要将选择恢复
			o.checked = !o.checked;
			//node的ID
			var nodeId = o.getAttribute("nodeId");
			//选择的内容ID
			var value = o.value;
			//显示的树的标题
			var title = o.getAttribute("desc");
			//不允许选择要返回false
			return false;
		}
		
		//允许选择，返回true，则会进行下一步的选择
		return true;
	}
	</script>
</BZ:head>
<BZ:body onload="_onload1();">
	<BZ:form name="srcForm" method="post" action="">
		<div class="kuangjia">
		<!-- 目标栏目 -->
		<input id="TARGET_CHANNEL_IDS" name="TARGET_CHANNEL_IDS" type="hidden"/>
		<!-- 原栏目 -->
		<input id="CHANNEL_ID" name="CHANNEL_ID" type="hidden" value='<%=request.getAttribute("CHANNEL_ID")!=null?request.getAttribute("CHANNEL_ID"):"" %>'/>
		<!-- 引用的文章字符串 -->
		<input name="IDS" id="ARTICLE_IDS" type="hidden" value='<%=request.getAttribute("IDS")!=null?request.getAttribute("IDS"):"" %>'/>
		<div class="list">
		<table border="0" cellpadding="0" cellspacing="0" class="operation">
		<tr>
		<td style="padding-left:15px"></td>
		<td align="right" style="padding-right:10px;height:35px;">
		    <input type="button" class="button_add" value="确定" onclick="_ok();">
		    <input type="button" value="关闭" class="button_close" onclick="_back()"/>
		</td>
		</tr>
		</table>
		<div class="heading">选择要发布到的栏目</div>
		<!-- 应用树 -->
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