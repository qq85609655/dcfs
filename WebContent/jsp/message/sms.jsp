<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.common.Constants"%>
<%@page import="hx.taglib.TagTools"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String resourcepath=TagTools.getResourcePath(request,"");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<BZ:html>   
<BZ:head>
<title>����Ϣ����</title>
<BZ:script isList="true" isAjax="true" isDate="true"/>
    <script type="text/javascript">
      var msg = new Hint(false);
      function _autochange(len,th){
    		if(th.value.length==len)
    		{
    			var next = th.nextSibling.nextSibling;
    			next.focus();
    		}
    	}
  	
    </script>
  <style type="text/css">
   body{
   background-color:#F6F9FD;
 
   }
      form {
      margin: 0;
      }
      .editor {
      margin-top: 5px;
      margin-bottom: 5px;
      }
    </style>
	<script type="text/javascript">
function _checkAjaxRecMan(obj)
{
	//inputValue = obj.value;
	var spanPhone = document.getElementById("checkRecPhone");  
	var recMan = document.getElementById("P_REC_MAN");
	//��������У���ֻ�����
	 var flag = "true";
	 var phone=recMan.value; 
	   if(!/^((13[0-9]{1})|159|153)+\d{8}$/.test(phone)) 
	   { 
		   flag = "false";
	   } 
	   if("false"==flag)
	   {
		   spanPhone.style.display="inline";
		   recMan.focus(); 
		   return false;
	   }
	   else
	   {
		   spanPhone.style.display="none";
		   return true;
	   }
}
function _sub(){
  	if(_check(document.srcForm))
	  {
   	 	 document.srcForm.action=path+"message/sendMessage.action";
   	 	 document.srcForm.submit();
   	  }
  }
	</script>
</BZ:head>
<BZ:body>
<form name="srcForm" id="srcForm" method="post" action="<%=path%>/message/sendMessage.action" Enctype ="multipart/form-data">
<BZ:frameDiv className="kuangjia" property="clueTo">
<div class="heading">д����</div>
<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
    <tr>
      <td align="right"><BZ:notnullspan></BZ:notnullspan>�ռ��ˣ�</td>
      <td>
         <BZ:input size="30" onblur="_checkAjaxRecMan(this)" field="REC_MAN" defaultValue=""  prefix="P_" formTitle="��ϵ��" notnull="��ϵ�˱�����д" maxlength="20"/>
             <span id="checkRecPhone" style="display:none;color:red">�����ʽ���ԣ�����������</span>
      </td>
    </tr>   
    <tr>
      <td align="right"><BZ:notnullspan></BZ:notnullspan>�������⣺</td>
      <td>
         <BZ:input size="30" field="MSG_SUBJECT" defaultValue="��ɫԤ����Ϣ����"  prefix="P_" formTitle="��Ϣ����" notnull="��Ϣ���������д" maxlength="100" restriction="hasSpecialChar"/>
      </td>
    </tr> 
    <tr> 
      <td align="right"><BZ:notnullspan></BZ:notnullspan>�������ݣ�</td>
      <td>
            <textarea id="content1" name="msgContent" style="width:580px;height:250px;"></textarea>
      </td>
    </tr>
     <tr>
      <td colspan="2" align="center">�ӳٷ���ʱ��(Сʱ)��
     	<BZ:input size="3" onkeyup="" field="SEND_TIMER"  formTitle="ָ������ʱ��"  maxlength="3" restriction="int" prefix="P_" defaultValue="0"/>
      	&nbsp;&nbsp;&nbsp;����ʧ�ܴ���(��)��
      	<BZ:input size="3" onkeyup="" field="SEND_FAIL_NUM" formTitle="����ʧ�ܴ���"  maxlength="3" restriction="int" prefix="P_" defaultValue="30"/>
      </td>
    </tr>   
    <tr><td colspan="2"><div class="down"><input onclick="_sub()" type="button" value="����" class="btn_hui"/></div></td></tr>
  </table> 
  </BZ:frameDiv>
</form>
</BZ:body>
</BZ:html>


