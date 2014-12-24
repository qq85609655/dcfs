
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ page import="com.hx.framework.organ.vo.*" %>
<%@ page import="com.hx.framework.person.vo.*" %>
<%@ page import="com.hx.framework.common.*" %>
<%@ page import="com.hx.framework.sdk.*" %>
<%@ page import="java.util.*" %>
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
	
	String sdate=request.getParameter("ACT_START_TIME");
	String edate=request.getParameter("ACT_END_TIME");
	if(sdate==null){
		sdate="";
	}
	if(edate==null){
		edate="";
	}
%>
<BZ:html>
<BZ:head>
<title>用户登录行为统计</title>
<BZ:script isList="true" />
<script src="<BZ:resourcePath/>/js/date/WdatePicker.js"></script>
  <script type="text/javascript">
  
	function _onload() {
	}
	
	function search() {
		document.srcForm.action=path+"audit/statisticLogin.action";
		document.srcForm.submit(); 
	}
  
  </script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="audit/statisticLogin.action">
<input type="hidden" name="deleteuuid" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<div class="kuangjia">
<div class="heading">查询条件</div>
<div  class="chaxun">
<table class="chaxuntj">

	<tr>
		<td width="30%" nowrap="nowrap" align="right">时间：</td>
		<td width="40%"  nowrap="nowrap">
			从<input size="15" class="Wdate" id="ACT_START_TIME" name="ACT_START_TIME" readonly="readonly" value="<%=sdate %>" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'ACT_END_TIME\')||\'2020-10-01\'}'})"/>
			到<input size="15" class="Wdate" id="ACT_END_TIME"  name="ACT_END_TIME"  readonly="readonly" value="<%=edate %>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'ACT_START_TIME\')}',maxDate:'2020-10-01'})"/></td>
		<td align="center" valign="middle" width="30%">
			<input type="button" value="统计" class="button_search" onclick="search()"/>&nbsp;&nbsp;
			<input type="reset" value="重置" class="button_reset"/>
		</td>
	</tr>
</table>
</div>
<div class="list">
<div class="heading">统计表</div>
	<table width="100%" border="1px">
	<tr>
		<td nowrap="nowrap">序号</td>
		<td nowrap="nowrap">机构</td>
		<td nowrap="nowrap">处室</td>
		<td nowrap="nowrap">人员</td>
		<td nowrap="nowrap">登录成功次数</td>
		<td nowrap="nowrap">登录失败次数</td>
	</tr>
	<%
		List<Organ> organList=(List<Organ>)request.getAttribute("organList");
		DataList dataList1=(DataList)request.getAttribute("dataList1");
		DataList dataList2=(DataList)request.getAttribute("dataList2");
		HashMap<String,String>map1=new HashMap<String,String>();
		for(int i=0;i<dataList1.size();i++){
			Data data=dataList1.getData(i);
			map1.put(data.getString("ACTOR_ID"),data.getString("ACT_RESULT_COUNT"));
		}
		HashMap<String,String>map2=new HashMap<String,String>();
		for(int i=0;i<dataList2.size();i++){
			Data data=dataList2.getData(i);
			map2.put(data.getString("ACTOR_ID"),data.getString("ACT_RESULT_COUNT"));
		}
		
		int count=1;
		for(int i=0;i<organList.size();i++){
			Organ o=organList.get(i);
			if(Constants.ORG_ID_JSH.equals(o.getParentId())){//一级部门
				int r=1;
				//找人员
				List<Person>plist=PersonHelper.getPersonsOfOrgan(o.getId());
				//找二级部门
				List<Organ>olist=OrganHelper.getSubOrgansAll(o.getId());
					//找二级部门人员
				//List<Person>
				for(int j=0;j<plist.size();j++){
					Person p=plist.get(j);
					
					String c1=map1.get(p.getPersonId())==null?"0":map1.get(p.getPersonId());
					String c2=map2.get(p.getPersonId())==null?"0":map2.get(p.getPersonId());
					
					if(c1.trim().equals("")) c1="0";
					if(c2.trim().equals("")) c2="0";
					
					if(Integer.parseInt(c1)!=0 || Integer.parseInt(c2)!=0){
	%>
						<tr>
							<td nowrap="nowrap"><%=count++ %></td>
							<td nowrap="nowrap"><%=o.getcName()%></td>
							<td nowrap="nowrap">&nbsp;</td>
							<td nowrap="nowrap"><%=p.getcName() %></td>
							<td nowrap="nowrap"><%=map1.get(p.getPersonId())==null?"0":map1.get(p.getPersonId()) %></td>
							<td nowrap="nowrap"><%=map2.get(p.getPersonId())==null?"0":map2.get(p.getPersonId()) %></td>
						</tr>
	<%
					}
				}
					
				for(int j=0;j<olist.size();j++){
					Organ osub=olist.get(j);
					plist=PersonHelper.getPersonsOfOrgan(osub.getId());
					//int r2=1;
					for(int k=0;k<plist.size();k++){
						Person p=plist.get(k);
	
						String c1=map1.get(p.getPersonId())==null?"0":map1.get(p.getPersonId());
						String c2=map2.get(p.getPersonId())==null?"0":map2.get(p.getPersonId());
						if(c1.trim().equals("")) c1="0";
						if(c2.trim().equals("")) c2="0";
						
						if(Integer.parseInt(c1)!=0 || Integer.parseInt(c2)!=0){
						%>
							<tr>
								<td nowrap="nowrap"><%=count++ %></td>
								<td nowrap="nowrap"><%=o.getcName() %></td>
								<td nowrap="nowrap"><%=osub.getcName()%></td>
								<td nowrap="nowrap"><%=p.getcName() %></td>
								<td nowrap="nowrap"><%=map1.get(p.getPersonId())==null?"0":map1.get(p.getPersonId()) %></td>
								<td nowrap="nowrap"><%=map2.get(p.getPersonId())==null?"0":map2.get(p.getPersonId()) %></td>
							</tr>
						<%
						}
					}
				}
					
			}
		}//for1 
	%>
	
	</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>