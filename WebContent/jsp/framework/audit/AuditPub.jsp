
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*,java.util.*" %>
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
	Map<String,String> map = (Map<String,String>)request.getAttribute("map");
%>
<BZ:html>
<BZ:head>
<title>�б�</title>
<BZ:script isList="true" isDate="true"/>
	<script type="text/javascript">
	$(document).ready(function(){
		dyniframesize(['mainFrame']);
	});
	function _onload() {

		var st = document.getElementById("ACT_LEVEL");
		var v = document.getElementById("level").value;
		for(var i=0;i<st.length;i++){
			if(st.options[i].value==v){
				st.options[i].selected=true;
			}
		}
		var st1 = document.getElementById("ACT_TBL_NAME");
		var v = document.getElementById("tbl_name").value;
		for(var i=0;i<st1.length;i++){
			if(st1.options[i].value==v){
				st1.options[i].selected=true;
			}
		}
		}

		function search() {
			document.srcForm.action=path+"audit/AuditPub!query.action";
			document.srcForm.submit();
		}

		function _export()
		{
			if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
				document.srcForm.action=path+"audit/exportAuditPubExcel.action";
				document.srcForm.submit();
				document.srcForm.action=path+"audit/AuditPub!query.action";
			}
		}
		function _delete(){
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
				document.srcForm.action=path+"audit/AuditPub!delete.action";
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
			document.srcForm.action=path+"audit/AuditPub!lookAuditPub.action?ID="+ID;
			document.srcForm.submit();
		}
	}
	</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="audit/AuditPub.action">
<input type="hidden" name="deleteuuid" />
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<input type="hidden" id="level" name="level" value="<%=map.get("act_level")%>"/>
<input type="hidden" id="tbl_name" name="tbl_name" value="<%=map.get("tbl_name")%>"/>
<!--  -->
<div class="kuangjia">
<div class="heading">��ѯ����</div>
<div  class="chaxun">
<table class="chaxuntj">
	<tr>
		<td width="10%" nowrap="nowrap">��Ϊ�����ƣ�</td>
		<td width="20%"><input type="text" name="ACT_NAME" value="<%=map.get("actor_name") %>"></td>
		<td width="10%" nowrap="nowrap">������Ϊ��</td>
		<td width="20%"><input  type="text"  name="ACT_ACTION" value="<%=map.get("act_action") %>"/></td>
		<td width="15%" nowrap="nowrap">����������ࣺ</td>
		<td width="20%"><input type="text"  name="ACT_OBJ_TYPE" value="<%=map.get("act_obj_type") %>"/></td>
	</tr>
	<tr>
	<td >����</td>
	<td><select name="ACT_LEVEL" id="ACT_LEVEL">
		<option value="">��ѡ��</option>
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5">5</option>
	</select>
	</td>
	<td >���������</td>
	<td ><input type="text"  name="ACT_RESULT" value="<%=map.get("act_result")%>"/></td>
	<td >��ע��</td>
	<td ><input type="text"  name="ACT_MEMO" value="<%=map.get("memo")%>"/></td>
	</tr>
	<tr>
	<td>��Ϊʱ�䣺</td>
	<td colspan="3">��<input size="15" class="Wdate" id="ACT_START_TIME" name="ACT_START_TIME" readonly="readonly"  onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'ACT_END_TIME\')||\'2020-10-01\'}'})" value="<%=map.get("start_act_time") %>"/>��<input size="15" class="Wdate" id="ACT_END_TIME"  name="ACT_END_TIME"  readonly="readonly" value="<%=map.get("end_act_time") %>"  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'ACT_START_TIME\')}',maxDate:'2020-10-01'})"/></td>
	<td>���ݷ�Χ:</td>
	<td><select name="ACT_TBL_NAME" id="ACT_TBL_NAME">
		<option value="PUB_AUDIT">��ǰ����</option>
		<option value="PUB_AUDIT_ARCHIVE">�鵵����</option>
	</select>
	</td>
	<td align="center" valign="middle">
		<input type="button" value="��ѯ" class="button_search" onclick="search()"/>&nbsp;&nbsp;
		<input type="button" value="����" class="button_goto" onclick="_export()"/>&nbsp;&nbsp;
		<input type="reset" value="����" class="button_reset"/>
	</td>
	</tr>
</table>
</div>
<div class="list">
<div class="heading">�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
	<BZ:th name="���" sortType="none" width="8%" sortplan="ACT_ID"/>
	<BZ:th name="��Ϊ��IP" sortType="string" width="10%" sortplan="database" sortfield="ACTOR_IP"/>
	<BZ:th name="��Ϊ������" sortType="string" width="10%" sortplan="database" sortfield="ACTOR_NAME"/>
	<BZ:th name="������Ϊ" sortType="string" width="5%" sortplan="database" sortfield="ACT_ACTION"/>
	<BZ:th name="�����������" sortType="string" width="10%" sortplan="database" sortfield="ACT_OBJ_TYPE"/>
	<BZ:th name="��������" sortType="string" width="10%" sortplan="database" sortfield="ACT_OBJ"/>
	<BZ:th name="�������" sortType="string" width="10%" sortplan="database" sortfield="ACT_RESULT"/>
	<BZ:th name="��Ϊʱ��" sortType="string" width="10%" sortplan="database" sortfield="ACT_TIME"/>
	<BZ:th name="����" sortType="string" width="5%"  sortplan="database" sortfield="ACT_LEVEL"/>
	<BZ:th name="��ע" sortType="string" width="12%" sortplan="database" sortfield="MEMO"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ACT_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
	<td><BZ:data field="ACTOR_IP" defaultValue=""/></td>
	<td><BZ:data field="ACTOR_NAME" defaultValue=""/></td>
	<td><BZ:data field="ACT_ACTION" defaultValue=""/></td>
	<td><BZ:data field="ACT_OBJ_TYPE" defaultValue=""/></td>
	<td><BZ:data field="ACT_OBJ" defaultValue=""/></td>
	<td><BZ:data field="ACT_RESULT" defaultValue=""/></td>
	<td><BZ:data field="ACT_TIME" defaultValue=""/></td>
	<td><BZ:data field="ACT_LEVEL" defaultValue=""/></td>
	<td><BZ:data field="MEMO" defaultValue=""/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td><BZ:page form="srcForm" property="dataList"/></td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>