<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.common.Constants"%>
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

UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);
String secid=user.getPerson().getSecretLevel();

//�����Ȩ��
String autherAuth = (String)request.getAttribute("AUTHER_AUTH");
//Ͷ����Ȩ��
String writerAuth = (String)request.getAttribute("WRITER_AUTH");
//��ǰ��Ŀ����˵Ļ��д˱�־
String isAuth = (String)request.getAttribute("IS_AUTH");
%>
<BZ:html>
<BZ:head>
<title>�б�</title>
<BZ:script isList="true" isAjax="true"/>
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
  //window.open("about:blank","_addArticle");
  document.srcForm.action=path+"article/Article!toAdd.action";
  document.srcForm.target = "_addArticle";
  document.srcForm.submit();
  document.srcForm.target = "_self";
  document.srcForm.action = path + "article/Article!tempQuery.action";
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
			ID = V.split(",")[0];
			document.srcForm.action=path+"article/Article!toModifyTemp.action?<%=Channel.ID %>="+ID;
			document.srcForm.target = "_addArticle";
			document.srcForm.submit();
			document.srcForm.target = "_self";
			document.srcForm.action = path + "article/Article!tempQuery.action";
		}
	}
  
  function _chakan(){
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
	  
  var curId = ID.split(",")[0];
  var f = getStr("com.hx.pub.CheckLevelAjax","ID="+curId+"&ID_NAME=ID&TABLE_NAME=CMS_ARTICLE");
  if(f=="true"){
	  document.srcForm.action=path+"article/Article!detailArt.action?<%=Article.ID %>="+ID;
	  document.srcForm.target = "chakan";
	  document.srcForm.submit();
	  document.srcForm.target = "_self";
	  document.srcForm.action = path + "article/Article!tempQuery.action";
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
		var V="";
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
				document.srcForm.action=path+"article/Article!deleteBatchForTemp.action";
				document.srcForm.submit();
				document.srcForm.action = path + "article/Article!tempQuery.action";
			}else{
				return;
			}
		}
	}
  
	//�ύ���
	function tijiaoshenhe(){
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
			alert('��ѡ��Ҫ�ύ��˵�����');
			return;
		}else{
			var V1 = V.split("#");
			  for(var i=0;i<V1.length-1;i++){
				  uuid = uuid + V1[i].split(",")[0] + "#";
			  }
			if(confirm('ȷ��Ҫ�ύ�����?')){
				document.getElementById("Article_IDS").value=uuid;
				document.srcForm.action=path+"article/Article!submitAudit.action";
				document.srcForm.submit();
				document.srcForm.action = path + "article/Article!tempQuery.action";
			}else{
				return;
			}
		}
	}
  
  //��ѯ����
  function _searchSub(){
	  document.srcForm.action=path+"article/Article!tempQuery.action";
	  document.srcForm.page.value = 1;
	  document.srcForm.submit();
  }
  </script>
</BZ:head>
<BZ:body codeNames="SYS_ORGAN_PERSON;SYS_CHANNELS">
<BZ:form name="srcForm" method="post" action="article/Article!tempQuery.action">
<div class="kuangjia">

<!-- ��ѯ������ʼ -->
<div class="heading">��ѯ����</div>
<div  class="chaxun">
	<table class="chaxuntj">
		<tr>
			<td>���⣺</td>
			<td><BZ:input field="TITLE" prefix="Search_" defaultValue="" property="data"/></td>
			<td>״̬��</td>
			<td>
				<BZ:select field="STATUS" prefix="Search_" formTitle="" property="data" className="rs-search-select">
					<BZ:option value="">ѡ��״̬</BZ:option>
					<BZ:option value="1">�ݴ�</BZ:option>
					<BZ:option value="2">�ȴ����</BZ:option>
					<BZ:option value="4">����˻�</BZ:option>
					<BZ:option value="5">��������</BZ:option>
					<BZ:option value="3">�ѷ���</BZ:option>
				</BZ:select>
			</td>
			<td>���淽ʽ��</td>
			<td>
				<BZ:select field="STORE_STATUS" prefix="Search_" formTitle="" property="data" className="rs-search-select">
					<BZ:option value="">ѡ��ʽ</BZ:option>
					<BZ:option value="REFERENCE">����</BZ:option>
					<BZ:option value="PERSIST">����</BZ:option>
				</BZ:select>
			</td>
			<td colspan="2" style="align:right">
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
<BZ:th name="" sortType="none" width="11%" sortplan="jsp"/>
<BZ:th name="����" sortType="string" width="25%" sortplan="database" sortfield="TITLE"/>
<BZ:th name="����ʱ��" sortType="date" width="15%" sortplan="database" sortfield="CREATE_TIME"/>
<BZ:th name="������" sortType="string" width="12%" sortplan="database" sortfield="CREATOR"/>
<BZ:th name="״̬" sortType="string" width="12%" sortplan="database" sortfield="STATUS"/>
<%-- <BZ:th name="�����" sortType="string" width="10%" sortplan="database" sortfield="SEQ_NUM"/> --%>
<BZ:th name="�洢" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="������Ŀ" sortType="string" width="15%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="article">

<tr>
<%
Data data = (Data)pageContext.getAttribute("article");
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
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>,<BZ:data field="CHANNEL_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<%
}else{
%>
<td noselect="true"><BZ:i></BZ:i></td>
<%
}
%>
<td><BZ:data field="TITLE" defaultValue=""/></td>
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
<input type="button" value="�޸�" class="button_update" onclick="_update()"/>&nbsp;&nbsp;
<%-- <%
	//�����ĿΪ��˲ſ��ܽ����ж��Ƿ�Ϊ�����
	if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
		if(!"AUTHER_AUTH".equals(autherAuth)){
			
%>
<input type="button" style="width: 80px" value="�ύ���" class="button_select" onclick="tijiaoshenhe()"/>&nbsp;&nbsp;
<%
		}
	}
%> --%>
<%-- <%
	//�ж���Ŀ�Ƿ�Ϊ���
	if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
			
%>
<input type="button" style="width: 80px" value="�ύ���" class="button_select" onclick="tijiaoshenhe()"/>&nbsp;&nbsp;
<%
	}
%> --%>
<input type="button" value="Ԥ��" class="button_update" onclick="_chakan()"/>&nbsp;&nbsp;
<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<!-- <input type="button" value="�������ص�ַ" class="button_add" style="width: 100px" onclick="_generateUrl();"/>&nbsp;&nbsp; -->
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>