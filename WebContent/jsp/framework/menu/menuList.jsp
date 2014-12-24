<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ page import="hx.util.InfoClueTo" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String NAV_ID=(String)request.getAttribute("NAV_ID");
if(NAV_ID==null){
	NAV_ID="";
}
String parent_id=(String)request.getParameter("PARENT_ID");
if(parent_id==null){
	parent_id="0";
}
String PNAME=(String)request.getAttribute("PNAME");
if(PNAME==null){
	PNAME="";
}
String compositor=(String)request.getParameter("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getParameter("ordertype");
if(ordertype==null){
	ordertype="";
}
InfoClueTo clueTo = (InfoClueTo)request.getAttribute("clueTo");
int type = -1;
if(clueTo!=null)
{
	type = clueTo.getInfotype();
}
%>
<BZ:html>
<BZ:head>
<title>�˵��б�</title>
<BZ:script isList="true"  />
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function _onload(){

		var type = <%=type%>;
		if(type==0)
		{
			parent.leftFrame.location ="<%=request.getContextPath() %>/menu/menuTree.action?NAV_ID=<%=NAV_ID %>&PARENT_ID=<%=parent_id %>";
		}
	}
	function search(){
	document.srcForm.action=path+"CodeSortServlet";
	document.srcForm.submit();
	}

	function add(){
	document.srcForm.action=path+"menu/menuToAdd.action";
	document.srcForm.submit();
	}
	function _update(){
	var sfdj=0;
	var ID="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	if(document.getElementsByName('xuanze')[i].checked){
	ID=document.getElementsByName('xuanze')[i].value;
	sfdj++;
	}
	}
	if(sfdj!="1"){
	alert('��ѡ��һ������');
	return;
	}else{
	document.srcForm.action=path+"menu/menuDetailed.action?ID="+ID+"&jsp=modify";
	document.srcForm.submit();
	}
	}

	function chakan(){
	var sfdj=0;
	var ID="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	if(document.getElementsByName('xuanze')[i].checked){
	ID=document.getElementsByName('xuanze')[i].value;
	sfdj++;
	}
	}
	if(sfdj!="1"){
	alert('��ѡ��һ������');
	return;
	}else{
	document.srcForm.action=path+"menu/menuDetailed.action?ID="+ID+"&jsp=look";
	document.srcForm.submit();
	}
	}
	function _delete(){
	var sfdj=0;
	var uuid="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	if(document.getElementsByName('xuanze')[i].checked){
	uuid=uuid+"#"+document.getElementsByName('xuanze')[i].value;
	sfdj++;
	}
	}
	if(sfdj=="0"){
	alert('��ѡ��Ҫɾ��������');
	return;
	}else{
	if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')){
	document.getElementById("deleteid").value=uuid;
	document.srcForm.action=path+"menu/menuDelete.action";
	document.srcForm.submit();
	}else{
	return;
	}
	}
	}

	function _bakNavigation(){
	document.location.href=path+"navigation/navigationList.action";
	//document.srcForm.submit();
	}
	function _back(){
	parent.location.href=path+"navigation/navigationList.action";
	}
	</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="menu/menuList.action">
<input type="hidden" name="P_NAV_ID" value="<%=NAV_ID%>"/>
<input type="hidden" name="NAV_ID" value="<%=NAV_ID%>"/>
<input type="hidden" name="PARENT_ID" value="<%=parent_id%>"/>
<input type="hidden" name="PNAME" value="<%=PNAME%>"/>
<input type="hidden" name="deleteid" />
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" id="compositor" name="compositor" value="<%=compositor%>"/>
<input type="hidden" id="ordertype" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="list">
<div class="heading">�˵��б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" sortType="none" width="10%" sortplan="jsp" />
<BZ:th name="�˵�����" sortType="string" width="15%" sortplan="database" sortfield="MENU_NAME"/>
<BZ:th name="�˵�����" sortType="string" width="10%" sortplan="database" sortfield="MENU_TYPE"/>
<BZ:th name="���˵�" sortType="string" width="10%" sortplan="database" sortfield="PNAME"/>
<BZ:th name="�˵�URL" sortType="string" width="13%" sortplan="database" sortfield="MENU_URL"/>
<BZ:th name="�����" sortType="int" width="10%" sortplan="database" sortfield="SEQ_NUM"/>
<BZ:th name="�Ƿ�ģ�����" sortType="string" width="12%" sortplan="database" sortfield="IS_MODULE_ENTRY"/>
<BZ:th name="״̬" sortType="string" width="7%" sortplan="database" sortfield="STATUS"/>
<BZ:th name="����ʱ��" sortType="string" width="13%" sortplan="database" sortfield="CREATE_TIME"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="fordata">
<tr>
<td tdvalue="<BZ:data field="MENU_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="MENU_NAME" defaultValue=""/></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("MENU_TYPE",""))){%>��Դ�˵�<%}else{ %>�ⲿURL<%} %></td>
<td><BZ:data field="PNAME" defaultValue=""/></td>
<td><BZ:data field="MENU_URL" defaultValue=""/></td>
<td><BZ:data field="SEQ_NUM" defaultValue=""/></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("IS_MODULE_ENTRY",""))){%>��<%}else{ %>��<%} %></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("STATUS",""))){%>����<%}else{ %>����<%} %></td>
<td><BZ:data field="CREATE_TIME" defaultValue="" type="Date"/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="2"><BZ:page form="srcForm" property="dataList"/></td>
</tr>
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;">
	<input type="button" value="���" class="button_add" onclick="add()"/>&nbsp;&nbsp;
	<input type="button" value="�鿴" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;
	<input type="button" value="�޸�" class="button_update" onclick="_update()"/>&nbsp;&nbsp;
	<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
	<input type="button" value="����" class="button_back" onclick="_back()"/>
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>