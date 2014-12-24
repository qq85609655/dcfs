
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<BZ:html>
<BZ:head>
<title>组织机构详细信息</title>
<BZ:script isEdit="true"/>
<script>
$(document).ready(function() {
	dyniframesize(['mainFrame','mainFrame']);
});
	function tijiao(){
		document.srcForm.action=path+"organ/Organ!modify.action";
		document.srcForm.submit();
	}
	function _back(){
		document.srcForm.action=path+"organ/Organ!queryChildrenPage.action";
		document.srcForm.submit();
	}
	function _showExtention(){
		var b = document.getElementById('extentionTable').style.display;
		if(b=='none'){
			document.getElementById('extentionTable').style.display = "block";
		}else{
			document.getElementById('extentionTable').style.display = "none";
		}
	}
</script>
</BZ:head>
<BZ:body property="data" codeNames="ORG_GRADE;XZQH2012">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<div class="heading">基本信息</div>
<!-- 当前修改的组织机构ID -->
<BZ:input field="ID" type="hidden" prefix="Organ_" defaultValue=""/>
<BZ:input field="ORG_LEVEL_CODE" prefix="Organ_" type="hidden" defaultValue=""/>
<!-- 父组织机构ID -->
<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(Organ.PARENT_ID) %>"/>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">组织名称</td>
<td width="20%"><BZ:dataValue field="CNAME"  type="String" defaultValue=""/></td>

<td width="10%">组织简称</td>
<td width="20%"><BZ:dataValue field="SHORT_CNAME" type="String" defaultValue="" /></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">组织类型</td>
<td width="20%"><BZ:dataValue field="ORG_TYPE" type="String" codeName="organTypeList" defaultValue="" /></td>
<td width="10%">门牌号</td>
<td width="20%"><BZ:dataValue field="ORG_DOOR_NUM" type="String" defaultValue="" /></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">负责人</td>
<td width="20%">
<BZ:input field="RESP_PERSON" prefix="Organ_" type="Hidden" defaultValue=""/>
<BZ:dataValue field="RESP_PERSON_NAME"  type="String" defaultValue="" />
</td>
<td width="10%">联系电话</td>
<td width="20%"><BZ:dataValue field="ORG_PHONE" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">排序号</td>
<td width="20%"><BZ:dataValue field="SEQ_NUM"   type="String" defaultValue=""/></td>
<td width="10%">所属地区</td>
<td width="20%"><BZ:dataValue field="AREA_CODE" codeName="XZQH2012" showParent="true" defaultValue=""  /></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">说明</td>
<td width="85%" colspan="4"><BZ:dataValue field="MEMO" type="String" defaultValue="" /></td>
</tr>

</table>

<div class="heading" style="cursor: hand;" id="extentionDiv" onclick="_showExtention();">扩展信息(点击查看更多)</div>
<!-- 当前修改的组织机构ID -->
<table class="contenttable" id="extentionTable" style="display: none">

<tr>
<td width="5%"></td>
<td width="10%">英文名称</td>
<td width="20%"><BZ:dataValue field="ENNAME"  type="String" defaultValue=""/></td>
<td width="10%">组织编码</td>
<td width="20%"><BZ:dataValue field="ORG_CODE" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">行政级别</td>
<td width="20%" colspan="4"><BZ:dataValue field="ORG_GRADE"  codeName="ORG_GRADE" defaultValue=""  /></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">联系地址</td>
<td width="85%" colspan="4"><BZ:dataValue field="ORG_ADDR" type="String" defaultValue=""/></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">Email</td>
<td width="85%" colspan="4"><BZ:dataValue field="ORG_EMAIL"  type="String" defaultValue=""/></td>
</tr>
<!-- 扩展属性显示区域 begin -->
<BZ:propExtend propType="0" data="extendPropsMap" view="true"/>
<!-- 扩展属性显示区域 end -->
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2">
	<input type="button" value="返回" class="button_back" onclick="_back()"/>
</td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>