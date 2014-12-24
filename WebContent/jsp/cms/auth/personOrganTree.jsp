<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>栏目树</title>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript" src="<BZ:url/>/jsp/innerpublication/view/js/jquery.js"></script>
	<script type="text/javascript">
	function _ok(){
		if(!_sel()){
			alert("请选择内容！");
			return;
		}
		window.returnValue=reValue;
		var name="";
		var value="";
		var appIds="";
		var sfdj=0;
		for(var i=0 ;i<reValue.length;i++){
			appIds=appIds + reValue[i]["value"]+"!";
			sfdj++;
		}

		if(sfdj=="0"){
			   alert('请选择要发布到的栏目');
			   return;
		}else{
			if(confirm('确认选择吗?')){
			  window.returnValue = appIds;
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
	</script>
</BZ:head>
<BZ:body onload="_onload1()">
	<BZ:form name="srcForm" method="post" action="">
		<div class="kuangjia">
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
		<div class="heading">选择数据</div>
		<!-- 应用树 -->
		<table width="100%">
			<tr>
				<td><BZ:tree property="dataList" type="1" selectvalue="selectedData"/></td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>