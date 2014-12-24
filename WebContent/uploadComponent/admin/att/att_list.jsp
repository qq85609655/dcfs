<%@page import="com.hx.upload.datasource.DatasourceManager"%>
<%@page import="com.hx.upload.vo.AttType"%>
<%@page import="com.hx.upload.vo.Att"%>
<%@page import="com.hx.upload.datasource.vo.Data"%>
<%@page import="com.hx.upload.datasource.vo.DataList"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	DataList dataList = (DataList)request.getAttribute("dataList");
	DataList attTypes = (DataList)request.getAttribute("attTypes");
	String attTypeCode = (String)request.getAttribute("ATT_TYPE_CODE");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>�������͹���</title>
<link rel="stylesheet" type="text/css" href="<%=path %>/uploadComponent/admin/skin/css/base.css">
<script language="javascript">
function selAll()
{
	for(i=0;i<document.getElementsByName("xuanze").length;i++)
	{
		if(!document.getElementsByName("xuanze")[i].checked)
		{
			document.getElementsByName("xuanze")[i].checked=true;
		}
	}
}

function noSelAll()
{
	for(i=0;i<document.getElementsByName("xuanze").length;i++)
	{
		if(document.getElementsByName("xuanze")[i].checked)
		{
			document.getElementsByName("xuanze")[i].checked=false;
		}
	}
}

function _delete(){
	  var sfdj=0;
	   var uuid="";
	   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	   if(document.getElementsByName('xuanze')[i].checked){
	   uuid=uuid+document.getElementsByName('xuanze')[i].value+"@";
	   sfdj++;
	   }
	  }
	  if(sfdj=="0"){
	   alert('��ѡ��Ҫɾ��������');
	   return;
	  }else{
	  if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')){
	  var code = document.getElementById("code").value;
	  code = encodeURI(encodeURI(code));
	  window.location.href = "<%=path %>/att/Att.<%=DatasourceManager.getRequestPrefix() %>?param=delBatchAtts&ATTS_IDS="+uuid+"&ATT_TYPE_CODE="+code;
	  }else{
	  return;
	  }
	  }
}

//���渽�����ͶԻ���
function add_att_type_dialog(){
	window.showModalDialog("add_att_type.jsp",this,"dialogWidth=800px;dialogHeight=230px;scroll=no");
}

//����Դ����Ի���
function opra_datasource_dialog(){
	window.showModalDialog("opra_datasource.jsp",this,"dialogWidth=800px;dialogHeight=250px;scroll=no");
}

//���̹���Ի���
function opra_disk_path_dialog(){
	window.showModalDialog("opra_disk_path.jsp",this,"dialogWidth=800px;dialogHeight=120px;scroll=no");
}

//�޸ĸ������ͶԻ���
function mod_att_type_dialog(id){
	window.showModalDialog("mod_att_type.jsp?id="+id,this,"dialogWidth=800px;dialogHeight=230px;scroll=no");
}

function changeAttType(obj){
	var code = obj.value;
	code = encodeURI(encodeURI(code));
	document.getElementById("ATT_TYPE_CODE").value = code;
	window.location.href = "<%=path %>/att/Att.<%=DatasourceManager.getRequestPrefix() %>?param=queryAtts&ATT_TYPE_CODE="+code;
}

function delAtt(id,typeId){
	window.location.href = "<%=path %>/att/Att.<%=DatasourceManager.getRequestPrefix() %>?param=delAtt&ID="+id+"&ATT_TYPE_ID="+typeId;
}
</script>
</head>
<body leftmargin="8" topmargin="8" background='<%=path %>/uploadComponent/admin/skin/images/allbg.gif'>

<!--  ������  
<form name='form3' action='' method='get'>
<input type='hidden' name='dopost' value='' />
<table width='98%'  border='0' cellpadding='1' cellspacing='1' bgcolor='#CBD8AC' align="center" style="margin-top:8px">
  <tr bgcolor='#EEF4EA'>
    <td background='<%=path %>/uploadComponent/admin/skin/images/wbg.gif' align="left">
      <table border='0' cellpadding='0' cellspacing='0'>
        <tr>
          <td width='90' align='center'>����������</td>
          <td width='160'>
          <select name='cid' style='width:150'>
          <option value='0'>ѡ������...</option>
          	<option value='1'>����</option>
          </select>
        </td>
        <td width='70'>
          �ؼ��֣�
        </td>
        <td width='160'>
          	<input type='text' name='keyword' value='' style='width:150px' />
        </td>
        <td width='110'>
    		<select name='orderby' style='width:80px'>
            <option value='id'>����...</option>
            <option value='pubdate'>����ʱ��</option>
      	</select>
        </td>
        <td>
          <input name="imageField" type="image" src="<%=path %>/uploadComponent/admin/skin/images/frame/search.gif" width="45" height="20" border="0" class="np" />
        </td>
       </tr>
      </table>
    </td>
  </tr>
</table>
</form>
<br>
-->

<!--  ����ת��λ�ð�ť  -->
<input id="ATT_TYPE_CODE" type="hidden" value='<%=request.getAttribute("ATT_TYPE_CODE")!=null?request.getAttribute("ATT_TYPE_CODE"):"" %>' name="ATT_TYPE_CODE">
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
<tr>
 <td height="26" background="<%=path %>/uploadComponent/admin/skin/images/newlinebg3.gif">
  <table width="98%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td align="left" style="padding-left: 5px;">
  <select id="code" name="code" onchange="changeAttType(this);">
	<option value="">ȫ������</option>
	<%
		if(attTypes != null && attTypes.size() > 0){
		    for(int i = 0; i < attTypes.size(); i++){
		        Data data = attTypes.getData(i);
	%>
	<option <%=data.getString(AttType.CODE).equals(attTypeCode)?"selected='selected'":"" %> value="<%=data.getString(AttType.CODE) %>"><%=data.getString(AttType.ATT_TYPE_NAME) %></option>
	<%
		    }
		}
	%>
  </select>
  </td>
  <td align="right" style="display: none;">
    <input type='button' class="coolbg np" onClick="add_att_type_dialog()" value='����ͳ��' />
    <input type='button' class="coolbg np" onClick="opra_datasource_dialog()" value='����ͳ��' />
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<!--  �����б�   -->
<form name="form2">
<input type="hidden" id="ATTS_IDS" name="ATTS_IDS" value=""/>
<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="12" background="<%=path %>/uploadComponent/admin/skin/images/tbg.gif">&nbsp;�����б�&nbsp;</td>
</tr>
<tr align="center" bgcolor="#FAFAF1" height="22">
	<td>ѡ��</td>
	<td>���</td>
	<td>��������</td>
	<td>������С(Byte)</td>
	<td>����·��</td>
	<td>�����и�����</td>
	<td>�ϴ�����</td>
	<td>״̬</td>
	<td>������������</td>
	<td>�洢����</td>
	<td>����</td>
</tr>
<%
	if(dataList != null && dataList.size() > 0){
	    for(int i = 0; i < dataList.size(); i++){
	        Data data = dataList.getData(i);
%>
<tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22" >
	<td><input name="xuanze" type="checkbox" id="xuanze" value='<%=data.getString(Att.ID)+"!"+data.getString(Att.ATT_TYPE_ID,"") %>' class="np"></td>
	<td><%=i+1 %></td>
	<td><%=data.getString(Att.ATT_NAME,"") %></td>
	<td><%=data.getString(Att.ATT_SIZE) %> Byte</td>
	<td><%=data.getString(Att.FILESYSTEM_PATH,"") %></td>
	<td><%=data.getString(Att.RANDOM_NAME,"") %></td>
	<td><%=data.getString(Att.CREATE_TIME) %></td>
	<td><%="1".equals(data.getString(Att.STATUS))?"�ݴ�":"����" %></td>
	<td><%=data.getString(AttType.ATT_TYPE_NAME,"") %></td>
	<td><%="1".equals(data.getString(AttType.STORE_TYPE))?"����":"���ݿ�" %></td>
	<td><a href="JavaScript:delAtt('<%=data.getString(Att.ID) %>','<%=data.getString(Att.ATT_TYPE_ID) %>');" style="text-decoration: none;">ɾ��</a></td>
</tr>
<%
	    }
	}else{
%>
<tr align='center' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22" >
	<td colspan="14" style="color: red;font-weight: bold;">�޸�����Ϣ�������ʵ�ʲ�����ϣ���鿴����Դ��������ã�</td>
</tr>
<%
	}
%>

<!--��ҳ���� -->
<tr align="right" bgcolor="#EEF4EA">
	<td height="36" colspan="12" align="left">
		<!--��ҳ���� -->
		&nbsp;
		<a href="javascript:selAll()" class="coolbg">ȫѡ</a>
		<a href="javascript:noSelAll()" class="coolbg">ȡ��</a>
		<a href="javascript:_delete()" class="coolbg">&nbsp;ȫ��ɾ��&nbsp;</a>
		<!-- ���� 
		<a href="javascript:updateArc(0)" class="coolbg">&nbsp;����&nbsp;</a>
		<a href="javascript:checkArc(0)" class="coolbg">&nbsp;���&nbsp;</a>
		<a href="javascript:adArc(0)" class="coolbg">&nbsp;�Ƽ�&nbsp;</a>
		<a href="javascript:moveArc(0)" class="coolbg">&nbsp;�ƶ�&nbsp;</a>
		-->
	</td>
</tr>
</table>

</form>
</body>
</html>