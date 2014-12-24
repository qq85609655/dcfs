
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<BZ:html>
<BZ:head>
<title>��֯������ϸ��Ϣ</title>
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
<div class="heading">������Ϣ</div>
<!-- ��ǰ�޸ĵ���֯����ID -->
<BZ:input field="ID" type="hidden" prefix="Organ_" defaultValue=""/>
<BZ:input field="ORG_LEVEL_CODE" prefix="Organ_" type="hidden" defaultValue=""/>
<!-- ����֯����ID -->
<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(Organ.PARENT_ID) %>"/>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">��֯����</td>
<td width="20%"><BZ:dataValue field="CNAME"  type="String" defaultValue=""/></td>

<td width="10%">��֯���</td>
<td width="20%"><BZ:dataValue field="SHORT_CNAME" type="String" defaultValue="" /></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">��֯����</td>
<td width="20%"><BZ:dataValue field="ORG_TYPE" type="String" codeName="organTypeList" defaultValue="" /></td>
<td width="10%">���ƺ�</td>
<td width="20%"><BZ:dataValue field="ORG_DOOR_NUM" type="String" defaultValue="" /></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">������</td>
<td width="20%">
<BZ:input field="RESP_PERSON" prefix="Organ_" type="Hidden" defaultValue=""/>
<BZ:dataValue field="RESP_PERSON_NAME"  type="String" defaultValue="" />
</td>
<td width="10%">��ϵ�绰</td>
<td width="20%"><BZ:dataValue field="ORG_PHONE" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">�����</td>
<td width="20%"><BZ:dataValue field="SEQ_NUM"   type="String" defaultValue=""/></td>
<td width="10%">��������</td>
<td width="20%"><BZ:dataValue field="AREA_CODE" codeName="XZQH2012" showParent="true" defaultValue=""  /></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">˵��</td>
<td width="85%" colspan="4"><BZ:dataValue field="MEMO" type="String" defaultValue="" /></td>
</tr>

</table>

<div class="heading" style="cursor: hand;" id="extentionDiv" onclick="_showExtention();">��չ��Ϣ(����鿴����)</div>
<!-- ��ǰ�޸ĵ���֯����ID -->
<table class="contenttable" id="extentionTable" style="display: none">

<tr>
<td width="5%"></td>
<td width="10%">Ӣ������</td>
<td width="20%"><BZ:dataValue field="ENNAME"  type="String" defaultValue=""/></td>
<td width="10%">��֯����</td>
<td width="20%"><BZ:dataValue field="ORG_CODE" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">��������</td>
<td width="20%" colspan="4"><BZ:dataValue field="ORG_GRADE"  codeName="ORG_GRADE" defaultValue=""  /></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">��ϵ��ַ</td>
<td width="85%" colspan="4"><BZ:dataValue field="ORG_ADDR" type="String" defaultValue=""/></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">Email</td>
<td width="85%" colspan="4"><BZ:dataValue field="ORG_EMAIL"  type="String" defaultValue=""/></td>
</tr>
<!-- ��չ������ʾ���� begin -->
<BZ:propExtend propType="0" data="extendPropsMap" view="true"/>
<!-- ��չ������ʾ���� end -->
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2">
	<input type="button" value="����" class="button_back" onclick="_back()"/>
</td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>