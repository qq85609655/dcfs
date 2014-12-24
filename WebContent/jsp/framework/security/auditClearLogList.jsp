
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*,java.util.*" %>
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
	String startDate=(String)request.getAttribute("startDate");
	if(startDate==null){
	    startDate="";
	}
	String endDate=(String)request.getAttribute("endDate");
	if(endDate==null){
	    endDate="";
	}
	String type=(String)request.getAttribute("type");
	if(type==null){
	    type="";
	}
	
%>
<BZ:html>
<BZ:head>
<title>�����־�鵵</title>
<BZ:script isList="true" isDate="true"/>
  <script type="text/javascript">
  
	function _onload() {
		var st1 = document.getElementById("Type");
		var v = document.getElementById("tbl_name").value;
		for(var i=0;i<st1.length;i++){
			if(st1.options[i].value==v){
				st1.options[i].selected=true;
			}
		}
  	}
  	
  	function search() {
	  	document.srcForm.action=path+"clearLog/queryList.action";
	  	document.srcForm.submit(); 
  	}

  	function _hand()
  	{
  		document.srcForm.action=path+"clearLog/toHandLogClear.action";
	  	document.srcForm.submit(); 
  	}

  	function _auto()
  	{
  		document.srcForm.action=path+"clearLog/toAutoClearSetUp.action";
	  	document.srcForm.submit(); 
  	}
  </script>
</BZ:head>
<BZ:body onload="_onload()" codeNames="LOGRANGE" >
<BZ:form name="srcForm" method="post" action="clearLog/queryList.action">
<input type="hidden" name="deleteuuid" />
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<input type="hidden" id="tbl_name" name="tbl_name" value="<%=type%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="heading">��ѯ����</div>
<div  class="chaxun">
<table class="chaxuntj">
	<tr>
	<td width="5%">ʱ�䣺</td>
	<td width="30%" colspan="4">��<input size="15" class="Wdate" id="START_TIME" name="START_TIME" readonly="readonly" value="<%=startDate %>" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'END_TIME\')||\'2020-10-01\'}'})"/>��<input size="15" class="Wdate" id="END_TIME"  name="END_TIME"  readonly="readonly" value="<%=endDate %>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'START_TIME\')}',maxDate:'2020-10-01'})"/></td>
	<td width="10%">�鵵��ʽ</td>
	<td width="10%">
	    <select name="Type" id="Type">
			<option value="1">�ֶ��鵵</option>
			<option value="2">�Զ��鵵</option>
	    </select>
	</td>
	<td width="30%" align="right" valign="middle">
		<input type="button" value="��ѯ" class="button_search" onclick="search()"/>&nbsp;&nbsp;
		<input type="reset" value="����" class="button_reset"/>
	</td>
	<td width="15%"></td>
	</tr>
</table>
</div>
<div class="list">
<div class="heading">�����־�鵵�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
	<BZ:th name="���" sortType="none" width="8%" sortplan="jsp"/>
	<BZ:th name="�����־����" sortType="string" width="10%" sortplan="database" sortfield="DATA_TYPE"/>
	<BZ:th name="�鵵ʱ��" sortType="string" width="15%" sortplan="database" sortfield="OPERATION_TIME"/>
	<BZ:th name="�鵵���ݷ�Χ" sortType="string" width="10%" sortplan="database" sortfield="DATA_PERIOD"/>
	<BZ:th name="�鵵��������" sortType="string" width="10%" sortplan="database" sortfield="DATA_ROW_COUNT"/>
	<BZ:th name="�鵵��ʽ" sortType="string" width="10%" sortplan="database" sortfield="OPERATION_TYPE"/>
	<BZ:th name="������" sortType="string" width="10%" sortplan="database" sortfield="B_CNAME"/>
	<BZ:th name="���" sortType="string" width="10%" sortplan="database" sortfield="OPERATION_RESULT"/>
	<BZ:th name="��ע" sortType="string" width="17%" sortplan="database" sortfield="MEMO"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
	<td><BZ:data field="DATA_TYPE" defaultValue="" checkValue="1=ϵͳ������Ϊ�����־;2=ϵͳ���ʿ��������־;3= �û���¼��Ϊ�����־;4=Ӧ�ò�����Ϊ�����־"/></td>
	<td><BZ:data field="OPERATION_TIME" defaultValue=""/></td>
	<td><BZ:data field="DATA_PERIOD" defaultValue=""  codeName="LOGRANGE" /></td>
	<td><BZ:data field="DATA_ROW_COUNT" defaultValue=""   /></td>
	<td><BZ:data field="OPERATION_TYPE" defaultValue="" checkValue="1=�ֶ��鵵;2=�Զ��鵵"/></td>
	<td><BZ:data field="B_CNAME" defaultValue=""/></td>
	<td><BZ:data field="OPERATION_RESULT" defaultValue="" checkValue="1=�ɹ�;2=ʧ��"/></td>
	<td><BZ:data field="MEMO" defaultValue=""/></td>
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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="�ֶ��鵵" class="button_update" onclick="_hand()" style="width: 100px"/>&nbsp;&nbsp;<input type="button" value="�Զ��鵵����" class="button_update" onclick="_auto()" style="width: 120px"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>