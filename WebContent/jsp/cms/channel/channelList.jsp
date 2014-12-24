<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
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

String path = request.getContextPath();
DataList dataList = (DataList)request.getAttribute("dataList");
%>
<BZ:html>
<BZ:head>
<title>�б�</title>
<BZ:script isList="true" isAjax="true"/>
<%=request.getAttribute("refreshTree")!=null?request.getAttribute("refreshTree"):"" %>
  <script type="text/javascript">
  
$(document).ready(function(){
	dyniframesize([ 'mainFrame','mainFrame' ]);
});
  function search(){
  document.srcForm.action=path+"";
  document.srcForm.submit(); 
  }
  
  function add(){
  document.srcForm.action=path+"channel/Channel!toAdd.action";
  document.srcForm.submit();
  document.srcForm.action = path + "channel/Channel!queryChildren.action";
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
  document.srcForm.action=path+"channel/Channel!toModify.action?<%=Channel.ID %>="+ID;
  document.srcForm.submit();
  document.srcForm.action = path + "channel/Channel!queryChildren.action";
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
  document.srcForm.action=path+"channel/Channel!queryDetail.action?<%=Channel.ID %>="+ID;
  document.srcForm.submit();
  document.srcForm.action = path + "channel/Channel!queryChildren.action";
  }
  }
  function _delete(){
	  var sfdj=0;
	  var uuid="";
	  for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		  if(document.getElementsByName('xuanze')[i].checked){
			  uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
			  sfdj++;
		  }
	  }
	  if(sfdj=="0"){
		  alert('��ѡ��Ҫɾ��������');
		  return;
	  }else{
		  var articleDL = getDataList("com.hx.cms.channel.AjaxGetArticleOfChannel", "uuid="+uuid);
		  if(articleDL.size()>0){
			  alert("ѡ�е���Ŀ��������Ŀ�����£�����ɾ����");
			  return;
		  }
		  var channelDL = getDataList("com.hx.cms.channel.AjaxGetChannels", "uuid="+uuid);
		  if(channelDL.size()>0){
			  if(confirm('ѡ�е���Ŀ������Ŀ��ȷ��Ҫɾ����?')){
				  document.getElementById("Channel_IDS").value=uuid;
				  document.srcForm.action=path+"channel/Channel!deleteBatch.action";
				  document.srcForm.submit();
				  document.srcForm.action = path + "channel/Channel!queryChildren.action";
			  }else{
				  return;
			  }
		  }else{
			  if(confirm('ȷ��Ҫɾ��ѡ����Ŀ��?')){
				  document.getElementById("Channel_IDS").value=uuid;
				  document.srcForm.action=path+"channel/Channel!deleteBatch.action";
				  document.srcForm.submit();
				  document.srcForm.action = path + "channel/Channel!queryChildren.action";
			  }else{
				  return;
			  }
		  }
	  }
  }
  
  //�ƶ���Ŀ
  function _changeChannel(){
  var sfdj=0;
   var uuid="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   uuid=uuid+document.getElementsByName('xuanze')[i].value+"!";
   sfdj++;
   }
  }
  if(sfdj=="0"){
   alert('��ѡ���ƶ�������');
   return;
  }else{
  	  var parentId = document.getElementById("PARENT_ID").value;
	  window.showModalDialog(path+"channel/Channel!changeChannelFrame.action?<%=Channel.IDS %>="+uuid+"&<%=Channel.PARENT_ID %>="+parentId, this, "dialogWidth=300px;dialogHeight=400px;scroll=no");
	  document.srcForm.submit();
	  parent.document.srcForm.submit();
  }
  }
  </script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post" action="channel/Channel!queryChildren.action">
<div class="kuangjia">
<input id="Channel_IDS" name="IDS" type="hidden"/>
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- ����ĿID -->
<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(Channel.PARENT_ID) %>"/>
<div class="list">
<div class="heading">��Ŀ�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="����" sortType="string" width="45%" sortplan="database" sortfield="NAME"/>
<BZ:th name="��Ŀ��ʽ" sortType="string" width="20%" sortplan="database" sortfield="CHANNEL_STYLE"/>
<BZ:th name="�Ƿ����" sortType="string" width="15%" sortplan="database" sortfield="IS_AUTH"/>
<BZ:th name="�����" sortType="string" width="10%" sortplan="database" sortfield="SEQ_NUM"/>
<%-- <BZ:th name="����" sortType="string" width="20%" sortplan="jsp"/> --%>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="channel">
<%
	Data data = (Data)pageContext.findAttribute("channel");
	int seqNum = data.getInt(Channel.SEQ_NUM);
%>
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="NAME" onlyValue="true"/></td>
<td><BZ:data field="CHANNEL_STYLE" defaultValue="" checkValue="1=��ͨ��Ŀ;2=�ⲿ����;3=������Ŀ"/></td>
<td><BZ:data field="IS_AUTH" defaultValue="" checkValue="1=���;2=�����"/></td>
<td><BZ:data field="SEQ_NUM" defaultValue=""/></td>
<%-- <td>
<%
if(dataList != null && dataList.size() > 1){
	if(seqNum == 1){
%>
<a href="<%=path %>/channel/Channel!changeSeqnum.action?target=down&ID=<%=data.getString(Channel.ID) %>&PARENT_ID=<%=request.getAttribute(Channel.PARENT_ID) %>" style="text-decoration: none">����</a>
<%		
	}
	if(seqNum < Channel.CHANNEL_UP_DOWN_MAXNUM && seqNum > 1){
		if(dataList != null && dataList.size() > seqNum){
%>
<a href="<%=path %>/channel/Channel!changeSeqnum.action?target=up&ID=<%=data.getString(Channel.ID) %>&PARENT_ID=<%=request.getAttribute(Channel.PARENT_ID) %>">����</a>&nbsp;&nbsp;<a href="<%=path %>/channel/Channel!changeSeqnum.action?target=down&ID=<%=data.getString(Channel.ID) %>&PARENT_ID=<%=request.getAttribute(Channel.PARENT_ID) %>">����</a>
<%
		}else{
%>
<a href="<%=path %>/channel/Channel!changeSeqnum.action?target=up&ID=<%=data.getString(Channel.ID) %>&PARENT_ID=<%=request.getAttribute(Channel.PARENT_ID) %>">����</a>
<%
		}
	}
	if(seqNum == Channel.CHANNEL_UP_DOWN_MAXNUM){
%>
<a href="<%=path %>/channel/Channel!changeSeqnum.action?target=up&ID=<%=data.getString(Channel.ID) %>&PARENT_ID=<%=request.getAttribute(Channel.PARENT_ID) %>">����</a>
<%
	}
}
%>
</td> --%>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="2"><BZ:page form="srcForm" property="dataList" type="special"/></td>
</tr>
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;">
<input type="button" value="���" class="button_add" onclick="add()"/>&nbsp;&nbsp;
<!-- 
<input type="button" value="�鿴" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;
 -->
<input type="button" value="�޸�" class="button_update" onclick="_update()"/>&nbsp;&nbsp;
<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<input type="button" value="�ƶ���.." style="width: 80px" class="button_select" onclick="_changeChannel()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>