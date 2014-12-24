
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hx.framework.sdk.*" %>
<%@ page import="com.hx.framework.organ.vo.*" %>
<%@ page import="hx.database.databean.*" %>
<%@ page import="hx.util.*" %>
<%
String compositor=(String)request.getParameter("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getParameter("ordertype");
if(ordertype==null){
	ordertype="";
}


String startDate=request.getParameter("P_STARTDATE");
String lastDate=request.getParameter("P_LASTDATE");

if(startDate==null) startDate=UtilDateTime.nowDateString();
if(lastDate==null) lastDate=UtilDateTime.nowDateString();
%>
<BZ:html>
<BZ:head>
<title>统计</title>
<BZ:script />		  
<style>
.baogao1 { border:1px solid #99bbe8; background:#dfe8f6;}
.baogao1 td { background:#FFFFFF;height:30px;}
.baogao1 h2 { font-family:"黑体"; font-size:20px; font-weight:normal; height:54px; line-height:54px; text-align:center; width:100%; background:#f0f5f9; border-top:1px solid #d6dbe1; border-bottom:1px solid #d4e2f7;}
.baogao1 .border { border:1px solid #d6dbe1; border-width:0 1px 0 1px; width:100%;}
.baogao1 .table1 { line-height:30px; margin:6px auto;}
.baogao1 .table1 td{ height:30px; }
.baogao1 .table1 img{ vertical-align:middle}
</style>

<script src="<BZ:resourcePath/>/js/date/WdatePicker.js"></script>
<script type="text/javascript">
var simpleGrid;
function _onload(){
    //simpleGrid=new SimpleGrid("tableGrid","srcForm");
}
function search_(t){
	 //document.all("P_pageHeight").value=chart.document.body.scrollHeight-10;
	// document.all("P_pageWidth").value=chart.document.body.scrollWidth-10;
	if(document.getElementById("P_CATELOG").value.trim()==''){
		 alert("请选择页面分类！");
		 return;
	 }
	 document.srcForm.action=path+"clickcount/statisticTable.action";//?countType="+t;
	 document.srcForm.submit(); 
}
function _export(t){
	 //document.all("P_pageHeight").value=chart.document.body.scrollHeight-10;
	// document.all("P_pageWidth").value=chart.document.body.scrollWidth-10;
	 if(document.getElementById("P_CATELOG").value.trim()==''){
		 alert("请选择页面分类！");
		 return;
	 }
	 document.srcForm.action=path+"clickcount/statisticExport.action";//?countType="+t;
	 document.srcForm.submit(); 
}
function showCatelogTree(param,type,multi) {			
  	  var url=path+"clickcount/clickCountCatelogTree.action?type="+type+"&multiSel="+multi;
	  var selectValue=window.showModalDialog(url,"","dialogWidth=550px;dialogHeight=740px;status=no;help=no;scroll=auto");
     if(selectValue) {
    	 if(multi){
    		 var ids="",names="";
    		 for(var i=0 ;i<selectValue.length;i++){
    			 if(i>0){
	    			 ids=ids+",";
	    			 names=names +",";
    			 }
    			 ids=ids + selectValue[i]["value"];
    			 names=names + selectValue[i]["name"];
   			}
    		
    		 document.getElementById("P_"+param).value=ids;
    		 document.getElementById("p_"+param+"_display").value=names;
    	 }else{

    	  	   if(selectValue.name){
   	     	   		document.getElementById("p_"+param+"_display").value=selectValue.name;
    	  	   }
    	  	   if(selectValue.value){
    	       		document.getElementById("P_"+param).value=selectValue.value;
    	  	   }
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
<BZ:body onload="_onload()"  property="data">
	<BZ:form name="srcForm" method="post" action="clickcount/statisticTable.action">
	    <input type="hidden" name="compositor" value="<%=compositor%>"/>
        <input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<div class="kuangjia">
			<div class="heading">点击率统计条件</div>
			<div  class="chaxun">
				<table class="chaxuntj">
					<tr>
						<td width="5%">页面分类：</td>
						<td width="10%">
						    <BZ:input id="P_CATELOG" field="CATELOG" type="hidden" prefix="P_" defaultValue=""  />
						    <BZ:input id="p_CATELOG_display"  field="CATELOG_DISPALY"  prefix="P_"  defaultValue=""  onclick="showCatelogTree('CATELOG','1','true')"/>
						</td>
						<td width="5%">统计范围：</td>
						<td width="10%">
							<BZ:select field="VALUETYPE" formTitle="统计范围" property="data" prefix="P_">
								<BZ:option value="2">按时间范围</BZ:option>
								<BZ:option value="1">总数</BZ:option>
							</BZ:select>
						</td>
						<td width="5%">统计方式：</td>
						<td width="10%">
							<BZ:select field="COUNTTYPE" formTitle="统计方式" property="data" prefix="P_">
								<BZ:option value="1">点击次数</BZ:option>
								<BZ:option value="2">点击人数</BZ:option>
							</BZ:select>
						</td>
					</tr>
					<tr>
						<td>点击时间：</td>
						<td colspan="4">
						    从<input size="15" class="Wdate" id="P_STARTDATE" name="P_STARTDATE" readonly="readonly" value="<%=startDate %>" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'P_LASTDATE\')||\'2020-10-01\'}'})"/>
						    &nbsp;&nbsp;到<input size="15" class="Wdate" id="P_LASTDATE"  name="P_LASTDATE"  readonly="readonly" value="<%=lastDate %>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'P_STARTDATE\')}',maxDate:'2020-10-01'})"/>
						</td>														
						<td  style="align:right">
						    <input type="button" value="统计" class="button_search" onclick="search_(1)"/>&nbsp;&nbsp;
						    <input type="button" value="导出" class="button_search" onclick="_export(1)"/>&nbsp;&nbsp;
						    <input type="reset" value="重置" class="button_reset"/>
						</td>
					
					</tr>
				</table>
			</div>
			<div class="list" align="center">
				
				<% 
					List<String> cata_ids=(List<String>)request.getAttribute("cata_ids");
					List<String> cata_names=(List<String>)request.getAttribute("cata_names");
//					DataList clist=(DataList)request.getAttribute("countList");
					List<Map> clist=(List<Map>)request.getAttribute("clist");
					
					List<Organ> olist=(List<Organ>)request.getAttribute("olist");
					
					if(cata_ids!=null && clist!=null &clist.size()>0){
						
						%>
						<div class="heading">统计表</div>
						<table class="baogao1" >
							<thead style="background-color:#ADD8E6" >
							<tr style="height: 30px">
							<th rowspan="1" colspan="3" >页面分类</th>
							<th colspan="<%=olist.size() %>">部门</th>
							<th rowspan="2">合计</th>
							</tr>
							<tr>
								<th>大类</th>
								<th>中类</th>
								<th>小类</th>
								<%
								//输出头
								for(int i=0;i<olist.size();i++){
								%>
									<th><%=olist.get(i).getcName()%></th>
								<% }%>
								
							</tr>
							</thead>
							<tbody>
							
						<%
						
						//输出数据
						for(int i=0;i<clist.size();i++){
							Map mapi=(Map)clist.get(i);
							Data cdata=(Data)mapi.get("DATA");
							int rowspan1=0;
							//
							List childs=(List)mapi.get("childs");
							if(childs!=null && childs.size()>0){
								//rowspan1=childs.size();
								for(int j=0;j<childs.size();j++){
									Map mapj=(Map)childs.get(j);
									List childs2=(List)mapj.get("childs");
									if(childs2!=null && childs2.size()>0){
										rowspan1+=childs2.size();
									}
									Data cdataj=(Data)mapj.get("DATA");
									if(cdataj!=null){ rowspan1++;}
								}
							}
							if(cdata!=null){ rowspan1++;}
				%>
								<%if(cdata!=null){ %>
									<tr>
									<% if(i==clist.size()-1){ %>
										<td rowspan="<%=rowspan1 %>" colspan='3' align="center" ><%= mapi.get("CNAME") %></td>
									<%}else{ %>
										<td rowspan="<%=rowspan1 %>"><%= mapi.get("CNAME") %></td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									<%} %>
										<%
										for (int j=0;j<olist.size();j++){ 
												String c=cdata.getString(olist.get(j).getId(),"");
										%>
											<td align="center"><%=c %></td>
										<%} %>
											<td align="center"><%=cdata.getString("heji")%></td>
										
									</tr>
								<%} %>
							<%
								if(childs!=null && childs.size()>0){ 
								for(int j=0;j<childs.size();j++){
									int rowspan2=0;
									Map mapj=(Map)childs.get(j);
									List childs2=(List)mapj.get("childs");
									if(childs2!=null && childs2.size()>0){
										rowspan2=childs2.size();
									}
									Data cdataj=(Data)mapj.get("DATA");
									if(cdataj!=null){ rowspan2++;}
							%>
										<%if(cdataj!=null){%>
											<tr>
												<%if(cdata==null && j==0){ %>
													<td rowspan="<%=rowspan1 %>"><%= mapi.get("CNAME") %></td>
												<%} %>
												<td rowspan="<%=rowspan2 %>"><%= mapj.get("CNAME") %></td>
													<td>&nbsp;</td>
													<%
													for (int k=0;k<olist.size();k++){ 
															String c=cdataj.getString(olist.get(k).getId(),"");
													%>
														<td align="center"><%=c %></td>
													<%} %>
														<td align="center"><%=cdataj.getString("heji")%></td>
												
											</tr>
										<%} %>
									<%
										if(childs2!=null && childs2.size()>0){ 
											for(int k=0;k<childs2.size();k++){
												Map mapk=(Map)childs2.get(k);
												Data cdatak=(Data)mapk.get("DATA");
									%>
												<%if(cdatak!=null){%>
													<tr>
														<%if(cdata==null && cdataj==null && j==0 && k==0){ %>
															<td rowspan="<%=rowspan1 %>"><%= mapi.get("CNAME") %></td>
														<%} %>
														<%if(cdataj==null && k==0){ %>
															<td rowspan="<%=rowspan2 %>"><%= mapj.get("CNAME") %></td>
														<%} %>
														
														<td ><%= mapk.get("CNAME") %></td>
															<%
															for (int m=0;m<olist.size();m++){ 
																	String c=cdatak.getString(olist.get(m).getId(),"");
															%>
																<td align="center"><%=c %></td>
															<%} %>
																<td align="center"><%=cdatak.getString("heji")%></td>
													
													</tr>
												<%} %>
										
									
									<%}} %>
								
							
							<%} }%>
				
				<%}%>
				
							</tbody>
						</table>
						
						<%
					}		
				%>
			
			</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>