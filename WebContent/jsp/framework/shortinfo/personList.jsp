<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String compositor=(String)request.getAttribute("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getAttribute("ordertype");
if(ordertype==null){
	ordertype="";
}

//���Ȩ�ޱ�ʶ
String checkAudit = (String)request.getAttribute("CHECK_AUDIT");
//��������
Data sdata = (Data)request.getAttribute("data");
if(sdata == null){
	sdata = new Data();
}
%>
<BZ:html>
<BZ:head>
<title>�б�</title>
<BZ:script isList="true"/>
  <script type="text/javascript">
  
  function _onload(){
  
  }
  function search(){
	  document.srcForm.page.value=1;
	  document.srcForm.action=path+"usergroup/personList.action";
	  document.srcForm.submit();
  }
  
  function allotAudit(){
  var sfdj=0;
   var uuid="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
   sfdj++;
   }
  }
  if(sfdj=="0"){
   alert('��ѡ��Ҫ��Ȩ����');
   return;
  }else{
  if(confirm('ȷ��Ҫ��Ȩ��?')){
	//���ý�ɫ��
	parent.left1Frame._ok();
	document.getElementById("ROLES_IDS").value = parent.left1Frame.document.getElementById("ROLE_IDS").value;
	document.getElementById("PERSONS_IDS").value = uuid;
	document.srcForm.action = "<%=request.getContextPath() %>/role/Authorize!personAuthorize.action";
  	document.srcForm.submit();
  }else{
  return;
  }
  }
  }
	
	//�鿴��֯������Ӧ�Ľ�ɫȨ��
	function queryAudit(){
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
			  var flag = window.showModalDialog("<%=request.getContextPath() %>/role/Authorize!perFrame.action?PERSON_IDS="+ID, this, "dialogWidth=600px;dialogHeight=350px;scroll=auto");
			  if(flag == "true"){
			  	document.srcForm.submit();
			  }
		  }
		  }
		  
	//��ѯ����û�з����ɫ���û�
	function checkAudit(){
		document.srcForm.action = "<%=request.getContextPath() %>/person/Person!queryNoRolesPersons.action";
		document.getElementById("CHECK_AUDIT").value = "CHECK_AUDIT";
		document.srcForm.submit();
	}
	
	//ѡ����֯����
	function selectOrgan(){
		var reValue = window.showModalDialog(path+"usergroup/generateTree.action?treeDispatcher=selectOrganTree", this, "dialogWidth=300px;dialogHeight=300px;scroll=auto");
		//alert(reValue["value"] + ":" + reValue["name"]);
		document.getElementById("ORGAN_ID_").value = reValue["value"];
		document.getElementById("ORGAN_NAME_").value = reValue["name"];
		if(reValue["value"] == ""){
			document.getElementById("ORG_ID").value = "BSC,GZJ";
		}
	}
	
	function writerChannels(){
	   var sfdj=0;
	   var uuid="";
	   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	   if(document.getElementsByName('xuanze')[i].checked){
	   uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
	   sfdj++;
	   }
	  }
	  if(sfdj=="0"){
	   alert('��ѡ��Ҫ��Ȩ����');
	   return;
	  }else{
	  if(confirm('ȷ��Ҫ��Ȩ��?')){
		//���ý�ɫ��
		parent.left1Frame._ok();
		document.getElementById("CHANNEL_IDS").value = parent.left1Frame.document.getElementById("CHANNEL_IDS").value;
		document.getElementById("PERSONS_IDS").value = uuid;
		document.srcForm.action = "<%=request.getContextPath() %>/cms_auth/Auth!writerChannels.action";
	  	document.srcForm.submit();
	  }else{
	  return;
	  }
	  }
	}
	
	function auditChannels(){
		var sfdj=0;
	   var uuid="";
	   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	   if(document.getElementsByName('xuanze')[i].checked){
	   uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
	   sfdj++;
	   }
	  }
	  if(sfdj=="0"){
	   alert('��ѡ��Ҫ��Ȩ����');
	   return;
	  }else{
	  if(confirm('ȷ��Ҫ��Ȩ��?')){
		//���ý�ɫ��
		parent.left1Frame._ok();
		document.getElementById("CHANNEL_IDS").value = parent.left1Frame.document.getElementById("CHANNEL_IDS").value;
		document.getElementById("PERSONS_IDS").value = uuid;
		document.srcForm.action = "<%=request.getContextPath() %>/cms_auth/Auth!auditChannels.action";
	  	document.srcForm.submit();
	  }else{
	  return;
	  }
	  }
	}
	
	
	function checkedPerson(){
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				var che = document.getElementsByName('xuanze')[i];
				var id = che.value;
				
				var pname = che.getAttribute("pname");
				var dname = che.getAttribute("dname");
				var tel = che.getAttribute("tel");
				
				var value = pname+"["+dname+"]"+"("+tel+")";
				//���option
				var select = parent.document.getElementById("d2");
				var option=document.createElement("OPTION");
			   	option.value=id;
			   	option.text=value;
			   	select.add(option);
			}
		}
		//alert(select.innerHTML);
	}
	
	var xx = "xuanze";
  </script>
</BZ:head>
<BZ:body onload="_onload()" property="sdata">
<BZ:form name="srcForm" method="post" isContextPath="true" action="usergroup/personList.action">

<!-- ��������ʼ -->

<!-- ��Ŀ�� -->
<input name="CHANNEL_IDS" id="CHANNEL_IDS" type="hidden"/>

<!-- ��Ȩ��Ա -->
<input name="PERSONS_IDS" id="PERSONS_IDS" type="hidden"/>

<!-- ��ǰ��Ա�б���������֯����ID -->
<%-- <input id="ORG_ID" name="ORG_ID" value="<%=request.getParameter(OrganPerson.ORG_ID) %>" type="hidden"> --%>

<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>

<!-- ���������� -->

<div class="kuangjia">
<!-- ��ѯ���� -->
<div class="heading">��ѯ����</div>
<div class="chaxun">
	<table class="chaxuntj">
		<tr>
			<td width="10%" align="right" nowrap="nowrap">���ţ�</td>
			<td width="20%" align="left">
				<%-- <input type="hidden" id="ORGAN_ID_" name="S_ORGAN_ID_" value='<%=sdata.getString("ORGAN_ID_")!=null?sdata.getString("ORGAN_ID_"):"" %>'/>
				<input type="text" id="ORGAN_NAME_" name="S_ORGAN_NAME_" value='<%=sdata.getString("ORGAN_NAME_")!=null?sdata.getString("ORGAN_NAME_"):"" %>' readonly="readonly" onclick="selectOrgan();"/> --%>
				<BZ:input type="helper" prefix="S_" field="ORGAN_ID_" helperCode="SYS_ALL_ORG" helperTitle="��֯��" treeType="0" className="inputOne" defaultShowValue="" />
			</td>
			<td width="10%" align="right" nowrap="nowrap">��Ա������</td>
			<td width="20%" align="left">
				<%-- <input name="S_PERSON_NAME_" type="text" value='<%=sdata.getString("PERSON_NAME_")!=null?sdata.getString("PERSON_NAME_"):"" %>'/> --%>
				<BZ:input prefix="S_" field="PERSON_NAME_" defaultValue="" className="inputOne"/>
			</td>
			<td width="40%">
				<input type="button" value="��ѯ" class="button_search" onclick="search()"/>
			</td>
		</tr>
	</table>
</div>

<div class="list">
<div class="heading">ѡ����Ա</div>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="height:35px;">
<img alt="���ѡ���û�" src="<BZ:resourcePath/>/main/images/send_user.png" style="cursor: pointer;" onclick="checkedPerson();">
</td>
</tr>
</table>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="<input type='checkbox'  name='quanxuan' id='quanxuan' onclick='_selectAll(this,xx);'/>" width="7%" sortType="none"/>
<BZ:th name="���" sortType="string" width="8%" sortplan="jsp"/>
<BZ:th name="����" sortType="string" width="30%" sortplan="database" sortfield="CNAME"/>
<BZ:th name="����" sortType="string" width="30%" sortplan="database" sortfield="ORG_NAME"/>
<BZ:th name="�绰" sortType="string" width="25%" sortplan="database" sortfield="MOBILE"/>
</BZ:thead>
<!-- 
<BZ:th name="ְ��" sortType="string" width="20%" sortplan="database" sortfield="POST_NAME"/>
 -->
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td noselect="true"><input pname='<BZ:data field="CNAME" defaultValue="" onlyValue="true"/>' dname='<BZ:data field="ORG_NAME" defaultValue="" onlyValue="true"/>' tel='<BZ:data field="MOBILE" defaultValue="" onlyValue="true"/>' name="xuanze" type="checkbox" value="<BZ:data field="PERSON_ID" onlyValue="true"/>"></td>
<td><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" defaultValue="" onlyValue="true"/></td>
<td><BZ:data field="ORG_NAME" defaultValue="" onlyValue="true"/></td>
<td><BZ:data field="MOBILE" defaultValue="" onlyValue="true"/></td>
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
</div>
<br>
</BZ:form>
</BZ:body>
</BZ:html>