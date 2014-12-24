
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<% 
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
<BZ:script isList="true" />
<script src="<BZ:resourcePath/>/js/date/WdatePicker.js"></script>
  <script type="text/javascript">
  
	function _onload() {
		
	}
	
	function search() {
		document.srcForm.action=path+"audit/AuditSys!query.action";
		document.srcForm.submit(); 
	}
  
	function _delete() {
		var sfdj=0;
	  	var uuid="";
	  	for(var i=0;i<document.getElementsByName('xuanze').length;i++) {
		  if(document.getElementsByName('xuanze')[i].checked) {
			  uuid=uuid+"#"+document.getElementsByName('xuanze')[i].value;
			  sfdj++;
		  }
	 	}
		if(sfdj=="0") {
			alert('��ѡ��Ҫɾ��������');
		 	return;
		} else {
			if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')) {
				document.getElementById("deleteuuid").value=uuid;
				document.srcForm.action=path+"audit/AuditSys!delete.action";
				document.srcForm.submit();
			} else {
				return;
			}
		}
	}
	 
	function chakan() {
		var sfdj=0;
	  	var ID="";
	  	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	  		if(document.getElementsByName('xuanze')[i].checked){
	  			ID=document.getElementsByName('xuanze')[i].value;
	  			sfdj++;
	  		}
	 	}
	 	if(sfdj!="1") {
	  		alert('��ѡ��һ������');
	  		return;
	 	} else {
	 		document.srcForm.action=path+"audit/AuditSys!lookAuditSys.action?ID="+ID;
	 		document.srcForm.submit();
	 	}
	}
  </script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="audit/AuditSys.action">
<input type="hidden" name="deleteuuid" />
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<div class="kuangjia">
<div class="heading">��ѯ����</div>
<div  class="chaxun">
<table class="chaxuntj">
<tr>
	<td width="3%">��Ϊ�����ƣ�</td>
	<td width="20%"><input type="text" name="SYSTEM_ACTOR_NAME" value=""/></td>
	<td width="7%">����:</td>
	<td width="25%"><input type="text" name="ACT_ACTION"/></td>
	<td width="9%">�������:</td>
	<td width="25%"><input type="text" name="ACT_OBJ_TYPE"/></td>
	</tr>
	<tr>
	<td width="3%">��Ϊ����</td>
	<td width="20%"><select name="ACT_LEVEL">
	   <option value="" selected="selected">��ѡ��</option>
	   <option value="1">1</option>
	   <option value="2">2</option>
	   <option value="3">3</option>
	   <option value="4">4</option>
	   <option value="5">5</option>
	</select>
	</td>
	<td width="7%">���:</td>
	<td width="25%"><input type="text" name="ACT_RESULT"/></td>
	<td width="9%">��ע:</td>
	<td width="25%"><input type="text" name="ACT_MEMO"/></td>
	</tr>
	<tr>
	<td width="3%">ʱ�䣺</td>
	<td width="20%" colspan="5">��<input size="15" class="Wdate" id="ACT_START_TIME" name="ACT_START_TIME" readonly="readonly" value="" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'ACT_END_TIME\')||\'2020-10-01\'}'})"/>��<input size="15" class="Wdate" id="ACT_END_TIME"  name="ACT_END_TIME"  readonly="readonly" value="" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'ACT_START_TIME\')}',maxDate:'2020-10-01'})"/></td>
	</tr>
	<tr >
	<td align="center" valign="middle">
		<input type="button" value="��ѯ" class="button_search" onclick="search()"/>&nbsp;&nbsp;
		<input type="reset" value="����" class="button_reset"/>
	</td>
	</tr>
</table>
</div>
<div class="list">
<div class="heading">�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
	<BZ:th name="���" sortType="none" width="15%" sortplan="jsp"/>
	<BZ:th name="��Ϊ��IP" sortType="string" width="10%" sortplan="database" sortfield="ACTOR_IP"/>
	<BZ:th name="��Ϊ������" sortType="string" width="10%" sortplan="database" sortfield="ACTOR_NAME"/>
	<BZ:th name="��Ϊ����" sortType="none" width="10%" sortplan="database" sortfield="ACT_TYPE"/>
	<BZ:th name="������Ϊ" sortType="string" width="10%" sortplan="database" sortfield="ACT_ACTION"/>
	<BZ:th name="�����������" sortType="string" width="10%" sortplan="database" sortfield="ACT_OBJ_TYPE"/>
	<BZ:th name="��������" sortType="string" width="10%" sortplan="database" sortfield="ACT_OBJ"/>
	<BZ:th name="�������" sortType="string" width="10%" sortplan="database" sortfield="ACT_RESULT"/>
	<BZ:th name="��Ϊʱ��" sortType="string" width="10%" sortplan="database" sortfield="ACT_TIME"/>
	<BZ:th name="��Ϊ����" sortType="string" width="5%" sortplan="database" sortfield="ACT_LEVEL"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ACT_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
	<td><BZ:data field="ACTOR_IP" defaultValue=""/></td>
	<td><BZ:data field="ACTOR_NAME" defaultValue=""/></td>
	<td><BZ:data field="ACT_TYPE" defaultValue=""/></td>
	<td><BZ:data field="ACT_ACTION" defaultValue=""/></td>
	<td><BZ:data field="ACT_OBJ_TYPE" defaultValue=""/></td>
	<td><BZ:data field="ACT_OBJ" defaultValue=""/></td>
	<td><BZ:data field="ACT_RESUL" defaultValue=""/></td>
	<td><BZ:data field="ACT_TIME" defaultValue=""/></td>
	<td><BZ:data field="ACT_LEVEL" defaultValue=""/></td>
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
</BZ:form>
</BZ:body>
</BZ:html>