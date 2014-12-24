
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String compositor=(String)request.getParameter("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getParameter("ordertype");
if(ordertype==null){
	ordertype="";
}
%>
<BZ:html>
<BZ:head>
<title>列表</title>
<BZ:script isList="true"/>		  
<script src="<BZ:resourcePath/>/js/date/WdatePicker.js"></script>
<script type="text/javascript">
var simpleGrid;
function _onload(){
    simpleGrid=new SimpleGrid("tableGrid","srcForm");
}
function search_(){
 document.srcForm.action=path+"clickcount/query.action";
 document.srcForm.submit(); 
}
function showCatelogTree(param,type) {			
  var url=path+"clickcount/clickCountCatelogTree.action?type="+type;
	   var selectValue=window.showModalDialog(url,"","dialogWidth=300px;dialogHeight=400px;status=no;help=no;scroll=auto");
     if(selectValue) {
  	   if(selectValue.name){
     	   		document.getElementById("p_"+param+"_display").value=selectValue.name;
  	   }
  	   if(selectValue.value){
       	document.getElementById("P_"+param).value=selectValue.value;
  	   }
     }                
}

function showDeptTree(fname){
	var reValue = window.showModalDialog(path+"role/Role!selectOrg.action", this, "dialogWidth=480px;dialogHeight=320px;scroll=auto");
	document.getElementsByName("P_"+fname)[0].value = reValue["value"];
	document.getElementsByName("p_"+fname+"_display")[0].value = reValue["name"];
	//alert( reValue["value"]);
}

function showPersonTree(fname){
	var reValue = window.showModalDialog(path+"person/selectPerson.action", this, "dialogWidth=480px;dialogHeight=320px;scroll=auto");
	document.getElementsByName("P_"+fname)[0].value = reValue["value"];
	document.getElementsByName("p_"+fname+"_display")[0].value = reValue["name"];
	//alert( reValue["value"]);
}

</script>
</BZ:head>
<BZ:body onload="_onload()"  >
	<BZ:form name="srcForm" method="post" action="clickcount/query.action">
	    <input type="hidden" name="compositor" value="<%=compositor%>"/>
           <input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<div class="kuangjia">
			<div class="heading">查询条件</div>
			<div  class="chaxun">
				<table class="chaxuntj">
					<tr>
						<td width="5%">部门：</td>
						<td width="10%">
						    <BZ:input id="P_CLICK_DEPT" field="CLICK_DEPT" type="hidden" prefix="P_" defaultValue=""  />
						    <input id="p_CLICK_DEPT_display"  value=""  onclick="showDeptTree('CLICK_DEPT','1')"/>
						</td>
						<td width="5%">人：</td>
						<td width="10%">
						    <BZ:input id="P_CLICK_PERSON" field="CLICK_PERSON" type="hidden" prefix="P_" defaultValue=""  />
						    <input id="p_CLICK_PERSON_display"  value=""  onclick="showPersonTree('CLICK_PERSON','1')"/>
						</td>
						<td width="5%">分类：</td>
						<td width="10%">
						    <BZ:input id="P_CATELOG" field="CATELOG" type="hidden" prefix="P_" defaultValue=""  />
						    <input id="p_CATELOG_display"  value=""  onclick="showCatelogTree('CATELOG','1')"/>
						</td>
						<td width="5%" style="display: none">页面：</td>
						<td width="10%" style="display: none">
						    <BZ:input id="P_PAGEINFO" field="PAGEINFO" type="hidden" prefix="P_" defaultValue="" />
						    <input id="p_PAGEINFO_display"  value="" onclick="showCatelogTree('PAGEINFO','0')"/>
						</td>	
					</tr>
					<tr>
						<td>点击时间：</td>
						<td  colspan="3">
						    从<input size="15" class="Wdate" id="P_STARTDATE" name="P_STARTDATE" readonly="readonly" value="" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'P_LASTDATE\')||\'2020-10-01\'}'})"/>
						    &nbsp;&nbsp;到<input size="15" class="Wdate" id="P_LASTDATE"  name="P_LASTDATE"  readonly="readonly" value="" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'P_STARTDATE\')}',maxDate:'2020-10-01'})"/>
						</td>														
						<td colspan="4" style="align:right">
						    <input type="button" value="查询" class="button_search" onclick="search_()"/>&nbsp;&nbsp;
						    <input type="reset" value="重置" class="button_reset"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="list">
				<div class="heading">列表</div>
					<BZ:table tableid="tableGrid" tableclass="tableGrid">
						<BZ:thead theadclass="titleBackGrey">
						    <BZ:th name="序号" sortType="none" width="5%" sortplan="jsp"/>
							<BZ:th name="分类" sortType="none" width="8%" sortplan="jsp"/>
							<BZ:th name="页面" sortType="string" width="32%" sortplan="database" sortfield="CODENAME"/>
							<BZ:th name="点击部门" sortType="string" width="5%" sortplan="jsp"/>
							<BZ:th name="点击人" sortType="string" width="5%" sortplan="jsp"/>
							<BZ:th name="当前点击数" sortType="string" width="5%" sortplan="jsp"/>
							<BZ:th name="总点击数" sortType="string" width="5%" sortplan="jsp"/>
							<BZ:th name="首次点击时间" sortType="string" width="10%" sortplan="jsp"/>
							<BZ:th name="最近点击时间" sortType="string" width="10%" sortplan="jsp"/>
							
						</BZ:thead>
						<BZ:tbody>
							<BZ:for property="dataList">
							    <tr>
									<td><BZ:i></BZ:i></td>
									<td><BZ:data field="CATALOG_NAME" defaultValue=""/></td>
									<td><BZ:data field="PAGE_NAME" defaultValue=""/></td>
									<td><BZ:data field="CLICK_DEPT" defaultValue="" codeName="organCode" /></td>
									<td><BZ:data field="CLICK_PERSON" defaultValue="" codeName="personCode" /></td>
									<td><BZ:data field="CLICK_COUNT" defaultValue="0"/></td>
									<td><BZ:data field="TOTAL_COUNT" defaultValue=""/></td>
									<td><BZ:data field="START_TIME" defaultValue=""/></td>
									<td><BZ:data field="LAST_CLICK_TIME" defaultValue=""/></td>
									
								</tr>
							</BZ:for>														
						</BZ:tbody>
					</BZ:table>	
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="dataList"/></td>
						</tr>
					</table>
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>