
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
  <script type="text/javascript">
	function _onload() {
		
	}
  
	function search() {
		document.srcForm.action=path+"log/Log!query.action";
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
				document.srcForm.action=path+"log/Log!delete.action";
				document.srcForm.submit();
			} else {
			 	return;
			}
		}
	}
	
	function chakan() {
		var sfdj=0;
 		var ID="";
 		for(var i=0;i<document.getElementsByName('xuanze').length;i++) {
 			if(document.getElementsByName('xuanze')[i].checked) {
	 			ID=document.getElementsByName('xuanze')[i].value;
	 			sfdj++;
 		  	}
		}
	 	if(sfdj!="1") {
	  		alert('��ѡ��һ������');
	  		return;
	 	} else {
	 		document.srcForm.action=path+"log/Log!lookLog.action?ID="+ID;
	 		document.srcForm.submit();
	 	}
	}
  </script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="log/Log.action">
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
<td width="10%">��־д���ߣ�</td>
<td width="50%"><input type="text" name="LOGFIND_LOG_WRITOR" value=""/></td>
<td width="10%"></td>
<td width="20%"></td>
<td width="10%"><input type="button" value="��ѯ" class="button_search" onclick="search()"/>&nbsp;&nbsp;<input type="reset" value="����" class="button_reset"/></td>
</tr>
</table>
</div>
<div class="list">
<div class="heading">�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
	<BZ:th name="���" sortType="none" width="15%" sortplan="jsp"/>
	<BZ:th name="��־ʱ��" sortType="string" width="25%" sortplan="jsp"/>
	<BZ:th name="��־д����" sortType="string" width="25%" sortplan="jsp"/>
	<BZ:th name="��־����" sortType="none" width="25%" sortplan="jsp"/>
	<BZ:th name="��־����" sortType="string" width="25%" sortplan="jsp"/>   
	<BZ:th name="��־��Դ" sortType="string" width="25%" sortplan="jsp"/>
	<BZ:th name="��־��Ϣ��" sortType="none" width="25%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="LOG_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
	<td><BZ:data field="LOG_TIME" defaultValue=""/></td>
	<td><BZ:data field="LOG_WRITOR" defaultValue=""/></td>
	<td><BZ:data field="LOG_TYPE" defaultValue=""/></td>
	<td><BZ:data field="LOG_LEVEL" defaultValue=""/></td>
	<td><BZ:data field="LOG_SOURCE" defaultValue=""/></td>
	<td><BZ:data field="LOG_MESSAGE" defaultValue=""/></td>
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
	<input type="button" value="�鿴" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;
	<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>