<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@ page import="com.hx.framework.ldap.LdapUserQueryer"%>
<%@ page import="hx.database.databean.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.*"%>
<%  String info=(String)request.getAttribute("info");
       if(info==null){
	   info="";
    }
       
    String compositor=(String)request.getParameter("compositor");
    if(compositor==null){
    	compositor="";
    }
    String ordertype=(String)request.getParameter("ordertype");
    if(ordertype==null){
    	ordertype="";
    }
    
    String IS_FILTER=request.getParameter("IS_FILTER");
    String btnValue="显示所有用户";
    if(IS_FILTER==null){
    	IS_FILTER="true";
    }
    if(IS_FILTER.equals("false")){
    	btnValue="过滤已有用户";
    }
%>

<BZ:html>
<BZ:head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>用户列表</title>
<BZ:script isList="true"/>
<script type="text/javascript">
var simpleGrid;
function _onload(){
    simpleGrid=new SimpleGrid("tableGrid","srcForm");
}
function _add(){
	var sfdj=0;
	   var ID="";
	   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	   if(document.getElementsByName('xuanze')[i].checked){
	   ID=document.getElementsByName('xuanze')[i].value;
	   sfdj++;
	   }
	  }
	  if(sfdj!="1"){
	   alert('请选择一条数据');
	   return;
	  }else{

		  alert("请选择组织机构！");
    	 var reValue = window.showModalDialog("../role/Role!selectOrg.action", this, "dialogWidth=200px;dialogHeight=250px;scroll=auto");
    	 document.getElementById("PERSON_ORGAN_ID").value = reValue["value"];
    	 document.getElementById("TEMP_ORGAN_ID").value = reValue["name"];
    	 document.getElementById("S_ORG_ID").value = reValue["value"];
    	
    	 if( confirm("确认添加到应用吗？")){
    		 document.srcForm.action=path+"person/Person!toAdd.action";
		     document.getElementById("USERINFO").value=ID;
		     document.srcForm.submit();
    	 }

    	 
	 }
}
function search(){
	
	 document.srcForm.action=path+"ldap/ldapUserList!query.action";
	  document.srcForm.submit();
}
function _viewall(){
	if(document.getElementById("IS_FILTER").value=="true"){
		document.getElementById("IS_FILTER").value="false";
	}else{
		document.getElementById("IS_FILTER").value="true";
	}
		document.srcForm.action=path+"ldap/ldapUserList!query.action";
		document.srcForm.submit();
}
//选择组织机构
function selectOrgan(){
	var reValue = window.showModalDialog(path+"organ/Organ!generateTree.action?treeDispatcher=selectOrganTree", this, "dialogWidth=400px;dialogHeight=400px;scroll=auto");
	document.all("S_ORG_ID").value = reValue["value"];
	document.all("A_ORGAN_NAME").value = reValue["name"];
}
//显示部门
function _showExtention(){
	var b = document.getElementById('extentionTable').style.display;
	if(b=='none'){
		document.getElementById('extentionTable').style.display = "block";
	}else{
		document.getElementById('extentionTable').style.display = "none";
	}
}
</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="ldap/ldapUserList">
<input type="hidden" name="ldap" value="true"></input>
<input type="hidden" id="USERINFO" name="USERINFO" value="">
<input type="hidden" name="USER_ID" id="USER_ID" 	value="">
<input type="hidden" name="PERSON_ORGAN_ID" id="PERSON_ORGAN_ID" >
<input type="hidden" name="TEMP_ORGAN_ID" id="TEMP_ORGAN_ID" >
<input type="hidden" id="S_ORG_ID" name="S_ORG_ID" value="<%=request.getParameter("S_ORG_ID")==null?"":request.getParameter("S_ORG_ID") %>" >
<input type="hidden" name="IS_FILTER" id="IS_FILTER" value="<%=IS_FILTER %>" >
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="heading">查询条件</div>
	<div  class="chaxun">
		<table class="chaxuntj" width="100%">
		<tr><td align='right'><input type="button" value="查看全部部门" onclick="_showExtention();" class="button_select" />
		</td>
		</tr>
		<tr>
		<td >
		<table width="100%">
		<tr>
			<td width="15%"  nowrap="nowrap" align="center">部门：</td>
			<td width="75%" align="left" colspan="4">
			<%
				List<String> deptList=(List)request.getAttribute("deptList");
				String[] deptNames=(String[])request.getAttribute("deptNames");
				List<String> l=null;
				if(deptNames!=null&&deptNames.length>0){
					l=Arrays.asList(deptNames);
				}else{
					l=new ArrayList();
				}
				String checked=null;
				for(int i=0;i<=deptList.size()/6-1;i++){
					String str=deptList.get(i);	
					if(l.contains(str)){
						 checked="checked='checked'";
					}else{
						checked="";
					}
					 if(i%4==0){%>
					 <br/>
					 <% 
					 }
				%>
				  <span style="width:182px">
				  <input type="checkbox" id="S_DEPT_NAME" value="<%=str %>" <%=checked %> name="S_DEPT_NAME"/><%=str %>
				  </span>
				<%
				 
				}%>	
				
				</td>
				
		</tr>
		<tr >
			<td width="15%"></td>
			<td width="80%" colspan="4" >
				<table class="chaxuntj" id="extentionTable" style="display: none" width="100%" >
				<%
				if(deptNames!=null&&deptNames.length>0){
					l=Arrays.asList(deptNames);

				}else{
					l=new ArrayList();
				}
				for(int i=deptList.size()/6;i<=deptList.size()-1;i++){
					String str=deptList.get(i);	
				
					if(l.contains(str)){
						 checked="checked='checked'";
					}else{
						checked="";
					}
					if(i%4==0){%>
					 <br/>
					 <% 
					 }
				%><span style="width:182px">
				  <input type="checkbox" id="S_DEPT_NAME" value="<%=str %>" <%=checked %> name="S_DEPT_NAME"/><%=str %>
				</span>
				<%
				 
				}%>	
				</table>
			</td>
			
		</tr>
		</table>
		</td>
		</tr>
		<tr><td>
			<table>
				
				<td width="14%" align="center" nowrap="nowrap" >用户ID：</td>
				<td width="16%" align="left"><input type="text" name="S_USER_ID" id="S_USER_ID" class="inputText" value="<%=request.getAttribute("userId")==null?"":request.getAttribute("userId")%>" /></td>
				<td width="10%" align="right" nowrap="nowrap">用户名：</td>
				<td width="20%" align="left"><input type="text" name="S_USER_NAME" id="S_USER_NAME" class="inputText" value="<%=request.getAttribute("userName")==null?"":request.getAttribute("userName")%>" />
				<td width="10%"></td>
				<td width="10%">
					<input type="button" value="查询" class="button_search" onclick="search()"/>&nbsp;&nbsp;
				</td>
			</table>
			</td>
			</tr>
	</table>
	</div>
	
<div class="list">
<div class="heading">用户列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
	<BZ:thead theadclass="titleBackGrey">
		<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp" />
		<BZ:th name="部门" sortType="string" width="30%" sortplan="jsp"/>
		<BZ:th name="用户名" sortType="string" width="30%" sortplan="jsp"/>
		<BZ:th name="用户ID" sortType="string" width="30%" sortplan="jsp"/>
	</BZ:thead>
	<BZ:tbody>
		<BZ:for property="dataList" >
			<tr>
				<td tdvalue="<BZ:data field="USER_ID"  onlyValue="true"/>#<BZ:data field="USER_NAME"  onlyValue="true"/>" style="width:10%"> <BZ:i></BZ:i>  </td>
				<td><BZ:data field="DEPT_NAME" defaultValue=""/></td>
				<td><BZ:data field="USER_NAME" defaultValue=""/></td>
				<td><BZ:data field="USER_ID" defaultValue=""/></td>
			</tr>
		</BZ:for>
	</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
	<tr>
		<td style="padding-left:15px"></td>
		<td align="right" style="padding-right:30px;height:35px;">
			<input type="button" value="<%=btnValue %>" style="width:100px" class="button_add" onclick="_viewall()"/>&nbsp;&nbsp;
			<input type="button" value="添加到应用" style="width:100px" class="button_add" onclick="_add()"/>&nbsp;&nbsp;
		</td>
	</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>