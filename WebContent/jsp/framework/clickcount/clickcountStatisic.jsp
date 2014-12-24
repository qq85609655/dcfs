
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
<title>统计</title>
<BZ:script isList="true"/>		  
<script src="<BZ:resourcePath/>/js/date/WdatePicker.js"></script>
<script type="text/javascript">
var simpleGrid;
function _onload(){
    simpleGrid=new SimpleGrid("tableGrid","srcForm");
}
function search_(){
	 document.all("P_pageHeight").value=chart.document.body.scrollHeight-10;
	 document.all("P_pageWidth").value=chart.document.body.scrollWidth-10;
	 
	 document.srcForm.action=path+"clickcount/chart.action";
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
<BZ:body onload="_onload()" codeNames="personCode;organCode" >
	<BZ:form name="srcForm" method="post" action="" target="chart">
	    <input type="hidden" name="compositor" value="<%=compositor%>"/>
        <input type="hidden" name="ordertype" value="<%=ordertype%>"/>
        <input type="hidden" name="P_pageWidth" value=""/>
        <input type="hidden" name="P_pageHeight" value=""/>
		<div class="kuangjia">
			<div class="heading">点击率统计</div>
			<div  class="chaxun">
				<table class="chaxuntj">
					<tr>
						<td width="5%">统计方式：</td>
						<td width="10%">
							<BZ:select field="xDimension" formTitle="统计方式" property="data" prefix="P_">
								<BZ:option value="1">按页面</BZ:option>
								<BZ:option value="2">按页面分类</BZ:option>
								<BZ:option value="3">按人员</BZ:option>
								<BZ:option value="4">按处室</BZ:option>
								<BZ:option value="5">时间：年</BZ:option>
								<BZ:option value="6">时间：月</BZ:option>
								<BZ:option value="7">时间：日</BZ:option>
							</BZ:select>
						</td>
						<td width="5%">点击数：</td>
						<td width="10%">
							<BZ:select field="valueType" formTitle="点击数" property="data" prefix="P_">
								<BZ:option value="1">总数</BZ:option>
								<BZ:option value="2">按时间范围</BZ:option>
							</BZ:select>
						</td>
						<td width="5%">显示方式：</td>
						<td width="10%">
							<BZ:select field="outType" formTitle="显示方式" property="data" prefix="P_" >
								<BZ:option value="1">表格</BZ:option>
								<BZ:option value="2">图表</BZ:option>
							</BZ:select>
						</td>
						<td width="5%">坐标方向：</td>
						<td width="10%">
							<BZ:select field="xyDirection" formTitle="坐标方向" property="data" prefix="P_">
								<BZ:option value="1">(点击数)竖向</BZ:option>
								<BZ:option value="2">(点击数)横向</BZ:option>
							</BZ:select>
						</td>
						<td width="5%"></td>
						<td width="10%">
						</td>
					</tr>
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
						<td width="5%">页面：</td>
						<td width="10%">
						    <BZ:input id="P_PAGEINFO" field="PAGEINFO" type="hidden" prefix="P_" defaultValue="" />
						    <input id="p_PAGEINFO_display"  value="" onclick="showCatelogTree('PAGEINFO','0')"/>
						</td>	
					</tr>
					<tr>
						<td>点击时间：</td>
						<td  colspan="5">
						    从<input size="15" class="Wdate" id="P_STARTDATE" name="P_STARTDATE" readonly="readonly" value="" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'P_LASTDATE\')||\'2020-10-01\'}'})"/>
						    &nbsp;&nbsp;到<input size="15" class="Wdate" id="P_LASTDATE"  name="P_LASTDATE"  readonly="readonly" value="" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'P_STARTDATE\')}',maxDate:'2020-10-01'})"/>
						</td>														
						<td colspan="4" style="align:right">
						    <input type="button" value="统计" class="button_search" onclick="search_()"/>&nbsp;&nbsp;
						    <input type="reset" value="重置" class="button_reset"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="list">
				<iframe name="chart" style="width:100%;height:600px"></iframe>
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>