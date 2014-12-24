
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ page import="hx.database.databean.*"%>
<%@page import="hx.database.databean.Data"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.*"%>
<BZ:html>
<BZ:head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>所有在线人员</title>
	<BZ:script isList="true" />
	
<script type="text/javascript">
	
	function _onload(){
		  	
	 }
	
</script>
</BZ:head>
<BZ:body onload="_onload()" codeNames="SEX">
	<BZ:frameDiv property="clueTo" className="kuangjia">
	<input type="hidden" name="compositor" value=""/>
	<input type="hidden" name="ordertype" value=""/>
		<div class="list">
			<div class="heading">在线人员信息列表</div>
			<BZ:table tableid="tableGrid" tableclass="tableGrid">
				<BZ:thead theadclass="titleBackGrey">
					<BZ:th name="序号" sortType="none" width="5%" sortplan="jsp"></BZ:th>
					<BZ:th name="姓名" sortType="string" width="20%" sortplan="jsp"></BZ:th>
					<BZ:th name="性别" sortType="string" width="20%" sortplan="jsp"></BZ:th>
					<BZ:th name="账号ID" sortType="string" width="20%" sortplan="jsp"></BZ:th>
					<BZ:th name="部门" sortType="string" width="20%" sortplan="jsp"></BZ:th>
					<BZ:th name="登录时间" sortType="string" width="25%" sortplan="jsp"></BZ:th>
				</BZ:thead>
				<BZ:tbody>
				
				<BZ:for property="LGPLIST">
					<tr >
						<td><BZ:i></BZ:i></td>
						<td><BZ:data field="NAME" onlyValue="true"/></td>
						<td><BZ:data field="SEX" onlyValue="true" codeName="SEX"/></td>
						<td><BZ:data field="ACCOUNT" onlyValue="true"/></td>
						<td><BZ:data field="ORGAN" onlyValue="true"/></td>
						<td><BZ:data field="LOGINDATE" onlyValue="true"/></td>
					</tr>
				</BZ:for>
				</BZ:tbody>
			</BZ:table>
		</div>
	</BZ:frameDiv>
</BZ:body>
</BZ:html>