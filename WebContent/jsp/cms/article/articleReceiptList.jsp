<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	 //1 获取排序字段、排序类型(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	
%>
<BZ:html>
	<BZ:head>
		<title>通知公告列表</title>
		<BZ:webScript list="true" isAjax="true"/>
	</BZ:head>
	<script>
	$(document).ready(function(){
		dyniframesize([ 'mainFrame' ]);
	});
	
	function _detail(ID){
		document.srcForm.action = path+"article/receiptAdd.action?ID="+ID;
		document.srcForm.submit();
	}
	</script>
	<BZ:body>
		<BZ:form name="srcForm" method="post" action="article/receiptList.action">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<div class="page-content">
			<div class="wrapper">
				<div class="table-header">
					<h4 class="lighter">通知公告列表</h4>
					<div class="widget-toolbar">
						<div class="icon-chevron-up"></div>
					</div>
				</div>
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 7%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 63%;">
									<div id="TITLE" class="sorting">标题</div>
								</th>
								<th style="width: 20%;">
									<div id="CREATE_TIME" class="sorting">发布时间</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled">操作</div>
								</th>
							</tr>
						</thead>
						<tbody>
							<BZ:for property="dl" fordata="mydata">
								<tr class="emptyData">
									<td class="center"><BZ:i /></td>
									<td>
										<%
										String IS_TOP = ((Data) pageContext.getAttribute("mydata")).getString("IS_TOP");
										if("1".equals(IS_TOP)){
										%>
										<img alt="置顶" src="<%=path %>/jsp/cms/images/top.gif"/>
										<%
										}
										Date createTime = new SimpleDateFormat("yyyy-MM-dd").parse(((Data) pageContext.getAttribute("mydata")).getString("CREATE_TIME"));
										//持续时间
										Integer days = ((Data) pageContext.getAttribute("mydata")).getInt("NEW_TIME");
										Calendar createTime_ = Calendar.getInstance();
										createTime_.setTime(createTime);
										createTime_.add(Calendar.DAY_OF_MONTH,days);
										Calendar date = Calendar.getInstance();
										String IS_NEW = ((Data) pageContext.getAttribute("mydata")).getString("IS_NEW");
										if("1".equals(IS_NEW) && createTime_.compareTo(date) > 0){
										%>
										<img alt="最新" src="<%=path %>/jsp/cms/images/new.gif"/>
										<%} %>
										<BZ:data field="TITLE" defaultValue="" />
									</td>
									<td><BZ:data field="CREATE_TIME" defaultValue="" type="date"/></td>
									<td style="text-align: center;">
										<a style="cursor: pointer;text-decoration: underline;" onclick="_detail('<BZ:data field="ID" defaultValue="" onlyValue="true"/>')">查看</a>
									</td>
								</tr>
							</BZ:for>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		</BZ:form>
	</BZ:body>
</BZ:html>