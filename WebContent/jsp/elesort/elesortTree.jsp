<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String treeLeaf = (String)request.getAttribute("treeLeaf");
	request.setAttribute("select", treeLeaf);
%>
<BZ:html>
<BZ:head>
	<title>数据元分类</title>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript">
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		if(id=='-1'){
			id="0";
		}
		//处理
		document.getElementById("PARENT_ID").value=id;
		parent.mainFrame.location = "<%=request.getContextPath() %>/EleSortServlet?method=eleSortList&p_PARENT_ID="+id+"&compositor=SEQ_NUM";
	}
	$(document).ready(function() {
		dyniframesize(['leftFrame','mainFrame']);
	});
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="/EleSortServlet?method=generateTree">
		<!-- 修改组织机构的标志位 -->
		<input type="hidden" name="treeDispatcher" value="eleSortTree" />
		<BZ:input prefix="p_" id="PARENT_ID" field="PARENT_ID" type="hidden" defaultValue=""/>
		<div class="kuangjia">
		<div class="list">
		<div class="heading">数据元分类树</div>
			<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/" topName="数据元分类" selectvalue="select"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>