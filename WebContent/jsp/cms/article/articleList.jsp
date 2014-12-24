<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="java.util.Date"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.common.Constants"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String path = request.getContextPath();
String compositor=(String)request.getAttribute("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getAttribute("ordertype");
if(ordertype==null){
	ordertype="";
}

DataList dataList = (DataList) request.getAttribute("dataList");
UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);
String secid=user.getPerson().getSecretLevel();

//�����Ȩ��
String autherAuth = (String)request.getAttribute("AUTHER_AUTH");
//Ͷ����Ȩ��
String writerAuth = (String)request.getAttribute("WRITER_AUTH");
%>
<BZ:html>
<BZ:head>
<title>�б�</title>
<BZ:script isList="true" isAjax="true" />
<link type="text/css" rel="stylesheet" href="<BZ:url/>/resource/style/base/form.css"/>
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
  if(document.getElementById("CHANNEL_ID").value == 0){
  	alert("��ѡ��������Ŀ!");
  	return ;
  }
  document.srcForm.action=path+"article/Article!toAdd.action";
  document.srcForm.target = "_blank";
  document.srcForm.submit();
  document.srcForm.target = "_self";
  document.srcForm.action=path+"article/Article!query.action";
  }
  function _update(){
   var sfdj=0;
   var V = "";
   var ID="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   V=document.getElementsByName('xuanze')[i].value;
   sfdj++;
   }
  }
  if(sfdj!="1"){
   alert('��ѡ��һ������');
   return;
  }else{
  //window.open("about:blank","_addArticle");
  if(V.split(",")[1] == "REFERENCE"){
	  alert("���������޷��޸�");
	  return;
  }
  ID = V.split(",")[0];
  document.srcForm.action=path+"article/Article!toModify.action?<%=Channel.ID %>="+ID;
  document.srcForm.target = "_addArticle";
  document.srcForm.submit();
  document.srcForm.target = "_self";
  document.srcForm.action=path+"article/Article!query.action";
  }
  }
  
  function _chakan(){
   var sfdj=0;
   var V = "";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   V=document.getElementsByName('xuanze')[i].value;
   sfdj++;
   }
  }
  if(sfdj!="1"){
   alert('��ѡ��һ������');
   return;
  }else{
  var curId = V.split(",")[0];
  var f = getStr("com.hx.pub.CheckLevelAjax","ID="+curId+"&ID_NAME=ID&TABLE_NAME=CMS_ARTICLE");
  if(f=="true"){
	  document.srcForm.action=path+"article/Article!detailArt.action?<%=Article.ID %>="+V;
	  document.srcForm.target = "chakan";
	  document.srcForm.submit();
	  document.srcForm.target = "_self";
	  document.srcForm.action=path+"article/Article!query.action";
  }else{
  	alert("��Ϣ�޷��鿴");
  }
  }
  }
  
  //�������ص�ַ
  function _generateUrl(){
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
  	window.open(path+"article/Article!generateDownloadUrl.action?<%=Article.ID %>="+ID,"_blank");
  }
  }
  
	function _delete(){
		var sfdj=0;
		var V = "";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				V=V+document.getElementsByName('xuanze')[i].value+"#";
				sfdj++;
			}
		}
		if(sfdj=="0"){
			alert('��ѡ��Ҫɾ��������');
			return;
		}else{
			if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')){
				document.getElementById("Article_IDS").value=V;
				document.srcForm.action=path+"article/Article!deleteBatch.action";
				document.srcForm.submit();
				document.srcForm.action=path+"article/Article!query.action";
			}else{
				return;
			}
		}
	}
  
  //��������
  function chexiaofabu(){
  var sfdj=0;
  var V = "";
   var uuid="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   V=V+document.getElementsByName('xuanze')[i].value+"#";
   sfdj++;
   }
  }
  if(sfdj=="0"){
   alert('��ѡ��Ҫ��������������!');
   return;
  }else{
	  var V1 = V.split("#");
	  for(var i=0;i<V1.length-1;i++){
		  uuid = uuid + V1[i].split(",")[0] + "#";
		  if(V1[i].split(",")[1] == "REFERENCE"){
			  alert("���������޷�����");
			  return;
		  }
	  }
  if(confirm('ȷ��Ҫ����ѡ��������?')){
  document.getElementById("Article_IDS").value=uuid;
  document.srcForm.action=path+"article/Article!cancelPublish.action";
  document.srcForm.submit();
  document.srcForm.action=path+"article/Article!query.action";
  }else{
  return;
  }
  }
  }
  
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
			var channelId = document.getElementById("CHANNEL_ID").value;
			var dsds = window.showModalDialog(path+"article/Article!changeChannelFrame.action?<%=Article.IDS %>="+uuid+"&<%=Article.CHANNEL_ID %>="+channelId, this, "dialogWidth=200px;dialogHeight=250px;scroll=no");
			if("yesa"==dsds){
	  			setTimeout("refresh_()", 500);
	  	  	}
		}
	}
	
	function refresh_(){
		document.srcForm.action=path+"article/Article!query.action";
		document.srcForm.submit();
	}
  
  /* //��������Ŀ
  function _publishTo(){
  var sfdj=0;
   var uuid="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
   sfdj++;
   }
  }
   
  if(sfdj=="0"){
   alert('��ѡ�񷢲�������');
   return;
  }else{
	  window.open("","_addArticle","width=720px,height=600px,scrollbars=yes,resizable=yes,toolbar=no,menubar=no,location=no,status=no");
	  document.getElementById("Article_IDS").value=uuid;
	  document.srcForm.action=path+"article/Article!toReferenceArticle.action";
	  document.srcForm.target = "_addArticle";
	  document.srcForm.submit();
	  document.srcForm.target = "_self";
	  document.srcForm.action=path+"article/Article!query.action";
  }
  } */
//��������Ŀ
  function _publishToChannels(){
	  var sfdj=0;
	  var V = "";
	  for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		  if(document.getElementsByName('xuanze')[i].checked){
			  V=V+document.getElementsByName('xuanze')[i].value+"#";
			  sfdj++;
		  }
	  }
	  if(sfdj=="0"){
		  alert('��ѡ�񷢲�������');
		  return;
	  }else{
		  document.getElementById("Article_IDS").value=V;
		  /* var channelIdDL = getDataList("com.hx.cms.article.AjaxGetChannelsOfArticle", "uuid="+uuid);
		  if(channelIdDL.size()>0){
			  var channels = "";
			  for(var i=0;i<channelIdDL.size();i++){
				  var CHANNEL_ID = channelIdDL.getData(i).getString("CHANNEL_ID","");
				  if(i == 0){
					  channels = CHANNEL_ID;
				  }else{
					  channels = channels + "," + CHANNEL_ID;
				  }
			  }
			  document.getElementById("CHANNELS").value = channels;
		  }else{
			  document.getElementById("CHANNELS").value = "";
		  } */
		  _showHelper('CHANNELS_NAME','CHANNELS','��Ŀ��','SYS_CHANNELS_OF_PERSON','','','2','true');
		  /* document.srcForm.action=path+"article/Article!referenceArticle.action";
		  document.srcForm.submit(); */
	  }
  }
  function _selectTree(id0,id,title,code,showParent,params,type){
	  if(id == "CHANNELS"){
		  document.srcForm.action=path+"article/Article!referenceArticle.action";
		  document.srcForm.submit();
	  }
  }
  
  //��ѯ����
  function _searchSub(){
	  document.srcForm.action=path+"article/Article!query.action";
	  document.srcForm.page.value = 1;
	  document.srcForm.submit();
  }
  </script>
</BZ:head>
<BZ:body codeNames="SYS_ORGAN_PERSON;SYS_CHANNELS_OF_PERSON;SYS_CHANNELS">
<BZ:form name="srcForm" method="post" action="article/Article!query.action">
<input type="hidden" id="CHANNELS_NAME" name="CHANNELS_NAME"/>
<input type="hidden" id="CHANNELS" name="CHANNELS"/>
<div class="kuangjia">

<!-- ��ѯ������ʼ -->
<div class="heading">��ѯ����</div>
<div  class="chaxun">
	<table class="chaxuntj">
		<tr>
			<td>���⣺</td>
			<td><BZ:input field="TITLE" prefix="Search_" defaultValue="" property="data"/></td>
			<td>���淽ʽ��</td>
			<td>
				<BZ:select field="STORE_STATUS" prefix="Search_" formTitle="" property="data" className="rs-search-select">
					<BZ:option value="">ѡ��ʽ</BZ:option>
					<BZ:option value="REFERENCE">����</BZ:option>
					<BZ:option value="PERSIST">����</BZ:option>
				</BZ:select>
			</td>
			<td colspan="4" style="align:right">
			    <input type="button" value="��ѯ" class="button_search" onclick="_searchSub();"/>
			</td>
		</tr>
	</table>
</div>
<!-- ��ѯ�������� -->

<input id="Article_IDS" name="IDS" type="hidden"/>
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- ����ĿID -->
<input id="CHANNEL_ID" name="CHANNEL_ID" type="hidden" value="<%=request.getAttribute(Article.CHANNEL_ID) %>"/>
<div class="list">
<div class="heading">�����б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="" sortType="none" width="8%" sortplan="jsp"/>
<BZ:th name="����" sortType="string" width="22%" sortplan="database" sortfield="TITLE"/>
<BZ:th name="����ʱ��" sortType="date" width="20%" sortplan="database" sortfield="CREATE_TIME"/>
<BZ:th name="������" sortType="string" width="15%" sortplan="database" sortfield="CREATOR"/>
<BZ:th name="״̬" sortType="string" width="10%" sortplan="database" sortfield="STATUS"/>
<%-- <BZ:th name="�����" sortType="string" width="10%" sortplan="database" sortfield="SEQ_NUM"/> --%>
<BZ:th name="�洢" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="������Ŀ" sortType="string" width="15%" sortplan="jsp"/>
<%-- <BZ:th name="����" sortType="string" width="10%" sortplan="jsp"/> --%>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="article">
<tr>
<%
Data data = (Data)pageContext.getAttribute("article");
int seqNum = data.getInt(Article.SEQ_NUM);

//�ܼ�����
String mj = data.getString(Article.SECURITY_LEVEL);
if (mj==null || "".equals(mj)){
	mj="0";
}
if (secid==null || "".equals(secid)){
	secid="0";
}
if (Integer.parseInt(secid,10)>=Integer.parseInt(mj,10)){
%>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>,<BZ:data field="STORE_STATUS" onlyValue="true"/>"><BZ:i></BZ:i></td>
<%
}else{
%>
<td noselect="true"><BZ:i></BZ:i></td>
<%
}
%>

<td>
<%
Date createTime = new SimpleDateFormat("yyyy-MM-dd").parse(data.getString("CREATE_TIME"));
//����ʱ��
Integer days = data.getInt(Article.NEW_TIME);
Calendar createTime_ = Calendar.getInstance();
createTime_.setTime(createTime);
createTime_.add(Calendar.DAY_OF_MONTH,days);
Calendar date = Calendar.getInstance();

//�ö�
if(Article.IS_TOP_YES.equals(data.getString(Article.IS_TOP))){
%>
<img alt="�ö�" src="<%=path %>/jsp/cms/images/top.gif"/>
<%
}
//�Ƚ�
if(Article.IS_NEW_YES.equals(data.getString(Article.IS_NEW)) && createTime_.compareTo(date) > 0){
%>
<img alt="����" src="<%=path %>/jsp/cms/images/new.gif"/>
<%
}
%>
<BZ:data field="TITLE" defaultValue=""/>
</td>
<td><BZ:data field="CREATE_TIME" type="Date" defaultValue=""/></td>
<td><BZ:data field="CREATOR" defaultValue="" codeName="SYS_ORGAN_PERSON"/></td>
<td><BZ:data field="STATUS" defaultValue="" checkValue="1=�ݴ�;2=�ȴ����;3=�ѷ���;4=�˻�;5=����"/></td>
<%-- <td>
	<%
		if(!"2147483647".equals(data.getString("SEQ_NUM"))){
	%>
	<BZ:data field="SEQ_NUM" defaultValue=""/>
	<%
		}
	%>
</td> --%>
<td><BZ:data field="STORE_STATUS" defaultValue="" checkValue="PERSIST=����;REFERENCE=����"/></td>
<td><BZ:data field="CHANNEL_ID" defaultValue="" codeName="SYS_CHANNELS"/></td>

<%-- <td>
<%
if(dataList != null && dataList.size() > 1){
	if(seqNum == 1){
%>
<a href="<%=path %>/article/Article!changeSeqnum.action?target=down&ID=<%=data.getString(Article.ID) %>&CHANNEL_ID=<%=request.getAttribute(Article.CHANNEL_ID) %>" style="text-decoration: none">����</a>
<%
	}
	if(seqNum < Article.ARTICLE_UP_DOWN_MAXNUM && seqNum > 1){
		if(dataList != null && dataList.size() > seqNum){
%>
<a href="<%=path %>/article/Article!changeSeqnum.action?target=up&ID=<%=data.getString(Article.ID) %>&CHANNEL_ID=<%=request.getAttribute(Article.CHANNEL_ID) %>">����</a>&nbsp;<a href="<%=path %>/article/Article!changeSeqnum.action?target=down&ID=<%=data.getString(Article.ID) %>&CHANNEL_ID=<%=request.getAttribute(Article.CHANNEL_ID) %>">����</a>
<%
		}else{
%>
<a href="<%=path %>/article/Article!changeSeqnum.action?target=up&ID=<%=data.getString(Article.ID) %>&CHANNEL_ID=<%=request.getAttribute(Article.CHANNEL_ID) %>">����</a>
<%
		}
	}
	if(seqNum == Article.ARTICLE_UP_DOWN_MAXNUM){
%>
<a href="<%=path %>/article/Article!changeSeqnum.action?target=up&ID=<%=data.getString(Article.ID) %>&CHANNEL_ID=<%=request.getAttribute(Article.CHANNEL_ID) %>">����</a>
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
<!-- <input type="button" value="���" class="button_add" onclick="add()"/>&nbsp;&nbsp; -->

<%-- <%
	//Ͷ����Ȩ��
	if("WRITER_AUTH".equals(writerAuth)){
%> --%>
<input type="button" value="�޸�" class="button_update" onclick="_update()"/>&nbsp;&nbsp;
<input type="button" value="�ƶ���.." style="width: 80px" class="button_select" onclick="_changeChannel()"/>&nbsp;&nbsp;
<!-- <input type="button" value="������.." style="width: 80px" class="button_select" onclick="_publishTo()"/>&nbsp;&nbsp; -->
<input type="button" value="������.." style="width: 80px" class="button_select" onclick="_publishToChannels()"/>&nbsp;&nbsp;
<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<%-- <%
	}
%>

<%
	//�����Ȩ��
	if("AUTHER_AUTH".equals(autherAuth)){
%> --%>
<input type="button" value="��������" style="width: 80px" class="button_select" onclick="chexiaofabu()"/>&nbsp;&nbsp;
<%-- <%
	}
%> --%>
<input type="button" value="Ԥ��" class="button_select" onclick="_chakan()"/>&nbsp;&nbsp;
<!-- <input type="button" value="�������ص�ַ" class="button_add" style="width: 100px" onclick="_generateUrl();"/>&nbsp;&nbsp; -->
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>