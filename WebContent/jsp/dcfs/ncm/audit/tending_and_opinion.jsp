<%
/**   
 * @Title: tending_and_opinion.jsp
 * @Description: �����ƻ�����֯���
 * @author xugy
 * @date 2014-10-30����1:05:23
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
	<title>�����ƻ�����֯���</title>
	<BZ:webScript edit="true" tree="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	setSigle();
	var FLAG = "<%=FLAG%>";
	if(FLAG == "4"){
		dyniframesize(['TOFrame4','mainFrame']);//�������ܣ����Ԫ������Ӧ
	}
	if(FLAG == "5"){
		dyniframesize(['TOFrame5','mainFrame']);//�������ܣ����Ԫ������Ӧ
	}
	if(FLAG == "6"){
		dyniframesize(['TOFrame6','mainFrame']);//�������ܣ����Ԫ������Ӧ
	}
	if(FLAG == "7"){
		dyniframesize(['TOFrame7','mainFrame']);//�������ܣ����Ԫ������Ӧ
	}
	//intoiframesize('TOFrame');
});
</script>
<BZ:body property="data" codeNames="PROVINCE;ETXB;BCZL;">
	<table class="bz-edit-data-table">
		<tr>
			<td class="bz-edit-data-title">ʡ��</td>
			<td class="bz-edit-data-value">
				<BZ:dataValue field="PROVINCE_ID" defaultValue="" onlyValue="true" codeName="PROVINCE"/>
			</td>
			<td class="bz-edit-data-title">����Ժ</td>
			<td class="bz-edit-data-value" colspan="5">
				<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title" width="10%">����</td>
			<td class="bz-edit-data-value" width="15%">
				<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
			</td>
			<td class="bz-edit-data-title" width="10%">�Ա�</td>
			<td class="bz-edit-data-value" width="15%">
				<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" codeName="ETXB"/>
			</td>
			<td class="bz-edit-data-title" width="10%">��������</td>
			<td class="bz-edit-data-value" width="15%">
				<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="date"/>
			</td>
			<td class="bz-edit-data-title" width="10%">��������</td>
			<td class="bz-edit-data-value" width="15%">
				<BZ:dataValue field="SN_TYPE" defaultValue="" onlyValue="true" codeName="BCZL"/>
			</td>
		</tr>
		<tr>
			<td class="bz-edit-data-title">�������</td>
			<td class="bz-edit-data-value" colspan="7">
				<BZ:dataValue field="DISEASE_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
		if("4".equals(FLAG)){
		%>
		<tr>
			<td class="bz-edit-data-value" colspan="8">
				�����ƻ������ģ�<br/><br/>
				<BZ:dataValue field="TENDING_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%    
		}if("5".equals(FLAG)){
	    %>
		<tr>
			<td class="bz-edit-data-value" colspan="8">
				�����ƻ���Ӣ�ģ�<br/><br/>
				<BZ:dataValue field="TENDING_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%       
		}if("6".equals(FLAG)){
	    %>
		<tr>
			<td class="bz-edit-data-value" colspan="8">
				��֯��������ģ�<br/><br/>
				<BZ:dataValue field="OPINION_CN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
		}if("7".equals(FLAG)){
	    %>
		<tr>
			<td class="bz-edit-data-value" colspan="8">
				��֯�����Ӣ�ģ�<br/><br/>
				<BZ:dataValue field="OPINION_EN" defaultValue="" onlyValue="true"/>
			</td>
		</tr>
		<%
		}
		%>
	</table>
</BZ:body>
</BZ:html>
