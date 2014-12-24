
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
	String startDate=(String)request.getAttribute("startDate");
	if(startDate==null){
	    startDate="";
	}
	String endDate=(String)request.getAttribute("endDate");
	if(endDate==null){
	    endDate="";
	}
%>
<BZ:html>
<BZ:head>
<title>�����־ɾ��</title>
<BZ:script isList="true" isDate="true"/>
  <script type="text/javascript">
  
	function _onload() {
		
  	}
  	
  	function search() {
	  	document.srcForm.action=path+"clearLog/queryDelList.action";
	  	document.srcForm.submit(); 
  	}

  	function _auto()
  	{
  		document.srcForm.action=path+"clearLog/toAutoDelSetUp.action";
	  	document.srcForm.submit(); 
  	}
  	function _handDel()
  	{
  		document.srcForm.action=path+"clearLog/toHandDelLog.action";
	  	document.srcForm.submit();
  	}
  </script>
</BZ:head>
<BZ:body onload="_onload()" codeNames="LOGRANGE" >
<BZ:form name="srcForm" method="post" action="clearLog/queryDelList.action">
<input type="hidden" name="deleteuuid" />
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="heading">��ѯ����</div>
<div  class="chaxun">
<table class="chaxuntj">
	<tr>
	<td width="5%">ʱ�䣺</td>
	<td width="30%" colspan="4">��<input size="15" class="Wdate" id="START_TIME" name="START_TIME" readonly="readonly" value="<%=startDate %>" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'END_TIME\')||\'2020-10-01\'}'})"/>��<input size="15" class="Wdate" id="END_TIME"  name="END_TIME"  readonly="readonly" value="<%=endDate %>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'START_TIME\')}',maxDate:'2020-10-01'})"/></td>
	<td width="30%" align="right" valign="middle">
		<input type="button" value="��ѯ" class="button_search" onclick="search()"/>&nbsp;&nbsp;
		<input type="reset" value="����" class="button_reset"/>
	</td>
	<td width="15%"></td>
	</tr>
</table>
</div>
<div class="list">
<div class="heading">�����־ɾ���б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
	<BZ:th name="���" sortType="none" width="8%" sortplan="jsp"/>
	<BZ:th name="�����־����" sortType="string" width="10%" sortplan="database" sortfield="DATA_TYPE"/>
	<BZ:th name="ɾ��ʱ��" sortType="string" width="15%" sortplan="database" sortfield="OPERATION_TIME"/>
	<BZ:th name="ɾ�����ݷ�Χ" sortType="string" width="10%" sortplan="database" sortfield="DATA_PERIOD"/>
	<BZ:th name="ɾ����������" sortType="string" width="10%" sortplan="database" sortfield="DATA_ROW_COUNT"/>
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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="�ֶ�ɾ��" class="button_update" onclick="_handDel()" style="width: 120px"/>&nbsp;&nbsp;<input type="button" value="�Զ�ɾ������" class="button_update" onclick="_auto()" style="width: 120px"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>