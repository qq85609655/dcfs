
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
<title>�б�</title>
<BZ:script isList="true"/>
<script type="text/javascript">
  
function _onload(){
  	var simpleGrid = new SimpleGrid("tableGrid", "srcForm");
}
function search() {
	document.srcForm.action = path + "TaglibPageServlet";
	pageshow(document.srcForm);
}
function add() {
	document.srcForm.action = path + "TaglibPageServlet?method=edit";
	document.srcForm.submit();
}
</script>
</BZ:head>
<BZ:body onload="_onload()" codeNames="SEX">
	<BZ:form name="srcForm" method="post" action="">
		<input type="hidden" name="deleteuuid" />
		<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
		<input type="hidden" name="compositor" value="" />
		<input type="hidden" name="ordertype" value="" />
		<!--  -->
		<div class="kuangjia">
		<div class="heading">��ѯ����</div>
		<div class="chaxun">
		<table class="chaxuntj">
			<tr>
				<td width="10%">������</td>
				<td width="20%"><BZ:input field="NAME" property="datatj"
					type="string" prefix="p_" /></td>
				<td width="10%">�Ա�</td>
				<td width="20%"><BZ:input field="SEX" property="datatj"
					type="string" prefix="p_" /></td>
				<td width="10%"></td>
				<td width="20%"></td>
				<td width="10%"><input type="button" value="��ѯ"
					class="button_search" onclick="search()" />&nbsp;&nbsp;<input
					type="reset" value="����" class="button_reset" /></td>
			</tr>
		</table>
		</div>
		<div class="list">
		<div class="heading">�б�</div>
		<BZ:table tableid="tableGrid" tableclass="tableGrid">
			<BZ:col colnumber="7" />
			<BZ:thead theadclass="titleBackGrey">
				<BZ:th name="���" sortType="none" width="5%" sortplan="jsp" />
				<BZ:th name="����" sortType="string" width="10%" sortplan="jsp" />
				<BZ:th name="�Ա�" sortType="string" width="10%" sortplan="jsp" />
				<BZ:th name="��������" sortType="string" width="10%" sortplan="jsp" />
				<BZ:th name="����" sortType="string" width="10%" sortplan="jsp" />
				<BZ:th name="ѧ��" sortType="string" width="20%" sortplan="jsp" />
				<BZ:th name="����" sortType="string" width="35%" sortplan="jsp" />
			</BZ:thead>
			<BZ:tbody>
				<BZ:for property="LIST">
					<tr>
						<td><BZ:i>
							<input type="checkbox" name="xuanze"
								value="<BZ:data field="UUID" onlyValue="true"/>" />
						</BZ:i></td>
						<td><BZ:a field="NAME" target="_self">javascript:document.location='<BZ:url/>/TaglibPageServlet?method=edit&UUID=<BZ:data field="UUID" onlyValue="true"/>'</BZ:a></td>
						<td><BZ:data field="SEX" codeName="SEX" /></td>
						<td><BZ:data field="BIRTHDAY" defaultValue="" type="DateTime"/></td>
						<td><BZ:data field="AGE" defaultValue="" /></td>
						<td><BZ:data field="SCHOOLRECORD" defaultValue="" /></td>
						<td><BZ:data field="RESUME" defaultValue="" /></td>
					</tr>
				</BZ:for>
			</BZ:tbody>
		</BZ:table>
		<table border="0" cellpadding="0" cellspacing="0" class="operation">
			<tr>
				<td colspan="2"><BZ:page form="srcForm" property="LIST" /></td>
			</tr>
			<tr>
				<td style="padding-left: 15px"></td>
				<td align="right" style="padding-right: 30px; height: 35px;"><input
					type="button" value="���" class="button_add" onclick="add()" />&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>