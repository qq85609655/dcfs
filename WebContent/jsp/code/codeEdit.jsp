<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.DataList"%>
<%
DataList codeList=(DataList)request.getAttribute("codeList");
Data codedata=(Data)request.getAttribute("data");
String CODESORTID=(String)request.getAttribute("CODESORTID");

String noback=request.getParameter("noback");
if(noback==null){
	noback="";
}

%>
<%@page import="hx.database.databean.Data"%>
<BZ:html>
<BZ:head>
<title>���ҳ��</title>
<BZ:script/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
			}
	document.srcForm.action=path+"CodeSortServlet?method=savecode";
 	document.srcForm.submit();
	}
	function _back(){
 	document.srcForm.action=path+"CodeSortServlet?method=codelist";
 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="P_CODESORTID" value="<%=CODESORTID%>"/>
<input type="hidden" name="P_CODEID" value="<%=codedata.getString("CODEID","")%>"/>
<input type="hidden" name="CODESORTID" value="<%=CODESORTID%>"/>
<input type="hidden" name="P_CODEVALUE" value="<%=codedata.getString("CODEVALUE","") %>"/>
<input type="hidden" name="noback"  value="<%=noback %>"/>

<div class="kuangjia">
<div class="heading">���</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">��������</td>
<td width="20%"><BZ:input field="CODENAME" prefix="P_" notnull="�������������" formTitle="��������"/></td>
<td width="10%">����ֵ</td>
<td width="20%"><input type="text" name="CODEVALUE" value="<%=codedata.getString("CODEVALUE","") %>" disabled="disabled"/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>��ĸ��</td>
<td><input type="text" name="P_CODELETTER" value="<%=codedata.getString("CODELETTER","") %>"/></td>
<td>�����</td>
<td><input type="text" name="P_PNO" value="<%=codedata.getString("PNO","") %>"/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>�ϼ�����</td>
<td><BZ:select field="PARENTCODEVALUE"  formTitle="" codeName="CODESORTID" isCode="true" prefix="P_">
    <option value="">--��ѡ��--</option>
    </BZ:select></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td></td>
<td>��������</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_CODEDESC"><%=codedata.getString("CODEDESC","") %></textarea></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="����" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="����" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>