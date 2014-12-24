<%
/**   
 * @Title: tending_and_opinion.jsp
 * @Description: 抚育计划和组织意见
 * @author xugy
 * @date 2014-10-30下午1:05:23
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String FLAG = (String)request.getAttribute("FLAG");
%>
<BZ:html>
<BZ:head>
	<title>抚育计划和组织意见</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	setSigle();
	var FLAG = "<%=FLAG%>";
	if(FLAG == "4"){
		dyniframesize(['TOFrame4','mainFrame']);//公共功能，框架元素自适应
	}
	if(FLAG == "5"){
		dyniframesize(['TOFrame5','mainFrame']);//公共功能，框架元素自适应
	}
	if(FLAG == "6"){
		dyniframesize(['TOFrame6','mainFrame']);//公共功能，框架元素自适应
	}
	if(FLAG == "7"){
		dyniframesize(['TOFrame7','mainFrame']);//公共功能，框架元素自适应
	}
	//intoiframesize('TOFrame');
});
</script>
<BZ:body property="data" codeNames="PROVINCE;ETXB;BCZL;">
	<table class="bz-edit-data-table">
		<tr>
			<td class="bz-edit-data-title">省份</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE"/>
			</td>
			<td class="bz-edit-data-title">福利院</td>
			<td class="bz-edit-data-value" colspan="5">
				<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title" width="10%">姓名</td>
			<td class="bz-edit-data-value" width="15%">
				<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title" width="10%">性别</td>
			<td class="bz-edit-data-value" width="15%">
				<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
			</td>
			<td class="bz-edit-data-title" width="10%">出生日期</td>
			<td class="bz-edit-data-value" width="15%">
				<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-title" width="10%">病残种类</td>
			<td class="bz-edit-data-value" width="15%">
				<BZ:dataValue field="SN_TYPE" defaultValue="" onlyValue="true" codeName="BCZL"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">病残诊断</td>
			<td class="bz-edit-data-value" colspan="7">
				<BZ:dataValue field="DISEASE_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
		if("4".equals(FLAG)){
		%>
		<tr>
			<td class="bz-edit-data-value" colspan="8">
				抚育计划（中文）<br/><br/>
				<BZ:dataValue field="TENDING_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%    
		}if("5".equals(FLAG)){
	    %>
		<tr>
			<td class="bz-edit-data-value" colspan="8">
				抚育计划（英文）<br/><br/>
				<BZ:dataValue field="TENDING_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%       
		}if("6".equals(FLAG)){
	    %>
		<tr>
			<td class="bz-edit-data-value" colspan="8">
				组织意见（中文）<br/><br/>
				<BZ:dataValue field="OPINION_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
		}if("7".equals(FLAG)){
	    %>
		<tr>
			<td class="bz-edit-data-value" colspan="8">
				组织意见（英文）<br/><br/>
				<BZ:dataValue field="OPINION_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
		}
		%>
	</table>
</BZ:body>
</BZ:html>
