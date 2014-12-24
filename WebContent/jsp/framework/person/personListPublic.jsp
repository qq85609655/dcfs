<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.person.vo.Person"%>
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@page import="com.hx.framework.common.FrameworkConfig"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);

	String compositor=(String)request.getParameter("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getParameter("ordertype");
	if(ordertype==null){
		ordertype="";
	}
%>
<BZ:html>
<BZ:head>
<title>�б�</title>
<BZ:script isList="true"/>
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function _onload(){

	}
	function search(){


		document.srcForm.action=path+"person/Person!query.action?public=true";
		document.srcForm.submit();
	}
	function exportExcel(){
		if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
			document.srcForm.action=path+"person/exportExcelPublic.action";
			document.srcForm.submit();
		}
		else{
			return;
		}
	}
	//ѡ����֯����
	function selectOrgan(){
		var reValue = window.showModalDialog(path+"organ/Organ!generateTree.action?treeDispatcher=selectOrganTree", this, "dialogWidth=400px;dialogHeight=600px;scroll=auto");
		document.all("S_ORG_ID").value = reValue["value"];
		document.all("A_ORGAN_NAME").value = reValue["name"];
	}
	</script>
</BZ:head>
<BZ:body onload="_onload()" codeNames="SEX" >
<BZ:form name="srcForm" method="post" action="person/Person!query.action?public=true">
<BZ:frameDiv property="clueTo" className="kuangjia">
<input id="Person_IDS" name="IDS" type="hidden"/>
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- ��ǰ��Ա�б���������֯����ID -->
<input type="hidden" id="ORG_ID" name="ORG_ID" value="<%=request.getParameter("S_ORG_ID")==null?"":request.getParameter("S_ORG_ID") %>" >


	<div class="heading">��ѯ����</div>
	<div  class="chaxun">
		<table class="chaxuntj">
			<tr>
				<td width="10%" align="right" nowrap="nowrap" >���ţ�</td>
				<td width="20%" align="left">
					<BZ:input type="hidden" prefix="S_" field="ORG_ID" defaultValue="" property="data"/>
					<BZ:input type="String" prefix="A_" field="ORGAN_NAME" defaultValue="" readonly="true" onclick="selectOrgan();" property="data"/>
				</td>
				<td width="10%" align="right" nowrap="nowrap">��Ա���ƣ�</td>
				<td width="20%" align="left"><BZ:input field="CNAME" type="String" property="data" prefix="S_" defaultValue="" /></td>
				<td width="10%"></td>
				</tr>

			<tr>
				<td width="10%" align="right" nowrap="nowrap" >�칫����ţ�</td>
				<td width="20%" align="left"><BZ:input field="ROOM_NUM" type="String"  property="data" prefix="S_" defaultValue="" />
				</td>
				<td width="10%" align="right" nowrap="nowrap">�칫�绰��</td>
				<td width="20%" align="left"><BZ:input field="OFFICE_TEL" type="String"  property="data" prefix="S_" defaultValue="" />
				</td>
				<td width="10%" align="right" nowrap="nowrap" >�ƶ��绰��</td>
				<td width="20%" align="left"><BZ:input field="MOBILE" type="String"  property="data" prefix="S_" defaultValue="" />
				</td>
				<td width="10%"><input type="button" value="��ѯ" class="button_search" onclick="search()"/>&nbsp;&nbsp;
				<input type="button" value="����" class="button_add" style="width: 80px" onclick="exportExcel()"/>

				</td>
			</tr>

		</table>
	</div>
<div class="list">
<div class="heading">��Ա�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid" >
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" sortType="none" width="5%" sortplan="jsp"/>
<BZ:th name="����" sortType="string" width="15%" sortplan="database" sortfield="CNAME"/>
<BZ:th name="����" sortType="string" width="15%" sortplan="database" sortfield="ORGAN_NAME"/>
<BZ:th name="�칫�����" sortType="string" width="15%" sortplan="database"sortfield="ROOM_NUM"/>
<BZ:th name="�칫�绰" sortType="string" width="15%" sortplan="database" sortfield="OFFICE_TEL"/>
<BZ:th name="�ƶ��绰" sortType="String" width="20%" sortplan="database" sortfield="MOBILE"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="onedata">
<tr>
<td tdvalue="<BZ:data field="Person_ID" onlyValue="true"/>&<BZ:data field="ORG_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" onlyValue="true"/></td>
<td><BZ:data field="ORGAN_NAME" defaultValue=""/></td>
<td><BZ:data field="ROOM_NUM" defaultValue="" /></td>
<td><BZ:data field="OFFICE_TEL" defaultValue="" /></td>
<td><BZ:data field="MOBILE" defaultValue="" /></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>

<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="2"><BZ:page form="srcForm" property="dataList"/></td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>