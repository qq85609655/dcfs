
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
DataList datalist = (DataList)request.getAttribute("dataList");
int pwdCount= datalist.size();
request.setAttribute("data",new Data());
%>
<BZ:html>
<BZ:head>
<title>�˺��������ҳ��</title>
<BZ:script tree="true" isEdit="true"/>
<script type="text/javascript" language="javascript">
	function tijiao()
	{
		for(var i=0;i<<%=pwdCount%>;i++){
			var pi=document.getElementsByName("DEFAULT_PWD_"+i)[0];
			var ri=_getRule(i);
			//alert(ri);
			if(pi.value!='' && ri!=''){
				if(!pi.value.match(new RegExp(ri))){
					alert("Ĭ�����벻���Ϲ���"+pi.value);
					pi.focus();
					return;
				}
			}
		}
		
		document.srcForm.action=path+"pwdPolicy/setUp.action";
	 	document.srcForm.submit();
	}
	function _back()
	{
	    document.srcForm.action=path+"securityPolicy/securityPolicyList.action";
	    document.srcForm.submit();
	}
	
	function _getRule(i){
		var ri=document.getElementsByName("RULE_REGULAR_STR_"+i);
		//alert(ri);
		//alert(ri.length);
		for(var j=0;j<ri.length;j++){
			if(ri[j].checked){
				return ri[j].value.split(',,,')[0];
			}
		}
		return "";
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<input name="pwdCount" type="hidden" value="<%=pwdCount%>"/>
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="heading">�����������</div>
<table class="contenttable">
<tr>
<td>
<%
	   
	   if(datalist.size()>0)
	   {
		   for(int i=0;i<datalist.size();i++)
		   {
			   Data data = datalist.getData(i); 
	%>

	<fieldset style="margin-top: 5px">
	<legend style="font-weight: bolder;font-size: 14px"><%=data.getString("TYPENAME","") %></legend>
	<table cellspacing="1">
		<tr>
			<td style="width:20%;text-align: right;">
				��¼����ɳ��Դ�����
			</td>
			<td style="width:30%;text-align: left;">
				<input name="LOGIN_RETRY_MAX_NUM_<%=i%>" type="text" value="<%=data.getString("LOGIN_RETRY_MAX_NUM","0") %>"/>
				<input name="ID_<%=i%>" type="hidden" value="<%=data.getString("ID","") %>"/>
				<input name="ACCOUNT_TYPE_<%=i%>" type="hidden" value="<%=data.getString("TYPEID") %>"/> 
			</td>
			<td style="width:20%;text-align: right;">
				������
			</td>
			<td style="width:30%;text-align: left;">
				<input name="MEMO_<%=i%>" type="text" value="<%=data.getString("MEMO","") %>"/>
			</td>
		</tr>
		<tr>
			<td style="width:20%;text-align: right;">
				������С���ȣ�
			</td>
			<td>
				<input name="MIN_LENGTH_<%=i%>" type="text" value="<%=data.getString("MIN_LENGTH","")%>"/> 
			</td>
			<td style="width:20%;text-align: right;">
			          ������󳤶ȣ�
			</td>
			<td>
				<input name="MAX_LENGTH_<%=i%>" type="text" value="<%=data.getString("MAX_LENGTH","")%>"/>
			</td>
		</tr>
		<tr>			 
			<td style="width:20%;text-align: right;">
				���븴�Ӽ���
				
			</td>
			<td colspan="3" >
				<%
				   DataList gzlist= (DataList)request.getAttribute("gzList");
				   if(gzlist.size()>0)
				   {
					   for(int j=0;j<gzlist.size();j++)
					   {
						   Data gzdata = gzlist.getData(j); 
				%>
				<input type="radio" name="RULE_REGULAR_STR_<%=i%>" value="<%= gzdata.getString("PWD_REGUlAR_STR")%>,,,<%= gzdata.getString("CNAME")%>" <%if(gzdata.getString("PWD_REGUlAR_STR").equals(data.getString("RULE_REGULAR_STR"))) {%>checked<%} %>/><%=gzdata.getString("CNAME") %>&nbsp;&nbsp;
				<% 
					   }
				   }
				%>
			</td>
		</tr>
		<tr>
		    <td style="width:20%;text-align: right;">
				����޸����ڣ�
			 </td>
			 <td>
			 	<input name="CHANGE_PERIOD_<%=i%>" style="width: 80px" type="text" value="<%=data.getString("CHANGE_PERIOD","")%>"/>��
			 </td>
			<td style="width:20%;text-align: right;">
				Ĭ�����룺
			</td>
			<td>
				<input name="DEFAULT_PWD_<%=i%>" type="text" value="<%=data.getString("DEFAULT_PWD","")%>"/>
			</td>
		 </tr>
		 <tr>
			<td style="width:20%;text-align: right;" nowrap="nowrap">
				�״ε�¼�Ƿ�����޸����룺
			</td>
			<td>
				<input name="IS_MUST_CHG_DEFAULT_PWD_<%=i%>" type="radio" value="1" <%if("1".equals(data.getString("IS_MUST_CHG_DEFAULT_PWD"))) {%>checked<%} %>/>�� 
				&nbsp;&nbsp;&nbsp;&nbsp;<input name="IS_MUST_CHG_DEFAULT_PWD_<%=i%>" type="radio" value="2" <%if("2".equals(data.getString("IS_MUST_CHG_DEFAULT_PWD"))) {%>checked<%} %>/>��
			</td>
			<td style="width:20%;text-align: right;">
				״̬��
			</td>
			<td>
				<input type="radio" name="STATUS_<%=i%>" value="1" <%if("1".equals(data.getString("STATUS"))) {%>checked<%} %>/>����  
				&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="STATUS_<%=i%>" value="0" <%if("0".equals(data.getString("STATUS"))) {%>checked<%} %>/>ͣ��
			</td>
		 </tr>
	</table>
	</fieldset>
	<%
		   }
	   }else
	   {
	%>
	<fieldset>
	<legend style="font-weight: bolder;font-size: 14px">δ���˻�����</legend>
	<span>���������ú��˻�����</span>
	<br>
	</fieldset>
	<%
	}
	%>
	</td>
 </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="����" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="reset" value="����" class="button_reset" />&nbsp;&nbsp;<input type="button" value="����" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>