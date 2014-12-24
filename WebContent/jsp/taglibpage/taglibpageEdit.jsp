<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<BZ:html>
<BZ:head>
<title>添加页面</title>
<BZ:script isEdit="true" isDate="true"/>
<script type="text/javascript">
  
function save(){
	document.srcForm.action=path+"TaglibPageServlet?method=save";
	pageshow(document.srcForm);
}
function _back() {
	document.srcForm.action=path+"TaglibPageServlet";
	document.srcForm.submit();
}
</script>
</BZ:head>
<BZ:body codeNames="SEX" property="DATA">

<BZ:form name="srcForm" method="post">
<BZ:input field="UUID" type="hidden" defaultValue="" prefix="P_"/>
<div class="kuangjia">
<div class="heading">添加</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">姓名</td>
<td width="20%"><BZ:input accesskey="Q" formTitle="姓名" field="NAME" defaultValue="" prefix="P_" type="string" notnull="必须填写"/></td>
<td width="10%">性别</td>
<td width="20%"><BZ:select field="SEX"  formTitle="性别" notnull="必须选择" codeName="SEX" isCode="true" prefix="P_">
    <option value="">--请选择--</option>
    </BZ:select></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>出生年月</td>
<td><BZ:input field="BIRTHDAY" type="DateTime"  prefix="P_"/></td>
<td>年龄</td>
<td><BZ:input field="AGE" prefix="P_" type="String" defaultValue="" maxlength="3" restriction="number"></BZ:input></td>
<td></td>
</tr>
<tr>
<td></td>
<td>学历</td>
<td><BZ:input field="SCHOOLRECORD" prefix="P_" type="String"></BZ:input></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td></td>
<td>简历</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_RESUME"><BZ:dataValue field="RESUME" onlyValue="true" defaultValue="无"/></textarea></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="save()"/>&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>