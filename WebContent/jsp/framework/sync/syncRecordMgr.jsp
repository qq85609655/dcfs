
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
DataList sysList=(DataList)request.getAttribute("sysList");
Data data=(Data)request.getAttribute("data");
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
<title>ͬ����¼����</title>
<BZ:script isList="true"  />
	<script type="text/javascript">

	var idnames=new Array();
	<%
		DataList list=(DataList)request.getAttribute("dataList");
		if(list!=null){

			for(int i=0;i<list.size();i++){
				String id=list.getData(i).getString("ID");
				String name=list.getData(i).getString("CNAME");
		%>
			idnames["<%=id%>"]="<%=name%>";
		<%
			}
		}
	%>
	function _onload(){

	}
	function search(){
		document.srcForm.action=path+"sync/SyncRecord.action";
		document.srcForm.submit();
	}
	function _manualSync(){
	 var sfdj=0;
	 var uuid="";
	 var names="";
	 for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		 if(document.getElementsByName('xuanze')[i].checked){
			 uuid=uuid+"#"+document.getElementsByName('xuanze')[i].value;
			 sfdj++;
		 }
	}
	if(sfdj=="0"){
	 alert('��ѡ��Ҫͬ��������');
	 return;
	}else{
	if(confirm('ȷ��Ҫͬ��ѡ����Ϣ��?')){
		document.getElementById("deleteid").value=uuid;
		document.srcForm.action=path+"sync/syncRecordManual.action";
		document.srcForm.submit();
	}else{
	return;
	}
	}
	}
	function _delete(){
	var sfdj=0;
	 var uuid="";
	 var names="";
	 for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		 if(document.getElementsByName('xuanze')[i].checked){
			 uuid=uuid+"#"+document.getElementsByName('xuanze')[i].value;
			 names=names+idnames[document.getElementsByName('xuanze')[i].value]+"#";
			 sfdj++;
		 }
	}
	if(sfdj=="0"){
	 alert('��ѡ��Ҫɾ��������');
	 return;
	}else{
	if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')){
		document.getElementById("deleteid").value=uuid;
		document.getElementById("CNAMES").value=names;
		document.srcForm.action=path+"sync/syncRecordDelete.action";
		document.srcForm.submit();
	}else{
	return;
	}
	}
	}
	function _onceSync(){
		if(confirm('ȷ��Ҫִ��һ��ͬ����?')){
		 document.srcForm.action=path+"sync/syncRecordOnce.action";
	document.srcForm.submit();
	}
	}
	</script>
</BZ:head>
<BZ:body onload="_onload()" property="data">
<BZ:form name="srcForm" method="post" action="sync/SyncRecord.action">
<input type="hidden" name="deleteid" />
<input type="hidden" name="CNAMES" />
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>

<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="heading">ͬ����¼����</div>
<div  class="chaxun">
<table class="chaxuntj">
<tr>
<td width="5%"></td>
<td width="15%">�������ƣ�</td>
<td width="20%"><BZ:input field="DATA_NAME" type="String" prefix="C_" defaultValue=""/></td>
<td width="5%"></td>
<td width="15%">�¼����ͣ�</td>
<td width="20%"><BZ:select field="EVENT_TYPE" formTitle="" prefix="C_">
					<BZ:option value="" selected="true">--��ѡ�� --</BZ:option>
					<BZ:option value="addUser">����û�</BZ:option>
					<BZ:option value="updateUser" >�����û�</BZ:option>
					<BZ:option value="deleteUser" >ɾ���û�</BZ:option>
					<BZ:option value="addOrg" >�����֯����</BZ:option>
					<BZ:option value="updateOrg" >������֯����</BZ:option>
					<BZ:option value="deleteOrg" >ɾ����֯����</BZ:option>
					<BZ:option value="modifyPwd" >�޸��û�����</BZ:option>
				</BZ:select></td>
<td></td>
</tr>
<tr>
<td width="5%"></td>
<td width="15%">ͬ��״̬��</td>
<td width="20%"><BZ:select field="STATUS" formTitle="" prefix="C_">
					<BZ:option value="" selected="true">--��ѡ�� --</BZ:option>
					<BZ:option value="0">�ɹ�</BZ:option>
					<BZ:option value="1">ʧ��</BZ:option>
				</BZ:select></td>
<td width="5%"></td>
<td width="15%">ͬ����ʽ��</td>
<td width="20%"><BZ:select field="SYNC_TYPE" formTitle="" prefix="C_">
					<BZ:option value="" selected="true">--��ѡ�� --</BZ:option>
					<BZ:option value="auto">�Զ�</BZ:option>
					<BZ:option value="manual">�ֶ�</BZ:option>
				</BZ:select></td>
<td></td>
</tr>
<tr>
<td width="5%"></td>
<td width="15%">Ŀ��ϵͳ��</td>
<td width="20%">
			<%
				for(int i = 0;i<sysList.size();i++){
					Data targetSys = sysList.getData(i);
					String targetId = targetSys.getString("TARGET_ID");
					String targetName = targetSys.getString("TARGET_NAME");
					%>
					<input type="checkbox" value="<%=targetId %>" name="C_TARGET_ID"
					<%//��ѯ�������䣺
						String targetIdC = data.getString("TARGET_ID");
						if(targetIdC!=null && targetIdC.indexOf(targetId)!=-1){
							%>checked<%
						}
					%>
					><%=targetName %>&nbsp;
					<%
				}
			%>
</td>
<td width="5%"></td>
<td width="15%"></td>
<td width="20%"></td>
<td><input type="button" value="��ѯ" class="button_search" onclick="search()"/>&nbsp;&nbsp;<input type="reset" value="����" class="button_reset"/></td>
</tr>
</table>
</div>
<div class="list">
<div class="heading">ͬ����¼�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" sortType="none" width="5%" sortplan="jsp"/>
<BZ:th name="��������" sortType="string" width="15%" sortplan="jsp"/>
<BZ:th name="�¼�����" sortType="string" width="12%" sortplan="jsp"/>
<BZ:th name="Ŀ��ϵͳ" sortType="string" width="18%" sortplan="jsp"/>
<BZ:th name="ͬ����ʽ" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="ͬ������" sortType="int" width="10%" sortplan="jsp"/>
<BZ:th name="���ͬ��ʱ��" sortType="string" width="20%" sortplan="jsp"/>
<BZ:th name="ͬ��״̬" sortType="string" width="10%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="fordata">
<tr>
<td tdvalue="<BZ:data field="STATE_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="DATA_NAME" defaultValue=""/></td>
<td><BZ:data field="EVENT_TYPE" defaultValue="" checkValue="addUser=����û�;updateUser=�����û�;deleteUser=ɾ���û�;addOrg=�����֯����;updateOrg=������֯����;deleteOrg=ɾ����֯����;modifyPwd=�޸��û�����"/></td>
<td><BZ:data field="TARGET_NAME" defaultValue=""/></td>
<td><BZ:data field="SYNC_TYPE" defaultValue="" checkValue="auto=�Զ�;manual=�ֶ�"/></td>
<td><BZ:data field="SYNC_TIMES" defaultValue=""/></td>
<td><BZ:data field="LAST_SYNC_TIME" defaultValue=""/></td>
<td><BZ:data field="STATUS" defaultValue="" checkValue="0=�ɹ�;1=ʧ��"/></td>
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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="һ��ͬ��" class="button_send" onclick="_onceSync()"/>&nbsp;&nbsp;<input type="button" value="�ֶ�ͬ��" class="button_send" onclick="_manualSync()"/>&nbsp;&nbsp;<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>