<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html; charset=gb2312"%>
<%
	String contextpath = request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextpath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
<title>�ޱ����ĵ�</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #F4F9FF;
}
-->
</style>
</head>
<script>
function _retrieve(){
	alert("��ѯ");
}
function newGroup(){
	document.location.href="xjsjy.html";
}
</script>
<body>
<form>
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="text01" >

  
      <tr>
        <td height="25" colspan="4">
				  <div id="query">
					  ����Դ���ƣ�&nbsp;
					  <input name="enterpriseid" type="text" class="queryinput" size="11" maxlength="9" />
					  &nbsp;
					  ����Դ���ͣ�&nbsp;
					  <select name="DS_TYPE">
                            <option value="" selected >��-ȫ��-��</option>
                            
                            <option value="DS_TYPE_JDBC" >JDBC����Դ</option>
                            
                            <option value="DS_TYPE_JNDI" >JNDI����Դ</option>
                            
                            <option value="DS_TYPE_OLAP" >OLAP����Դ</option>
                            
                            <option value="DS_TYPE_EXCEL" >EXCEL����Դ</option>
                            
                            <option value="DS_TYPE_XML" >XML����Դ</option>
                            
                            <option value="DS_TYPE_TXT" >TXT����Դ</option>
                            
                            <option value="DS_TYPE_SOCKET" >SOCKET����Դ</option>
                            
                            <option value="DS_TYPE_WEBSERVICE" >WEBSERVICE����Դ</option>
                            
                            <option value="DS_TYPE_MQ" >MQ����Դ</option>
                            			
                    </select>
					  <input type="button" name="submit" value="��ѯ(Q)" class="input01" accesskey="Q" onclick="_retrieve();"/ tabindex="100" Onkeydown="">
				  </div>		  
				</td>
</tr>	
 <tr>
        <td height="18" colspan="4">
			&nbsp;	 	  
		</td>
</tr>
 <tr>
      <td colspan="4">
		<div id="primarydata" style="width:100%; overflow:hidden" >
		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#9CC6F7" class="text01">
	    <tr height="22">
		  <th width="5%"><div align="center">&nbsp;</div></th>
	      <th width="5%"><div align="center">���</div></th>
	      <th width="20%"><div align="center">����Դ����</div></th>
	      <th width="20%"><div align="center">����Դ����</div></th> 
		  <th width="20%"><div align="center">����Դ����</div></th>   
		  <th width="20%"><div align="center">����ʱ��</div></th>   
		  <th width="10%"><div align="center">���Ӳ���</div></th>         	
      </tr>
      
      <tr height="22" >
         <td class="listdata"><div align="center"><input type="checkbox" name="checkbox" value="checkbox" class="input"></div></td>
        <td class="listdata"><div align="center">1</div></td>
        <td class="listdata"><div align="left">XML������</div></td>       
        <td class="listdata"><div align="left">XML����Դ</div></td>  
		<td class="listdata"><div align="left">XML������</div></td> 
		<td class="listdata"><div align="left">2006-04-20</div></td>
		<td class="listdata"><div align="center"><input type="button" name="test" value="����" onClick="alert('��������Դ����');" class="input01"></div></td>        				
     
      </tr>	  		  		  		  
    </table>
		</div>
		</td>
    </tr>
    <tr>
      <td colspan="4" height="24"></td>
    </tr>
  <tr><td align="center" colspan="4"><input type="button" name="addButton" value="�½�" class="input01" onClick="newGroup();">&nbsp;<input type="button" name="delButton" value="ɾ��" class="input01" onClick="alert('ɾ��');"></td></tr>
</table>

</form>
</body>
</html>