<%@page import="com.hx.upload.datasource.vo.Data"%>
<%@page import="com.hx.upload.datasource.vo.DataList"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.upload.datasource.DiskpathManager"%>
<%@page import="com.hx.upload.datasource.DatasourceManager"%>
<%@page import="com.hx.upload.vo.AttType"%>
<%
	String path = request.getContextPath();
	DataList dataList = (DataList)request.getAttribute("dataList");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>�������͹���</title>
<link rel="stylesheet" type="text/css" href="<%=path %>/uploadComponent/admin/skin/css/base.css">
<script type="text/javascript" src="<%=path %>/uploadComponent/admin/js/public.js"></script>
<script language="javascript">


//���ѡ���ļ����ļ���
function getCheckboxItem()
{
	var allSel="";
	if(document.form2.id.value) return document.form2.id.value;
	for(i=0;i<document.form2.id.length;i++)
	{
		if(document.form2.id[i].checked)
		{
			if(allSel=="")
				allSel=document.form2.id[i].value;
			else
				allSel=allSel+"`"+document.form2.id[i].value;
		}
	}
	return allSel;
}

//���ѡ������һ����id
function getOneItem()
{
	var allSel="";
	if(document.form2.id.value) return document.form2.id.value;
	for(i=0;i<document.form2.id.length;i++)
	{
		if(document.form2.id[i].checked)
		{
				allSel = document.form2.id[i].value;
				break;
		}
	}
	return allSel;
}
</script>
</head>
<body leftmargin="8" topmargin="8" background='<%=path %>/uploadComponent/admin/skin/images/allbg.gif'>

<!--  ����ת��λ�ð�ť  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
<tr>
 <td height="26" background="<%=path %>/uploadComponent/admin/skin/images/newlinebg3.gif">
  <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td align="right">
    <input type='button' class="coolbg np" onClick="add_att_type_dialog('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>')" value='��Ӹ�������' />
    <input type='button' class="coolbg np" onClick="opra_datasource_dialog('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>')" value='����Դ����' />
    <input type='button' class='coolbg np' onClick="opra_disk_path_dialog('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>')" value='����·������' />
    <input type='button' class='coolbg np' onClick="rebuildTable('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>')" value='�ؽ����ݿ��' />
    <input type='button' class='coolbg np' onClick="flashDownload('<%=path %>','<%=DatasourceManager.getRequestPrefix() %>')" value='Flash�������' />
 </td>
 </tr>
</table>
</td>
</tr>
</table>
  
<!--  �����б�   -->
<form name="form2">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="14" background="<%=path %>/uploadComponent/admin/skin/images/tbg.gif">&nbsp;���������б�&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22">
	<td>���</td>
	<td>���</td>
	<td>��������</td>
	<td>�������ʹ���</td>
	<td>�洢����</td>
	<td>������С</td>
	<td>����ģʽ</td>
	<td>������ʽ</td>
	<td>����·��</td>
	<td>��������</td>
	<td>��������</td>
	<!-- 
	<td>ģ������</td>
	<td>Ӧ������</td>
	 -->
	<td>����</td>
</tr>

<%
	if(dataList != null && dataList.size() > 0){
		for(int i = 0 ; i < dataList.size(); i++){
			Data data = dataList.getData(i);
%>

<tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#E7E7E7';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22" >
	<td><input name="id" type="checkbox" id="id" value="<%=data.getString(AttType.CODE) %>" class="np"></td>
	<td><%=i+1 %></td>
	<td><%=data.getString(AttType.ATT_TYPE_NAME) %></td>
	<td><%=data.getString(AttType.CODE) %></td>
	<td><%=1 == data.getInt(AttType.STORE_TYPE)?"����":"���ݿ�"%></td>
	<td><%=data.getInt(AttType.ATT_SIZE) %>MB</td>
	<td><%=1 == data.getInt(AttType.ATT_MORE)?"������":"�฽��" %></td>
	<td><%=data.getString(AttType.ATT_FORMAT) %></td>
	<td>
		<%
			if(1 == data.getInt(AttType.STORE_TYPE)){
		%>
		<%=DiskpathManager.getDiskPath() + data.getString(AttType.ENTITY_NAME) + "/" %>
		<%
			}
		%>
	</td>
	<td>
		<%
			/* if(1 == data.getInt(AttType.STORE_TYPE)){
				if(1 == data.getInt(AttType.FILE_SORT_WEEK)){
					out.println("����");
				}
				if(2 == data.getInt(AttType.FILE_SORT_WEEK)){
					out.println("����");
				}
				if(3 == data.getInt(AttType.FILE_SORT_WEEK)){
					out.println("����");
				}
			} */
		%>
		<%=data.getString(AttType.FILE_SORT_WEEK) %>
	</td>
	<td><%=data.getString(AttType.ENTITY_NAME) %></td>
	<!-- 
	<td><%-- <%=data.getString(AttType.MOD_NAME,"") %> --%></td>
	<td><%-- <%=data.getString(AttType.APP_NAME,"") %> --%></td>
	 -->
	<td>
		<a href="JavaScript:void(0);" style="text-decoration: none;" onclick="mod_att_type_dialog('<%=path %>','<%=data.getString(AttType.CODE) %>','<%=DatasourceManager.getRequestPrefix() %>');">�޸�</a>
	 | 
	 	<a href="JavaScript:void(0);" style="text-decoration: none;" onclick="del_att_type('<%=path %>','<%=data.getString(AttType.CODE) %>','<%=DatasourceManager.getRequestPrefix() %>');">ɾ��</a>
	</td>
</tr>

<%
		}
	}else{
%>
<tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22" >
	<td colspan="14" style="color: red;font-weight: bold;">�޸���������Ϣ�������ʵ�ʲ�����ϣ���鿴����Դ��������ã�</td>
</tr>
<%
	}
%>
<!-- ���� 
<tr bgcolor="#FAFAF1">
<td height="28" colspan="14">
	&nbsp;
	<a href="javascript:selAll()" class="coolbg">ȫѡ</a>
	<a href="javascript:noSelAll()" class="coolbg">ȡ��</a>
	<a href="javascript:void(0);" onclick="deleteBatch('<%=request.getContextPath() %>','<%=DatasourceManager.getRequestPrefix() %>')" class="coolbg">&nbsp;ȫ��ɾ��&nbsp;</a>
	<a href="javascript:updateArc(0)" class="coolbg">&nbsp;����&nbsp;</a>
	<a href="javascript:checkArc(0)" class="coolbg">&nbsp;���&nbsp;</a>
	<a href="javascript:adArc(0)" class="coolbg">&nbsp;�Ƽ�&nbsp;</a>
	<a href="javascript:moveArc(0)" class="coolbg">&nbsp;�ƶ�&nbsp;</a>
</td>
</tr>
-->

<!--��ҳ���� -->
<tr align="right" bgcolor="#EEF4EA">
	<td height="36" colspan="14" align="center">
		<!--��ҳ���� -->
	</td>
</tr>
</table>

</form>
</body>
</html>