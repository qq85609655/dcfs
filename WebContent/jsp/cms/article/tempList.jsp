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

//审核人权限
String autherAuth = (String)request.getAttribute("AUTHER_AUTH");
//投稿人权限
String writerAuth = (String)request.getAttribute("WRITER_AUTH");
//当前栏目不审核的话有此标志
String isAuth = (String)request.getAttribute("IS_AUTH");
%>
<BZ:html>
<BZ:head>
<title>列表</title>
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
  	alert("请选择文章栏目!");
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
			alert('请选择一条数据');
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
   alert('请选择一条数据');
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
  	alert("信息无法查看");
  }
  }
  }
  
  //生成下载地址
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
   alert('请选择一条数据');
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
			alert('请选择要删除的数据');
			return;
		}else{
			if(confirm('确认要删除选中信息吗?')){
				document.getElementById("Article_IDS").value=V;
				document.srcForm.action=path+"article/Article!deleteBatchForTemp.action";
				document.srcForm.submit();
				document.srcForm.action = path + "article/Article!tempQuery.action";
			}else{
				return;
			}
		}
	}
  
	//提交审核
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
			alert('请选择要提交审核的数据');
			return;
		}else{
			var V1 = V.split("#");
			  for(var i=0;i<V1.length-1;i++){
				  uuid = uuid + V1[i].split(",")[0] + "#";
			  }
			if(confirm('确认要提交审核吗?')){
				document.getElementById("Article_IDS").value=uuid;
				document.srcForm.action=path+"article/Article!submitAudit.action";
				document.srcForm.submit();
				document.srcForm.action = path + "article/Article!tempQuery.action";
			}else{
				return;
			}
		}
	}
  
  //查询条件
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

<!-- 查询条件开始 -->
<div class="heading">查询条件</div>
<div  class="chaxun">
	<table class="chaxuntj">
		<tr>
			<td>标题：</td>
			<td><BZ:input field="TITLE" prefix="Search_" defaultValue="" property="data"/></td>
			<td>状态：</td>
			<td>
				<BZ:select field="STATUS" prefix="Search_" formTitle="" property="data" className="rs-search-select">
					<BZ:option value="">选择状态</BZ:option>
					<BZ:option value="1">暂存</BZ:option>
					<BZ:option value="2">等待审核</BZ:option>
					<BZ:option value="4">审核退回</BZ:option>
					<BZ:option value="5">撤销发布</BZ:option>
					<BZ:option value="3">已发布</BZ:option>
				</BZ:select>
			</td>
			<td>保存方式：</td>
			<td>
				<BZ:select field="STORE_STATUS" prefix="Search_" formTitle="" property="data" className="rs-search-select">
					<BZ:option value="">选择方式</BZ:option>
					<BZ:option value="REFERENCE">引用</BZ:option>
					<BZ:option value="PERSIST">保存</BZ:option>
				</BZ:select>
			</td>
			<td colspan="2" style="align:right">
			    <input type="button" value="查询" class="button_search" onclick="_searchSub();"/>
			</td>
		</tr>
	</table>
</div>
<!-- 查询条件结束 -->

<input id="Article_IDS" name="IDS" type="hidden"/>
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- 父栏目ID -->
<input id="CHANNEL_ID" name="CHANNEL_ID" type="hidden" value="<%=request.getAttribute(Article.CHANNEL_ID) %>"/>
<div class="list">
<div class="heading">文章列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="" sortType="none" width="11%" sortplan="jsp"/>
<BZ:th name="标题" sortType="string" width="25%" sortplan="database" sortfield="TITLE"/>
<BZ:th name="发布时间" sortType="date" width="15%" sortplan="database" sortfield="CREATE_TIME"/>
<BZ:th name="创建者" sortType="string" width="12%" sortplan="database" sortfield="CREATOR"/>
<BZ:th name="状态" sortType="string" width="12%" sortplan="database" sortfield="STATUS"/>
<%-- <BZ:th name="排序号" sortType="string" width="10%" sortplan="database" sortfield="SEQ_NUM"/> --%>
<BZ:th name="存储" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="所属栏目" sortType="string" width="15%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="article">

<tr>
<%
Data data = (Data)pageContext.getAttribute("article");
//密级过滤
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
<td><BZ:data field="STATUS" defaultValue="" checkValue="1=暂存;2=等待审核;3=已发布;4=退回;5=撤销"/></td>
<%-- <td>
	<%
		if(!"2147483647".equals(data.getString("SEQ_NUM"))){
	%>
	<BZ:data field="SEQ_NUM" defaultValue=""/>
	<%
		}
	%>
</td> --%>
<td><BZ:data field="STORE_STATUS" defaultValue="" checkValue="PERSIST=保存;REFERENCE=引用"/></td>
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
<input type="button" value="添加" class="button_add" onclick="add()"/>&nbsp;&nbsp;
<input type="button" value="修改" class="button_update" onclick="_update()"/>&nbsp;&nbsp;
<%-- <%
	//如果栏目为审核才可能进入判断是否为审核人
	if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
		if(!"AUTHER_AUTH".equals(autherAuth)){
			
%>
<input type="button" style="width: 80px" value="提交审核" class="button_select" onclick="tijiaoshenhe()"/>&nbsp;&nbsp;
<%
		}
	}
%> --%>
<%-- <%
	//判断栏目是否为审核
	if(!Channel.IS_AUTH_STATUS_NO.equals(isAuth)){
			
%>
<input type="button" style="width: 80px" value="提交审核" class="button_select" onclick="tijiaoshenhe()"/>&nbsp;&nbsp;
<%
	}
%> --%>
<input type="button" value="预览" class="button_update" onclick="_chakan()"/>&nbsp;&nbsp;
<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<!-- <input type="button" value="生成下载地址" class="button_add" style="width: 100px" onclick="_generateUrl();"/>&nbsp;&nbsp; -->
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>