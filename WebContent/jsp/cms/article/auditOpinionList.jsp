<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.article.vo.AuditOpinion"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	String path = request.getContextPath();
	DataList dataList = (DataList)request.getAttribute("dataList");
	//单个内容被审核时可以预览内容
	String singleton = (String)request.getAttribute("ART_SINGLETON");
%>
<BZ:html>
<BZ:head>
<title>添加审议意见</title>
<BZ:script isEdit="true"/>
<script type="text/javascript" src="<%=path %>/fckeditor/fckeditor.js"></script>
<script>
	function tijiao()
	{
	var title = document.getElementById("VALID_TITLE").value;
	
	
	
	var creator = document.getElementById("VALID_CREATOR").value;
	var dept = document.getElementById("VALID_DEPT_ID").value;
	var createTime = document.getElementById("VALID_CREATE_TIME").value;
	if(title == "" || title.length == 0){
		alert("请填写标题!");
		document.getElementById("VALID_TITLE").focus();
		return;
	}
	if(text == "" || text.length == 0){
		alert("请填写意见与建议!");
		oEditor.Focus();
		return;
	}
	if(creator == "" || creator.length == 0){
		alert("请填写提供者!");
		document.getElementById("VALID_CREATOR").focus();
		return;
	}
	if(dept == "" || dept.length == 0){
		alert("请选择部门!");
		document.getElementById("VALID_DEPT_ID").focus();
		return;
	}
	if(createTime == "" || createTime.length == 0){
		alert("请填写日期!");
		document.getElementById("VALID_CREATE_TIME").focus();
		return;
	}
	document.srcForm.action=path+"gzjy/Gzjy!add.action";
 	document.srcForm.submit();
 	//var username = document.getElementById("LOGIN_USERNAME").value;
 	//top.leftFrame.srcForm.action = "<%=request.getContextPath() %>/gzjy/Gzjy!queryCurList.action?USERNAME="+username;
 	//top.leftFrame.srcForm.submit();
	}
	
	//运行时加载，初始化fckeditor，然后显示要修改的内容
	<%-- window.onload = function(){
		var oFCKeditor = new FCKeditor('AUDIT_OPINION');
		oFCKeditor.BasePath = "<%=path %>/fckeditor/";
		oFCKeditor.Height = "300";
		oFCKeditor.ToolbarSet = 'Basic'; 
		oFCKeditor.ReplaceTextarea();
	} --%>
	
	function _back(){
	var ID = document.getElementById("CHANNEL_ID").value;
 	document.srcForm.action=path+"article/Article!auditQuery.action?CHANNEL_ID="+ID;
 	document.srcForm.submit();
	}
	
	//通过审核
  function shenhetongguo(){
  	  if(confirm("确定提交吗?")){
	  	  document.srcForm.action=path+"article/Article!passAudit.action";
		  document.srcForm.submit();
  	  }
  }
  
  //驳回审核
  function bohuishenhe(){
  	  if(confirm("确定提交吗?")){
		  document.srcForm.action=path+"article/Article!backAudit.action";
		  document.srcForm.submit();
	  }
  }
  
  function _chakan(){
  	  document.srcForm.action=path+"article/Article!detailArt.action?<%=Article.ID %>=<%=request.getAttribute(AuditOpinion.IDS) %>";
	  document.srcForm.target = "chakan";
	  document.srcForm.submit();
	  document.srcForm.target = "_self";
  }
  $(document).ready(function(){
	  dyniframesize([ 'mainFrame','mainFrame' ]);
});
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post">
<%
	String ids=(String)request.getAttribute(AuditOpinion.IDS);
	ids=ids.split(",")[0]+"#";
%>
<input name="IDS" type="hidden" value="<%=ids %>"/>
<input id="CHANNEL_ID" name="CHANNEL_ID" type="hidden" value="<%=request.getAttribute(Article.CHANNEL_ID) %>"/>
<div class="kuangjia">
<div class="heading">审核意见</div>
<table class="contenttable">
<tr height="30px">
<td></td>
<td align="right" nowrap>审核意见</td>
<td colspan="4">
<textarea id="AUDIT_OPINION" name="AUDIT_OPINION" style="height: 60px;width: 500px"></textarea>
</td>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2">
<input type="button" value="审核并发布" style="width: 90px" class="button_add" onclick="shenhetongguo()"/>&nbsp;&nbsp;
<input type="button" style="width: 90px" value="审核不通过" class="button_add" onclick="bohuishenhe()"/>&nbsp;&nbsp;

<%-- <%
	if(singleton != null && !"".equals(singleton)){
%>
<input type="button" value="预览" class="button_select" onclick="_chakan()"/>&nbsp;&nbsp;
<%
	}
%> --%>

<input type="button" value="返回" class="button_back" onclick="_back()"/>
<!-- <input type="button" value="关闭" class="button_back" onclick="window.top.close();"/> -->
</td>
</tr>
</table>
</div>
</BZ:form>

<%
	if(dataList != null && dataList.size() > 0){
%>
<div style="margin:10px;" class="kuangjia">
<div class="heading">历史审核意见</div>
<table class="contenttable" cellspacing="0" cellpadding="0">
<%
		for(int i = 0; i < dataList.size(); i++){
			Data data = dataList.getData(i);
%>
	<tr>
		<td style="border-top-width: 2px;border-top-color: #AED0F6;border-top-style: solid;border-bottom-width: 2px;border-bottom-color: #AED0F6;border-bottom-style: solid;border-left-width: 1px;border-left-color: #5FA1ED;border-left-style: solid;border-right-width: 1px;border-right-color: #5FA1ED;border-right-style: solid;">
			<table>
				<tr>
					<td width="10%"></td>
					<td colspan="4" style="font-size: 18px">
					<br />
					<%=data.getString(AuditOpinion.AUDIT_OPINION,"") %></td>
					<td></td>
				</tr>
				
				<tr>
					<td width="10%"></td>
					<td width="93%" colspan="3" style="color: #898989">&nbsp;&nbsp;&nbsp;&nbsp;<%=data.getString(AuditOpinion.USER_NAME,"") %>&nbsp;&nbsp;审核于：&nbsp;&nbsp;<%=data.getString(AuditOpinion.AUDIT_TIME,"") %></td>
				</tr>
				
			</table>
		</td>
	</tr>
<%
		}
%>
</table>
</div>
<%
	}
%>
</BZ:body>
</BZ:html>