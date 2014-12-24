
<%@page import="com.hx.framework.organ.vo.OrganType"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
%>
<BZ:html>
<BZ:head>
<title>添加页面</title>
<BZ:script isEdit="true" isDate="true" isAjax="true"/>
<script>
	
	function tijiao() {

		if (!runFormVerify(document.srcForm, false)) {
			return;
		}else{
			var param = "CLUSTERNODE_ID="+document.getElementById("CLUSTERNODE_ID").value;
			var flag = getDataList("com.hx.framework.clustermanage.ClusterAddAjax",param);
			if(flag){
				alert("集群元素ID已经存在！");
			}else{
				document.srcForm.action = path + "clustermanage/findCluster!add.action";
				document.srcForm.submit();
			}
		}
	}
	
	function _back() {
		document.srcForm.action = path + "clustermanage/findCluster.action";
		document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data" codeNames="PROTOCOL;CLUSTER_ID">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<div class="heading">添加集群节点</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">节点标识</td>
<td width="20%">
<BZ:input id="CLUSTERNODE_ID" field="NODEID" prefix="CLUSTERNODE_" formTitle="ID" notnull="请输入元素ID" type="String" defaultValue=""/>common-config中配置的nodeId
</td>
<td width="10%">协议</td>
<td width="20%">
	<BZ:select field="PROTOCOL" formTitle="协议" prefix="CLUSTERNODE_" codeName="PROTOCOL" isCode="true">
		<!-- 
		<BZ:option value="http" selected="true">http</BZ:option>
		<BZ:option value="https">https</BZ:option>
		 -->
	</BZ:select>
</td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">端口号</td>
<td width="20%"><BZ:input field="PORT" prefix="CLUSTERNODE_" notnull="请输入端口号" formTitle="端口号" type="String" defaultValue=""/></td>
<td width="10%">元素IP地址</td>
<td width="20%"><BZ:input field="IPADDRESS" prefix="CLUSTERNODE_" formTitle="元素的IP地址" notnull="请输入IP地址" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">上下文根</td>
<td width="20%"><BZ:input field="CONTEXTPATH" prefix="CLUSTERNODE_" notnull="请输入上下文根" formTitle="上下文根" type="String" defaultValue=""/></td>
<td width="10%">集群ID</td>
<td width="20%">
	<BZ:select field="CLUSTERID" formTitle="集群ID" prefix="CLUSTERNODE_" codeName="CLUSTER_ID" isCode="true"></BZ:select>
</td>
<td width="5%"></td>
</tr>
<!-- 
<tr>
<td width="5%"></td>
<td width="10%">创建时间</td>
<td width="20%"><BZ:input field="ADDTIME" prefix="CLUSTERNODE_" notnull="请选择创建时间" formTitle="创建时间" type="date" readonly="readonly"/></td>
<td width="10%">创建人</td>
<td width="20%">
	<BZ:input field="PERSON_ID" prefix="CLUSTERNODE_" notnull="请输入创建人的姓名" formTitle="集群创建人的姓名" type="String" defaultValue=""/>
</td>
<td width="5%"></td>
</tr>
 -->
<tr>
<td></td>
<td>备注</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="CLUSTERNODE_MEMO"></textarea></td>
</tr>

</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>