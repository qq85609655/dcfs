
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String APP_ID=(String)request.getAttribute("APP_ID");
if(APP_ID==null){
	APP_ID="";
}
String PMOUDLE=(String)request.getAttribute("PMOUDLE");
if(PMOUDLE==null){
    PMOUDLE="";
}
String PNAME=(String)request.getAttribute("PNAME");
if(PNAME==null){
    PNAME="";
}
request.setAttribute("data",new Data());
%>
<BZ:html>
<BZ:head>
<title>ģ�����ҳ��</title>
<BZ:script tree="true"/>
<script type="text/javascript" language="javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
			}else{
				if(confirm('�Ƿ�Ҫ���ɲ˵�?')){
					document.srcForm.action=path+"module/resourceModuleAdd.action?flag=1";
					document.srcForm.submit();
				}	else{
					document.srcForm.action=path+"module/resourceModuleAdd.action?flag=2";
					document.srcForm.submit();
				}
		}
	}
	function _back(){
	document.srcForm.action=path+"module/resourceModuleList.action?APP_ID=<%=APP_ID%>&PMOUDLE=<%=PMOUDLE%>";
	document.srcForm.submit();
	}

	function showModuleTree(obj){
	var x=obj.offsetLeft,y=obj.offsetTop;
		while(obj=obj.offsetParent)
		{
			x+=obj.offsetLeft;
			y+=obj.offsetTop;
		}
	//document.getElementById('tujxzobj').value=tyjname;
	document.getElementById('moduleTreeDiv').style.left=x;
	document.getElementById('moduleTreeDiv').style.top=y+20;
	document.getElementById('moduleTreeDiv').style.display='';
	}

	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		//����
	document.getElementById('moduleTreeDiv').style.display='none';
	if(id==''){
		id='0';
	}
	document.getElementById('PMOUDLE').value=id;
	document.getElementById('PNAME').value=tree.currentNode.T;
	}

	function _close(){
	document.getElementById('moduleTreeDiv').style.display='none';
	}

	function _qingkong(){
	document.getElementById('PMOUDLE').value="0";
	document.getElementById('PNAME').value="";
	document.getElementById('moduleTreeDiv').style.display='none';
	}

</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="resourceModuleAdd">
<input type="hidden" name="P_APP_ID" value="<%=APP_ID%>"/>
<BZ:input field="PMOUDLE" type="hidden" prefix="P_" defaultValue="<%=PMOUDLE %>" id="PMOUDLE"/>
<div id="moduleTreeDiv" style="position:absolute; width:150px; background-color:#646464; height:200px;z-index:199; display:none" onmouseleave="_close()">
<div style="height:175px; overflow:auto; margin-top:2px; margin-left:2px; margin-right:2px; background-color:#FFF">
<BZ:tree property="moduleTree" type="0"/>
</div>
<div align="center"><input type="button" name="qingchu" value="���" onclick="_qingkong()"/></div>
</div>
<div class="kuangjia">
<div class="heading">ģ�����</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">ģ������</td>
<td width="20%"><BZ:input field="CNAME" type="String" prefix="P_" defaultValue="" notnull="������ģ������" formTitle="ģ������"/></td>
<td width="12%">Ӣ������</td>
<td width="18%"><BZ:input field="ENNAME" type="String" prefix="P_" defaultValue="" notnull="������Ӣ������" formTitle="Ӣ������"/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>��ģ��</td>
<td><BZ:input field="PNAME" id="PNAME" type="String" prefix="P_" defaultValue="<%=PNAME %>" onclick="showModuleTree(this)"/></td>
<td>�Ƿ���ҪȨ�޿���</td>
<td>��&nbsp;<BZ:radio field="NEED_RIGHT" prefix="P_"  value="1" property="data" formTitle="Ȩ�޿���" defaultChecked="true"/>&nbsp;&nbsp;��&nbsp;<BZ:radio field="NEED_RIGHT" prefix="P_" formTitle="Ȩ�޿���" value="0" property="data" /></td>
<td></td>
</tr>
<tr>
<td></td>
<td>�Ƿ�ɹ���</td>
<td>��&nbsp;<BZ:radio field="ADMIN_FLAG" prefix="P_" formTitle="Ȩ�޿���" value="1" property="data" defaultChecked="true"/>&nbsp;&nbsp;��&nbsp;<BZ:radio field="ADMIN_FLAG" prefix="P_" formTitle="Ȩ�޿���" value="0" property="data" /></td>
<td>״̬</td>
<td><BZ:select field="STATUS" formTitle="״̬" property="data" prefix="P_" ><BZ:option value="1">����</BZ:option><BZ:option value="0">ͣ��</BZ:option></BZ:select></td>
<td></td>
</tr>
<tr>
<td></td>
<td>����</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_MEMO"></textarea></td>
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