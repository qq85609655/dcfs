
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@page import="com.hx.framework.sdk.*"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	Data person = (Data)request.getAttribute("person");
	Data person1 = (Data)request.getAttribute("person1");
	Data personExt = (Data)request.getAttribute("personExt");
	Data organPerson = (Data)request.getAttribute("organPerson");
	String respId=person.getString("RESP_DEPT");
	if(respId!=null && !respId.trim().equals("")){
		String[] ss=respId.split(",");
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<ss.length;i++){
			if(i>0){
				sb.append(",");
			}
			sb.append(OrganHelper.getOrganCNameById(ss[i]));
		}
		person.add("RESP_DEPT_NAME",sb.toString());
	}

%>
<BZ:html>
<BZ:head>
<title>��Ա��ϸ��Ϣҳ��</title>
<BZ:script isEdit="true" isDate="true" />
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function tijiao()
	{
		document.srcForm.action=path+"person/Person!modify.action";
		document.srcForm.submit();
	}
	function _back(){
		document.srcForm.action=path+"person/Person!query.action";
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
<BZ:body codeNames="POLITIC_CODE;MARRY_CODE;EDU_CODE;COUNTRY;CARD_CODE;DEGREE_CODE;PROVINCE;NATION;CITY;SEX;SECURITY_LEVEL_P" property="person">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<!-- ��Ա������֯���� -->
<input name="OrganPerson_ORG_ID" type="hidden" value="<%=request.getAttribute(OrganPerson.ORG_ID) %>"/>
<input name="ORG_ID" type="hidden" value="<%=request.getAttribute(OrganPerson.ORG_ID) %>"/>
<input name="S_CNAME" type="hidden" value='<%=request.getParameter("S_CNAME") %>'>
<input name="S_ORG_ID" type="hidden" value='<%=request.getParameter("S_ORG_ID") %>'>
<input name="S_ACCOUNT_ID" type="hidden" value='<%=request.getParameter("S_ACCOUNT_ID") %>'>
<input name="S_STATUS" type="hidden" value='<%=request.getParameter("S_STATUS") %>'>
<!-- ��Ա���,��ǰ��Action���� -->
<BZ:input field="PERSON_ID" prefix="Person_" type="hidden" property="person"/>
<!-- ��չ��ϢID -->
<BZ:input field="ID" prefix="OrganPerson_" type="hidden" property="organPerson"/>
<div class="heading">������Ϣ</div>
<table class="contenttable">

<tr style="display: none">
<td width="5%"></td>
<td width="10%">��</td>
<td width="20%"><BZ:dataValue field="FIRST_NAME"  type="String" defaultValue="" />
</td>
<td width="10%">��</td>
<td width="20%"><BZ:dataValue field="LAST_NAME" type="String" defaultValue="" /></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">����</td>
<td width="20%"><BZ:dataValue field="CNAME" type="String"  defaultValue=""/>
<BZ:dataValue field="CNAME"  type="String" defaultValue=""/>
</td>
<td width="10%">�Ա�</td>
<td width="20%"><BZ:dataValue field="SEX"  defaultValue=""  codeName="SEX"/></td>
<td width="5%"></td>
</tr>

<tr>
	<td width="5%"></td>
	<td width="10%">�����</td>
	<td width="20%"><BZ:dataValue field="SEQ_NUM" type="String" defaultValue=""  /></td>
	<td width="10%">�칫�绰</td>
	<td width="20%"><BZ:dataValue field="OFFICE_TEL"  type="String" defaultValue=""  /></td>
	<td width="5%"></td>
</tr>

<tr>
	<td width="5%"></td>
	<td width="10%">Email</td>
	<td width="20%"><BZ:dataValue field="EMAIL" type="String" defaultValue="" /></td>
	<td width="10%">����ְ��</td>
	<td width="20%">
		<BZ:dataValue field="POST"  defaultValue="" codeName="positionList" property="organPerson"/>
	</td>
	<td width="5%"></td>
</tr>

<tr>
	<td width="5%"></td>
	<td width="10%">�Ƿ��ص���ϵ��</td>
	<td width="20%">
		<BZ:dataValue field="IS_IMP_CONTACT" defaultValue="" property="personExt" checkValue="1=��;0=��"/>
	</td>
	<td width="10%">��Ա�������</td>
	<td width="20%">
		<BZ:select field="SECURITY_LEVEL" formTitle="" prefix="Person_" isCode="true" codeName="SECURITY_LEVEL_P"/>
	</td>
	<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">�ƶ��绰</td>
<td width="20%"><BZ:dataValue field="MOBILE"  type="String" defaultValue=""  /></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">��ע</td>
<td width="100%" colspan="4"><textarea disabled="disabled" readonly rows="6" style="width:100%" name="PersonExt_OTHER_INFO"><%=personExt.getString("OTHER_INFO")!=null?personExt.getString("OTHER_INFO"):"" %></textarea></td>
</tr>
</table>

<div class="heading" style="cursor: hand;" id="extentionDiv" onclick="_showExtention();">��չ��Ϣ(����鿴����)</div>
<table class="contenttable" id="extentionTable" style="display: none">
<tr>
<td width="5%"></td>
<td width="10%">�칫�ҷ����</td>
<td width="20%"><BZ:dataValue field="ROOM_NUM"  type="String" defaultValue="" /></td>
<td width="10%">ְ��</td>
<td width="20%">
	<BZ:dataValue field="POST_LEVEL" defaultValue="" codeName="positionLevelList" />
</td>
<td width="5%"></td>
</tr>
<tr>
	<td width="5%"></td>
	<td width="10%">������</td>
	<td width="85%" colspan="4">
		<BZ:dataValue field="RESP_DEPT_NAME" type="String" defaultValue="" />
	</td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">����(Ӣ��)</td>
<td width="20%"><BZ:dataValue field="ENNAME"  type="String" defaultValue="" /></td>
<td width="10%">����״��</td>
<td width="20%"><BZ:dataValue field="MARRY_CODE"  defaultValue=""  codeName="MARRY_CODE"/></td>
<td width="5%"></td>
</tr>

<tr>
	<td width="5%"></td>
	<td width="10%">����</td>
	<td width="85%" colspan="4">
		<BZ:dataValue field="NATIVE_PlACE" type="String" defaultValue="" />
	</td>
</tr>

<tr>
	<td width="5%"></td>
	<td width="10%">����</td>
	<td width="20%"><BZ:dataValue field="BIRTHDAY"  type="date"  defaultValue=""  /></td>
	<td width="10%">��Ա���</td>
	<td width="20%"><BZ:dataValue field="PERSON_CODE"   type="String" defaultValue=""  /></td>
	<td width="5%"></td>
</tr>

<tr>
	<td width="5%"></td>
	<td width="10%">֤������</td>
	<td width="20%">
		<BZ:dataValue field="CARD_CODE" defaultValue="" codeName="CARD_CODE" /></td>
	<td width="10%">֤������</td>
	<td width="20%"><BZ:dataValue field="CARD_NUM"   defaultValue=""  /></td>
	<td width="5%"></td>
</tr>

<tr>
	<td width="5%"></td>
	<td width="10%">����</td>
	<td width="20%">
		<BZ:dataValue field="NATION" defaultValue="" codeName="NATION"  />
	</td>
	<td width="10%">������ò</td>
	<td width="20%">
		<BZ:dataValue field="POLITIC_CODE" defaultValue="" codeName="POLITIC_CODE"  />
	</td>
	<td width="5%"></td>
</tr>

<tr>
	<td width="5%"></td>
	<td width="10%">���ѧ��</td>
	<td width="20%">
		<BZ:dataValue field="EDU_CODE"  defaultValue="" codeName="EDU_CODE" property="personExt"/>
	</td>
	<td width="10%">���ѧλ</td>
	<td width="20%">
		<BZ:dataValue field="DEGREE_CODE" defaultValue="" codeName="DEGREE_CODE" property="personExt"/>
	</td>
	<td width="5%"></td>
</tr>

<tr>
	<td width="5%"></td>
	<td width="10%">����ǩ��</td>
	<td width="20%" colspan="3"><BZ:dataValue  type="String"  defaultValue="" field="SIGNATURE" property="personExt"/></td>
	<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">��ͥ�绰</td>
<td width="20%"><BZ:dataValue field="HOME_TEL"  type="String" defaultValue="" property="personExt"/></td>
<td width="10%"></td>
<td width="20%"></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">�칫����</td>
<td width="20%"><BZ:dataValue field="OFFICE_FAX"  type="String" defaultValue=""  /></td>
<td width="10%">��ͥ����</td>
<td width="20%"><BZ:dataValue field="HOME_FAX"  type="String" defaultValue="" property="personExt"/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">MSN</td>
<td width="20%"><BZ:dataValue field="MSN"  type="String" defaultValue="" property="personExt"/></td>
<td width="10%">QQ</td>
<td width="20%"><BZ:dataValue field="QQ" type="String" defaultValue="" property="personExt"/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">����(����)</td>
<td width="20%"><BZ:dataValue field="COUNTRY"  defaultValue="" codeName="COUNTRY"  /></td>
<td width="10%">ʡ��(��)</td>
<td width="20%"><BZ:dataValue field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"  /></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">����</td>
<td width="20%"><BZ:dataValue field="CITY_ID"  defaultValue="" codeName="CITY"  /></td>
<td width="10%">��������</td>
<td width="20%"><BZ:dataValue field="ZIP"  defaultValue=""  defaultValue=""  /></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">������ҳ</td>
<td width="90%" colspan="4">
	<BZ:dataValue field="HOME_PAGE" defaultValue=""  type="String"  property="personExt"/></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">��ϵ��ַ</td>
<td width="90%" colspan="4">
	<BZ:dataValue field="CONNECT_ADDR"  defaultValue="" type="String" property="personExt" /></td>
</tr>

</table>

<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="����" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="����" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>