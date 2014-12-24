<%@page language="java" contentType="text/html; charset=GBK" %>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String compositor=(String)request.getAttribute("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getAttribute("ordertype");
if(ordertype==null){
	ordertype="";
}

String path = request.getContextPath();

String personId = (String)request.getAttribute("PERSON_ID");
%>
<BZ:html>
<BZ:head>
<title>联系人列表</title>
<base target="_self" />
<BZ:script isList="true" isDate="true"/>
<script type="text/javascript">
  function _onload(){
  	
  }
  
  function _delete(){
  	var sfdj=0;
    var uuid="";
    for(var i=0;i<document.getElementsByName('xuanze').length;i++){
    if(document.getElementsByName('xuanze')[i].checked){
    uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
    sfdj++;
    }
   }
   if(sfdj=="0"){
   alert('请选择要移除的数据');
   return;
   }else{
   if(confirm('确认要移除选中信息吗?')){
   document.getElementById("LINKMAN_IDS").value=uuid;
   document.srcForm.action=path+"usergroup/deleteLinkmansOfPerson.action";
   document.srcForm.submit();
   }else{
   return;
   }
   }
  }
</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- 人员ID -->
<input type="hidden" id="PERSON_ID" name="PERSON_ID" value="<%=personId%>"/>
<input type="hidden" id="LINKMAN_IDS" name="LINKMAN_IDS">

<div class="list">
<div class="heading">联系人列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" width="10%" sortType="none" sortplan="jsp"/>
<BZ:th name="姓名" width="30%" sortType="string" sortplan="jsp"/>
<BZ:th name="部门" width="30%" sortType="string" sortplan="jsp"/>
<BZ:th name="电话" width="30%" sortType="string" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList">
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" defaultValue=""/></td>
<td><BZ:data field="ORGNAME" defaultValue=""/></td>
<td><BZ:data field="MOBILE" defaultValue=""/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;">
<input type="button" value="移除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<input type="button" value="关闭" class="button_delete" onclick="window.close();"/>
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>